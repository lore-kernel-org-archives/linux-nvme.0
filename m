From: hch@lst.de (Christoph Hellwig)
Date: Sat, 3 Nov 2018 09:21:38 +0100
Subject: [PATCH] nvme-pci: Add Write Zero support to Intel 660p
In-Reply-To: <20181102142114.GA24372@localhost.localdomain>
References: <20181026224146.198311-1-gwendal@chromium.org>
 <20181026225807.GA10621@localhost.localdomain>
 <20181027074452.GA15404@lst.de>
 <20181029152401.GA16336@localhost.localdomain> <20181101052749.GA4349@lst.de>
 <20181101143807.GL19483@localhost.localdomain>
 <20181102060815.GA16583@lst.de>
 <20181102142114.GA24372@localhost.localdomain>
Message-ID: <20181103082138.GA25370@lst.de>

On Fri, Nov 02, 2018@08:21:15AM -0600, Keith Busch wrote:
> Okay, that wording is unfortunate and the feature is useless if that's
> how it can be interpreted.

While I agree that it is unfortunate it matches how ATA TRIM and
SCSI UNMAP work.  And that is how it happened - I vague remember
discussions in the working group.
