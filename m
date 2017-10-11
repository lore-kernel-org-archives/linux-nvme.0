From: james.smart@broadcom.com (James Smart)
Date: Wed, 11 Oct 2017 08:10:51 -0700
Subject: [PATCH v2 4/7] nvme_fc: add dev_loss_tmo to controller
In-Reply-To: <81f8a5be-4c46-d603-6494-145f1032b692@grimberg.me>
References: <20170927045046.22238-1-jsmart2021@gmail.com>
 <20170927045046.22238-5-jsmart2021@gmail.com>
 <20171005080040.GB5063@infradead.org>
 <9c9b8f0d-cc31-91ec-1be8-b5fd616dd0c5@gmail.com>
 <81f8a5be-4c46-d603-6494-145f1032b692@grimberg.me>
Message-ID: <f483c5dc-e5c3-ab1d-4419-919b8515dbb1@broadcom.com>

On 10/11/2017 3:17 AM, Sagi Grimberg wrote:
>
>> Hmm - this raise flags in my mind. I'm not sure how a dev_loss_tmo 
>> applies to any other transport other than FC.
>
> Can you explain what exactly do you mean by dev_loss_tmo only applies
> to FC?

Well I'm at a loss at how dev_loss_tmo could apply to another transport 
like RDMA or TCP. I'd like someone to explain it to me.

afaik - no other transport has events from the fabric when connectivity 
changes (perhaps on the otherside of a switch) thus the transport 
actively tracks connectivity to the other endpoint.? FC does. So we know 
almost immediately when a target port goes away. Dev_loss_tmo is a 
duration after initial connectivity loss where we wait and suspend 
devices attached to the fc port - both scsi and fc-nvme - allowing the 
port to come back and the os-device to resume operation. if it expires, 
the device is deleted.? It's existed on SCSI for many years.? So it's 
basically the same behavior as the ctrl_loss_tmo, but the timer is at 
the port level and spans multiple ctrl's. Given they were so similar, I 
munged the ctrl_loss_tmo and dev_loss_tmo together and timed things at 
the controller only. Now I'm regretting that choice and keeping things 
in their natural place: ctlr_loss_tmo a the ctlr level (regardless of 
connectivity, with immediate reconnect reschedule if no connectivity); 
and dev_loss_tmo at the fc port level (connectivity loss starts 
reset/reconnect on all, timeout deletes all).

-- james
