Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5629E7718B
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2024 03:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tm4vi93zhGU6jMShK8v9dXj2qRoZyLNgulYEPMAb9cc=; b=W/j8S+2il1ZTGmiKZ6FKvQ/a6o
	0nxc+jRFl14a6Ykyofvhozbbja5jwAHjGXzyVY+e+DQbuCcTAvNm/AFuz1u/+Jf0jMrkLfkwzggnh
	hHBILVjVchOBeN+MqYRGYbR/Qm0bA4FZAiPe5QR0rlWqRl8aNiPDBdrTrzs8VbSeJV4RtxeYrmEeg
	9T2K6THXntfZcORhZZgjJgNBRbTXUrSW04kQ7USdzcKow2KHeT/y8fRSx2RDPYmFCtjvK5lkrymcD
	8ZVP35Hl2ucwdO8njt5S9Oz6dMtP9E44IgSImGqw/S3mPalLKLDkcT1+gzTpicvwes1EJm0ID1tMj
	+hv8OuTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOU5x-00000003psb-0V9N;
	Fri, 20 Dec 2024 03:54:33 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOU5v-00000003ppr-0Epr
	for linux-nvme@lists.infradead.org;
	Fri, 20 Dec 2024 03:54:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9222D5C6AD0;
	Fri, 20 Dec 2024 03:53:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74928C4CEE0;
	Fri, 20 Dec 2024 03:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734666870;
	bh=B9CEGvBNRfhGVurbju4TtwIhLntIlz8erTg6Vcjqd24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JOEwRlr9jctLmVud9s5hNdEGNPe1GpTds+E6xKrm8nqYBzXIaotKAegGXlnRXc1pf
	 srZu5xGKOwK0p7zBtwxU/ZWyJOmu+9JZPyh5BEHeiz0jxGMyVv03zhJRhf1AIQZARm
	 V3tKUhAlQPZ3/7fz7U/3Oh03R0RMKVk8RagGD/8xNBHL6dd8ITAaFijs5BR8lirPDd
	 FSfAwMjVKu9/gnKgyWQRyYfXi6rKKaqZWtfd4eJHUxdvm2l002nhMwDUwqbMbgAUTm
	 NF/3LQV0EdPEXCwYiFu9KQZ500lI4DYlOl5LtY0sMpTaHH/7FGgfdancLpkhChrT4J
	 7K6qSi2EhsyQg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v6 06/18] nvme: Add PCI transport type
Date: Fri, 20 Dec 2024 12:54:29 +0900
Message-ID: <20241220035441.600193-7-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220035441.600193-1-dlemoal@kernel.org>
References: <20241220035441.600193-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241219_195431_181449_DF62BA4B 
X-CRM114-Status: GOOD (  17.01  )
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

Define the transport type NVMF_TRTYPE_PCI for PCI endpoint targets.
This transport type is defined using the value 0 which is reserved in
the NVMe base specifications v2.1 (Figure 294). Given that struct
nvmet_port are zeroed out on creation, to avoid having this transsport
type becoming the new default, nvmet_referral_make() and
nvmet_ports_make() are modified to initialize a port discovery address
transport type field (disc_addr.trtype) to NVMF_TRTYPE_MAX.

Any port using this transport type is also skipped and not reported in
the discovery log page (nvmet_execute_disc_get_log_page()).

The helper function nvmet_is_pci_ctrl() is also introduced to check if
a target controller uses the PCI transport.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/nvme/target/configfs.c  | 4 ++++
 drivers/nvme/target/discovery.c | 3 +++
 drivers/nvme/target/nvmet.h     | 5 +++++
 include/linux/nvme.h            | 1 +
 4 files changed, 13 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 4b2b8e7d96f5..20cad722c060 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -37,6 +37,7 @@ static struct nvmet_type_name_map nvmet_transport[] = {
 	{ NVMF_TRTYPE_RDMA,	"rdma" },
 	{ NVMF_TRTYPE_FC,	"fc" },
 	{ NVMF_TRTYPE_TCP,	"tcp" },
+	{ NVMF_TRTYPE_PCI,	"pci" },
 	{ NVMF_TRTYPE_LOOP,	"loop" },
 };
 
@@ -46,6 +47,7 @@ static const struct nvmet_type_name_map nvmet_addr_family[] = {
 	{ NVMF_ADDR_FAMILY_IP6,		"ipv6" },
 	{ NVMF_ADDR_FAMILY_IB,		"ib" },
 	{ NVMF_ADDR_FAMILY_FC,		"fc" },
+	{ NVMF_ADDR_FAMILY_PCI,		"pci" },
 	{ NVMF_ADDR_FAMILY_LOOP,	"loop" },
 };
 
@@ -1839,6 +1841,7 @@ static struct config_group *nvmet_referral_make(
 		return ERR_PTR(-ENOMEM);
 
 	INIT_LIST_HEAD(&port->entry);
+	port->disc_addr.trtype = NVMF_TRTYPE_MAX;
 	config_group_init_type_name(&port->group, name, &nvmet_referral_type);
 
 	return &port->group;
@@ -2064,6 +2067,7 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 	port->inline_data_size = -1;	/* < 0 == let the transport choose */
 	port->max_queue_size = -1;	/* < 0 == let the transport choose */
 
+	port->disc_addr.trtype = NVMF_TRTYPE_MAX;
 	port->disc_addr.portid = cpu_to_le16(portid);
 	port->disc_addr.adrfam = NVMF_ADDR_FAMILY_MAX;
 	port->disc_addr.treq = NVMF_TREQ_DISABLE_SQFLOW;
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 28843df5fa7c..7a13f8e8d33d 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -224,6 +224,9 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 	}
 
 	list_for_each_entry(r, &req->port->referrals, entry) {
+		if (r->disc_addr.trtype == NVMF_TRTYPE_PCI)
+			continue;
+
 		nvmet_format_discovery_entry(hdr, r,
 				NVME_DISC_SUBSYS_NAME,
 				r->disc_addr.traddr,
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index abcc1f3828b7..4dad413e5fef 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -693,6 +693,11 @@ static inline bool nvmet_is_disc_subsys(struct nvmet_subsys *subsys)
     return subsys->type != NVME_NQN_NVME;
 }
 
+static inline bool nvmet_is_pci_ctrl(struct nvmet_ctrl *ctrl)
+{
+	return ctrl->port->disc_addr.trtype == NVMF_TRTYPE_PCI;
+}
+
 #ifdef CONFIG_NVME_TARGET_PASSTHRU
 void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys);
 int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index a5a4ee56efcf..42fc00dc494e 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -64,6 +64,7 @@ enum {
 
 /* Transport Type codes for Discovery Log Page entry TRTYPE field */
 enum {
+	NVMF_TRTYPE_PCI		= 0,	/* PCI */
 	NVMF_TRTYPE_RDMA	= 1,	/* RDMA */
 	NVMF_TRTYPE_FC		= 2,	/* Fibre Channel */
 	NVMF_TRTYPE_TCP		= 3,	/* TCP/IP */
-- 
2.47.1


