From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 30 Mar 2017 23:51:01 -0700
Subject: [PATCH] nvme: supplement nvme error status code enum items in
 linux/nvme.h
In-Reply-To: <480997ba-4ee6-0b5a-3581-56c401b2254e@huawei.com>
References: <1490709577-8204-1-git-send-email-guanjunxiong@huawei.com>
 <480997ba-4ee6-0b5a-3581-56c401b2254e@huawei.com>
Message-ID: <20170331065101.GA14519@infradead.org>

On Fri, Mar 31, 2017@09:48:46AM +0800, Guan Junxiong wrote:
> Does this patch which supplements  those left-out status codes/values  look good ?

It looks fine.  Where fine means it looks correct but I don't see the
point of adding status values not actually used in the kernel.
