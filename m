From: keith.busch@intel.com (Keith Busch)
Date: Fri, 23 Jun 2017 11:25:46 -0400
Subject: [PATCH V3 2/2] nvme: Add support for FW activation without reset
In-Reply-To: <7c382f8a-12cc-566b-f461-1bc40ccf751c@samsung.com>
References: <1497078344-5509-1-git-send-email-a.dawn@samsung.com>
 <CGME20170610070845epcas1p361081521580b9ca7bf45605249f992e2@epcas1p3.samsung.com>
 <1497078522-5764-1-git-send-email-a.dawn@samsung.com>
 <20170619170551.GK21765@localhost.localdomain>
 <876bfb79-9bf2-1def-2a4e-94d472c08868@samsung.com>
 <20170621133742.GA4962@localhost.localdomain>
 <7c382f8a-12cc-566b-f461-1bc40ccf751c@samsung.com>
Message-ID: <20170623152546.GB7783@localhost.localdomain>

On Fri, Jun 23, 2017@05:41:21PM +0530, Arnav Dawn wrote:
> 
> On Wednesday 21 June 2017 07:07 PM, Keith Busch wrote:
> >
> > One last thing I noticed, it looks like the nvme_fw_act_work will break
> > if an IO timeout occurs while it's running since that may reset the
> > controller and restart IO queues.
>
> could you please clarify more?
> I think ,that, if an IO Timeout resets controller and restarts queue,
> the nvme_ctrl_pp_status will return false, ending the nvme_fw_act_work.

Sure, the nvme_fw_act_work will observe CSTS.PP cleared, then it restarts
the IO queues, but the nvme reset requires those queues to be quiesced.
