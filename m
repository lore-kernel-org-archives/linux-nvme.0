From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 4 Dec 2017 20:11:14 +0200
Subject: [PATCH rfc 2/2] nvmet: expose option to emulate a nvm subsystem
 in read-only mode
In-Reply-To: <20171204161930.GA12277@lst.de>
References: <20171204092435.20000-1-sagi@grimberg.me>
 <20171204092435.20000-3-sagi@grimberg.me> <20171204161930.GA12277@lst.de>
Message-ID: <c3d78077-b5b0-c05e-fca1-ca9ef5a0e1eb@grimberg.me>

Hey Christoph,

> I don't think that is what the SMART log is inteded for.

Can you please elaborate what you mean? are you talking about this
patch in particular (simply an emulation)? or support for this
altogether? A subsystem can, at any point, be placed in read-only mode.
In that case it needs to send SMART AER to indicate health status
change. I think that if the media has been placed in read-only mode, we
need to log it, and set all the subsystem namespaces in read-only mode.

Anything different you think we need to do here?

> Please review the write protected namespace TP in the working group instead
> and make sure it passes soon so that we can use it.

I did look at write protect, this is not the use-case here.
write-protect is a per-namespace attribute which is controlled by
the host, this addresses NVMe subsystem critical warning scenario.
