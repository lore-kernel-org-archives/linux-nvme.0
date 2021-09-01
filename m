Return-Path: <SRS0=EXAn=NX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AD9C432BE
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 12:22:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF6C60BD3
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 12:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5EF6C60BD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YEGOUEuCd3jDVt+GQN1Gp8vmAtZ9GuWSJj/uVhU/frw=; b=bW4L1GEdTRn0l1
	nzxEq3ZOjlUOLRJAt2l7AJtQITxyyZ9+6s2tJqVkZrDGKDAESzjAqK+rPHXaWeouiSGtFQID1x0Hr
	xx7xPaqkIzGFTsaZqYKOjmpPwEoiIqDsxF8wHCD2XVmy6aUA03n6UM8gypXdZYGExWD8pvcJMs5Yv
	R0SQixwTCwxw2dq2dELcEQlQIzU9jd7RMPQ3W/tko5/CzfIW+KgKVEt0Xksdc97M7MyCCOPPDpH2I
	OnBzf1D2qmvzDACoGy0SNdUb3ZGKC76LIqBT9gRDvSVvWT7XXt6ZC58DSs/rXVqSM/k16jWRSQ12w
	oWWnrVo0SiXD7qI1STlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mLPFy-005upT-2w; Wed, 01 Sep 2021 12:22:18 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLPFq-005uoz-JI
 for linux-nvme@lists.infradead.org; Wed, 01 Sep 2021 12:22:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C0F186736F; Wed,  1 Sep 2021 14:22:05 +0200 (CEST)
Date: Wed, 1 Sep 2021 14:22:05 +0200
From: "hch@lst.de" <hch@lst.de>
To: sasaki tatsuya <tatsuya6.sasaki@kioxia.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] nvme: update keep alive interval when kato is modified
Message-ID: <20210901122205.GA10479@lst.de>
References: <894db4eeb08a4622aa1b08425cad0133@kioxia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <894db4eeb08a4622aa1b08425cad0133@kioxia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210901_052210_825716_112D94FD 
X-CRM114-Status: UNSURE (   9.39  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.15 with a few cosmetic fixups, including making
the From match the spelling of your name in the signoff to keep the
commit vs signoff bots silent.  I hope this ok, if you want a different
spelling let me know.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
