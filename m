From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 19 Oct 2017 13:36:50 +0300
Subject: [PATCH 03/17] block: provide a direct_make_request helper
In-Reply-To: <d8605553-ef38-4aa2-1513-39ae49de3856@grimberg.me>
References: <20171018165258.23212-1-hch@lst.de>
 <20171018165258.23212-4-hch@lst.de>
 <d8605553-ef38-4aa2-1513-39ae49de3856@grimberg.me>
Message-ID: <b4a2622d-a228-a6d8-769d-5b684ceff922@grimberg.me>


>> +/**
>> + * direct_make_request - hand a buffer directly to its device driver 
>> for I/O
>> + * @bio:? The bio describing the location in memory and on the device.
>> + *
>> + * This function behaves like generic_make_request(), but does not 
>> protect
>> + * against recursion.? Must only be used if the called driver is known
>> + * to not call generic_make_request (or direct_make_request) again from
>> + * its make_request function.? (Calling direct_make_request again from
>> + * a workqueue is perfectly fine as that doesn't recurse).
> 
> Question: are the double spaces on purpose?

Other than that,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
