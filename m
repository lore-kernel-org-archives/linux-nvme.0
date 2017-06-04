From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 4 Jun 2017 18:24:09 +0300
Subject: [PATCH] nvme: fix hang in remove path
In-Reply-To: <20170602180435.GA23335@dhcp-216.srv.tuxera.com>
References: <20170602083208.4518-1-ming.lei@redhat.com>
 <20170602180435.GA23335@dhcp-216.srv.tuxera.com>
Message-ID: <244bc065-92eb-c3e0-faa7-11569fc326d6@grimberg.me>


> It would make sense to still add:
> 
> if (ctrl->state == NVME_CTRL_DELETING || ctrl->state == NVME_CTRL_DEAD)
> 	return
> 
> inside nvme_configure_apst at the top irrespective of this change.

I'm not sure what is the value given that it is taken care of in
.queue_rq?
