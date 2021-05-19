Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C29C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 06:43:32 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62ACF61042
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 06:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62ACF61042
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7xin8YcM8UXA1N0nCbD4BbyDBrLeWo+T/XKKPOETZ9c=; b=YqeL5WzyaP9cUFJJ4SstgwL76
	IhzRWQDoWpZ7Rsh0efe+zQd10XmwTe/wwLD/V9J/zp5+0SFKES4yzhPZ9gqELag3Wlu3FPo3sOuAn
	IGdZhYLFthf+EtU5bT7lEe0L3I8ltfDLUfbl/hEmwRml9NPmjT6W+da8VqxLvZm4zEnujwfYcA+UA
	iMKsRa/xUKHvDju8RDUg3EIFV7D/DWWjpcDnvD2io7fp5/TckG1Zb9HmCHY1v7MQltZIKaYjNy/2e
	lbDjHzCF1VqPT8Gr24U0U7zVnuXgh9ge2w4S0oyhhpvHVGDC/fEnSrubU5+6ZX2vVq8e8587ShFGf
	GKnqC0ueA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljFvF-0031mu-Qs; Wed, 19 May 2021 06:43:13 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljFvC-0031mV-S8
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 06:43:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=JfcaAWiL9MX/KzgqZFMd5GxaGaNC7KsyrSBFfXwwLXo=; b=s6tpzZl/vCPHQm8bwEcudEJ99+
 BCpIes9O4hr0XdndLBH8c8gp9XuHBzo1A8xlOcOXIkA4ML9K3/q3urUiW4O/UoeayXO5ENl3FGq7v
 CGZKzy2bRMZy705+eMX5OE0SHPpsBo3iUkxefPfjGFxF8IwZVCXE/5ujMxZonQL8OfwLjKmzBO55g
 3tQAFsd28NBnoBJEKgyWBiMSfauCCarezvz5Cw6y3CL9Kzgf2C2F4wnq9hNZYJrm/CIw1aEuZVwu8
 prL1Lkb+EK81d3kAyjNVoEM9q40mnm+ldmIGV5P3p7YuKAjx3VxSl3eFzb2jPcHBEix9uEJiJdLef
 bhoIdT+w==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1ljFuD-00EhMY-7f; Wed, 19 May 2021 06:42:25 +0000
Date: Wed, 19 May 2021 07:42:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Smart <jsmart2021@gmail.com>
Cc: linux-nvme@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvme-fc: clear q_live at beginning of association teardown
Message-ID: <YKSzQeErB18H7/Z6@infradead.org>
References: <20210511045635.12494-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210511045635.12494-1-jsmart2021@gmail.com>
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

applied to nvme-5.13.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
