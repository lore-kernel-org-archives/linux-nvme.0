From: keith.busch@intel.com (Keith Busch)
Date: Wed, 21 Jun 2017 09:37:43 -0400
Subject: [PATCH V3 2/2] nvme: Add support for FW activation without reset
In-Reply-To: <876bfb79-9bf2-1def-2a4e-94d472c08868@samsung.com>
References: <1497078344-5509-1-git-send-email-a.dawn@samsung.com>
 <CGME20170610070845epcas1p361081521580b9ca7bf45605249f992e2@epcas1p3.samsung.com>
 <1497078522-5764-1-git-send-email-a.dawn@samsung.com>
 <20170619170551.GK21765@localhost.localdomain>
 <876bfb79-9bf2-1def-2a4e-94d472c08868@samsung.com>
Message-ID: <20170621133742.GA4962@localhost.localdomain>

On Wed, Jun 21, 2017@01:06:31PM +0530, Arnav Dawn wrote:
> On Monday 19 June 2017 10:35 PM, Keith Busch wrote:
> > On Sat, Jun 10, 2017@12:38:42PM +0530, Arnav Dawn wrote:
> >
> >> +				ctrl->fw_act_timeout = jiffies +
> >> +					msecs_to_jiffies(ctrl->mtfa * 100);
> > Instead of adding another field to the nvme_ctrl structure, just
> > calculate the timeout in your nvme_fw_act_work function.
>
> intention was to  set fw_act_timeout as soon as the AER is received.
> Since work could be scheduled after some time, setting timeout in
> work function would add that delay to it.

This feature doesn't require such tight constraints. The 100ms sleep
granularity in your CSTS.PP polling already exceeds the amount of time
it takes for work to schedule.

> >> +			else
> >> +				ctrl->fw_act_timeout = jiffies +
> >> +					msecs_to_jiffies(admin_timeout * 1000);
> >> +
> >> +			schedule_delayed_work(&ctrl->fw_act_work, 0);
> > If scheduling with 0 delay, why is this delayed work?
>
> I used delayed work so i could use cancel_delayed_work, as cancel_work
> was not available.

If you really have a use for cancel_work, you could send a patch to
export the symbol.

In any case, that's probably not going to do what you want. The work can
only be cancelled if it hasn't started, and since you start it without
delay, the work will likely be running. Maybe you want to add some other
criteria for the nvme_fw_act_work to end early, though I expect CSTS.PP
to clear if f/w load failed.

One last thing I noticed, it looks like the nvme_fw_act_work will break
if an IO timeout occurs while it's running since that may reset the
controller and restart IO queues.

> +    case NVME_AER_ERR_FW_IMG_LOAD:
> +        dev_warn(ctrl->device, "FW image load error\n");
> +        cancel_delayed_work(&ctrl->fw_act_work);
> +        break;
>      default:
