From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 7 Dec 2017 08:45:29 +0200
Subject: [PATCH rfc 1/2] nvme: support smart read-only critical warning
 event
In-Reply-To: <20171206224746.GC14274@lst.de>
References: <20171204092435.20000-1-sagi@grimberg.me>
 <20171204092435.20000-2-sagi@grimberg.me> <20171204200721.GB17023@lst.de>
 <0c6a853d-c8c5-2144-09e1-8e6cae90fb2a@grimberg.me>
 <20171206224746.GC14274@lst.de>
Message-ID: <2cf2fdeb-c9b7-b11b-b718-ff24633b174f@grimberg.me>


>> 2. handle the event in the kernel, issue the log page with retain bit on
>> and only then notify userspace.
> 
> The retain bit is a new optional feature in nvme 1.3.  I fear we
> won't see all that many controllers respecting it.

Well, for those devices user-space will see a cleared log
page...

Unless you prefer option 1? Or have a better idea?
