Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B49C43334
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jun 2022 10:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xBM3SjSADpCtaGTcU20MqvmhiyUnvgFDR0aC/pBuNI4=; b=BtMEN6a/Wi41PikLRG2yGPXUJ0
	rvleagTIY9C8K/9iZIsHLxfVyZmXgakqUiJf7SfD9oQw3VYTBsOF9ImrCgwPXeVnXDn8MtxFZDuJV
	mTMV3uLicncEAbGews4Oe2xqQOKvH7kMDt9mGy/RTlRcz37NBELi9lm4H9rOeE3Ks6dYe5vjkRQzu
	dAd6p96uhvDEbHSCaNVuo1mlsHNvtI8LOtjVkiNrF6/+nAjn3T9e+DPDKGKuXlC937a166ta1YBcl
	meLo+ioezW4oFC9IwJ2EeyOb9nMgkpDEj03kBD9zIxlA18C63tAwN6L6Jzzc2o2nscq9pewUY5xCu
	mLivfwTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyWPJ-006dQ5-Kb; Tue, 07 Jun 2022 10:25:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyWG5-006Zey-Sl
	for linux-nvme@lists.infradead.org; Tue, 07 Jun 2022 10:16:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9498267373; Tue,  7 Jun 2022 12:16:18 +0200 (CEST)
Date: Tue, 7 Jun 2022 12:16:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Xiang wangx <wangxiang@cdjrlc.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Fix syntax errors in comments
Message-ID: <20220607101618.GA23881@lst.de>
References: <20220604143254.15638-1-wangxiang@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220604143254.15638-1-wangxiang@cdjrlc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220607_031622_127378_0D484225 
X-CRM114-Status: UNSURE (   8.32  )
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

