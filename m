From: rakesh@tuxera.com (Rakesh Pandit)
Date: Mon, 5 Jun 2017 11:44:34 +0300
Subject: [PATCH] nvme: fix hang in remove path
In-Reply-To: <244bc065-92eb-c3e0-faa7-11569fc326d6@grimberg.me>
References: <20170602083208.4518-1-ming.lei@redhat.com>
 <20170602180435.GA23335@dhcp-216.srv.tuxera.com>
 <244bc065-92eb-c3e0-faa7-11569fc326d6@grimberg.me>
Message-ID: <20170605084434.GA30864@dhcp-216.srv.tuxera.com>

On Sun, Jun 04, 2017@06:24:09PM +0300, Sagi Grimberg wrote:
> 
> > It would make sense to still add:
> > 
> > if (ctrl->state == NVME_CTRL_DELETING || ctrl->state == NVME_CTRL_DEAD)
> > 	return
> > 
> > inside nvme_configure_apst at the top irrespective of this change.
> 
> I'm not sure what is the value given that it is taken care of in
> .queue_rq?

We would avoid getting error message which says: "failed to set APST
feature 7".  Why an error if controller is already under reset.

Note 7 here is NVME_SC_ABORT_REQ.  Also we would avoid walking through
all power states inside the nvme_configure_apst as
nvme_set_latency_tolerance was called with value
PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT (-1) which sets
ctrl->ps_max_latency_us to U64_MAX and tries to send a sync command
which of course fails with error message.
