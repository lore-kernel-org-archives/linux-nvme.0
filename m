From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Sat, 18 May 2019 00:01:57 +0900
Subject: [PATCH 1/2] nvme: add thermal zone infrastructure
In-Reply-To: <2bf1e2cf-b922-d947-c939-375aba75994d@intel.com>
References: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
 <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com>
 <2bf1e2cf-b922-d947-c939-375aba75994d@intel.com>
Message-ID: <CAC5umygRTpq3GktaMKBdC8+-ghkJKCzFME+rm+V6vasrOAyOPw@mail.gmail.com>

2019?5?17?(?) 6:22 Heitke, Kenneth <kenneth.heitke at intel.com>:
>
>
>
> On 5/15/2019 9:17 AM, Akinobu Mita wrote:
> > The NVMe controller reports up to nine temperature values in the SMART /
> > Health log page (the composite temperature and temperature sensor 1 through
> > temperature sensor 8).
> > The temperature threshold feature (Feature Identifier 04h) configures the
> > asynchronous event request command to complete when the temperature is
> > crossed its correspoinding temperature threshold.
>
> s/correspoinding/corresponding/

OK.

> > +
> > +static void nvme_thermal_init(struct nvme_ctrl *ctrl)
> > +{
> > +     INIT_WORK(&ctrl->thermal_work, nvme_thermal_work);
> > +}
>
> Does this work queue need to be destroyed at some point?

This is work_struct, not workqueue.  So it can't be destroyed.
But I noticed that we should call flush_work for thermal_work at
unregistering thermal zone devices.
