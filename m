From: hch@lst.de (Christoph Hellwig)
Date: Mon, 4 Dec 2017 17:19:30 +0100
Subject: [PATCH rfc 2/2] nvmet: expose option to emulate a nvm
 subsystem in read-only mode
In-Reply-To: <20171204092435.20000-3-sagi@grimberg.me>
References: <20171204092435.20000-1-sagi@grimberg.me>
 <20171204092435.20000-3-sagi@grimberg.me>
Message-ID: <20171204161930.GA12277@lst.de>

I don't think that is what the SMART log is inteded for.  Please
review the write protected namespace TP in the working group instead
and make sure it passes soon so that we can use it.
