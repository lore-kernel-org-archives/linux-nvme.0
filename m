Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE09C43460
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:11:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80736610D0
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80736610D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=41D3QUvwaQwAQy3A3fxDFAMX1hYOw03Kouxl9otI0EI=; b=pGeeIeseK4DYDVCld7DUDpNQcN
	ZChOONOVmiwGacHMK1DPHZMWxXyIwhEhpL6yt7kKDkR3w7L/KEyLJCpICbKDnuV7Bh1ZvkmnvYv0H
	QxB3d7/UV33AsybrugdX3yjF1ONLgdHLBHQDz4Ww9OsXROchO4IoBYvDt8fZMaD7PrmU4krRJYhAR
	Vdr6pNTe6+9q+jG+jlGx5gneGpwmyimF9fkSoCrh93QK76q2OXiblEa1iIIlktYMZyDrqQ0Vbcri5
	KA5ymZj3s4TwfbOW8sQemQSqUNL9vgBgNA3d/6xrTxWpbGaKPAY/JcBVtcmmqZVnAPdkth2Wx00Zd
	CxarZGwA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUTV6-007vzv-Ll; Thu, 08 Apr 2021 12:11:08 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUTV5-007vzi-53
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 12:11:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=Qb4yGfhDdlmxcGniNt8/AIO3sVWU1ULrZ8JaEeAOsTI=; b=WnAZny/MiStz6qfeN9bMy0f4+y
 l51jtsys+RlJXV0yf1ghmPem0YT9IYAH0lnjjo8DKzjPyvhTHq9cp1TXQqxcD7xxolzxo7sQivRqm
 W/UM8VNOJ04NyF+00S2cT6xZdDrEXUt6H9Ze3GHjLOxdL4f1G4tf3Eeh04IbdYXunXi4N3MObAqD0
 fXMxtcwpgONNAJOmiDNZyjyb5OUxd0ngUt5kGhK6xTTZzPtqFWlCEpXs9EwSBiIjKiYA+3qEFvYWE
 6K6/bSzfNx3Ps9YvoaKP3eis12pIwv2XaujVspaLVfmdro3CIDC/dXGnP0yw9yGrlV0KZsYAZ8Jih
 F7AjG8+w==;
Received: from 213-225-2-171.nat.highway.a1.net ([213.225.2.171]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lUTUt-00HA4Z-8G; Thu, 08 Apr 2021 12:10:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Kanchan Joshi <joshiiitr@gmail.com>,
 Javier Gonz??lez <javier.gonz@samsung.com>, linux-nvme@lists.infradead.org
Subject: nvme ioctl refactor and generic per-namespace char device
Date: Thu,  8 Apr 2021 14:08:29 +0200
Message-Id: <20210408120842.1450092-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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

Hi all,

this series picks up the generic per-namespace character device
from Minwoo and Javier with a few small fixed, but rebases them on
an ioctl refactoring I had pending, which cleans up a lot of the
lower level code.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
