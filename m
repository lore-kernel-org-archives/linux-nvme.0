From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 24 May 2018 07:57:58 -0600
Subject: [PATCHv2 0/8] nvme timeout fixes v2
In-Reply-To: <20180524032257.GB15354@ming.t460p>
References: <20180522220332.9244-1-keith.busch@intel.com>
 <20180523030057.GF31196@ming.t460p>
 <20180523161614.GE11037@localhost.localdomain>
 <20180524032257.GB15354@ming.t460p>
Message-ID: <20180524135757.GI11037@localhost.localdomain>

On Thu, May 24, 2018@11:23:07AM +0800, Ming Lei wrote:
> On Wed, May 23, 2018@10:16:14AM -0600, Keith Busch wrote:
> > On Wed, May 23, 2018@11:00:59AM +0800, Ming Lei wrote:
> > > Looks V2 still may trigger IO hang warning:
> > 
> > Anything in particular that triggered this?
> 
> I am running the modified block 011:
> 
> diff --git a/tests/block/011 b/tests/block/011
> index 62e89f758ef1..5f71f8b9aca0 100755
> --- a/tests/block/011
> +++ b/tests/block/011
> @@ -44,10 +44,10 @@ test_device() {
>                         --ignore_error=EIO,ENXIO,ENODEV &
>  
>         while kill -0 $! 2>/dev/null; do
> -               echo 0 > "/sys/bus/pci/devices/${pdev}/enable"
> -               sleep .2
> -               echo 1 > "/sys/bus/pci/devices/${pdev}/enable"
> -               sleep .2
> +               setpci -s "${pdev}" 4.w=00:04
> +               sleep .01
> +               setpci -s "${pdev}" 4.w=04:04
> +               sleep .01

Okay, fair enough. Easy enuogh to fix.

Just a reality check here, what is your expectation for this test? Any
driver should just give up on device truly behaving this way should.

> io-timeout can't trigger admin IO timeout, just found that yesterday's hang
> follows warning of 'Trying to free already-free', so it should be related
> with admin queue, and not take a close look at your V2 yet, but seems
> you don't address the issues handled by the following patches:
> 
> https://marc.info/?l=linux-block&m=152644343805986&w=2
> https://marc.info/?l=linux-block&m=152644344805995&w=2
> https://marc.info/?l=linux-block&m=152644346006002&w=2

Right, I had said those patches were fine. I wasn't trying to duplicate
them here, but I'll be sure to do so in the next round.
