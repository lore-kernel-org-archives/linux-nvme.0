From: keith.busch@intel.com (Keith Busch)
Date: Thu, 8 Nov 2018 15:19:28 -0700
Subject: [PATCH v2 1/1] nvmet: debug namespace noiob boundary emulation
In-Reply-To: <79a9960e-9d6d-220b-64b7-91dec2edc85a@grimberg.me>
References: <20181030175729.25011-1-sagi@grimberg.me>
 <20181108091239.GB4160@lst.de>
 <79a9960e-9d6d-220b-64b7-91dec2edc85a@grimberg.me>
Message-ID: <20181108221928.GC2932@localhost.localdomain>

On Thu, Nov 08, 2018@02:11:00PM -0800, Sagi Grimberg wrote:
> > > Useful to exercise the host driver to noiob support without
> > > having device that actually require it. name it with a debug
> > > prefix such that it is clear that its a debug feature.
> > 
> > I'd really prefer to have a new CONFIG_NVME_TARGET_DEBUG
> > or similar config symbol so that we can not build these purely
> > debug knobs if desired.
> 
> Really? I don't think this is worth it, we already have a tone of
> build time config options (https://lwn.net/Articles/733418/) and having
> another knob for small debug options for our nvmet is not helping.
> Also it will also introduce some annoying ifdefs and more 0-day
> testing complaints in the future. And, it is also sometimes annoying
> to have to rebuild a kernel (or module) especially when debugging on
> a station without access to modify the running source code.
> 
> So I'm not sure I agree with this preference. But I'm not completely
> against it, can we have more people share their thoughts here?

I'd honestly prefer the nvme target simply provide useful functionality
for end users rather than take on the responsibility of a test vehicle
for host drivers.

I don't contribute much to the target, though, so I'd yield to those who
do if they really consider these features to be worth maintaining.
