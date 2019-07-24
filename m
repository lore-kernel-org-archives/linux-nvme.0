From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 24 Jul 2019 11:16:42 -0700
Subject: [PATCH] nvme-tcp: Use protocol specific operations while reading
 socket
In-Reply-To: <20190724070107.GA2450@lst.de>
References: <20190708095200.15921-1-bharat@chelsio.com>
 <20190724062836.GA25058@chelsio.com> <20190724063324.GA1999@lst.de>
 <20190724065858.GA25528@chelsio.com> <20190724070107.GA2450@lst.de>
Message-ID: <2f7c6f5c-efb1-a16c-1d10-b253dbb5da0a@grimberg.me>


>>>> Hi Sagi/Christoph,
>>>> Can this be queued for rc?
>>>
>>> How is this a -rc candidate?  I was planning on queuing it up for 5.4444.
>> I believe its a trivial one, so was hoping it could get into immediate rc(rc-2).
>> If you think otherwise I am fine with 5.4 also.
> 
> It does look trivial, but that isn't really the criteria for rc time
> inclusion, the prime criteria is if is an important bug fix.

Yea, this is 5.4 for sure...
