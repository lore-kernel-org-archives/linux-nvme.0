From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 20 Sep 2017 14:27:58 +0300
Subject: [PATCH] nvme: allow timed-out ios to retry
In-Reply-To: <20170918002713.GA20043@infradead.org>
References: <20170907201804.24979-1-jsmart2021@gmail.com>
 <20170907203759.GA2832@localhost.localdomain>
 <20170918002713.GA20043@infradead.org>
Message-ID: <4201794f-94ac-5825-44f8-715dda700223@grimberg.me>

>> I'm a bit conflicted on this. While it'd be nice to give commands a chance
>> to succeed after a timeout handling's controller reset, some uses would
>> rather a command fail fast than succeed slow, and this change could keep
>> a request outstanding for a very long time.
> 
> That's what we have the fastfail flags for, which we set for all
> the internal commands for example? and evaluate just a little bit
> above the start_time line.

I'm 100% on board with this change!

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
