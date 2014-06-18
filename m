From: keith.busch@intel.com (Keith Busch)
Date: Wed, 18 Jun 2014 10:04:01 -0600 (MDT)
Subject: [PATCH] NVMe: Fail SCSI->NVMe translation for UNMAP when anchor
 is set
In-Reply-To: <B8DB29EA17EB2742AC3405C31A9B9EE9614C0D68@ORSMSX111.amr.corp.intel.com>
References: <1403082188-4852-1-git-send-email-daniel.mcleran@intel.com>
 <alpine.LRH.2.03.1406180908390.4699@AMR>
 <20140618152708.GH12025@linux.intel.com>
 <alpine.WNT.2.00.1406180929430.12984@DMCLERAN-DESK.amr.corp.intel.com>
 <20140618154532.GI12025@linux.intel.com>
 <B8DB29EA17EB2742AC3405C31A9B9EE9614C0D68@ORSMSX111.amr.corp.intel.com>
Message-ID: <alpine.LRH.2.03.1406180953510.4699@AMR>

On Wed, 18 Jun 2014, Mayes, Barrett N wrote:
>> On the one hand, it says that ANC_SUP shall be set to 0.
>
> LSI proposed the following and asked for feedback by June 9.  I don't recall
> seeing any comments to this on the public reflector.
>
> ANC_SUC
> Shall be set to 0, to indicate that setting the ANCHOR bit in UNMAP is not
> supported if the namespace is not resource or thin provisioned.

> Shall be set to 1, to indicate that setting the ANCHOR bit in UNMAP is
> supported if the namespace is resource provisioned. May be set to 1 if the
> namespace is thin provisioned.

I looked at the proposal and the translation for the PROVISIONING TYPE
would indicate any device that supports UNMAP also supports ANCHOR.
