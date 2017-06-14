From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Wed, 14 Jun 2017 12:59:56 -0300
Subject: [PATCH] nvme: Add support to create and send kobject
 uevents(uevents) when asynchronous events are received.
In-Reply-To: <cb923969-0547-5db1-d88a-bd214c72d200@huawei.com>
References: <1496670185-17020-1-git-send-email-zouming.zouming@huawei.com>
 <20170605174527.GB5432@infradead.org>
 <cb923969-0547-5db1-d88a-bd214c72d200@huawei.com>
Message-ID: <1e104af1-170c-5a7b-3849-cecb906d7310@linux.vnet.ibm.com>

On 06/06/2017 03:30 AM, Zou Ming wrote:
> Hi Christoph :
> 
>     I have found a discussions on the AERs in the history mail list (http://lists.infradead.org/pipermail/linux-nvme/2016-June/005118.html) before, and implemented the uevents mechanism based on the discussions.
> But didn't find the source patch that was mentioned in your email. Can you tell me where patch is?
>     And the modified patch will send later.
> 
> Best.
> 
> On 2017/6/6 1:45, Christoph Hellwig wrote:
>> Keith sent a patch for notifying userspace on AERs a while ago,
>> but the comments on the patch need to be addressed first.
>>
>> .
>>

I guess this one was what Christoph mentioned:
http://lists.infradead.org/pipermail/linux-nvme/2017-March/008909.html


> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 
