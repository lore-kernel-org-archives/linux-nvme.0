Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E8BC61DB9
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2026 19:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iBi81DoAME+eWZV4X1kfhpLDp5hpSffQeNzIrftqK00=; b=OpyryFcA+Fx+ydcpMg70FP63KK
	58WBmi6MPyt7VP691qTuxHD6k5MNc4zMxfLagP/Fp4oKnrlq9sV13pakNHAH706uazxP57iEh5QxJ
	x/zBh5HhkKFdCkkOc5kQUB+6EgQlpSztCcFXCPLF5sCeqgq8d0YspR4vEc7cNqfsoTZhxMqd+/g9x
	SoI5ljnRSf6KPbr1qBnu8+zfpjOTgex6QawTbOM1AGs5cwyT1FUO/T1Devu8Ys4xx0ntax0dIn996
	F/TXpqeRCAd3tfaUJ5cg4TjM9XwPAqOb9CbvP7hQTayJi78f3V+C1FEvCpvNg0VvrZ2f1N5vyqNA0
	1vzKv5Sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzfir-00000004hor-1gGm;
	Thu, 27 Aug 2026 19:25:13 +0000
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzfio-00000004ho8-12Ks
	for linux-nvme@lists.infradead.org;
	Thu, 27 Aug 2026 19:25:11 +0000
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-934956bee57so21911185a.2
        for <linux-nvme@lists.infradead.org>; Thu, 27 Aug 2026 12:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787858708; x=1788463508; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iBi81DoAME+eWZV4X1kfhpLDp5hpSffQeNzIrftqK00=;
        b=qFlAK7yHGRShil99bEVMLwaagYXipjhNiE8nEDkuhS7Ud4iAtfJxZxe9DVYowm9y6J
         aEpaLQPfqyA4xwvIduTwrOwVS+ZlUhP5cl8iXWZGlSpP1+6KOBCOyFclpCQdrXxwRqgq
         EpCM79kBEHO7A8J1cguKODicWMlnQ1vXln/vLtTvZ3fjz3t8qVGncNE4Wa9SSYqZnwFx
         DLrDi6PXgDA2RLfS0/irz2w2dBRpYj1Cy/j4AfPMN0uPoPsgt+MFua70fEaoqrfByJhk
         sk7RwS6qP/dcvcZhSb7NQtcnEWy948h6dbec167KBepY+z06s+AKq0OEYJm9In/F3rJ2
         WEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787858708; x=1788463508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iBi81DoAME+eWZV4X1kfhpLDp5hpSffQeNzIrftqK00=;
        b=Bim9/X1I60z54piKY9JAWTAho+itZd5eLd0ai01/7wDx6Ua+5hhN1v9stUabkuI5CD
         ypAVIxKpAkf/HH5BsIYwJ3unTdpp4IeVHCx31p1qPMuX7V/AHw/T26a6O4ZEnvXGSxpE
         urkd6Fr5O58tbrEKnb8ShrQ4juwa5s3Dr/VLqNZ5ny1aHTLu9toT+gjjGUSfA5A2S2ze
         YOuIYlT0aX/eIF9EZptV7vgnp34RbtAytEhiL5HSSVmC5XJIR1usiKGAQ3S2aO9XJ1SZ
         yDb2FlbtUyNdXvja0Js1ktSKgYz9MQgWZRlNn4hZiAZtuzSQMyCoQK1eD9n4c+IYEz1g
         abSQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqy9KbkpbDHs9Gmz91SGQYlGTYO73ZbGGL2WTQa3y41xECs1i6WV+3OmDqn9rnXNzgE5KCVf62KzZVw@lists.infradead.org
X-Gm-Message-State: AFuF++nMy1Xb++MpSvIWbGXXxPIz55AVyLNN1NFxREDzQftUjo0SPbNo
	8mZgGvdWt3EYHotq94CjolzoL9W623sP6Z3tx/ZphFExr9Pf5HTwd5OJDf90EQ==
X-Gm-Gg: AR+sD12OWBmuV8noSBF8LsCjULcwjcwZSczfsGHOZ5AT9ii1Kq58MMhJxSZ+9qnksIP
	8//uR3roGsg777Jv/sXxR5B0KQZ2l7rcXN2Cft4bSLSOHpfLSg2jllAXPYCp7e37TyiHMRDwaxI
	b+sH95kHV6QD4aAP/OtPNvTXN23MSWQmPDTYWgzJKuMtORAhKKaOI0cYIRnduazqCshdHtJEXim
	XAu5s9SX19R+wR9QSLuGCyRFyaTpqd/+4MiayvykS8eWxKudVAFZDWyk47/gf35MAOG3R2ghwng
	HohPvqMTxxiijizg84looU8lm0DOiEEh0l+qpI4+gz89dlj7Bla8RYNxbbnQmyVa5UyN8Hrdi7r
	pSxFrifo8oNM6UBAi/9LWz+3UQnSIzlIVOZyrchQtwxr6WHJFhXFO10blCh0A1NXAJ1NZGoQ42G
	NOf9yAMVSuTKHwCA/wCtHTBsAWWxiOSGybRmda8CnVR1YLPOudYert7qFfyHTtEZDY93yomrpOb
	HHzJ5XEmiRfLoRbQf6mpIFQv2oYvNHvKLGr
X-Received: by 2002:a05:620a:4707:b0:939:6a:a71e with SMTP id af79cd13be357-939138c0afcmr134402785a.21.1787858708152;
        Thu, 27 Aug 2026 12:25:08 -0700 (PDT)
Received: from shivam-EliteMini-Series.syr.edu ([128.230.213.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cd7044547sm24043406d6.19.2026.08.27.12.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 12:25:07 -0700 (PDT)
From: Shivam Kumar <kumar.shivam43666@gmail.com>
To: Greg KH <greg@kroah.com>
Cc: security@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	kumar.shivam43666@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] nvmet-tcp: reject unsolicited H2CData PDUs
Date: Thu, 27 Aug 2026 15:24:55 -0400
Message-ID: <20260827192455.1849385-1-kumar.shivam43666@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082755-stucco-champion-2bb9@gregkh>
References: <2026082755-stucco-champion-2bb9@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260827_122510_325177_D95A09C6 
X-CRM114-Status: GOOD (  15.54  )
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

nvmet_tcp_handle_h2c_data_pdu() accepts an H2CData PDU after only checking
that its TTAG is a valid in-range command index and that the command's
data buffers are mapped. It never checks that the target has actually
solicited that data by sending an R2T for the command.

A remote host can abuse this. It submits a write command that takes the
R2T path and, before the target transmits the R2T, sends an H2CData PDU
for that command's tag. The data completes the command early, and when
the command then fails synchronously (e.g. a length mismatch caught by
nvmet_check_transfer_len()), it is completed a second time. Each
completion calls nvmet_tcp_queue_response(), so the same command is added
to queue->resp_list twice while it is still linked; the second llist_add()
makes the node point to itself (lentry->next == lentry).

nvmet_tcp_process_resp_list() then walks that self-referential node and
adds the command to resp_send_list twice. With CONFIG_DEBUG_LIST this
trips the "list_add double add" check (kernel BUG); without it the loop
never terminates and the nvmet_tcp workqueue wedges (soft-lockup). It is
remotely triggerable and needs no authentication on an allow_any_host
subsystem.

Track whether an R2T has been transmitted for a command and reject an
H2CData PDU that arrives before it. The flag is cleared on command reuse
(nvmet_tcp_get_cmd() zeroes cmd->flags) and stays set across the multiple
H2CData PDUs of a single solicited transfer.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
---
 drivers/nvme/target/tcp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index e4f603b2ace7..328b075300a6 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -103,6 +103,7 @@ enum nvmet_tcp_recv_state {
 
 enum {
 	NVMET_TCP_F_INIT_FAILED = (1 << 0),
+	NVMET_TCP_F_R2T_SENT	= (1 << 1),
 };
 
 struct nvmet_tcp_cmd {
@@ -776,6 +777,7 @@ static int nvmet_try_send_r2t(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
 		return -EAGAIN;
 
 	cmd->queue->snd_cmd = NULL;
+	cmd->flags |= NVMET_TCP_F_R2T_SENT;
 	return 1;
 }
 
@@ -1009,6 +1011,12 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 		cmd = &queue->connect;
 	}
 
+	if (unlikely(!(cmd->flags & NVMET_TCP_F_R2T_SENT))) {
+		pr_err("queue %d: unsolicited H2CData (ttag %u)\n",
+		       queue->idx, data->ttag);
+		goto err_proto;
+	}
+
 	if (le32_to_cpu(data->data_offset) != cmd->rbytes_done) {
 		pr_err("ttag %u unexpected data offset %u (expected %u)\n",
 			data->ttag, le32_to_cpu(data->data_offset),
-- 
2.53.0


