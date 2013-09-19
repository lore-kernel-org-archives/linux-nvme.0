From: keith.busch@intel.com (Keith Busch)
Date: Thu, 19 Sep 2013 15:25:19 -0600 (MDT)
Subject: [PATCH 3/9] NVMe: Fail device if unresponsive during init
In-Reply-To: <20130919202957.GH4668@linux.intel.com>
References: <1378413915-16667-1-git-send-email-keith.busch@intel.com>
 <1378413915-16667-4-git-send-email-keith.busch@intel.com>
 <20130919202957.GH4668@linux.intel.com>
Message-ID: <alpine.LRH.2.03.1309191440330.31457@AMR>

On Thu, 19 Sep 2013, Matthew Wilcox wrote:
> On Thu, Sep 05, 2013@02:45:09PM -0600, Keith Busch wrote:
>> -		if (res)
>> +		if (res) {
>> +			if (res < 0)
>> +				goto out_free;
>>  			continue;
>> +		}
> Feels a little klunky.  How about:
>
> 		res = nvme_identify(dev, i, 0, dma_addr);
> -		if (res)
> +		if (res < 0)
> +			goto out_free;
> +		else if (res)
> 			continue;

Aha, that is much more pleasent.

>>  		res = nvme_get_features(dev, NVME_FEAT_LBA_RANGE, i,
>>  							dma_addr + 4096, NULL);
>> -		if (res)
>> +		if (res) {
>> +			if (res < 0)
>> +				goto out_free;
>>  			memset(mem + 4096, 0, 4096);
>> +		}
>
> I don't know if we need to do this.  Consider a hypothetical device that
> has a broken get_features, but everything else works fine.  We can still
> use that device just fine.  Contrariwise, if the device happens to break
> between issuing the identify and get_features, we'll still error out
> really soon afterwards.

The fault is really on the hardware in such a scenario (get features
support is mandatory), but I'm not sure we want to do what you're
suggesting. It will take 1 minute per namespace before completing probe so
a user could be waiting a very long time for a driver to load. This would
also leak command id's and we only have 64 of them; if the device has
more than 64 namespaces, modprobe blocks forever on alloc_cmdid_killable
until a user kills the task which may not be possible if this is happening
on boot.
