From: daniel.mcleran@intel.com (Dan McLeran)
Date: Wed, 18 Jun 2014 09:15:54 -0600 (Mountain Daylight Time)
Subject: [PATCH] NVMe: Fail SCSI->NVMe translation for UNMAP when anchor
 is set
In-Reply-To: <alpine.LRH.2.03.1406180908390.4699@AMR>
References: <1403082188-4852-1-git-send-email-daniel.mcleran@intel.com>
 <alpine.LRH.2.03.1406180908390.4699@AMR>
Message-ID: <alpine.WNT.2.00.1406180915170.13096@DMCLERAN-DESK.amr.corp.intel.com>

Wrong spec version. Gotta go clean house and get rid of my old ones.

On Wed, 18 Jun 2014, Keith Busch wrote:

> On Wed, 18 Jun 2014, Dan McLeran wrote:
>> SCSI UNMAP should fail if the host sends down the command with Anchor set. 
>> The
>> current code does not check this condition. This patch checks Anchor and 
>> fails
>> Scsi->NVMe translation if Anchor is set.
>
> The reference on nvmexpress.org says the command with anchor set is
> premissible "for resource-provisioned devices".
>
>> Signed-off-by: Dan McLeran <daniel.mcleran at intel.com>
>
