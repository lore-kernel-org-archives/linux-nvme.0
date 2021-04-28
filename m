Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372E8C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 06:46:55 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D600761073
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 06:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D600761073
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7xin8YcM8UXA1N0nCbD4BbyDBrLeWo+T/XKKPOETZ9c=; b=acXbzePxD3r1PGxhLuxEjChZ/
	YZnX4Om/kUfmmcr4Mv3iwdHmDAHBGpyD4AX/+afKvl6d4fAumlG29mzZXQT1WFG2WGjv42YMzVRLr
	WVGbpHyMZZo0A9qk5dvFr1K61g7FNAhbRmouF8zmN2hKr9ECfjm0ZnHXpcWV3YN4Z/tb7Hl1I7Etp
	FHnskCO3broy+/6tvclAWpnkmP2D3oh4hl7oMEmOF4ug8vbsUc+g7lWk9n6zrhd7bmabl8DnqjQEd
	JY1uuJFopOeTlDSQsMQH7/9qLHZJ2Qdm9FWTiswHR5xTd0BxJQRyiojY4gxpFyoMnLJgHqT+VNcHA
	GQHc3Q+Jw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbdy6-002xdL-KZ; Wed, 28 Apr 2021 06:46:42 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbdwk-002xPj-Gx
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 06:45:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=JfcaAWiL9MX/KzgqZFMd5GxaGaNC7KsyrSBFfXwwLXo=; b=xpfpXMvoWBWUCpIZeDre9eSCEp
 sgM9C8aNuZF++Uz3DER9XvwRO8cuxxLeJT+Du8Usl3vDJM//vByBpJGZOHZGMXOxWvvJBRAng1EQc
 xp5as3yi3R/VocjXzBpCnPRbK3Lyk57s3+NgtUrujAGfEnv9XaMQZQYZaY+lbp0Ddd7VGlPbABzWS
 W8K1BwhOfkoUp2dEcdPevoe33oK3vsFbKS9KxBTsmIkdhlZqZLmUHczLE09UDx1bA5WwZ+09aTws8
 2D3uPg43eJ676V8QgEMtGJY3FGqOBStIb08s/eamxjfyqEuS8BaQd6VtWIMGSBLjvxq+RMc82sXGM
 WYl4SiaA==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbdwi-00HDrm-5G
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 06:45:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4C9BD68B05; Wed, 28 Apr 2021 08:45:14 +0200 (CEST)
Date: Wed, 28 Apr 2021 08:45:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, kbusch@kernel.org, chaitanya.kulkarni@wdc.com,
 sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 0/2] kref and passthrough cleanup
Message-ID: <20210428064513.GC5988@lst.de>
References: <CGME20210427064849epcas5p424de8d9686fc422ecb80540d57d040f1@epcas5p4.samsung.com>
 <20210427064747.5988-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210427064747.5988-1-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_234516_360654_8444FB9B 
X-CRM114-Status: UNSURE (   7.99  )
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
