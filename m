Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF972C83F1B
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jul 2025 09:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0TFZBfTKSvZlUYhuHwh/vk0nwcmeP2xqNJ0/YxVSCj0=; b=GAu3G3W9iLo6kXUc4jHOh6JaNW
	XbU4nBgjCsmWVFsF71okcw3P2seQml/R4eG9GIqsNIZMaQUEUZWApAju3VpLIKf54pYa79BDe3HUd
	wCCNtOQQv/nIyat5rv/DFrq921ZmrVP6Dmqvg0fbFuxrprqyi/Mlm4MmqR0SGVoGRGAJMW1THQniE
	rT7WM0WPdyI51bt9VjORN8unUXAG0Ly53ktTUo1VlCRyWF2lvkSqLEnelXReqkJJqueOg568l0ZVC
	D7GfKVHWq4rLco24PbAPASiE3glOBIBEENqEAwT9J8jLrxHqn8hfiSc4Z2ngb9M78Ex3YCa2ZB/LW
	0WyCmfiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubFIa-00000001kZW-3z4H;
	Mon, 14 Jul 2025 09:16:36 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubFIW-00000001kXp-273f
	for linux-nvme@lists.infradead.org;
	Mon, 14 Jul 2025 09:16:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E309B61423;
	Mon, 14 Jul 2025 09:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9429AC4CEF7;
	Mon, 14 Jul 2025 09:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752484591;
	bh=eL+MfX1V8Mfw/6f5jaBeMGhJRWRE2FDY6L9HT7HNVLw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EJ85yz67JLGW+HGrj1fWSm0xWy3RJcRBmgV0lUJFahMINScGwG9xbjPuYldBogX8t
	 s+BaeSlDa8asLxuuAKCzLg5IYq6ypJLi60kojDujO7czMPfV+g8ExbozqTGrxSS7W1
	 me0JA6efSmq1NWapSOVEdVk4Zn3h5AJXr02HdXrFPU73HRFg2nziLjssCK7Biv9I8T
	 O9Gu+Oj2WnXD9ZLri63QE+DegpgoayHsrehvrKa2jU5/Yr2uHQlcRa1zxUNxBGPfZ6
	 xO376l3j6l36oAHj5Zl+Ubfli0giJenq+aBAkaQdvTM37zuhwQuQkjr9+CcIl7zq8h
	 WrMv7SkfwvUaA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87961C83F25;
	Mon, 14 Jul 2025 09:16:31 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Mon, 14 Jul 2025 11:15:33 +0200
Subject: [PATCH RFC 2/8] nvme: Add cdq data structure to nvme_ctrl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-jag-cdq-v1-2-01e027d256d5@kernel.org>
References: <20250714-jag-cdq-v1-0-01e027d256d5@kernel.org>
In-Reply-To: <20250714-jag-cdq-v1-0-01e027d256d5@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Klaus Jensen <k.jensen@samsung.com>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2081;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=eL+MfX1V8Mfw/6f5jaBeMGhJRWRE2FDY6L9HT7HNVLw=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGh0yuoiMgo9kvgQ2onuXE5Bzm5EOPldHUWSc
 djDt0GXzv++i4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJodMrqAAoJELqXzVK3
 lkFP7x8L/RbyrP9gWDYhZxH9l/ZFBQRLh1tU1lEpjnC+0l19BplIU233ls4Nb8jufwEnNM7UXmN
 f34Xd5pqD5X40TutgIT8NCx6ZAplYlm9cvfQN3nfMhJrOXNGFWrDh0SkoKAEikhlRDdbVJndHWF
 mppIYEWpeOoeJ1zPkyAx1tZE6luI6kkewQQVx9rCcRZyWd3oIceHT9EGPHsbOcJmXPUbtZrLE+h
 QXZUiib2GpEy7fV+FC6SjUCmbGlF8uX6lb6S1FkEX5qwYJc+1tk6THS4WelQDLvzcMOz2Bd8agG
 GCUVM2syC+eJ90IExrl4TOnJvouuzVBVY15ZnouJAs+PoQoIYSuC/RprqqbEer9SILxB5rQ/N0e
 rMlK4zTRYFWu4HJuptuMg8TMhkFJckLIA17dcGvxHgi8dTWm7AMlCbrKBAteyvQWPasB5nsUi/K
 4hHwBLWURwHEQuJLDr9OTSGPBX6b7QcLUnvujeCj42X5ZJ/+a4HfF2MswcEi9uLEQkmzqe8+rI5
 Jo=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239
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

Add a CDQ xarray to nvme_ctrl allowing for several CDQs per controller
(as per specification). The structure will house a pointer to its
controller (*ctrl), a pointer to the entry memory (*entries), number and
size of entries, current entry and phase bit value, the location of the
phase bit value within an entry, dma address, CDQ id and the file
pointer where the reading will be taking place.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 drivers/nvme/host/core.c |  1 +
 drivers/nvme/host/nvme.h | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7be6b42a1adcc3fdb3cec2e2d0e73fcf74244590..9b2de74d62f7a65aea2d28bbbed6681195d9afcd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4868,6 +4868,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	mutex_init(&ctrl->scan_lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
 	xa_init(&ctrl->cels);
+	xa_init(&ctrl->cdqs);
 	ctrl->dev = dev;
 	ctrl->ops = ops;
 	ctrl->quirks = quirks;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8fc4683418a3a6929311c7b56da90ebcbbe16d86..800970a0bb87f7a3b6e855f56a2493a7deed1ecd 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -411,6 +411,7 @@ struct nvme_ctrl {
 	enum nvme_ctrl_type cntrltype;
 	enum nvme_dctype dctype;
 	u16 awupf; /* 0's based value. */
+	struct xarray cdqs; /* Controller Data Queue */
 };
 
 static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
@@ -553,6 +554,20 @@ static inline bool nvme_ns_has_pi(struct nvme_ns_head *head)
 	return head->pi_type && head->ms == head->pi_size;
 }
 
+struct cdq_nvme_queue {
+	struct nvme_ctrl *ctrl;
+	void *entries;
+	u32 entry_nbyte;
+	u32 entry_nr;
+	u32 curr_entry;
+	u8 curr_cdqp;
+	uint cdqp_offset;
+	uint cdqp_mask;
+	dma_addr_t entries_dma_addr;
+	u16 cdq_id;
+	struct file *filep;
+};
+
 struct nvme_ctrl_ops {
 	const char *name;
 	struct module *module;

-- 
2.47.2



