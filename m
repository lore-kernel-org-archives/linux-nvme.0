From: axboe@fb.com (Jens Axboe)
Date: Wed, 23 Sep 2015 14:40:21 -0600
Subject: [PATCH] NVMe: Set affinity after allocating request queues
In-Reply-To: <alpine.LNX.2.00.1509232035500.23840@localhost.lm.intel.com>
References: <1441289897-16839-1-git-send-email-keith.busch@intel.com>
 <alpine.LNX.2.00.1509232035500.23840@localhost.lm.intel.com>
Message-ID: <56030E35.3060400@fb.com>

On 09/23/2015 02:37 PM, Keith Busch wrote:
> On Thu, 3 Sep 2015, Keith Busch wrote:
>> The asynchronous namespace scanning caused affinity hints to be set
>> before
>> its tagset initialized, so there was no cpu mask to set the hint. This
>> patch moves the affinity hint setting to after namespaces are scanned.
>
> Hi Jens,
>
> Would it be okay to get this merged in for 4.3? The affinity hint is
> very important to top out performance, so this should be considered a
> bug that the setting wasn't correct.

I haven't seen this patch, but yes if it's not setting the right hints, 
then it should be fixed as that is certainly a potentially big 
performance issue. In general we're still in dire need of having a 
proper way of having this done without a lot of driver interaction. I'd 
really love to see a framework that just has the driver ask blk-mq for a 
set of handlers, and blk-mq will set with the hints that it has already 
assigned. I might even have promised to write this, I should get around 
to do that... But I don't think it should be a gating factor for this 
fix, though it still needs to get done.

-- 
Jens Axboe
