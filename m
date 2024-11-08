Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584B6D5C0E5
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 15:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eIRw5fKnjdSN7XwVFaJn+Fov1RPuLcOs5rI4EZ6cg7s=; b=A6vUqiHtKGBpyDdn030s8elLQU
	akhwy4/zBJ+XJXMFvpviNVKu972YLCRME5Uule0MIrEwV9dBbgcnWaSS5IIxxyrtGxEj6YwYaw2A6
	DyabOmpAVZZs+NX5d0GOtD56sb/8aN7nqqH2WzT9TR9jpLCtn2ZNIlQPmkkdPhSju8cGF9e1g5X8V
	bc7RNCyrheJZVRbWIqzAplmGb83If2BEM3eSKC3Ho7xWlgN9e5/Qrh+p3YxpPN1iRKg5EC8bLT3fe
	Bs7mIvj8oNpURvFcQ+Sqjgfrmge+yAaeunJoRyfOhu+gbuwu322XJ9wK6Jk83Y/XoQdLyCGs+WGIY
	wGxiEYmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9QXw-0000000AxZ6-2flx;
	Fri, 08 Nov 2024 15:05:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Pwg-0000000AqXj-1wFf
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 14:26:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C471B68AA6; Fri,  8 Nov 2024 15:26:39 +0100 (CET)
Date: Fri, 8 Nov 2024 15:26:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, m@bjorling.me,
	matias.bjorling@wdc.com, kch@nvidia.com, kanie@linux.alibaba.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 09/13] nvmet: implement csi identify ns
Message-ID: <20241108142639.GE6694@lst.de>
References: <20241107193849.995554-1-kbusch@meta.com> <20241107193849.995554-10-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107193849.995554-10-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_062642_670541_40989887 
X-CRM114-Status: UNSURE (   8.27  )
X-CRM114-Notice: Please train this message.
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

Looks good with the missing anagripd endianess conversion added:

Reviewed-by: Christoph Hellwig <hch@lst.de>


