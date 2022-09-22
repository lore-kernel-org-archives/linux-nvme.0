Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDBCC6FA8B
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 05:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XUnKYtObNMFbyVscw/xnJ9ggE3pFmwJj1a9hRrGBILo=; b=tjD/ME7WDeWX2hpHaJqis+x6lZ
	/w4WfOYF4xBxpOYiR0Ykal6+moRyggbfNs+6SuVAsYpQH84IDCKkJCll3XS7RpxsMKhhZI+yve65H
	eRMebX7/4OqwH4h7ayMu5LT+jmwEHisqqx0TIxt+syIUx6NK8YiVyn//H0B10KcrcCtVwu1rvRekR
	PbOj59ARV28HsHgmoHVV83JAplgZggOTAutE/OtwSKjnCHbQ0aAQb704WBosxd+hHN18d2iVatfMj
	dv0dncXlx6eN0XFnS5JCSs6Jc2LaZEmRbFOsWZuFyvMdH3S772tv4tnHERbM+PScA56HeTCx3qdo0
	NvYXIU0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obF24-00DRmc-HV; Thu, 22 Sep 2022 05:45:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obF22-00DRm6-41
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 05:45:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4574468AFE; Thu, 22 Sep 2022 07:45:50 +0200 (CEST)
Date: Thu, 22 Sep 2022 07:45:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Leng <lengchao@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 01/13] nvme: add common helpers to allocate and free
 tagsets
Message-ID: <20220922054549.GB27338@lst.de>
References: <20220920171611.1289361-1-hch@lst.de> <20220920171611.1289361-2-hch@lst.de> <c9bc8a76-94aa-5a4c-526e-f92204635a22@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9bc8a76-94aa-5a4c-526e-f92204635a22@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_224554_326544_EB61BF3B 
X-CRM114-Status: GOOD (  18.35  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 21, 2022 at 11:37:08AM +0800, Chao Leng wrote:
>> +	ctrl->connect_q = blk_mq_init_queue(set);
>> +        if (IS_ERR(ctrl->connect_q)) {
>> +		ret = PTR_ERR(ctrl->connect_q);
>> +		goto out_free_tag_set;
>> +	}
> Maybe we should move the connect_q related code to nvme_alloc_admin_tag_set.
> Thus we don't need to set NVMF_RESERVED_TAGS for tagset,
> if there are large amount of ns queues, it will save resources.
> At the same time, it will simplify tagset-based implementation.
> According to the behavior logic, connect_q is a management resource.
> However, connect_q use the I/O tagset.
> As a result, it is difficult to process some logic based on tagset.

The fabrics connect command needs to be sent on each of the I/O
queues in addition to the admin queue, which means the admin tag_set
can't be used.


