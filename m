Return-Path: <SRS0=y1aL=4R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D332C3F2C6
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Feb 2020 18:57:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62F3D2467D
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Feb 2020 18:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oUWKTAsv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62F3D2467D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4XBjwD/p6/a1iFTRqGOCWojf//frzT3zuEp+dAdYY8c=; b=oUWKTAsv0cgBDN
	0te2fHJGCr4xEgCqpnoAh/818xrmqPe5JwKkXTZ/qBy8wVTELY9a/x43IuEVHY88c/z7YNmlK2rQU
	hCCohv6GzyopysMm6EDk81R1QVuS+YIEazMQmJjPf6OVSKnOQ89BW2YJQLUQEI7xODijvPbRn34ST
	AiAEHqlY2bHv1AzzlszwneKrIudEUTqSKr6VUwL2S/3igRNE/EWEFitfteRs8fskIUtkD4WNu7Pfl
	A3svDf6ZUELUHGTXUdgtF3zMGpzYsyj6xxG3WF3uKz1Ed2DXVuRk8Ql3s/+psJKWvN0J6hrUqqrVN
	LannuENqh9Ay4ld1K8EA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j87JA-0001cD-7B; Sat, 29 Feb 2020 18:57:52 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j87J8-0001c5-2B; Sat, 29 Feb 2020 18:57:50 +0000
Date: Sat, 29 Feb 2020 10:57:50 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Subject: Re: [PATCH v2 1/1] nvme-pci: Hold cq_poll_lock while completing CQEs
Message-ID: <20200229185750.GA5698@infradead.org>
References: <1582772023-67704-1-git-send-email-bijan.mottahedeh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1582772023-67704-1-git-send-email-bijan.mottahedeh@oracle.com>
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvme_poll_irqdisable will need the same fix.

Also I think we can merge nvme_process_cq and nvme_complete_cqes now
as the split is becoming rather pointless.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
