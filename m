From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 7 Dec 2017 08:41:33 +0200
Subject: [PATCH rfc 2/2] nvmet: expose option to emulate a nvm subsystem
 in read-only mode
In-Reply-To: <20171206224650.GB14274@lst.de>
References: <20171204092435.20000-1-sagi@grimberg.me>
 <20171204092435.20000-3-sagi@grimberg.me> <20171204161930.GA12277@lst.de>
 <c3d78077-b5b0-c05e-fca1-ca9ef5a0e1eb@grimberg.me>
 <20171204200653.GA17023@lst.de>
 <8abf14b8-53a0-c39d-e17e-99bd7840b7a7@grimberg.me>
 <20171206224650.GB14274@lst.de>
Message-ID: <1e296f21-ea8d-5697-8028-eeb3809b3983@grimberg.me>


>> Just to be clear, that is exactly what I intended to do.
> 
> My point is that we should not have a configfs nob to turn
> on the r/o nob, but do it based on an error from the lower
> block device.

What do you suggest we do when the subsystem exports two block
devices of two different subsystems where only one gets into
r/o state?
