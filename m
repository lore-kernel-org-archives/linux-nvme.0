From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 17 Aug 2018 15:09:40 -0700
Subject: memleak on hot unplug
In-Reply-To: <7516FE0D-1C04-4110-98C4-77810BC63A9A@javigon.com>
References: <7516FE0D-1C04-4110-98C4-77810BC63A9A@javigon.com>
Message-ID: <2186ac17-6079-50be-d6c0-ff42abc555f0@grimberg.me>


On 08/14/2018 01:34 AM, Javier Gonz?lez wrote:
> While reviewing Hannes' sysfs patches on top of Christoph's nvme-4.19, I
> came across a leak when hot unplugging the controller. The leak seems to
> be introduced by nvme_init_ctrl:dev_pm_qos_update_user_latency_tolerance()
> 
> A quick check shows that neither dev_pm_qos_expose_latency_tolerance()
> nor dev_pm_qos_hide_latency_tolerance() are being called in
> nvme_init_identify().
> 
> I don't know this part enough to come up with a fix, but I hop it is
> enough info for you.

CCing Andy.
