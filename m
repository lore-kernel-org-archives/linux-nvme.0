From: jsmart2021@gmail.com (James Smart)
Date: Sat, 7 Oct 2017 09:08:21 -0700
Subject: [PATCH v2 4/7] nvme_fc: add dev_loss_tmo to controller
In-Reply-To: <20171005080040.GB5063@infradead.org>
References: <20170927045046.22238-1-jsmart2021@gmail.com>
 <20170927045046.22238-5-jsmart2021@gmail.com>
 <20171005080040.GB5063@infradead.org>
Message-ID: <9c9b8f0d-cc31-91ec-1be8-b5fd616dd0c5@gmail.com>

On 10/5/2017 1:00 AM, Christoph Hellwig wrote:
> Can you please add the dev_loss_tmo to the generic nvme_ctrl and build
> the infrastructure in common code?
> 
> Then as a next step we can look into inferring it from the remote port
> for FC.
> 

Hmm - this raise flags in my mind. I'm not sure how a dev_loss_tmo 
applies to any other transport other than FC.

I am inclined to rework this a bit though as I think the mashing of the 
dev_loss_tmo value into the controller's ctrl_loss_tmo has caused 
confusion. The dev_loss_tmo should stay in the transport and be specific 
to the remoteport.  Mashing them also caused us to loose the initial 
creation ctrl_loss_tmo value if there had been one set and the dev_loss 
value dynamically changed.  I'll rework it so that: dev_loss_tmo is an 
FC internal timer that acts on the remoteport.  Upon device loss, the 
remote ports dev_loss timer will be started, and any controllers on the 
remote port will have their associations torn down and their 
ctrl_loss_tmo (aka max_reconnects and reconnect_delay) started. If a 
controllers max_reconnects is hit it will be deleted. If the rport's 
dev_loss_tmo is hit, it will delete any suspended controller.

-- james
