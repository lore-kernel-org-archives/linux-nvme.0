From: keith.busch@intel.com (Keith Busch)
Date: Thu, 10 Aug 2017 13:11:50 -0400
Subject: [PATCH] nvme-cli: fix connecting failure due to invalid uuid
 format of hostid
In-Reply-To: <20170810090958.GA3880@infradead.org>
References: <1501767496-14144-1-git-send-email-guanjunxiong@huawei.com>
 <20170810090958.GA3880@infradead.org>
Message-ID: <20170810171150.GF14634@localhost.localdomain>

On Thu, Aug 10, 2017@02:09:58AM -0700, Christoph Hellwig wrote:
> On Thu, Aug 03, 2017@09:38:16PM +0800, Guan Junxiong wrote:
> > When we connect or discover a target with --hostid option via the
> > /etc/nvme/hostid file, we fails this operation because the hostid
> > is only 35 not 36 bytes which doesn't pass the uuid checking in the
> > kernel.The last character is overridden with null bytes because fgets
> > reads at most one less than sizeof of buffer characters.
> > 
> > Signed-off-by: Guan Junxiong <guanjunxiong at huawei.com>
> 
> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>

I meant to reply to this one instead of the nvme_fc patch. This one to
nvme-cli is applied.
