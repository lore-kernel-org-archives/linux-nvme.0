From: keith.busch@intel.com (Keith Busch)
Date: Thu, 11 Jun 2015 14:20:45 +0000 (UTC)
Subject: NVME 1.2 support
In-Reply-To: <FF0E019DD74E2349AE9109F955A784D00EDFC61D@chn-hclt-mbs06.HCLT.CORP.HCL.IN>
References: <FF0E019DD74E2349AE9109F955A784D00EDFC52A@chn-hclt-mbs06.HCLT.CORP.HCL.IN>
 <alpine.LNX.2.00.1506101344540.15930@localhost.lm.intel.com>
 <FF0E019DD74E2349AE9109F955A784D00EDFC61D@chn-hclt-mbs06.HCLT.CORP.HCL.IN>
Message-ID: <alpine.LNX.2.00.1506111418080.15930@localhost.lm.intel.com>

On Wed, 10 Jun 2015, Rama kiran kumar Indrakanti wrote:
> On Wed, 10 Jun 2015, Rama kiran kumar Indrakanti wrote:
>>> Would like to know if NVME 1.2 spec is supported in the open source.
>>> As per the linux-driver-information page it says 1.0c.
>
>> Is there a particular 1.2 feature you're asking about?
> I am looking for get log page

That's a 1.0 feature, but you're looking for this in the driver? I'm
not sure what a driver would do with that. You can get any arbitrary
log page from user space, though.
