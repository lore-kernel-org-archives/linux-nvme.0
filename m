Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F72AC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Feb 2022 19:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EXm4V69Sk1tfunceJsqp7eSZdoIUcPRbG8loRCacZuM=; b=LMzgsq35x0GkypocEN5gxkBCf+
	4jTyx2/bXivTZidbWw3+12s02meCS3zHH/zVF/ZXKxn9YBoVj/DpeEbpEGAnP+U11h2+F892bGVUY
	ek4qNs0nJ+44iY7gP+vMuMELbFtyxZD4/VwwNYj5hmfODessaL54jgszuAb5P+3HF2xdR5umYexNZ
	Oth9o062kUDQvmwwtIlr5mtwIvrsexJdCDOGm9unvHQpoLvSLyS1oQrkPoWLWOdTFibDZclC9bj2T
	xXtiXiTUlIIe88pTiNHG4Q8hrQm3PcRKgU8hDr9jK41qH3nX6K3ZjLZEQdYrZ004JI1GMGx1brfNo
	UkSgFOmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNJnF-0028aq-Vp; Thu, 24 Feb 2022 19:28:50 +0000
Received: from 089144202139.atnat0011.highway.a1.net ([89.144.202.139]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNJnE-0028aN-57; Thu, 24 Feb 2022 19:28:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: properly validate the nvme uniqueue identifiers are unique v2
Date: Thu, 24 Feb 2022 20:28:41 +0100
Message-Id: <20220224192845.1097602-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi all,

this series fixed how the nvme driver check for unique identifier
and then also applied that logic across subsystems.

Changes since v1:
 - various small cleanups

