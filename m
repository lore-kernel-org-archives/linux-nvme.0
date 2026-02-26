Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDA9FD8FCB
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 15:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=eS2U+KZPNbisI9o3ZgTXC+7GA5
	O6Twk2u6CowEIy/Coq+y4PEFEvQWRQ8rsSkSx0MwWmh7wPrw9k03ytg3hA28StGrHmTCT7GmryUOt
	wxwBj72unlAd36F5NwO9A0i0xMC5rdVT24zO/ZxnmP/3AstYtKH+RXmnMR5kOKEOMlJLk7CgDELKi
	Q1fv7aySdlTzSAiBGQsXPO0pTJrTuIRkBt/wHDSeUEdiAB9AcCY6r65luziohC8j6g5TBtT66IwWZ
	Bibnrj/mmoziOtzoNhuow501ZI4LeVnH360PN6UrTmWBB4oFsHiPTWBWOmzQxEXBUtWrGKUt4EO1M
	5N3h1ILg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvdNQ-00000006WKv-0Puo;
	Thu, 26 Feb 2026 15:34:08 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvdNO-00000006WKX-1N8g
	for linux-nvme@bombadil.infradead.org;
	Thu, 26 Feb 2026 15:34:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=eqD/FLR4pDw4Wazo57XHN0x3o3
	69zcXO+8y0Lj5lpRlZMsAI636KWiaC2xPPFLhHPu8j7BeIL3a/iV5zRJKleSTg3jiU0eJ6y/xMFts
	MEnBx3QhZpE1LpO9qIAx273v/z6CBtxjrP6lzIfqBjVNs+vU3xpUtXA3dvdqlK0yxj3cirb6FWGAK
	ZghcAmApoyesH1M4ve2Cs1AnfgdqnEDMsPAczuQ+mNEUI0uLVdAVks3UF6q+Dbo6eQbIKDqNQVaxX
	dXfVb1Iu7VXcHGO5t3E9Cu0ldoqqZEoOj4oP82oqREw7TcBw8m3YlttMgrP2isq3k2C3PbJ+lK8FG
	M5+ejqXg==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvdNL-0000000BKsb-1pHr
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 15:34:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4DF6068CFE; Thu, 26 Feb 2026 16:33:59 +0100 (CET)
Date: Thu, 26 Feb 2026 16:33:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, wagi@monom.org,
	shinichiro.kawasaki@wdc.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2] nvmet: move async event work off nvmet-wq
Message-ID: <20260226153358.GC31398@lst.de>
References: <20260226043003.160555-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226043003.160555-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_153403_578460_5EA09F5E 
X-CRM114-Status: UNSURE (   9.31  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


