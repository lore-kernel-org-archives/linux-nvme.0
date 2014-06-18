From: keith.busch@intel.com (Keith Busch)
Date: Wed, 18 Jun 2014 09:35:13 -0600 (MDT)
Subject: [PATCH] NVMe: Fail SCSI->NVMe translation for UNMAP when anchor
 is set
In-Reply-To: <20140618152708.GH12025@linux.intel.com>
References: <1403082188-4852-1-git-send-email-daniel.mcleran@intel.com>
 <alpine.LRH.2.03.1406180908390.4699@AMR>
 <20140618152708.GH12025@linux.intel.com>
Message-ID: <alpine.LRH.2.03.1406180929180.4699@AMR>

On Wed, 18 Jun 2014, Matthew Wilcox wrote:
> On Wed, Jun 18, 2014@09:13:27AM -0600, Keith Busch wrote:
>> On Wed, 18 Jun 2014, Dan McLeran wrote:
>>> SCSI UNMAP should fail if the host sends down the command with Anchor set. The
>>> current code does not check this condition. This patch checks Anchor and fails
>>> Scsi->NVMe translation if Anchor is set.
>>
>> The reference on nvmexpress.org says the command with anchor set is
>> premissible "for resource-provisioned devices".
>
> So ... we should check whether the namespace has NSFEAT bit 0 set before
> failing the command?

This gets a little confusing (for me, at least). The translation for
VPD B2 says the device is "resource-provisioned" if it supports DSM
Deallocate, but the command is already going to be failed by the device
if it doesn't support DSM.
