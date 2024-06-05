Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E98C25B76
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 07:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NPzymWGZFZtOe+/jKRLbVu5DHM/rAWyTP2BsW0jWWww=; b=uoqOLmCBm2y61gu13Mn3wEFPEB
	UGi6Lt4NMsk2qIqasQ/ODe9TCHrYEOCAvUoSKP+ocJDV2dycCxHc/WTzJBHzkRY8khv9deViE0DG1
	DPxibu3gNto7+TztteKE+QoXrZbor9OiWy6cnJwGUN62qCugvmd7xOehgjppUGUY2PBzjb2Eeh/fy
	HQHu4QI04CGjDP7FdQgbzGDPnNGGooS3gD5HufMKIm2KyokJrftIgmt2/Q9QDxaroTL7BLU9tauTJ
	wjHUk69P01VY8/CEJg/2uGUQqA2I+qy/SfyiAWtq08KJyiZ6p8LxI6ROy0PiaUoxc/7ZgJB3AAZDY
	IqhKAcEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEl2c-00000004zqg-2Le6;
	Wed, 05 Jun 2024 07:26:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEl2Y-00000004zph-3fUj
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 07:26:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D0E7868D0D; Wed,  5 Jun 2024 09:26:26 +0200 (CEST)
Date: Wed, 5 Jun 2024 09:26:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	mlombard@redhat.com, hare@suse.de, shinichiro.kawasaki@wdc.com,
	james.smart@broadcom.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 0/5] nvme: fix initialization memleak
Message-ID: <20240605072626.GA16180@lst.de>
References: <20240604185908.3703052-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604185908.3703052-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_002635_079675_8CFD72A0 
X-CRM114-Status: UNSURE (   8.07  )
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

The whole series looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>


