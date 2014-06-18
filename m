From: willy@linux.intel.com (Matthew Wilcox)
Date: Wed, 18 Jun 2014 11:27:08 -0400
Subject: [PATCH] NVMe: Fail SCSI->NVMe translation for UNMAP when anchor
 is set
In-Reply-To: <alpine.LRH.2.03.1406180908390.4699@AMR>
References: <1403082188-4852-1-git-send-email-daniel.mcleran@intel.com>
 <alpine.LRH.2.03.1406180908390.4699@AMR>
Message-ID: <20140618152708.GH12025@linux.intel.com>

On Wed, Jun 18, 2014@09:13:27AM -0600, Keith Busch wrote:
> On Wed, 18 Jun 2014, Dan McLeran wrote:
> >SCSI UNMAP should fail if the host sends down the command with Anchor set. The
> >current code does not check this condition. This patch checks Anchor and fails
> >Scsi->NVMe translation if Anchor is set.
> 
> The reference on nvmexpress.org says the command with anchor set is
> premissible "for resource-provisioned devices".

So ... we should check whether the namespace has NSFEAT bit 0 set before
failing the command?
