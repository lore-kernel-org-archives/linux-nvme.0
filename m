Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA45CC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 13:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BR8QsH7M1qYAHvtVWFXEH7EJAVprX3PfWXrZM3sSi1M=; b=DNHV6WfbC427iJp9E7Vo56Cckw
	c1NflSQtBRd/x1mPTbPdOnrLrzh/RCs5n31gaw/NcNGuf2qbTl4xFjcz+lGD/KnZLigyepjJCfynU
	GRie2sSaYZLpgfKklXOVRwPztOydLiVk9C68jq/gdfksEFuzB0rpy9aqjsOvS4mqP3EFUl4CW3qhr
	uxuNQgcMFALur/MQjTnGW/VB/Q7rENSJYsLMh2ExcRKLWSPgHL/7MyXGTlSkq5g317Z2KJWVWYgt2
	TLqJZpxW5LDvbF2ZwWZDFQlBsJLvji84sI2Q/Gs4JMRrU2WlI1qPrqVtLvc3tSzCvneo/7J5o1A84
	w84HNtsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovINF-003qe1-GW; Wed, 16 Nov 2022 13:22:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovINC-003qW4-SV
	for linux-nvme@lists.infradead.org; Wed, 16 Nov 2022 13:22:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 15A2668D06; Wed, 16 Nov 2022 14:22:26 +0100 (CET)
Date: Wed, 16 Nov 2022 14:22:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, lengchao@huawei.com,
	linux-nvme@lists.infradead.org, Gerd Bayer <gbayer@linux.ibm.com>
Subject: Re: [PATCH] nvme: don't call blk_mq_{,un}quiesce_tagset when
 ctrl->tagset is NULL
Message-ID: <20221116132225.GA8071@lst.de>
References: <20221116072711.1903536-1-hch@lst.de> <e5de54b2-4906-9902-c150-732718a77571@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5de54b2-4906-9902-c150-732718a77571@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_052239_099852_44166E24 
X-CRM114-Status: GOOD (  12.56  )
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

On Wed, Nov 16, 2022 at 03:20:23PM +0200, Sagi Grimberg wrote:
>>   {
>> +	if (!ctrl->tagset)
>> +		return;
>
> Can this be placed in the pci code instead?

There's nothing PCIe-specific about this case.  All fabrics drivers
support controllers with I/O queues and thus the I/O tagset, e.g.
discovery controllers.

