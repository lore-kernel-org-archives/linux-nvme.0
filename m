From: hch@lst.de (Christoph Hellwig)
Date: Thu, 1 Nov 2018 06:27:49 +0100
Subject: [PATCH] nvme-pci: Add Write Zero support to Intel 660p
In-Reply-To: <20181029152401.GA16336@localhost.localdomain>
References: <20181026224146.198311-1-gwendal@chromium.org>
 <20181026225807.GA10621@localhost.localdomain>
 <20181027074452.GA15404@lst.de>
 <20181029152401.GA16336@localhost.localdomain>
Message-ID: <20181101052749.GA4349@lst.de>

On Mon, Oct 29, 2018@09:24:01AM -0600, Keith Busch wrote:
> > The 'Deallocate Logical Block Features' bits 0 and 1 only tell what
> > is read back from deallocated logic blocks, but it does not guarantee
> > that all blocks a DSM deallocate is called on are actually deallocated.
> 
> Sure, but whether the requested blocks are deallocated or not is
> irrelevant. We're only using this feature here for its deterministic
> read behavior.

I can't parse this.
