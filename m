From: keith.busch@intel.com (Keith Busch)
Date: Thu, 30 Mar 2017 13:22:37 -0400
Subject: [PATCH] nvme: make nvme error status codes converted to errno
 detailed
In-Reply-To: <e81a210c-a911-b275-eb53-51ee9f3f7c5e@huawei.com>
References: <1490782103-14668-1-git-send-email-guanjunxiong@huawei.com>
 <20170330081107.GA2991@infradead.org>
 <e81a210c-a911-b275-eb53-51ee9f3f7c5e@huawei.com>
Message-ID: <20170330172236.GG20181@localhost.localdomain>

On Thu, Mar 30, 2017@07:32:50PM +0800, guanjunxiong wrote:
>    Current block layer ends the requests with errors and logs different errno in a
> human readable string. So I think the detailed conversion above make sense.Also ,
> as Sagi said, It'll be useful if we can log the specific error (as a human readable
> string).
>    Anyway, since this patch would conflict with your rework in this area,
> I decide to suspend this patch.
>    BTW, what's the plan of your rework in this area?

I don't see a problem having more appropriate errno's here. The block
layer looks okay to accept any value, and the spec folks might be happy
to see their thought out status codes don't all become EIO. :)

But just so we all know, the majority of those statuses are only possible
to encounter with passthrough, and those are not translated to errno.
