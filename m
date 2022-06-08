Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6873EC43334
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jun 2022 19:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XFVNy23PiZlVhicvLjpG2WUQ7YnZGtJAFRrznDVH0so=; b=AaO1OOtMZ3mw/Xoxbzk2GlZ5e1
	Y+MyPrI8Xj25Nsx3hZ0R8FDfxSqNWsLVUzD+vaTT1Ef16Z8o9jV/UXA3B2ePSk1thSjFfXvKiXzes
	RgtDujd4Q2B/5DUVs89u8uo6yt0hceic0YtLzSxMKfnegh5DfLey4AWM7vBKuiuZB0Kd4kYm6KqEV
	z94T0RvSg8jtL5DbrU4MKFMmdgs4tF4t0niLbt2cDbCkxfbMcnRePYH50UD0VRNenvwj6T8BJblR9
	h7u9jHMXvGtWDjLncB3NPbqDL2FB9rkpjE3DMdUaWVZ/QxgV7CXlav/MlmzMXwjReQooHfkZETIWG
	h7C2ddJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nz0zA-00ElG9-Mp; Wed, 08 Jun 2022 19:04:56 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nz0z7-00ElEW-CR
	for linux-nvme@lists.infradead.org; Wed, 08 Jun 2022 19:04:54 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2BAC260A3D;
	Wed,  8 Jun 2022 19:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E146C3411C;
	Wed,  8 Jun 2022 19:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654715091;
	bh=erouWtfF1tNWjOQ8wgbXwDqdCZpNQL2IOZssmdIgBzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ujlggb+qt4QqcVRr++DkczD37lSEVdzRUa/Wzkuf3dgnycwY8SQYlX+jltCyXr5Eh
	 VEmfqpyYeYrYJftTMx3H1tXx402tl5SQppfXJYmnvcdjF8SwyhxVJDxenvC41nsRkn
	 nmjccu9IvflN/HUogIvk8Jpn8M+YMCl8ph8RMG4MMovp0XiLdbJRB3vDzsqeev4h3C
	 NOnxzCDxbpgIGX48t/hLhIDb2D3No3rkV+XlS00ksRzgExJZQb2WtjpU0I7HKE/MtC
	 MDVlfxeJZXViYeYQRKi/tsIBd79rLtEs9vDoHy1Qdp3GXNIxYi0oCvHpjQOMIYn0EL
	 l67GDxI9YTE/g==
Date: Wed, 8 Jun 2022 13:04:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Klaus Jensen <its@irrelevant.dk>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <YqDy0BIgLbAVRw2u@kbusch-mbp.dhcp.thefacebook.com>
References: <b395277c-5721-4773-9bbc-13cfbc1b0401@www.fastmail.com>
 <20220408161052.GA28661@lst.de>
 <YlB1E/p1uqpl3HiN@bombadil.infradead.org>
 <20220411050533.GB13927@lst.de>
 <20220411055455.GA14480@lst.de>
 <C85067CB-3909-4B62-A86D-467827EBF96E@oracle.com>
 <20220420073641.GA6859@lst.de>
 <26796ED5-859F-4844-B1D1-7C2FF5126E40@oracle.com>
 <20220608075252.GB13027@lst.de>
 <F8EC1673-8434-4294-ADAF-96238E65A7AE@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F8EC1673-8434-4294-ADAF-96238E65A7AE@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220608_120453_558433_E4AA8948 
X-CRM114-Status: GOOD (  17.27  )
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

On Wed, Jun 08, 2022 at 06:11:04PM +0000, Alan Adamson wrote:
> > On Jun 8, 2022, at 12:52 AM, Christoph Hellwig <hch@lst.de> wrote:
> 
> How do we get the clear_ids setting from the connect to the target?

I'm assuming something like this (untested):

---
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 59024af2da2e..3eaf463d0567 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -687,6 +687,7 @@ static void nvme_loop_remove_port(struct nvmet_port *port)
 static const struct nvmet_fabrics_ops nvme_loop_ops = {
 	.owner		= THIS_MODULE,
 	.type		= NVMF_TRTYPE_LOOP,
+	.flags		= NVMF_CLEAR_NS_DESCS,
 	.add_port	= nvme_loop_add_port,
 	.remove_port	= nvme_loop_remove_port,
 	.queue_response = nvme_loop_queue_response,
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 69818752a33a..03ce045af54e 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -300,6 +300,7 @@ struct nvmet_fabrics_ops {
 	unsigned int flags;
 #define NVMF_KEYED_SGLS			(1 << 0)
 #define NVMF_METADATA_SUPPORTED		(1 << 1)
+#define NVMF_CLEAR_NS_DESCS		(1 << 3)
 	void (*queue_response)(struct nvmet_req *req);
 	int (*add_port)(struct nvmet_port *port);
 	void (*remove_port)(struct nvmet_port *port);
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index b1f7efab3918..9fa5bc0e26d0 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -30,6 +30,19 @@ void nvmet_passthrough_override_cap(struct nvmet_ctrl *ctrl)
 		ctrl->cap &= ~(1ULL << 43);
 }
 
+static u16 nvmet_passthru_override_id_descs(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	u16 ret = NVME_SC_SUCCESS;
+
+	if (ctrl->ops->flags & NVMF_CLEAR_NS_DESCS) {
+		ret = NVME_SC_INVALID_FIELD;
+		nvmet_zero_sgl(req, 0, 0x1000);
+	}
+
+	return ret;
+}
+
 static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
@@ -176,6 +189,9 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 		case NVME_ID_CNS_NS:
 			nvmet_passthru_override_id_ns(req);
 			break;
+		case NVME_ID_CNS_NS_DESC_LIST:
+			nvmet_passthru_override_id_descs(req);
+			break;
 		}
 	} else if (status < 0)
 		status = NVME_SC_INTERNAL;
--

