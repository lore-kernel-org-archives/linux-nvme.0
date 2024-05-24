Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8DFC25B74
	for <linux-nvme@archiver.kernel.org>; Fri, 24 May 2024 07:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SszaC0X1d02cuFwqqc9U5r+VRNmz8ITYeF1N+FvVkxU=; b=cFx+Pdgnn8ldDv5LFI3vMGV6MX
	wISMAX1pJ/Fofj6he7SMQs4zzsHVBt6li2uZzaca5aFsAtP7X1oYgKWD0qqAQ/g4SgAUn48zJURlb
	J2SmvXWO2FxKDU7VBr4COLoikqVL5CWpRc06KsZl6dg7/uzW8SrNJNM8iZzXMP74nl9k3JFkvTBvR
	BhB9LbF79BUHTWS2NY35rPSweneFihp2zmjIdBqg8Zl5QbGDZJK19a+L3MZTEZBmuCL+sFxWSpGqb
	ymXglr/iqnNUw6mFnqVFzRgNEdDAl2gN3HlthtFXZ+XEIo8zlqIkB34qDNWVDdGxlMehJBYXvNMHa
	gOyGI6tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAPZK-00000008IMN-2MVL;
	Fri, 24 May 2024 07:42:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAPZG-00000008IJf-3dm4
	for linux-nvme@lists.infradead.org;
	Fri, 24 May 2024 07:42:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D30D368B05; Fri, 24 May 2024 09:42:19 +0200 (CEST)
Date: Fri, 24 May 2024 09:42:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com, hch@lst.de,
	sagi@grimberg.me, axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] nvme: use srcu for iterating namespace list
Message-ID: <20240524074219.GB17251@lst.de>
References: <20240523172050.4080218-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523172050.4080218-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240524_004223_286200_0ADF943C 
X-CRM114-Status: GOOD (  11.45  )
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

> -	ns = list_first_entry(&ctrl->namespaces, struct nvme_ns, list);
> -	if (ns != list_last_entry(&ctrl->namespaces, struct nvme_ns, list)) {
> +	ns = list_first_or_null_rcu(&ctrl->namespaces, struct nvme_ns, list);
> +	if (!ns) {
>  		dev_warn(ctrl->device,
>  			"NVME_IOCTL_IO_CMD not supported when multiple namespaces present!\n");
>  		ret = -EINVAL;
> @@ -808,14 +808,14 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp,
>  	dev_warn(ctrl->device,
>  		"using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!\n");
>  	kref_get(&ns->kref);

This still needs to use a kref_geT_unless_zero as mentioned in the last
round.


