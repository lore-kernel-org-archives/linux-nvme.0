Return-Path: <SRS0=aIMh=YK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0729ECE58E
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2019 17:38:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B771D21925
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2019 17:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kxy/XC89";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBh4Zvvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B771D21925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z3WHM20xjwoM7YpZeG/FbipVp9kwVTWpZVXQKcZz908=; b=kxy/XC89QxoOiG
	icFGFgBiVetDeFmKAXiVawmoNlBEvmIGPVV70YNh99U+WgXS1jvTsR8NEqcc2CWWmHo1rdZcRKxWn
	udgHtICXSafnaN6ArBCbJ/CVuwCk6NC48JhqknVh6kDYimEwZF3tStFQ4W9hSZ0uWmBPyRNbcZ8fJ
	/mgixWpWRoB79xvVqSXP4AZAaiJ3E3ORznR+bSamR9tEkbk0Vc1sNDIj+9USnSeEaRdOi8MaNM2u8
	LJko4AovkmsZ0AprS9chGqA3MHWQQz4l10SbnPcQd38DzL8fDFiD100YWVmAUgGVdCOpOk3LXNY+i
	sChr0poHEKj/9bwr2aDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iL9j6-000843-LV; Thu, 17 Oct 2019 17:38:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iL9j0-0007ta-FJ
 for linux-nvme@lists.infradead.org; Thu, 17 Oct 2019 17:38:11 +0000
Received: from C02WT3WMHTD6 (unknown [8.36.226.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A252021835;
 Thu, 17 Oct 2019 17:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1571333888;
 bh=8z62F80tqg6N2820/YBtBzuF1LK9/mC60VqTI66tXA4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tBh4Zvvsfxi3fALxaZStp4IVlXpQ7Ma3Wp2cBU8DzS+YUtBXIIBIatUKHZ4gcVQ0W
 9InA3jR6DtFRCdjFzYEHIS57eWVgGdHYzaRFsiqK6TyJJXqcRhhO2fLKAPRxMEkMkC
 tLOVn+AemJVfYd+/gZfzfHoxus4KZOPIO7rFNcck=
Date: Thu, 17 Oct 2019 11:38:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme-pci: Set the prp2 correctly when using more than 4k
 page
Message-ID: <20191017173807.GA91017@C02WT3WMHTD6>
References: <20191017073428.46155-1-haokexin@gmail.com>
 <20191017145554.GA8676@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191017145554.GA8676@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191017_103810_550115_323BD6C3 
X-CRM114-Status: UNSURE (   8.01  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@fb.com>, Kevin Hao <haokexin@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/17/19, 1:40 AM, "Kevin Hao" <haokexin@gmail.com> wrote:
> +	unsigned int offset = bv->bv_offset % dev->ctrl.page_size;

Can we do this without the modulo in the io path? The page_size is a power of
2, so this should work:

	unsigned int offset = bv->bv_offset & (dev->ctrl.page_size - 1);

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
