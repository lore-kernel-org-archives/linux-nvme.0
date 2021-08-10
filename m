Return-Path: <SRS0=1Q2H=NB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383B7C4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Aug 2021 16:24:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA46F60F94
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Aug 2021 16:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EA46F60F94
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zaC5yn4VHhEc0voZLQ0Ks9ECVyiBdb4//wwq21vMRRA=; b=XvA/2er7rd9guw
	LuML31TP6tTjxVG1GURrAK1Qv3QSZH0EW7+fTyk2PVMJK+c/YxI0MPTfvuoiG12Zhkagv7u0vd01r
	3eUY0XZNUCeKPqdvbRXvCxg7lkdjAFgl5qvXI5vPqbVleWP9OPajOpHTwYo/4G/tsium7q071IdOk
	r1Drh25941jh9olo8wpoU3g7Vo5EHSL5ClPvxMCFCPFSf7ItRiicnaLNWyBJzmru+AHloox2j4paP
	WA6hMzMGwf6MPqpIvbrYX5cNeahj8w3dsymBUwYZgxYVwi2Iq8vZg3tOJLEYwKH8V2xRrZu2Hlx67
	j/IrnHocWQs7GaVYCYiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mDUXS-004RgX-AR; Tue, 10 Aug 2021 16:23:38 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDUXR-004Rg2-HV
 for linux-nvme@bombadil.infradead.org; Tue, 10 Aug 2021 16:23:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=/q1ZC5iTRiRncSvUpnNYMdG1GH4u2c3ETZb7jAJ6dFc=; b=JGFNR7I43+8L7mycvvAGV8npgZ
 2V3d05W+xHnez4olLdvPOI2XPOq11Xelcr3ze7EC/y3mO2XqpNlvHBj+RXwSZQGoWexXzqnjZiejB
 WazG0lYeS2niR+gevZtLyyaM9aRWHS6KtzfE666wnV5Bht3EO+OPekIOh5AKbNM+KdCVgN9iYo8Fp
 pT39SOcNV+FA6j8MEl+cTT+cihQRY/S1PEnd5BKI32E3J93Uz/lZAMAaaBuXfjXoqk9lN2Iw1l5bU
 Cy2JGfCTdT6VFN4GfU6kNZUfGwnkUYdAnNuO/obmw9apTJv7q8i6882aYaDz3xPDyfnugiytgM6tr
 vNWU7BgQ==;
Received: from 089144200071.atnat0009.highway.a1.net ([89.144.200.71]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDUVM-00CKXq-6i; Tue, 10 Aug 2021 16:22:20 +0000
Date: Tue, 10 Aug 2021 18:21:27 +0200
From: Christoph Hellwig <hch@infradead.org>
To: amit.engel@dell.com
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, kbusch@kernel.org
Subject: Re: [PATCH] nvmet: check that host sqsize does not exceed ctrl MQES
Message-ID: <YRKnh08WMMWazabm@infradead.org>
References: <20210805150251.30385-1-amit.engel@dell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210805150251.30385-1-amit.engel@dell.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

applied to nvme-5.15 with the comment removed as suggested by Sagi.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
