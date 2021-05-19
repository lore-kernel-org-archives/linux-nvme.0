Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B59EC433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 06:35:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F037A611AE
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 06:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F037A611AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8rRsefVdR2YY0l/HT95d9VPCCP90HvBYlm2hfWMurRY=; b=KYOQ69QeM0CkV1kH2sCl96SQY
	G9u4Hsu+RgGr2rA9MRcia/v3rFhYTJqmuvvjoTIvNOaIk8/Cb8N73TY4qCIJyOZ1Qj6wl6Mt8l7Ri
	fPePt9G0GWnxRIQAEJTZtbg/f1aL6VwbwmWN4hq1Cqxd2ViG3Vk1y43NHwSI1nzvxl25CcovDHmFX
	cPMN4WsYrARW/S/vPYH23LuZdXjD6GeJGAMYElGGeu7jQVh8wTO6ZJGDi/WXGTTcyK9UXE+v9acHR
	qWNBzGrma6LdtxALnBPlRDPWs+QNyqdA4cZVNrYUe7+pVq3HN51q5xYgto7PYmM2ZB/ZaV+bAgIwi
	Jb98fLZyg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljFne-0030Mz-Jn; Wed, 19 May 2021 06:35:22 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljFnY-0030Kz-Kz
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 06:35:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=EyY3oFhiGOBiMf7bv2tjQUtQ4y8B0qLd3ccBuK1EdVQ=; b=00MgXvvru+S76lJ1jMoMZszAD1
 SE64DNz2yLG59PX9zNaMiL7G5yUqVgbxsKjxdsn0hRabO5N/HzjSP/MsO9bZe+Zxik7RNcN746hWm
 xRmXVKVf8r1ZBUaya8EAllI8yPzQ2SldSMD0kXyHrwj35Z26YOEqSaxtk0JRixglboJg1I0COSVMq
 31+pfbT0qLBC5xdLrHrgmVlvfK5dgBUv+tZZo2A1v4X++KZEtY9/HSTDAQzWdgykFMBLJKZPJU4sY
 jmXfWBQqTsEOemV5FR9kC/zGR5QPUWG5rzDFGzn2yXrBRauZ/cVxZbgO8u/sDbiJJ5pDod9yhKu6/
 uFoQyH0w==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljFnW-00FBO7-97
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 06:35:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8B44767373; Wed, 19 May 2021 08:35:11 +0200 (CEST)
Date: Wed, 19 May 2021 08:35:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de
Subject: Re: [RFC PATCH] nvme-tcp: rerun io_work if req_list is not empty
Message-ID: <20210519063510.GB30513@lst.de>
References: <20210517223643.2934196-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210517223643.2934196-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210518_233514_481783_C05EBBE0 
X-CRM114-Status: UNSURE (   8.22  )
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

applied to nvme-5.13 with the fixes tag added.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
