Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032D9D0D783
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Oct 2024 12:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=83Y6RA6yg/zU1Om4dLEePJWINdMemQKFg2LTQ+2u33E=; b=oxqqSV4/0+AC4OXNq96/AU8Eyi
	VFnBv/xO5ITaC++YGyiPW4W6ZrbILlsOB0emhKsSxYjpcW6KwkKeQrDgNohFlByUXOI5aCo/NybaD
	gYvTKZSfHD8xH7Q7S8UZ94h0csE5EVVncsKU4yyR2UkIdgfd4aiWrHIvX5cYsOD+NrkFHoI2X5Q4j
	kXYER+2IR0nakihmZ29byVMmHFipvt8meCXwY1MqUNNwFYn+Jss6K3ONJckklN6Es2WBrKZMmb4OU
	uyV1EhFDrg2eAe6H4+rmZ2xS+xZJ6RL3J73TEaDOlTQZjhv4D8Ccplb2YdnadAFKsc9LJmI/BblAw
	SINrfXSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szEnT-0000000GIs1-2aNy;
	Fri, 11 Oct 2024 12:31:07 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szEch-0000000GHDQ-3XO3
	for linux-nvme@lists.infradead.org;
	Fri, 11 Oct 2024 12:20:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DDEB35C504C;
	Fri, 11 Oct 2024 12:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F006C4CECF;
	Fri, 11 Oct 2024 12:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728649198;
	bh=USrx1eSbx00KxGW5SNsqKGkCfe9T8LfwHwehSbOrR1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XcGXmSZ5EBdyza640mDUbyYFCHJvq6TMDw8IAWU758p7dl/BSOWqNRNZyd9UGI3lJ
	 nC/Ukp2LR8pFOUI6a0J8ZF0o236l0qyZjtGMBguHNp7uhQ5YXSsDKotCD+yXK8WyMg
	 LvXrSFHlR1IPfdb02QSUKinQVmICK2jKXjI4+nVqqjOz82xPOfcQAXMgTa0ZOkdGEW
	 0c4UpPQyH4cp6xjG68G4yIBiu5zDJMhfvUEmnENbKugPuxKzvKyaP+2AASFX4C4M5x
	 TH+cv63Gq91FtIgeRIByVI8bxYNGQZzYHq7omHm9BTteTWlbZo1+xAEmW1PgWRmpjm
	 dBq0nWJIyrGGg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 2/5] nvmef: export nvmef_create_ctrl()
Date: Fri, 11 Oct 2024 21:19:48 +0900
Message-ID: <20241011121951.90019-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011121951.90019-1-dlemoal@kernel.org>
References: <20241011121951.90019-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_051959_944860_0F4709F5 
X-CRM114-Status: GOOD (  12.31  )
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

Export nvmef_create_ctrl() to allow drivers to directly call this
function instead of forcing the creation of a fabrics host controller
with a write to /dev/nvmef. The export is restricted to the NVME_FABRICS
namespace.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/host/fabrics.c | 4 ++--
 drivers/nvme/host/fabrics.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 432efcbf9e2f..e3c990d50704 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1276,8 +1276,7 @@ EXPORT_SYMBOL_GPL(nvmf_free_options);
 				 NVMF_OPT_FAIL_FAST_TMO | NVMF_OPT_DHCHAP_SECRET |\
 				 NVMF_OPT_DHCHAP_CTRL_SECRET)
 
-static struct nvme_ctrl *
-nvmf_create_ctrl(struct device *dev, const char *buf)
+struct nvme_ctrl *nvmf_create_ctrl(struct device *dev, const char *buf)
 {
 	struct nvmf_ctrl_options *opts;
 	struct nvmf_transport_ops *ops;
@@ -1346,6 +1345,7 @@ nvmf_create_ctrl(struct device *dev, const char *buf)
 	nvmf_free_options(opts);
 	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_NS_GPL(nvmf_create_ctrl, NVME_FABRICS);
 
 static const struct class nvmf_class = {
 	.name = "nvme-fabrics",
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 21d75dc4a3a0..2dd3aeb8c53a 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -214,6 +214,7 @@ static inline unsigned int nvmf_nr_io_queues(struct nvmf_ctrl_options *opts)
 		min(opts->nr_poll_queues, num_online_cpus());
 }
 
+struct nvme_ctrl *nvmf_create_ctrl(struct device *dev, const char *buf);
 int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val);
 int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val);
-- 
2.47.0


