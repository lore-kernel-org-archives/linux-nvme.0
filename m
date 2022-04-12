Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A351C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Apr 2022 06:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=llt+nUAmm+fiOtaoFaB23+zf/gmSnWqipoJPBOoVCBQ=; b=VsccB7BlRl2kvkJu93f48ChFRS
	OUTpdQi2/O6t/qLaIbmsWanxHi3M6F8hcPYC64NwHSA+QcWtkxvRkZ1wYtT9zq54vaXqAmX8sYR2w
	gQ2WONXUaQ8GxY5DahOjQ+LHXCbDdIRES4i3elh+t9Lv0ZHASXieBEJDXC6TMBug82W7X9EAeLaYS
	FYWV6N3DQ4DR46J/UuTbAeTAtqS4GeF491Lt+CH53Qf224Ji+gXRaT/JHMCYEgWOG1E0lKPuWr1oi
	YV8veV8SvhoD04OCsIHkOYzFsPXWh6hsgjnWmwCiIx9e7zmOUkNlsiZvcd97sJAUZ7MhrRNFUQlD1
	lqS730Aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ne9kQ-00BoqG-T5; Tue, 12 Apr 2022 06:11:30 +0000
Received: from [2001:4bb8:18e:76f5:73f2:2aba:795d:ae99] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ne9kP-00Bopn-BF; Tue, 12 Apr 2022 06:11:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 linux-nvme@lists.infradead.org
Subject: quirk broken namespace identifiers
Date: Tue, 12 Apr 2022 08:11:23 +0200
Message-Id: <20220412061126.244414-1-hch@lst.de>
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

this series adds a quirk to ignore namespace identifiers on controllers
where they are completely broken and then quirks two controllers for it.

