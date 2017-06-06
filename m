From: zouming.zouming@huawei.com (Zou Ming)
Date: Tue, 6 Jun 2017 14:30:38 +0800
Subject: [PATCH] nvme: Add support to create and send kobject
 uevents(uevents) when asynchronous events are received.
In-Reply-To: <20170605174527.GB5432@infradead.org>
References: <1496670185-17020-1-git-send-email-zouming.zouming@huawei.com>
 <20170605174527.GB5432@infradead.org>
Message-ID: <cb923969-0547-5db1-d88a-bd214c72d200@huawei.com>

Hi Christoph :

    I have found a discussions on the AERs in the history mail list (http://lists.infradead.org/pipermail/linux-nvme/2016-June/005118.html) before, and implemented the uevents mechanism based on the discussions.
But didn't find the source patch that was mentioned in your email. Can you tell me where patch is?
    And the modified patch will send later.

Best.

On 2017/6/6 1:45, Christoph Hellwig wrote:
> Keith sent a patch for notifying userspace on AERs a while ago,
> but the comments on the patch need to be addressed first.
> 
> .
> 
