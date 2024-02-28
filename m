Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B425C5478C
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 02:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=x425UDdGUcCTm66eoNkqKsvt1C4sqfGaUNSsnqHbMD4=; b=DCWVmLDlpauotOII48q6ZHudsG
	kZS2E0Bke38i6viD0h21aMTacpzWCSXJq4Q8CWjf0+3KZBeFWAk+s3IRlOSmRrPMiZocICfGUrZjh
	DPTdr15rEC8bUDDWifGXpYulAHlts+iGivUiO5z0gf2h/1yFcn6YVWEUTr5+aE0ukx1ks2502EWVj
	oSHZTw2VW1vfqpAu9NMtAKKy6SjcLkzmyakmTUX4DHIOrvGeIqBURqzDYscHfU97nysN7fnQN0hwj
	g2974JqALVFJLlmn5yekDIaR8Rbt9Lg/LGYnvwxFNhC+ckNktGGPVuMrpXhvbovDfOGaFuWILaWc/
	+tyfk9hQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf9jH-00000007iXQ-0feA;
	Wed, 28 Feb 2024 02:31:31 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf9jE-00000007iW9-1XhY
	for linux-nvme@lists.infradead.org;
	Wed, 28 Feb 2024 02:31:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709087485; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=x425UDdGUcCTm66eoNkqKsvt1C4sqfGaUNSsnqHbMD4=;
	b=pB0Dn7kNhyX0dXW/7Ft/0IFcBHmlePOBoW1HDCosiGULL/eFgbnuoABjP0QJ64EPXyBqneI/433RcG73cWPm5EO+mNxK+3JzHN7isyjaAoUucCNh2qqeeVqPJSb7cwqFnBIBPpPShpYNI55dBVmcrVTyWPlYil1EJoIXVwguG+8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W1OJ2pi_1709087478;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W1OJ2pi_1709087478)
          by smtp.aliyun-inc.com;
          Wed, 28 Feb 2024 10:31:24 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 0/2] nvmet: add some commands tracing
Date: Wed, 28 Feb 2024 10:31:16 +0800
Message-ID: <20240228023118.84959-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_183128_814274_8E1CC456 
X-CRM114-Status: UNSURE (   7.05  )
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

Hi all,
	This series of patches adds tracing support for ZNS commands and
authentication commands to the NVMe target module.

Changes from v1 to v2:
- Remove patch 1, "nvmet: parse dsm command's attr deallocate when tracing".

Guixin Liu (2):
  nvmet: add tracing of zns commands
  nvmet: add tracing of authentication commands

 drivers/nvme/target/trace.c | 66 +++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

-- 
2.43.0


