From: keith.busch@intel.com (Keith Busch)
Date: Mon, 24 Oct 2016 10:46:29 -0400
Subject: [PATCH 0/5] ahci: nvme remap support
In-Reply-To: <20161024124938.GB2389@lst.de>
References: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20161022065038.GA8547@lst.de>
 <CAPcyv4grb=53fvF9akx6r7M_EgHu90w2o3xZySqTev+gOnm14Q@mail.gmail.com>
 <20161023083424.GA31994@lst.de>
 <CAPcyv4iNNu5bxzEOx0XMy2Edd4d5xvrEK+6A4mYsNH5iXtbUTA@mail.gmail.com>
 <20161024124938.GB2389@lst.de>
Message-ID: <20161024144628.GC8633@localhost.localdomain>

On Mon, Oct 24, 2016@02:49:38PM +0200, Christoph Hellwig wrote:
> But this has a profound effect on the NVMe operation, because fo
> example the NVMe reset cycle is tied into PCIe function states.
> 
> Please bring this issue up with the relevant standards comittee first,
> otherwise we're getting us into a nightmare of undefined behavior here.
> 
> And it's not like Intel isn't active in this group.  I'd suggest you
> talk to Amber who is the editor for both the AHCI and NVMe spec,
> that should get you started.

Amber is aware of this and was supportive in having Intel open the
specs to enable this hardware.

The nvme driver has weird hooks to support the non-standard open channel
effort, and we let Apple dictate this driver can't have q-word access.
This remapping isn't exactly the first time we're helping non-standard
devices, and Dan's series looks isolated such that it won't harm
compliant ones.

Dan,
I take it you have access to this platform. Would you be able verify if
it can successfully resume from S3 and S4?
