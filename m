Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329DAC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jun 2022 17:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xBM3SjSADpCtaGTcU20MqvmhiyUnvgFDR0aC/pBuNI4=; b=scQasdSZZ8g1syGZeFNXkugo5V
	Mzk9M7k3ewsk3S1zkiau8db3QcItyTlCe9UPIkdZx+dmU3G5K4p7i87aQcKw2OVSbVlyKUFE1E2Iz
	19AaCagYq000rm35FjwH2ItRD8ZNA3E/iV2chlZNJ4KAeKgMgK4YRrE5RJpJpwTkTRsKn4mN8CwGH
	I5aHdG8gydU1OI5ClkZRiAcH3lpE0bnZpKmqkwzCTfim97Sxn/qkp8G9AmyxuQE0soVgEWc7TYrla
	nOIkkUwlV6cTssx7g7fFPyBNzU1QbEqaKvAE7gS7T1UbU/GA37vj2KWFf8+m3+DQwgdM3D4pje5wA
	kwPWLGeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0oKw-00546U-Gb; Mon, 13 Jun 2022 17:58:50 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0oKv-00545Z-7O
	for linux-nvme@bombadil.infradead.org; Mon, 13 Jun 2022 17:58:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xBM3SjSADpCtaGTcU20MqvmhiyUnvgFDR0aC/pBuNI4=; b=UClJuvRhNaDsUFljZ9lmC9HoSe
	DVnqsN0syuSgosoqmeOIESxidQ7XfLmfmeZgvj8EUDEQiHk9+6+fWF6zl5hSHG/SZ8G+b+TymgPGq
	Wi7jSR5YrV6LghKaw0ro0zkuDImE/qQi2q3dhRCu4F0f8ebJFT35oSXrH9omncdtRTvlSn8HSvRN1
	0dbZ5/qgVEYLyXmi0aOWkLmAhRLkHtqoQMI/6tjdIgDLl8ntkVHdyMyvgEMRm2J2k464I4fptz8JS
	7qnvp4qIfY5f8SOrfnHeVgvwGzdtA8Ois1o6CTB7ZaRsSrvpunTpgeIUArTMTloxl6Zs4tNgQZ1h9
	bO5IkJjQ==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0oKh-007dEq-1X
	for linux-nvme@lists.infradead.org; Mon, 13 Jun 2022 17:58:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EDC2068AFE; Mon, 13 Jun 2022 19:58:16 +0200 (CEST)
Date: Mon, 13 Jun 2022 19:58:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: "rasheed.hsueh" <rasheed.hsueh@lcfc.corp-partner.google.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Rasheed.Hsueh@lcfuturecenter.com, wuxy23@lenovo.com,
	gwendal@chromium.org, rasheed.yh@gmail.com
Subject: Re: [PATCH v1 1/1] nvme-pci: disable write zeros support on UMIC
 and Samsung SSDs
Message-ID: <20220613175816.GD15847@lst.de>
References: <20220610062734.9927-1-rasheed.hsueh@lcfc.corp-partner.google.com> <20220610062734.9927-2-rasheed.hsueh@lcfc.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610062734.9927-2-rasheed.hsueh@lcfc.corp-partner.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_185844_817328_FE3F230B 
X-CRM114-Status: UNSURE (   7.60  )
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

applied to nvme-5.19.

