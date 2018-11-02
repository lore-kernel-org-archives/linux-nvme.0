From: keith.busch@intel.com (Keith Busch)
Date: Fri, 2 Nov 2018 08:21:15 -0600
Subject: [PATCH] nvme-pci: Add Write Zero support to Intel 660p
In-Reply-To: <20181102060815.GA16583@lst.de>
References: <20181026224146.198311-1-gwendal@chromium.org>
 <20181026225807.GA10621@localhost.localdomain>
 <20181027074452.GA15404@lst.de>
 <20181029152401.GA16336@localhost.localdomain>
 <20181101052749.GA4349@lst.de>
 <20181101143807.GL19483@localhost.localdomain>
 <20181102060815.GA16583@lst.de>
Message-ID: <20181102142114.GA24372@localhost.localdomain>

On Fri, Nov 02, 2018@07:08:15AM +0100, Christoph Hellwig wrote:
> On Thu, Nov 01, 2018@08:38:08AM -0600, Keith Busch wrote:
> > We currently use DSM Deallocate for REQ_OP_WRITE_ZEROES. We don't care
> > if the blocks are actually deallocated. We only care if reading them
> > back determinisitically returns 0's, and DLFEAT tells us if we can rely
> > on that behavior.
> 
> No, DLFEAT _only_ tells you the value you read from actually deallocated
> blocks.  From the DLFEAT description:
> 
> "Bits 2:0 indicate the values read from a deallocated logical block and its
> metadata (excluding protection information). The values for this field have
> the following meanings:"
> 
> And from Section 6.7:
> 
> "This command is advisory; a compliant controller may choose to take no
> action based on information provided."
> 
> "Attribute ? Deallocate (AD): If set to ?1?, then the NVM subsystem may
> deallocate all provided ranges. The data returned for a deallocated range
> is specified in section 6.7.1.1."

Okay, that wording is unfortunate and the feature is useless if that's
how it can be interpreted.

The "advisory" parts were originally directed toward the Context
Attributes referring to access type and frequency.

The intended behavior for Deallocate was a controller picks exactly
one behavior: return 0's, 1's, or the previous written data. It was
never intended, as far as I know, for a controller to return read
data differently for any given range after returning success to a DSM
Deallocate command.

That must be at least part of the motivation for Write Zeroes adding
deallocate support.
