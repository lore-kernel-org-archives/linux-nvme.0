From: jsmart2021@gmail.com (James Smart)
Date: Mon, 14 May 2018 08:48:05 -0700
Subject: [PATCH] nvme: block ioctls if controller not in a live state
In-Reply-To: <20180514152308.GF7772@localhost.localdomain>
References: <20180507225558.5009-1-jsmart2021@gmail.com>
 <20180514152308.GF7772@localhost.localdomain>
Message-ID: <7f15fa07-3a67-4f95-78e9-307fee0b4a13@gmail.com>

On 5/14/2018 8:23 AM, Keith Busch wrote:
> On Mon, May 07, 2018@03:55:58PM -0700, James Smart wrote:
>> Rather than allow ioctl-based admin cmds to get intermixed on the admin
>> queue with commands being used to initialize a controller or io commands
>> to go to a controller in reconnect thus possibly hanging, reject them
>> if the controller isn't in the LIVE state. Reject with an -EAGAIN status
>> so that the app knows it could retry.
> 
> The admin ioctl is fine to use in ADMIN_ONLY state as well.
> 

Yep, I would need to take that state into account. For now, looks like 
I'll be adding poll support and reposting.

-- james
