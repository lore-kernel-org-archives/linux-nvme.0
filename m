From: jsmart2021@gmail.com (James Smart)
Date: Wed, 9 May 2018 16:20:19 -0700
Subject: [PATCH] nvme: block ioctls if controller not in a live state
In-Reply-To: <20180508071556.455kfgioocke47ju@linux-x5ow.site>
References: <20180507225558.5009-1-jsmart2021@gmail.com>
 <20180508071556.455kfgioocke47ju@linux-x5ow.site>
Message-ID: <71188ad3-d815-d24f-2af7-11036806d847@gmail.com>

On 5/8/2018 12:15 AM, Johannes Thumshirn wrote:
> On Mon, May 07, 2018@03:55:58PM -0700, James Smart wrote:
>> Rather than allow ioctl-based admin cmds to get intermixed on the admin
>> queue with commands being used to initialize a controller or io commands
>> to go to a controller in reconnect thus possibly hanging, reject them
>> if the controller isn't in the LIVE state. Reject with an -EAGAIN status
>> so that the app knows it could retry.
> 
> Shouldn't the nvmf_check_if_read() calls in the transport drivers'
> ->queue_rq() callouts handle this?
> 


yes - but if things reach that layer, the return status for the ioctl 
can be quite different.  (if I read things right) The core routines are 
coded so that if there's a hard error, a -Exxx status will be returned. 
Otherwise, it returns the nvme_req(req)->status value (assumed positive 
big value). Which means, if the if_ready checks reject it, it'll go back 
with an NVME_SC_ABORT_REQ status. Which means the cli gets a convoluted 
error response. For the cases where it would be blocked by controller 
state, I want an -EAGAIN status so that the app knows it can retry and 
it should succeed sometime in the future.  Any other status - the app 
gives up and accepts the status value.

-- james
