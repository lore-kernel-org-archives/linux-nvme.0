Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B73C30658
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jun 2024 06:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sKohXuC3ZAf8k7XZYuCkYima2qDbkZiCaW0PmntYqYk=; b=PN4hhTe9kYLyev9v1tk0YAQIar
	XH+DPfC45PPbi6C32NmJN8us4wVeDYkeHqVkf4FQauK9mqPcmYC6Pxn5ZGHVHxe0KqDK0Rt4Oy3ex
	WjRv+56n15wghUO04uUxPm7aK6xrflVVIVZrmTPnqE8JlaThpKKIoKqfuv0z2CzxO3Lg4FZ8zDFDK
	pZB6V+Ez7MPQonwoWlrMHDgvJgOrfm1VBHCfJDxsMkFbhx9CnsVwLjXtqeNmTgabnpUsbcb/2HP7B
	qcAK9PmrYde6OrPHMnLrS1c80d4HAreGH/a504hoWmUlPQlQsFRXFUba3NC0FLbcwKt9SqukwXw+m
	cZGAVFNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMiGW-00000009LEw-43bO;
	Thu, 27 Jun 2024 06:05:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMiGT-00000009LEF-1Sz6
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jun 2024 06:05:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BCAEF68CFE; Thu, 27 Jun 2024 08:05:43 +0200 (CEST)
Date: Thu, 27 Jun 2024 08:05:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: asml.silence@gmail.com, mpatocka@redhat.com, axboe@kernel.dk,
	hch@lst.de, kbusch@kernel.org, martin.petersen@oracle.com,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v2 00/10] Read/Write with meta/integrity
Message-ID: <20240627060542.GA15865@lst.de>
References: <CGME20240626101415epcas5p3b06a963aa0b0196d6599fb86c90bc38c@epcas5p3.samsung.com> <20240626100700.3629-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626100700.3629-1-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_230550_073959_E446FD80 
X-CRM114-Status: UNSURE (   7.87  )
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

What tree does this apply to?  There's quite a few rejects vs
for-6.11/block.


