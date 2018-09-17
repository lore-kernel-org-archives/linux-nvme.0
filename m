From: james.smart@broadcom.com (James Smart)
Date: Mon, 17 Sep 2018 09:07:54 -0700
Subject: [REPOST][PATCH] nvme_fc: add 'nvme_discovery' sysfs attribute to
 fc transport device
In-Reply-To: <20180917134127.GA6009@infradead.org>
References: <20180820220611.8769-1-jsmart2021@gmail.com>
 <20180911085843.GA17520@infradead.org>
 <c806be1b-f86f-de84-3669-d9bb89aaaf65@gmail.com>
 <20180917134127.GA6009@infradead.org>
Message-ID: <4667d394-999c-652d-b45d-d3cb9c02ec31@broadcom.com>



On 9/17/2018 6:41 AM, Christoph Hellwig wrote:
> On Tue, Sep 11, 2018@11:02:13AM -0700, James Smart wrote:
>> Well, I don't think I agree with you on the safeness of the locking, but
>> moving it to the other style isn't different and looks more normal. I'll
>> rework it.
> You are iterating the list without the lock and only take the lock
> to remove the entry - this is racy vs another thread adding to or
> removing from the list.

:)? By definition, there is only one thread processing a list. Lock was 
only to be coherent on the entry being on a list or not vs another thread.

But we're good.? The rework was a good idea.? Thanks.

-- james
