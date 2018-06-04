From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 4 Jun 2018 15:17:43 +0300
Subject: [PATCH] nvme: avoid hang on inaccessible paths
In-Reply-To: <20180604063753.GA20811@lst.de>
References: <20180530111637.22223-1-hare@suse.de>
 <20180530121241.GA1850@lst.de> <20180530143020.50a299b8@pentland.suse.de>
 <20180530125452.GA2763@lst.de>
 <35d5d780-b1c2-d176-639b-b41106e3e980@grimberg.me>
 <20180604082455.6369788d@pentland.suse.de> <20180604063753.GA20811@lst.de>
Message-ID: <db93e436-8f3b-352b-7395-f8eb7cf2e198@grimberg.me>



>> We'd need the async patches still, as they provide a way on how we can
>> call nvme-cli directly from within udev rules.
>> Without those patches nvme-cli might get stuck (as this issue neatly
>> proves) and would block udev from processing events.
> 
> So just run nvme-cli in the background from udev.  Or if udev really
> is too stupid for that have an option to fork and run in the background
> in nvme-cli itself..

 From udev man:

RUN{type}

...
        This can only be used for very short-running foreground tasks.
        Running an event process for a long period of time may block all
        further events for this or a dependent device.

        Starting daemons or other long running processes is not appropriate
        for udev; the forked processes, detached or not, will be
        unconditionally killed after the event handling has finished.

One way around this is to disown the command from udev shell
(e.g. $cmd & disown)
