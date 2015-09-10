From: keith.busch@intel.com (Keith Busch)
Date: Thu, 10 Sep 2015 13:46:49 +0000 (UTC)
Subject: [PATCH] NVMe: Force cancel commands on hot-removal
In-Reply-To: <CAPYzm7QwDTj+5eqcT4WGGNdLjEoAg1T7hDSH-dBQsCa++0Ostw@mail.gmail.com>
References: <1441743187-12277-1-git-send-email-keith.busch@intel.com>
 <CAPYzm7Sm4K-VVWxGLAD2sjJ_e=FL3aQor8npN4sVcJ6irBtzJg@mail.gmail.com>
 <CAPYzm7RB-LqEW1f0e-_Sh_ui3vS6q3sEOQ7sk5xfsOEG9SOVmg@mail.gmail.com>
 <alpine.LNX.2.00.1509091339130.23840@localhost.lm.intel.com>
 <CAPYzm7Sspbga3DkAyKC_gq1Y_2Em9GEE8mdn5x_0Z=-vXyZQVg@mail.gmail.com>
 <alpine.LNX.2.00.1509091620350.23840@localhost.lm.intel.com>
 <CAPYzm7S650StbfGhEiTsnXnvwFK_XvS5w1OeFAxZG88-oiaZig@mail.gmail.com>
 <CAPYzm7QwDTj+5eqcT4WGGNdLjEoAg1T7hDSH-dBQsCa++0Ostw@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1509101345580.23840@localhost.lm.intel.com>

On Thu, 10 Sep 2015, Mohana Goli wrote:
> I called?nvme_freeze_queues before calling nvme_ns_remove in nvme_dev_remove,which seems to be solved ?the problem.

Great! I thought that would do it, but I've some tests that seem to
get 1 IO lost somewhere in the block layer (thinking maybe it's in the
ctx->rq_list, still trying to confirm). That failure doesn't happen very
often though.


> On Thu, Sep 10, 2015@4:14 PM, Mohana Goli <mohana.goli@seagate.com> wrote:
>       Yes,i think we should call "nvme_freeze_queues" before deleting the gendisk.Right now that is no op since we are calling after deleting the name space.
> 
> On Wed, Sep 9, 2015@10:00 PM, Keith Busch <keith.busch@intel.com> wrote:
>       On Wed, 9 Sep 2015, Mohana Goli wrote:
>             I ran another test after creating filesystem on the nvme
>             devices.Unfortunately i have seen the IO Timeouts again.
>             I used the following steps:
> 
>
>       I guess we need stop the h/w queues first, then. I thought killing it
>       would have sufficed, but inflight commands will make it to the driver.
> 
> 
> 
> 
>
