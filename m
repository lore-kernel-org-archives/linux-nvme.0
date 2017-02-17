From: hch@lst.de (Christoph Hellwig)
Date: Fri, 17 Feb 2017 18:16:24 +0100
Subject: [PATCH 4/4] nvme: re-check security protocol support after reset
In-Reply-To: <20170217165551.GA2062@sbauer-Z170X-UD5>
References: <20170217125941.14319-1-hch@lst.de>
 <20170217125941.14319-5-hch@lst.de>
 <20170217152651.GA18275@localhost.localdomain>
 <20170217170128.GA29208@lst.de> <20170217165551.GA2062@sbauer-Z170X-UD5>
Message-ID: <20170217171624.GA29297@lst.de>

On Fri, Feb 17, 2017@09:55:51AM -0700, Scott Bauer wrote:
> I'm working on it now. Do you want a diff like Keith did or a separate patch?

Please make it a proper patch that applies on top of my patches 1-3 (where
3 really is yours anyway).  I'll respin 4 with the updates from Keith on
top of 1-3 + your patch then.
