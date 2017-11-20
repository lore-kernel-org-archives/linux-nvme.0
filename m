From: daniel.bmore.ricketts@gmail.com (Daniel Ricketts)
Date: Mon, 20 Nov 2017 10:50:32 -0800
Subject: PCIe reset and inflight I/O
Message-ID: <CANG1VsWOxeMz8n91K67F=VropETnrY_MDqzo2wMp-tkgj0AdGQ@mail.gmail.com>

After a PCIe reset completes, can there be inflight I/O anywhere in
the NVM subsystem (e.g. lower-level device or firmware buffers)?

Section 7.3.2 of revision 1.3a of the NVMe specification states that a
PCIe reset triggers a NVMe controller level reset, after which the
following actions are performed:

- The controller stops processing any outstanding Admin or I/O commands.
- All I/O Submission Queues are deleted.
- All I/O Completion Queues are deleted.

If an I/O command is initiated on a controller prior to a controller
reset, is it possible for the command to complete anywhere in the NVM
subsystem after the controller reset?

In general, I'm trying to understand how deep a PCIe reset is for
fencing out inflight I/O.

Thanks,
Dan
