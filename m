From: keith.busch@intel.com (Keith Busch)
Date: Wed, 17 Sep 2014 08:28:07 -0600 (MDT)
Subject: Question on IOStat accounting
In-Reply-To: <067e01cfd273$76dbc4e0$64934ea0$@samsung.com>
References: <067e01cfd273$76dbc4e0$64934ea0$@samsung.com>
Message-ID: <alpine.LRH.2.03.1409170820490.4696@AMR>

On Wed, 17 Sep 2014, Indraneel Mukherjee wrote:
> In the current implementation of IO accounting in the nvme driver,
> accounting is started once IOD is successfully prepared.
> Thereafter 2 cases can happen, either IO gets successfully submitted to
> device or it can get queued up in the IOD list if there is a failure.
>
> So what's the definition of iostat here? In-flight in the device or
> in-flight in the driver ? Is there a need to make this consistent?

It seems consistent with other block drivers. Usually stats are handled
above the device driver at the request layer, but bio-based drivers
handle the stats on their own.
