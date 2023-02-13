Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75C7C636D4
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 06:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KyvukF4j+V8aiFLmSm+1dzq03MiNS0feA3GICMUn0Ko=; b=UtC5XzLNZJQpsmGgTMW+TSgchT
	ReqnXQ0I/Wrv4yhhBEngpTfPLhqSVgBZ3HBdGvdjdMGWL0zdnoluPHvpF+SAIGSm5xhAALYolF2+F
	ESXJAZa+XuAmvcLnxX6+/jsCkmnzu7XJJhx+1QyOOVmEthwfZCtxIH7ARe+QygX6fYbf/b6xWJ1+R
	tQVONBEbxnWMYiCh4VmCsRg/3S56//PFwzK7v0OmskuyxdtoePcrPQeRtvU1wiVOksRUMR/E3zkI6
	F7x5iVj8mPKy7BskI6RishknYE6RqjSa4VbQBGy3I3rrePBmP2H70isBSQCZJ72qioIyzdfKHT4gJ
	UJ5DhgnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRSYF-00DNDQ-2u; Mon, 13 Feb 2023 06:42:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRSYA-00DNCV-KL
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 06:42:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C897A68BFE; Mon, 13 Feb 2023 07:42:50 +0100 (CET)
Date: Mon, 13 Feb 2023 07:42:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: max_hw_sectors error caused by recent NVMe driver commit
Message-ID: <20230213064250.GA14558@lst.de>
References: <BYAPR21MB1688B4BBFCCCD01C016A62D4D7DF9@BYAPR21MB1688.namprd21.prod.outlook.com> <20230213055945.GA13648@lst.de> <BYAPR21MB1688F70E49AAD658D86C439DD7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1688F70E49AAD658D86C439DD7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230212_224254_998947_2F14729C 
X-CRM114-Status: GOOD (  13.02  )
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

On Mon, Feb 13, 2023 at 06:41:12AM +0000, Michael Kelley (LINUX) wrote:
> Any reason to use dev->dev instead of &pdev->dev?  They should be
> the same, but with everything else in this function using &pdev->dev,
> the lack of consistency suggests there might be a reason.

No good reason - the code started with copy and paste from the previous
location and I can fix this up.

