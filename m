Return-Path: <SRS0=O63G=CN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F80C433E2
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 02:28:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 281C3206B7
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 02:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="x2Ne85ci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 281C3206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lnKVdfE8WQVasoCgCR/kiYgmOhyVhoKQvOgX7HbeijY=; b=x2Ne85ciXdolCQ8mALUZa7ATnU
	v5ctqusU5ghyA/OYiK/fVbNwaO8CJiEUH1UTCS17oQViLXWOW2Ig71O21k07REQNFDDnHARzivcfz
	69iWJM2TzxTqGYg5EvGZSNZKLYiTTaHvxcprgb99PlN4jO+3PJO2TW6UhSvRlpsdSRcgV5qXyrCri
	Od+2G53+7iwbGmE2LP1LGM823y6IM6JsjPj3xcYnS3ztObCvkTWZAkE6EYYN60KgDdP/4EOyqIo7c
	+lfdjSYvOp+6Cf7ZiwWsWjgwUuXD4aQvBLUKba8eb5dQHlYSkwzwjgHukf4kLM6UBTitjYBCNyVcu
	7F5fTVTg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kE1Sn-0005S9-Ra; Fri, 04 Sep 2020 02:28:29 +0000
Received: from mail3-165.sinamail.sina.com.cn ([202.108.3.165])
 by merlin.infradead.org with smtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kE1Sh-0005RS-Tc
 for linux-nvme@lists.infradead.org; Fri, 04 Sep 2020 02:28:26 +0000
Received: from unknown (HELO localhost.localdomain)([123.115.164.148])
 by sina.com with ESMTP
 id 5F51A63A0002F17B; Fri, 4 Sep 2020 10:28:12 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
X-SMAIL-MID: 710809628852
From: Hillf Danton <hdanton@sina.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Is it needed to zero out the dma buffer for
 DMA_ATTR_NO_KERNEL_MAPPING 
Date: Fri,  4 Sep 2020 10:28:01 +0800
Message-Id: <20200904022801.15828-1-hdanton@sina.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_222824_212839_61F44000 
X-CRM114-Status: UNSURE (   4.33  )
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
Cc: Hillf Danton <hdanton@sina.com>, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Matthew Wilcox <willy@infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Hi Folks

Currently the DMA_ATTR_NO_KERNEL_MAPPING buffer allocated is not
cleared while dma core always zero it out for coherent allocations.

Is it making sense to do memset for the attr?

Thanks
Hillf


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
