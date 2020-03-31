Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F046BC43331
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 15:49:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3731208E0
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 15:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JKbC4Z9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3731208E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FXyhbxo0eVCGZ9CfwabPf01gO4PDls4drKh3Szkz4MA=; b=JKbC4Z9gHldEph
	GKO/Rr9wkAFWz5pgzvwpeaaTKwMC3iuXD4MWS25DHncssLXl82y2/FubT1RckwwmcomvSaIRggnfI
	FLKndvuDXnW7ovkOq2ZMUiKnsm6gi9EFeSUkBxlyWhbsVOVBi25RpnXbW62fr2IF2gkQtxz4nuJ1P
	RzF3bt7BbkUmtWnVQlDnaKu2LypT/TQuEqPh6tM+XPlpRdSwpAZJCq35uAOX21QRfMLVroL4tbhMV
	971U7ohLG7kiR5vJbbY7rPzPz4HSc2oVzBi6plukwO1sXJAohCN1Ag6xFiB+FEeaWpOsGoHhABstk
	5W6Lha7ecWYuwIi6bjWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJJ96-0007aq-Ab; Tue, 31 Mar 2020 15:49:44 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jJHpL-0003to-Bh; Tue, 31 Mar 2020 14:25:15 +0000
Date: Tue, 31 Mar 2020 07:25:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH] nvmet-fc: fix typo in comment
Message-ID: <20200331142515.GA5488@infradead.org>
References: <20200318214043.18211-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200318214043.18211-1-jsmart2021@gmail.com>
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

Applied to nvme-5.7.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
