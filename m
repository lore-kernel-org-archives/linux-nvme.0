Return-Path: <SRS0=7/ZJ=QG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E277C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Nov 2021 17:10:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F25996142A
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Nov 2021 17:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F25996142A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VszlENjCJ3QQ5KvFIeSsfGOEUhb2i0XX2RaQ3R5pOdc=; b=xHSwTYE0jkDGEOG/tpQ+oc944m
	TRcELFj5VhmI0BECbDpEnu5WJnrCepwkLWMaCGxBV7lA5dlyxQ64cBPEcNWHxoWU0t+vxu6Hqworw
	R9uurC4nf+KfxlT41lelLaKDww+gpsabrLBWlTPAalsFGaXbvabE/mpnyJwYmqp3J7BXNw+i3MZoB
	tpWVEBTrBsmeduQc+EOMXDEgrwqQdYvsk9IMI9/aWhCx7ODsg49yI5llOxDPkFwr9Fz5c4lPdbJu5
	HFq2Fm19R1b0dke6oRsMdM2bOvGJPR+WQJDFyGyjz/sw7USKNck5xqpSIxuzRd7Kf4MHC29+1UzPT
	7nJjhGww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mo7PP-00B9q9-7z; Fri, 19 Nov 2021 17:10:43 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mo7PN-00B9px-U2; Fri, 19 Nov 2021 17:10:41 +0000
Date: Fri, 19 Nov 2021 09:10:41 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: Add sibling to list after full initialization
Message-ID: <YZfakf32dXVFhK5E@infradead.org>
References: <20211111132135.19216-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111132135.19216-1-dwagner@suse.de>
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

applied to nvme-5.16.

