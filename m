From: hch@lst.de (Christoph Hellwig)
Date: Fri, 2 Nov 2018 07:08:15 +0100
Subject: [PATCH] nvme-pci: Add Write Zero support to Intel 660p
In-Reply-To: <20181101143807.GL19483@localhost.localdomain>
References: <20181026224146.198311-1-gwendal@chromium.org>
 <20181026225807.GA10621@localhost.localdomain>
 <20181027074452.GA15404@lst.de>
 <20181029152401.GA16336@localhost.localdomain> <20181101052749.GA4349@lst.de>
 <20181101143807.GL19483@localhost.localdomain>
Message-ID: <20181102060815.GA16583@lst.de>

On Thu, Nov 01, 2018@08:38:08AM -0600, Keith Busch wrote:
> We currently use DSM Deallocate for REQ_OP_WRITE_ZEROES. We don't care
> if the blocks are actually deallocated. We only care if reading them
> back determinisitically returns 0's, and DLFEAT tells us if we can rely
> on that behavior.

No, DLFEAT _only_ tells you the value you read from actually deallocated
blocks.  From the DLFEAT description:

"Bits 2:0 indicate the values read from a deallocated logical block and its
metadata (excluding protection information). The values for this field have
the following meanings:"

And from Section 6.7:

"This command is advisory; a compliant controller may choose to take no
action based on information provided."

"Attribute ? Deallocate (AD): If set to ?1?, then the NVM subsystem may
deallocate all provided ranges. The data returned for a deallocated range
is specified in section 6.7.1.1."
