Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC83EC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 09:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uX3p9HyMW8QOUlZOkSl647SfpwLsmF6jferLORpip2g=; b=AgrExetLsHykDLTFb84rILmnUz
	TtfFB20z3Rd9fzn5BP9rgIIEx3v0KrMcKozwL9ckmWzroqqcgwopfraWNS9k6/vqnuJWLEgS7lDA6
	ff9c+7QWpWIStkl5menmIHQXVX0IgyGlRoak+KNEOzot5dIR0f8uplLm3eDjJQI/+uW0qbqlHYpQz
	D2qHb/bEthEoDHlzZz4TVPVoCgOZ8pfZWxQ5tLmG1zdnhcE3eFTFluBSa+oRwf6k9PyfYjmy/9lS1
	TU4u51oHTwrJj16cP0SgJyPw2mhz10UX9JUA/vMFZNoRkjrXGKGhkV41H38l69WMl20Di63vvmgiw
	GCOiedJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozxE9-007xiQ-QB; Tue, 29 Nov 2022 09:48:33 +0000
Received: from mga07.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozxE7-007xgI-Sc
	for linux-nvme@lists.infradead.org; Tue, 29 Nov 2022 09:48:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669715311; x=1701251311;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wmsGItexe72sOyEj5wmVRCqyjTOHw7jcpbQam55oxUg=;
  b=UUny52merrH6rj9nolsXqg0hLr9s34jzhKbFkE+Is3TBW2uUnY28enbX
   qagMDfRH1hjpssvVpRXKrl/iZWeeiM519MNdELPrmT3NuVnXed3kPA+Aj
   MQrPklbOuOcHj6ckqFWArJ9hCXOQWsYoC7fnEnhZQ3AU5p0kjWUI7itxJ
   sPHyMnTkrpWwX4I7azS6Tub4uS0U3zP+i4ulBkHxNPeYTfY1+pvIx1nNx
   ++41T2e+DUmG6fr8cenjcwOhL7GYhIJVVQHDYOU4Sp7E1cldwzSI4GCvo
   U4GSXdHEVuRJgw8+ENRUScwJBzNYnI4yG+boEwr4It99K38vPVj28bpNx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="379334021"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="379334021"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 01:48:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="645837594"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="645837594"
Received: from leirao-pc.bj.intel.com ([10.238.156.101])
  by fmsmga007.fm.intel.com with ESMTP; 29 Nov 2022 01:48:21 -0800
From: Lei Rao <lei.rao@intel.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	hang.yuan@intel.com
Cc: Lei Rao <lei.rao@intel.com>
Subject: [PATCH] nvme: clear the prp2 field of the nvme command.
Date: Tue, 29 Nov 2022 17:48:11 +0800
Message-Id: <20221129094811.893586-1-lei.rao@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_014832_031707_E9F64535 
X-CRM114-Status: GOOD (  11.01  )
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

If the prp2 field is not filled in nvme_setup_prp_simple(), the prp2
field is garbage data. According to nvme spec, the prp2 is reserved if
the data transfer does not cross a memory page boundary. Writing a
reserved coded value into a controller property field produces undefined
results, so it needs to be cleared in nvme_setup_prp_simple().

Signed-off-by: Lei Rao <lei.rao@intel.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f4335519399d..488ad7dabeb8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -797,6 +797,8 @@ static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
 	cmnd->dptr.prp1 = cpu_to_le64(iod->first_dma);
 	if (bv->bv_len > first_prp_len)
 		cmnd->dptr.prp2 = cpu_to_le64(iod->first_dma + first_prp_len);
+	else
+		cmnd->dptr.prp2 = 0;
 	return BLK_STS_OK;
 }
 
-- 
2.34.1


