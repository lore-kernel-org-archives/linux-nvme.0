From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 8 Nov 2018 14:11:00 -0800
Subject: [PATCH v2 1/1] nvmet: debug namespace noiob boundary emulation
In-Reply-To: <20181108091239.GB4160@lst.de>
References: <20181030175729.25011-1-sagi@grimberg.me>
 <20181108091239.GB4160@lst.de>
Message-ID: <79a9960e-9d6d-220b-64b7-91dec2edc85a@grimberg.me>


>> Useful to exercise the host driver to noiob support without
>> having device that actually require it. name it with a debug
>> prefix such that it is clear that its a debug feature.
> 
> I'd really prefer to have a new CONFIG_NVME_TARGET_DEBUG
> or similar config symbol so that we can not build these purely
> debug knobs if desired.

Really? I don't think this is worth it, we already have a tone of
build time config options (https://lwn.net/Articles/733418/) and having
another knob for small debug options for our nvmet is not helping.
Also it will also introduce some annoying ifdefs and more 0-day
testing complaints in the future. And, it is also sometimes annoying
to have to rebuild a kernel (or module) especially when debugging on
a station without access to modify the running source code.

So I'm not sure I agree with this preference. But I'm not completely
against it, can we have more people share their thoughts here?
