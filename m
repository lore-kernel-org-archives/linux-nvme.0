From: scott.bauer@intel.com (Scott Bauer)
Date: Thu, 17 Aug 2017 11:42:25 -0600
Subject: [PATCH] nvme: Honor RTD3 Entry Latency for shutdowns
In-Reply-To: <yq1o9rektt3.fsf@oracle.com>
References: <20170816195552.22492-1-martin.petersen@oracle.com>
 <20170816202543.ilkhynyffe2tjrl7@sbauer-Z170X-UD5>
 <yq1wp63qlug.fsf@oracle.com>
 <20170817150113.GL7233@localhost.localdomain>
 <yq1o9rektt3.fsf@oracle.com>
Message-ID: <20170817174224.tkgrkl4hp2yjgkag@sbauer-Z170X-UD5>

On Thu, Aug 17, 2017@01:06:32PM -0400, Martin K. Petersen wrote:
> 
> Keith,
> 
> >> > My only concern is if this value extends past the DPM_WATCHDOG
> >> > timeout value. If it does we're going to end up panic()ing the
> >> > kernel during suspends. If others agree I think we should set it to
> >> > the minimum value of DPM_WATCHDOG_TIMEOUT and shutdown_timeout.
> >> 
> >> I don't have a problem with that. Keith?
> >
> > Sounds good to me as well.
> 
> Hrm, this gets pretty messy.
> 
> DPM_WATCHDOG_TIMEOUT is buried deep in the config options (hidden behind
> PM_DEBUG and EXPERT). And as a result doesn't appear to be enabled in
> most common kernel configs. It also isn't exported from the PM subsystem
> in a generic way.
> 
> In addition, I'm not sure what we'd do in case a device demands a 10
> second shutdown time but the user has the kernel configured with a 2
> second DPM watchdog. Then what? The device is still going to take 10
> seconds to complete the shutdown request.

ugh, I thought it would be as easy as if (IS_ENABLED(CONFIG_DPM_WATCHDOG))
but I guess since that's a runtime check GCC cant remove the scope below,
since it's not known at compilation time.

We wont be able to fix this without some gross ifdefs/ifndefs.

I guess we can do a dev_warn() or something if the shutdown time is >
than some threshold instead? That way if people are getting sporatic
panics on suspends we can see that warning and fix it from there?
