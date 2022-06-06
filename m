Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9442C43334
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jun 2022 15:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1zznGX1VKxVZgKqg4YLxt14GAsA+sglKgQWrfChAXzE=; b=xHuiN+BG6N+GTEULS/AFvH1OmQ
	syMwZ+E52v99geTqHWqby8awF4qsRzi+kM8/DH1nokWvtzDvbSTySI0Xb6opaf0XpNurA6M6pd5NG
	NyTeimYwj1V5GKmdhUeV9jDvdNYTUbOqkxEC/C1xOvlbuKSuHbxnrvBDAsL4fSbqryCU9r2h4N/gU
	i9S+6ePR20IQgIiFgGl2zBt5LUwcHEmSBY2RmwFxspQjvbAzQrcr50xDLFfbVrGnG6JSd+Zol+MMG
	dQMOv342Ln1+0WJuuHqHPHW5DZjf0VVFdhAlqrQtq5B7N0u82AxzU8z4vJpvw7H7diGHLFHCXJE8/
	SgYFz/wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyEKZ-001hK7-LS; Mon, 06 Jun 2022 15:07:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyEKU-001hHP-9C
	for linux-nvme@lists.infradead.org; Mon, 06 Jun 2022 15:07:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7DD4868BEB; Mon,  6 Jun 2022 17:07:39 +0200 (CEST)
Date: Mon, 6 Jun 2022 17:07:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Stefan Reiter <stefan@pimaker.at>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA XPG
 GAMMIX S50
Message-ID: <20220606150739.GA9697@lst.de>
References: <20220606130116.87146-1-stefan@pimaker.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606130116.87146-1-stefan@pimaker.at>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_080742_546496_7447534A 
X-CRM114-Status: UNSURE (   9.07  )
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

Thanks,

I'll add this to the nvme-5.19 tree in a bit.

