Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361F8606A31D
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 19:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cXhZwmKj;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YElhEmlX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=me6FYCM5eDvC62XQltr2B69i+y7XDQa8ZdXTfsp7gZA=; b=cXhZwmKjWH7GpEeNCjStkZSOvD
	Z92mwSqvmeqdiCa3JxkJUjhpobUMp4lmc3lLvIeL9sD5NIbDcKGO3pu9JXoAgPkfZnXD1Cqu1x6Nq
	GuCX2533wAQMpKlu3F54WvXutqjqj1vbOUvQtJrE+f89oGOCZUXOFDQjbx42xFgZrAHIQeZo66nN2
	PbsWbSd5Jmi4Z6pUJR3DW5kYBOZtc6563jg/aDpyfHxArGM3TcPlC2fgXXsPbzq0JxCk0yEkhhdIw
	ow+iVwoYdo1EIfZUQgSbRLnT2hsN+vL+zgUkHjcfkxoGUD0a9yayvcU62e0NlopuF3uqQxlsK1Ydb
	Rk1Fpq9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLn90-00000005g5D-0zwi;
	Tue, 27 Oct 2026 19:47:38 +0000
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLn8y-00000005g4q-0F5N
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 19:47:37 +0000
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-5eac319a6c2so313866e0c.0
        for <linux-nvme@lists.infradead.org>; Tue, 27 Oct 2026 12:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793130454; x=1793735254; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=me6FYCM5eDvC62XQltr2B69i+y7XDQa8ZdXTfsp7gZA=;
        b=YElhEmlXnhyiG1NYAav7100HKI/4n/Wr1u3XNPeKaeJ69SwIwsxH0JQItz81gDCU1i
         VedRyxr3944PYgG0xssuPCzy+DIUp9euh8/pyKBf05ivJozlGdCsuwZZoBkL4TKKlYty
         JwMT5vjDWqe9sw/NXu73KdV3g5PAm0Mph3tvqu/xxdxquBBqPxxNFH6hTv3RJzw1oRvC
         Z20Qqk7/+F+zsP/eYbpajZiwLjYhSOfXDJhznSdC7Yj+b7u+f84KPYnzJ+ZO+tsEwFDS
         VGRS1RRxOP+pHHXpDLXimQrsSr7LKb8JKMlEvz2/8WWfLZvctSNzTHBFLvRdOCrULYMJ
         ufvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793130454; x=1793735254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=me6FYCM5eDvC62XQltr2B69i+y7XDQa8ZdXTfsp7gZA=;
        b=qxlIiKs4Kp5BwbwuXOMUuCf0j6dnsxDYhs1bIYxOMOGyYB/uSkjJ0WoZQQRCMro7Js
         3DvUxUmULGfNJR5oGTKT3xW1tkUaMunW+YlSTkhLcO9cFbRaqNf0vA5juqu1oouYFaot
         b+gmSAzh47/OlSJ5E753lwomiGc5nwFmKWQPqCEWLG9bv+lZ25UQy/4RUyLgNss2HWkW
         2ExJfy2nhs01g/wjyYBcao/PnwapLq/nBrqlQ2Ur5EVgUNvy5uyCyGVkcLvrTo3XwUX1
         Kn0KEGXT1wGxhLuj5aggM0kQDnMUjJymPtXSgOvB/pcXFGB8M2BiOfI6mX25uepuFxO3
         6YhA==
X-Gm-Message-State: AFq9FYINeAf+JX7P1lrIMhbEDzLtEQgoW/dJ+9avCsVDmqoc1ltJSS3k
	JTZJ/evp9yrThqoHGpTb8lntyHxl3hkiz2IzA3j0vGrPWLZJztn49ty8zNtxFY2YztI=
X-Gm-Gg: AYBFou3f36qCfDl0nwnUbIGlWuwacbXAXaevfU/Ms4K+8uI6o9nyDD4s2Pol+6JBgOx
	N2AqA/5u9CK3DCE8dVv4CVUXcRbSifr+Zjo06x1yzll5bKTUoKe7VSDEALDQQ5C8CFJ3W7pe1Zd
	3NOWX1+RqXJ/v1JQ/Qb3aEGOFtWXjA+p180nmc4OoErW3SjpTPVBjF07RY+HZOMb6TWbNCzDI1V
	goRCuPA6lEfdTaoGnpgH68FUTL1KlYYFKhH0gldD/aKotnixveU8srjPkH6iIaO4hBHtKcPSHbK
	VVg5Z0PhPOIIikuT6LiWZ1BY9Wifx7RNps7Vlt/8iPhNi1DSPhLHlEhHuFPak2s29jSR1lEU+3U
	p04g7kmApLhMGJ9YVVc2bj6vS0NmjnF790UkoEZg0zF8+x+NUdbRsKLrW+yrTxuvQxS9U/OUa2O
	VFkMZouJiSy+FbZNR6kjH4Jg1br41W+KfMJ7r3X7F1sid9X+B+35k838czqh7M3kduYghSB3sNR
	w3c6mkK3jesu9aIb/WpgNsZGotiHWdlrKXO/i0I0C6LV7p4W+LJzBLhJQjn9BPrts+PfjyKEzh9
	5Ls/+ACSB7k=
X-Received: by 2002:a05:6102:440c:b0:7c3:2168:d603 with SMTP id ada2fe7eead31-7d039fcfd46mr168471137.0.1793130454126;
        Tue, 27 Oct 2026 12:47:34 -0700 (PDT)
Received: from bridge.. ([2804:14d:ba6b:8339:260a:a9d6:ce02:aaa8])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cea3973caesm3466801137.2.2026.10.27.12.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:47:33 -0700 (PDT)
From: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@kernel.org,
	sgogte@purestorage.com,
	wagi@kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
Subject: [PATCH v2] nvme-tcp: fix request PDU size when header digest is enabled
Date: Tue, 27 Oct 2026 16:47:10 -0300
Message-ID: <20261027194710.334495-1-christian.aurichzm@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_124736_103570_4C44E9F7 
X-CRM114-Status: GOOD (  16.72  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since commit 61b0ed3be81b ("nvme-tcp: parallelize I/O queue allocation
and startup") the I/O tag set is allocated before the I/O queues.
nvme_tcp_init_request() sizes the PDU with nvme_tcp_hdgst_len(queue),
but queue->hdr_digest is only set later by nvme_tcp_alloc_queue(), so
every I/O PDU is allocated without room for the header digest.

With hdr_digest enabled, the digest is then written 4 bytes past the
PDU, over the header of the next PDU in the page_frag cache, and the
target drops the connection on the first I/O:

  nvmet_tcp: unexpected pdu type 159
  nvmet: ctrl 1 fatal error occurred!

Queues that a later reconnect adds for the first time have the same
problem.

Set queue->hdr_digest when allocating the controller, together with
pf_cache_lock, so it is valid before any request is initialized.

Fixes: 61b0ed3be81b ("nvme-tcp: parallelize I/O queue allocation and startup")
Signed-off-by: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
---
Changes in v2:
- Set queue->hdr_digest when allocating the controller, next to the
  pf_cache_lock init, instead of reading the option in
  nvme_tcp_init_request() (Keith)

v1: https://lore.kernel.org/linux-nvme/20261026184621.29276-1-christian.aurichzm@gmail.com/

Based on nvme-7.4 (aaedcff90148); needs a504cd79b167 from there.

Tested in QEMU with nvmet-tcp over loopback and parallel I/O: with
hdr_digest the connection failed on the first I/O before the fix; after
it, no errors and the data matched, also with data_digest and with a
reconnect growing the queues from 2 to 4 (attr_qid_max).

 drivers/nvme/host/tcp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index f876375dffd2..2209586f3809 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1948,7 +1948,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 		}
 	}
 
-	queue->hdr_digest = nctrl->opts->hdr_digest;
 	queue->data_digest = nctrl->opts->data_digest;
 
 	rcv_pdu_size = sizeof(struct nvme_tcp_rsp_pdu) +
@@ -3098,10 +3097,13 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 	/*
 	 * The I/O tag set is allocated before the I/O queues, and initializing
 	 * its requests already allocates the PDUs from the page frag caches of
-	 * the queues, so initialize their locks here.
+	 * the queues, sized by their header digest setting, so set up the
+	 * locks and hdr_digest here.
 	 */
-	for (i = 0; i < ctrl->ctrl.queue_count; i++)
+	for (i = 0; i < ctrl->ctrl.queue_count; i++) {
 		mutex_init(&ctrl->queues[i].pf_cache_lock);
+		ctrl->queues[i].hdr_digest = opts->hdr_digest;
+	}
 
 	ctrl->net = get_net(current->nsproxy->net_ns);
 
-- 
2.43.0


