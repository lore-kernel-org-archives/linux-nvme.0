Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF95C5AC7C
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2026 15:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2fB20ftjI5YyskQiNKGBxKLyrxp45Qvk/ySA69FxKHA=; b=Do4XWXGsdX2jx3orWvuJprzeIw
	7xozL+moQLnPYUc5rgzOuxBZgfXLGXl9lViAjl8kMs7f3sV+lsuqb0trBHiV5jyN+J5Eqsf3tlbB6
	2wHvq5Vn3S+MG32NiDbDbVs5cvjego67gh57nO/pUCWGyUSJ/Svk5SXMH+MUERqIhecUZ+AWzcsZt
	LtMTkHk3KjAZv/oH8tcjB18GxHYS1JrrBAeAy389IMSBrtl1JzvxhWs3RnZSisvSzPHsRodXWYD2N
	rA5ht08GvQ4V+yS6RtHbDIJwh5M8wTFG0AuAiAZXZuN9AmmxYvhi6YPiteUp/hb+mETJQrkvfXIU3
	noQchixw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ws01f-000000065Kt-0Pjo;
	Thu, 06 Aug 2026 15:28:55 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ws01Y-000000065Du-1jns;
	Thu, 06 Aug 2026 15:28:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B5FC443687;
	Thu,  6 Aug 2026 15:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78CEBC2BCFB;
	Thu,  6 Aug 2026 15:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786030127;
	bh=ZLJDszrW9HD7IRTiZASdqbu+USSjGBXGFe43o7bNZrE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y9KSw6SS00/FkdWaCDU9ttBeuCnjmYqQurygFg7wS8q2EP1VwVUKScUZbrJ0raRvP
	 9xwdJxOGyKJbQT4pq57PAKXV/DGr2CU+zsoU2827PDka30p2Afnw0+iMnOz5dlNwwQ
	 r35hP3i1Br7B+iRY2CjlSmaXXsUFjjtCWDI7TUvD/XJEFtovT2d5QMp+xq79Uuj0S5
	 BCoTCdy1S8K4hNi2AsiaV9H9KA7bXdRyYdwLzijHh+dQFHvOhNKgs+H16bDBkdeyUw
	 ws/MzQY2VcMYlHVjdESr9zlgXybt9sH4VOtgyfcyizJ1k7MuSFnWBY7Ohmhv6CweCV
	 P3jLA9FXuLPwQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F343C5AC80;
	Thu,  6 Aug 2026 15:28:47 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Thu, 06 Aug 2026 17:27:35 +0200
Subject: [PATCH 3/6] nvme-apple: Never set the opcode in the NVMMU TCB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-b4-nvme-fwabi-v1-3-bde19ce8db04@kernel.org>
References: <20260806-b4-nvme-fwabi-v1-0-bde19ce8db04@kernel.org>
In-Reply-To: <20260806-b4-nvme-fwabi-v1-0-bde19ce8db04@kernel.org>
To: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sven Peter <sven@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=886; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=ZLJDszrW9HD7IRTiZASdqbu+USSjGBXGFe43o7bNZrE=;
 b=owGbwMvMwCXmIlirolUq95LxtFoSQ1bJCs1X7mvXfs/qzv/Z+SRtRfHCDXzeYa3rU07/nnaAW
 4A5xXVJRykLgxgXg6yYIsv2/famTx6+EVy66dJ7mDmsTCBDGLg4BWAiClwM/xSr2SOetRTk7dYq
 b5eMDpu0sOv1iupH95N6u4XWXgkMSWb4nxZbsJudseTDGu8vb72W7N96Yv9x994rH97JTROx4J+
 /jh0A
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407
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

macOS always sets this to zero and the firmware starting with macOS 15
has started to complain about what we're doing here.

Fixes: 5bd2927aceba ("nvme-apple: Add initial Apple SoC NVMe driver")
Signed-off-by: Sven Peter <sven@kernel.org>
---
 drivers/nvme/host/apple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index f134b5ffb774..1ea732c3df1c 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -318,7 +318,7 @@ static void apple_nvme_submit_cmd_t8103(struct apple_nvme_queue *q,
 	u32 tag = nvme_tag_from_cid(cmd->common.command_id);
 	struct apple_nvmmu_tcb *tcb = &q->tcbs[tag];
 
-	tcb->opcode = cmd->common.opcode;
+	tcb->opcode = 0;
 	tcb->prp1 = cmd->common.dptr.prp1;
 	tcb->prp2 = cmd->common.dptr.prp2;
 	tcb->length = cmd->rw.length;

-- 
2.55.0



