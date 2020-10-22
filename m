Return-Path: <SRS0=3deH=D5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA5CC388F7
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 13:37:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F68241A3
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 13:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dIZEKrEd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M/MQIG7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F68241A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dfGG15TSfoH4hmmKRcLWihZO8neJKQHikyutt3jxdeY=; b=dIZEKrEdmb7QFXAnvDT7RKwjD
	O2KmhrPMAG1P+aih+lP4E9AeFJoF/VEI9fEhaCZGrp8sQeXzxeYY6ieFYDNAojyNULjANuSdd06Po
	4BKS3Y0eUfJlQENHWbfIe3zaxd/KKHWUbyrCXr5XYBulRlQv+q+nSwMrSZog1nX2k8C569KQP8es0
	iZpENb6rD1r1dYGEJuLYoyudlTVx3QT2E1h9d91YBtVb2hNAM+Nj/ihxfMPGQquPoQXn59r/6iC/L
	MCJS7k+Lalswa+av7E3C9z+E3nGAwWTV26ID+Y1appTDhsnKb4B+tb+IBKP2t20+w0duJdJYYpLPa
	MGxr79RAw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVamp-0001xe-W7; Thu, 22 Oct 2020 13:37:48 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVamo-0001wm-Bb
 for linux-nvme@merlin.infradead.org; Thu, 22 Oct 2020 13:37:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Sq5FTZdZCuJGAIiKXu3zLR9CZVx0uxX1AdIquLrEsgI=; b=M/MQIG7bwF+TFEsPcgybYgL1w9
 OURtiIxpW/JyLk2N/AVxM6GahhgJi+pwd3Fv9QKQ+J3OlbjuAs8SNNAhpv7aqmZMfOrWOzWJUJTTv
 95UetlvT+rYOHGq/q5coyFO0m7rM1HQpnyvloMgkqm3Lp7Rx0B3BfwuKyZTfJHhNkErNzTsj5+Ry9
 5A4rLgr/RbO+T/sfKjqxNVq7lcH0jCG0sB1+9MfmptR5emKUbDqZJ9onsf7Lasi6oce3IpuSbvYot
 6HaLQhTGlCPTIHpcrcUTpIWPfKUGfBVnyKVJun6FyzZOv2E6JlUTdkx5X34SdXPZ//S3QFBLnLvoS
 PgF7vxaQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kVamn-00081c-H4; Thu, 22 Oct 2020 13:37:45 +0000
Date: Thu, 22 Oct 2020 14:37:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH] nvme-fc: shorten reconnect delay if possible for FC
Message-ID: <20201022133745.GD30500@infradead.org>
References: <20201016212928.49429-1-james.smart@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201016212928.49429-1-james.smart@broadcom.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
