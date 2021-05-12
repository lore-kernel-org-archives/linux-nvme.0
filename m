Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454C2C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 17:50:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78A8561412
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 17:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A8561412
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7xin8YcM8UXA1N0nCbD4BbyDBrLeWo+T/XKKPOETZ9c=; b=n9g7KlDOi5Gm+ol+Quopui9YY
	i9/G/MkDpodhCHUi10tIN2M7Z9X6KjSNyZ8RmTXSlCwLBjz36RIfeIz4inmMI2UGiImVlBHeCYEUZ
	6MP5UQgZ+0lym4U2ef9S92ZIFjIzkRZ093K5YUiT5m78Bxx3/zHlzG3q7XnaZSdvVG8gTHTKFD2lF
	L5hKCFEWcXSmlwJbZhPnGHQ4GRoGDzTC6AvldCCuvMGzWLCWzZqGV/LMq6bo1bEWyD/37RV6ljbl7
	qj8n8a7QijZEmKtjLyOh6ZBSwU3tVbQDuXrspCszfTRsCf0faLYUWaUQe0FPP5DV7dNpmaa4OUKpV
	G+yD5Z8zw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgszc-003URU-9G; Wed, 12 May 2021 17:49:58 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgszY-003UQx-K0
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 17:49:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=JfcaAWiL9MX/KzgqZFMd5GxaGaNC7KsyrSBFfXwwLXo=; b=bZDPk+ZFl0021ULLcEd8R+huxU
 94juavYrhRTqGZb8EkjoyAFYs3JVHAj09d42xb/qjzcs6mhwSx7cxFNroI0UPeVG9NZARcvastJpe
 EDak2xpPdXgEBIGGhI1bTDmhqprpFCL2bNnjPi6FVMbUv3L6GDMLELkUJFQ93TTmGUBvC7ST+AgnI
 0vJCs+kpfBnC2e+6PKcP/0u5kbF4xmGYuATE97nzerIaRnEGny6Ucn9jjVJEeIR/g8NLOft1Ccq3r
 uaHqCTkW5WmN/fk3owJvM2Emj/iRAHD4q1OUBpP6oiIs0tM9AbiRL7oDBU3grSWS0aj8Gk03udwlT
 XM3eEsSg==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgszV-00AfFh-N2
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 17:49:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8180967373; Wed, 12 May 2021 19:49:42 +0200 (CEST)
Date: Wed, 12 May 2021 19:49:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Enzo Matsumiya <ematsumiya@suse.com>
Subject: Re: [PATCH v3] nvmet: Reset ns->file when open fails
Message-ID: <20210512174942.GA26130@lst.de>
References: <20210512145005.103653-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210512145005.103653-1-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_104949_917871_FFC44257 
X-CRM114-Status: UNSURE (   8.04  )
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

applied to nvme-5.13.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
