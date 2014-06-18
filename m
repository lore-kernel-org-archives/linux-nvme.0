From: daniel.mcleran@intel.com (Dan McLeran)
Date: Wed, 18 Jun 2014 09:30:24 -0600 (Mountain Daylight Time)
Subject: [PATCH] NVMe: Fail SCSI->NVMe translation for UNMAP when anchor
 is set
In-Reply-To: <20140618152708.GH12025@linux.intel.com>
References: <1403082188-4852-1-git-send-email-daniel.mcleran@intel.com>
 <alpine.LRH.2.03.1406180908390.4699@AMR>
 <20140618152708.GH12025@linux.intel.com>
Message-ID: <alpine.WNT.2.00.1406180929430.12984@DMCLERAN-DESK.amr.corp.intel.com>

Good point. So, is Anchor == 1 still illegal for non-resource-provisioned 
devices? The spec seems to imply that must be the case.

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
>
