From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 2 Jun 2017 22:25:47 -0700
Subject: [PATCH 1/2] nvme-cli: add fields into identify controller data
 structure
In-Reply-To: <e704f915-f08f-6fe9-1132-81d7b6845c7d@163.com>
References: <1496387899-26012-1-git-send-email-guanjunxiong@huawei.com>
 <1496387899-26012-2-git-send-email-guanjunxiong@huawei.com>
 <20170602074600.GA11424@infradead.org>
 <e704f915-f08f-6fe9-1132-81d7b6845c7d@163.com>
Message-ID: <20170603052547.GB14365@infradead.org>

On Sat, Jun 03, 2017@11:08:54AM +0800, guanjx09 wrote:
> Hi,Christoph
> 
> On Friday, June 02, 2017 03:46 PM, Christoph Hellwig wrote:
> > Please also add them to the kernel copy of the header so that they
> > stay in sync.  Except for that his looks fine to me:
> > 
> > Reviewed-by: Christoph Hellwig <hch at lst.de>
> > 
> 
> Here is the patch which adds those fields into nvme_id_ctrl structure
> in the kernel copy of the header. Does it looks good?

It does.  I'll apply it once the branch for Linux 4.13 is open.
