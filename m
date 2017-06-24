From: hch@lst.de (Christoph Hellwig)
Date: Sat, 24 Jun 2017 09:11:05 +0200
Subject: [PATCH V3 2/2] nvme: Add support for FW activation without reset
In-Reply-To: <7c382f8a-12cc-566b-f461-1bc40ccf751c@samsung.com>
References: <1497078344-5509-1-git-send-email-a.dawn@samsung.com>
 <CGME20170610070845epcas1p361081521580b9ca7bf45605249f992e2@epcas1p3.samsung.com>
 <1497078522-5764-1-git-send-email-a.dawn@samsung.com>
 <20170619170551.GK21765@localhost.localdomain>
 <876bfb79-9bf2-1def-2a4e-94d472c08868@samsung.com>
 <20170621133742.GA4962@localhost.localdomain>
 <7c382f8a-12cc-566b-f461-1bc40ccf751c@samsung.com>
Message-ID: <20170624071105.GC14437@lst.de>

On Fri, Jun 23, 2017@05:41:21PM +0530, Arnav Dawn wrote:
> 
> On Wednesday 21 June 2017 07:07 PM, Keith Busch wrote:
> > On Wed, Jun 21, 2017@01:06:31PM +0530, Arnav Dawn wrote:
> >> On Monday 19 June 2017 10:35 PM, Keith Busch wrote:
> >>> On Sat, Jun 10, 2017@12:38:42PM +0530, Arnav Dawn wrote:
> >>>
> >>>> +				ctrl->fw_act_timeout = jiffies +
> >>>> +					msecs_to_jiffies(ctrl->mtfa * 100);
> >>> Instead of adding another field to the nvme_ctrl structure, just
> >>> calculate the timeout in your nvme_fw_act_work function.
> >> intention was to  set fw_act_timeout as soon as the AER is received.
> >> Since work could be scheduled after some time, setting timeout in
> >> work function would add that delay to it.
> > This feature doesn't require such tight constraints. The 100ms sleep
> > granularity in your CSTS.PP polling already exceeds the amount of time
> > it takes for work to schedule.
> i agree, i will update it in next version.
> >>>> +			else
> >>>> +				ctrl->fw_act_timeout = jiffies +
> >>>> +					msecs_to_jiffies(admin_timeout * 1000);
> >>>> +
> >>>> +			schedule_delayed_work(&ctrl->fw_act_work, 0);
> >>> If scheduling with 0 delay, why is this delayed work?
> >> I used delayed work so i could use cancel_delayed_work, as cancel_work
> >> was not available.
> > If you really have a use for cancel_work, you could send a patch to
> > export the symbol.
> >
> > In any case, that's probably not going to do what you want. The work can
> > only be cancelled if it hasn't started, and since you start it without
> > delay, the work will likely be running. Maybe you want to add some other
> > criteria for the nvme_fw_act_work to end early, though I expect CSTS.PP
> > to clear if f/w load failed.
> you are right, if the device sends Firmware image load error AER,
> CSTS.PP is probably cleared, and the nvme_fw_act_work will end.
> so i think nothing needs to be done on FW Image load error AER.

please make sure you do a cancel_work_sync there and in the controller
removal path to make sure we don't have a work item lingering around.
