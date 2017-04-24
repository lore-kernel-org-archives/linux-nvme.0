From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 24 Apr 2017 07:58:42 -0700
Subject: [PATCH] nvme: avoid connecting to the same subsystem from the
 same path gain.
In-Reply-To: <1493040417-15680-1-git-send-email-guanjunxiong@huawei.com>
References: <1493040417-15680-1-git-send-email-guanjunxiong@huawei.com>
Message-ID: <20170424145842.GA32128@infradead.org>

On Mon, Apr 24, 2017@09:26:57PM +0800, Guan Junxiong wrote:
> From: Junxiong Guan <guanjunxiong at huawei.com>
> 
> Current code has the defect that we will get more /dev/nvme#n#
> generated in the /dev node if we execute the same connect command
> with nvme-cli tools more than once.

That's not a bug, it's a a feature.
