From: james.smart@broadcom.com (James Smart)
Date: Wed, 9 May 2018 09:29:13 -0700
Subject: [PATCH] nvme: block ioctls if controller not in a live state
In-Reply-To: <20180509051156.GB28673@infradead.org>
References: <20180507225558.5009-1-jsmart2021@gmail.com>
 <20180509051156.GB28673@infradead.org>
Message-ID: <06b65874-8bc8-b532-ad98-44e64b8440b8@broadcom.com>



On 5/8/2018 10:11 PM, Christoph Hellwig wrote:
> On Mon, May 07, 2018@03:55:58PM -0700, James Smart wrote:
>> Rather than allow ioctl-based admin cmds to get intermixed on the admin
>> queue with commands being used to initialize a controller or io commands
>> to go to a controller in reconnect thus possibly hanging, reject them
>> if the controller isn't in the LIVE state. Reject with an -EAGAIN status
>> so that the app knows it could retry.
> -EAGAIN implies that you can poll for the fd to be ready, so I think
> this is the wrong error code here.

That is the exact intent.? I do want the app to trigger off -EAGAIN in 
those two states and try again after a delay./? Perhaps I should change 
from !LIVE to NEW || RESETTING || CONNECTING to be more explicit.? I 
assumed !LIVE was sufficient as the other states should transition to 
LIVE or the delete path is taken which would remove the fd all together.

-- james
