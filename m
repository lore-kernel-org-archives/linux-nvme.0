Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32580C352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 14:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sFY04rsAj3ogD0v6uO8C45PHFHOx735U7yJ0DgGjOYw=; b=WKRBtHDkAW+3ArUoUiljcza2fx
	/y8JcrICqyB99XhJzjEP0/WZzLp5WqhX+qA2oZzeM9rHWVcNQCKdZSsvqVb4GmUwbXz3/xQylK59d
	NvM0NguQXmgdHxG9kWqT+R9E/GZ4wVxSo86z4WPBsLLj3N7YwzdCn6nAmFZ5dja1NDi6jVxOnn8ZT
	PhD6cM8VL2WYBzvdLK8pXCTEeS6n7oBocZ5dojWtOnXKpQnZJGsHT/AkAx0nSnWwZLpay8f/Yc6RE
	yiEDbdXFPxacIwO5ndzokriJ0W2R69EmeJ6HvxIDG6ldkpGtBr6D7tnuTGudf/3/cxMVc229jKGwJ
	q8zE3/9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Z5m-00BDbh-SD; Tue, 06 Dec 2022 14:38:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Z5i-00BDLG-U7
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 14:38:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5F8F668B05; Tue,  6 Dec 2022 15:38:32 +0100 (CET)
Date: Tue, 6 Dec 2022 15:38:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/5] nvme: consolidate setting the tagset flags
Message-ID: <20221206143832.GA31036@lst.de>
References: <20221130174240.227616-1-hch@lst.de> <20221130174240.227616-3-hch@lst.de> <3b03aa7f-ea25-2973-3efc-900676f11220@huawei.com> <20221206084621.GA9440@lst.de> <de84ad28-3e3f-e287-b103-bc1de3278b99@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de84ad28-3e3f-e287-b103-bc1de3278b99@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_063839_171900_5CE6A222 
X-CRM114-Status: GOOD (  14.09  )
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

On Tue, Dec 06, 2022 at 01:59:45PM +0200, Sagi Grimberg wrote:
>
>> On Tue, Dec 06, 2022 at 04:43:45PM +0800, Chao Leng wrote:
>>> tcp should set NVME_F_BLOCKING in ctrl->ops->flags, I did not see that in this patch.
>>> Did I miss something?
>>
>> No, I missed that I got lost during my rebase.
>
> With that looks good,

I've fixed that up and did a full blktests run with trtype=tcp.

With that I've pulled this and the remove cleanup series into nvme-6.2.

Thanks to everyone for the reviews!

