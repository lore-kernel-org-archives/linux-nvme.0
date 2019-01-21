From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 21 Jan 2019 09:50:16 -0800
Subject: [PATCH] nvme-multipath: drop optimization for static ANA group IDs
In-Reply-To: <20190121135025.GB25858@lst.de>
References: <20190109084515.82076-1-hare@suse.de>
 <20190119131956.GB24374@lst.de>
 <e0416085-b02f-3578-c3aa-02296b040aef@grimberg.me>
 <20190121135025.GB25858@lst.de>
Message-ID: <e326e2c1-18ed-34ef-7ec2-d224f9cbefd1@grimberg.me>


>>> Ok, based on the version that actually keeps the optimization I
>>> have to say I actually prefer this variant, given that it is a lot
>>> less code and special cases.  Sorry for sending you off the wrong track.
>>>
>>> Reviewed-by: Christoph Hellwig <hch at lst.de>
>>
>> Oh, so this ends up preferred over v2... I don't have any problem
>> with allocating for the worse case here...
>>
>> Doesn't look like this is urgent for 5.0 rc, shall we queue it
>> for 5.1?
> 
> Without it we use unallocate memory if the controller sets bit 6
> in anacap.  So yes, I think it should go into 5.0 and -stable.

OK, applied to nvme-5.0
