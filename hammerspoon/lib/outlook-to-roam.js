const timeToString = (time) =>
  `${time
    .getHours()
    .toString()
    .padStart(2, "0")}:${time.getMinutes().toString().padStart(2, "0")}`;

Application("Microsoft Outlook")
  .selectedObjects()
  .map((ev) => ({
    title: ev.subject(),
    time: `${timeToString(ev.startTime())}`,
    attendees: [
      ...ev.attendees().map((att) => `     - [[${att.emailAddress().name}]]`),
    ],
    agenda: ev
      .plainTextContent()
      .trim()
      .split(/[\r\n]+/)
      .join(" ----- "),
    location: ev.location(),
  }))
  .sort((a, b) => a.time - b.time)
  .map(
    (ev) => `[[Meeting/${ev.title}]] - ${ev.time}
  - Category:: #meeting
  - Attendees
${ev.attendees.join("\n")}
  - Agenda\n
    - ${ev.agenda}`
  )
  .join("\n");
