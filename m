From: barrett.n.mayes@intel.com (Mayes, Barrett N)
Date: Wed, 18 Jun 2014 17:23:27 +0000
Subject: [PATCH] NVMe: Fail SCSI->NVMe translation for UNMAP when anchor
 is set
In-Reply-To: <20140618162547.GJ12025@linux.intel.com>
References: <1403082188-4852-1-git-send-email-daniel.mcleran@intel.com>
 <alpine.LRH.2.03.1406180908390.4699@AMR>
 <20140618152708.GH12025@linux.intel.com>
 <alpine.WNT.2.00.1406180929430.12984@DMCLERAN-DESK.amr.corp.intel.com>
 <20140618154532.GI12025@linux.intel.com>
 <B8DB29EA17EB2742AC3405C31A9B9EE9614C0D68@ORSMSX111.amr.corp.intel.com>
 <20140618162547.GJ12025@linux.intel.com>
Message-ID: <B8DB29EA17EB2742AC3405C31A9B9EE9614C1433@ORSMSX111.amr.corp.intel.com>

>I'm not sure about Guy's reasoning that NVMe supports three different
>provisioning models like SCSI does.  Should probably take this to the
>NVMe mailing list now ...

ANC_SUP=0  if ONCS bit 2 is 0 _and_ NSFEAT bit 0 is 0
ANC_SUP=1 if ONCS bit 2 is 1 _or_ NSFEAT bit 0 is 1
