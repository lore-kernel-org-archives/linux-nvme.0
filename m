Return-Path: <SRS0=7pRJ=KP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3002C43460
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 05:45:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62138610A8
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 05:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62138610A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HjaJMpZ7e03k1udDrDqG6KFiaYpSpSO+qLAK7FSbEno=; b=QzoLzZ/ilUzMiL/Dr31U92z4A8
	qvxFxwzNAZz29qBfMvE9CDGb7xk3pxE0V3y+okaNMsma7XpEavsLdCbSR6BvrK25uAfRTJ4SC8XZm
	+P1WJccJlQFD58Mqy7zFkm1fzLpfVyC2jh9vm95mUSJTv3oZS1BugH04Zdc5giBTFi90NfEhIMDun
	M/ETLXUwC0KPeyadRWkv0+u8j05TsajzRRCMjmm6xoIah7ztMVYe0l3pZIXuLW2KcX4ACPE/IMIP6
	mi2abvNshImoqJ4Kh4if0zQ/QiDsEDcM/qnlAasvrR2MgJJosEy1HdmJ1qGFVkbMKP5YyK9h/jZ9O
	cZUL0Ucg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljbU1-005yd6-Hu; Thu, 20 May 2021 05:44:34 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljbTz-005ycu-FQ
 for linux-nvme@desiato.infradead.org; Thu, 20 May 2021 05:44:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=QHcZokHfUKv3tkTg3nfJ7rRpxFaLFdK3MBM4dhu2Igk=; b=lL38L7MRW//HkPtAxCmxLMHZsL
 8aSkP12x5d1RmKD1tI7KGG/whuN5JIarhgYeYteJ8vQ4ohpDezK+qDK1Qk29A+ScpdzrVrhK45E4a
 kAd94Md7VriaZaOkVewvm9cuA3I2V/k+Oumm2nX20L4jJMp3xSs+bveBf0N4nrEUzB4h1GL6oIXT0
 KjqwdwGMIIneXhIuDZVNjotsaccjoRaSp+uys+c15ePnmfhK3VlHzJJoRt+/C26j4wez17t2VTH4f
 kjpeuuUG2QobLTPcva61D2qbisBSnlg1yXXF48o06IP+JFauiTAPN678evS1Sucjjlh/N8EQM4Hhh
 ZoNxgOkA==;
Received: from [2001:4bb8:180:5add:a633:7cce:5450:3d63] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1ljbTx-00FxM9-RB; Thu, 20 May 2021 05:44:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>,
	linux-nvme@lists.infradead.org
Subject: misc nvme ioctl cleanups
Date: Thu, 20 May 2021 07:44:19 +0200
Message-Id: <20210520054426.567241-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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

this series untangles some of our ioctl code a little more.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
