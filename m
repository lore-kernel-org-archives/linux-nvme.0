Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B848C05027
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Feb 2023 03:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:Message-ID:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Lo0Yz6/hSCZqXizJJOsi32SosghjVJrL06iRZKeyuO0=; b=NLc3qb5oorSgDgWyrabljKrPDd
	2Jm1+poHmAyOuHo6THeu34o2RzVL8Qjm7/9wpB1yHCfm0g/2KcgOnh3cz/ECe+l9v4h4ksHPvRw0e
	CgX2pGTdXAxklkPFTlsqtcYw3wsBrqldxUS4V1pJTomgoNuVFCg7YTDeCUUf1xVWDtX96Wa8Ouikq
	d9jd3pPDKJ0N0Es1r+1f87k5vi72tBX/9A8AKzrNc6ZnXWtRXH3hVbzrMUSXFjRAlWDfVXXztnDgr
	UJgjljKca5l6KZDWEuCUnCX1mXOeX+LMtmBl3ryADZcwL1GVf7Z4/E9hEFENLd0o6DTnZpwEtTCMC
	xt2g8yHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNQKD-00EFYh-K4; Thu, 02 Feb 2023 03:31:49 +0000
Received: from smtpout01-ext2.partage.renater.fr ([194.254.240.33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNQK9-00EFWv-Ic
	for linux-nvme@lists.infradead.org; Thu, 02 Feb 2023 03:31:48 +0000
Received: from zmtaout01.partage.renater.fr (zmtaout01.partage.renater.fr [194.254.240.30])
	by smtpout10.partage.renater.fr (Postfix) with ESMTP id 934DC63B9C;
	Thu,  2 Feb 2023 04:31:31 +0100 (CET)
Received: from zmtaout01.partage.renater.fr (localhost [127.0.0.1])
	by zmtaout01.partage.renater.fr (Postfix) with ESMTPS id 854F11A0052;
	Thu,  2 Feb 2023 04:31:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zmtaout01.partage.renater.fr (Postfix) with ESMTP id 7C5D21A0136;
	Thu,  2 Feb 2023 04:31:31 +0100 (CET)
Received: from zmtaout01.partage.renater.fr ([127.0.0.1])
	by localhost (zmtaout01.partage.renater.fr [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zgCSZa5XFuWt; Thu,  2 Feb 2023 04:31:31 +0100 (CET)
Received: from zstore-b0-026.partage.renater.fr (zstore-b0-026.partage.renater.fr [10.254.240.112])
	by zmtaout01.partage.renater.fr (Postfix) with ESMTP id 423211A0052;
	Thu,  2 Feb 2023 04:31:31 +0100 (CET)
Date: Thu, 2 Feb 2023 04:31:31 +0100 (CET)
From: Irvin Cote <irvin.cote@insa-lyon.fr>
To: kbusch@kernel.org
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Message-ID: <640656069.60824897.1675308691167.JavaMail.zimbra@insa-lyon.fr>
Subject: Subject: [PATCH] nvme : host : pci.c : Replace int literal by
 corresponding macro
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4372 (ZimbraWebClient - GC103 (Linux)/8.8.15_GA_4372)
Thread-Index: qiw6HH2UZ+bOg83eGL16PHPXCNGd1w==
Thread-Topic: Subject: [PATCH] nvme : host : pci.c : Replace int literal by corresponding macro
X-Virus-Scanned: clamav-milter 0.103.6 at clamav02
X-Virus-Status: Clean
X-Renater-Ptge-SpamState: clean
X-Renater-Ptge-SpamScore: 0
X-Renater-Ptge-SpamCause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefjedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecutffgpfetvffgtfenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefkufggtgfgofhtsehtjegttdertdejnecuhfhrohhmpefkrhhvihhnucevohhtvgcuoehirhhvihhnrdgtohhtvgesihhnshgrqdhlhihonhdrfhhrqeenucggtffrrghtthgvrhhnpeeiuddtveeivdekhfekffetfeefieduudejueejteejffetveekhffftdekudehteenucfkphepuddtrddvheegrddvgedtrdduuddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddtrddvheegrddvgedtrdduuddvpdhhvghlohepiihsthhorhgvqdgstddqtddviedrphgrrhhtrghgvgdrrhgvnhgrthgvrhdrfhhrpdhmrghilhhfrhhomhepkfhrvhhinhcuvehothgvuceoihhrvhhinhdrtghothgvsehinhhsrgdqlhihohhnrdhfrheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrgigsohgvsehfsgdrtghomhdprhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopehsrghgihesghhrihhmsggvrhhgrdhmvgdprhgtphhtthhopehlihhnuhigqdhnvhhmvgeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhg
 vghrrdhkvghrnhgvlhdrohhrgh
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230201_193145_781459_8A25DDEC 
X-CRM114-Status: UNSURE (   9.73  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From e88b6a92c2447c2d5a343ca53cd735f4f83848d0 Mon Sep 17 00:00:00 2001
From: Irvin Cote <irvincoteg@gmail.com>
Date: Wed, 1 Feb 2023 23:14:25 -0300
Subject: [PATCH] nvme : host : pci.c : Replace int literal by corresponding macro
When re-setting the dbs field of the nvme_dev struct in the
nvme_pci_enable function, a integer literal is used to represent the offset
instead of the dedicated macro NVME_REG_DBS.

Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c734934c407c..ba65299636e1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2540,7 +2540,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	dev->q_depth = min_t(u32, NVME_CAP_MQES(dev->ctrl.cap) + 1,
 				io_queue_depth);
 	dev->db_stride = 1 << NVME_CAP_STRIDE(dev->ctrl.cap);
-	dev->dbs = dev->bar + 4096;
+	dev->dbs = dev->bar + NVME_REG_DBS;

 	/*
 	 * Some Apple controllers require a non-standard SQE size.
--
2.37.2

