Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED013CCA476
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Oct 2025 07:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mxptVhruQAiRPEx46nNiwkKEt3IcgJzyOLn78aoPtes=; b=j95CCZPoTAdXQMaiqpep/0x4DA
	Y9YCzc9a+qiyH6JyKHYwo6UNG9lUnP98hZyAwFAz9Q5/2W1Ya6RSYKoLa/QbtM0xbFxozAPtLodXo
	jMi84D8EiSOLs5zlXjDY0LR52fF8Ao8UZqplv0PwJFPhNbW24WCB+2oGpy7glKVW7nI/X8rkU8wNy
	g4NYlkRRIBmB8BXix/Nz25tqb3FmWtlp14DNhdCeyQRJvFK+OmQThjtWDTUa5KWchVDXrOQPhBa+D
	U+i9nAqM58n8XJ8yv2mt9wj4HNPP+kpclDsIa4KvMKFKv1Vgsd8BGG2NOAz9JWqAbkKRVPVLXLhOn
	1M0TMA5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v77RD-00000007qVx-1hox;
	Fri, 10 Oct 2025 07:21:15 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v77RA-00000007qVa-3Izq
	for linux-nvme@lists.infradead.org;
	Fri, 10 Oct 2025 07:21:13 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-781251eec51so1526587b3a.3
        for <linux-nvme@lists.infradead.org>; Fri, 10 Oct 2025 00:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760080872; x=1760685672; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mxptVhruQAiRPEx46nNiwkKEt3IcgJzyOLn78aoPtes=;
        b=ZgwPw5wHGLMWfSQGs51HQxlO2w6kSYbYWvQtBIkmGH+k+QENydj14cDvjNmwfFz9uQ
         M8WePED+BKUXw5rTwalw4gn6NYjHatsYA4aciJFwtUa13NRIGA7JL6IepXyk+yBgtL70
         gjgsNYr/FEgsHbkH/8zHm1pvgtX6p+F4DYS3EeY+raqLsz3cVM3I0Vn+kKoRLovoSHk2
         G8AX2LXgO4nPvuKAFPu063PuH1ATBkHDdQrULrFZ5mfRCGQyRfWvp0PWt8mvbupL34L0
         ItVArbgsFi3MkGkuQBZaX4Rqkl/DdiqpFPrzjGdLTnjoY+ZPuvHHPbceem+GojWRkctg
         ymhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760080872; x=1760685672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mxptVhruQAiRPEx46nNiwkKEt3IcgJzyOLn78aoPtes=;
        b=M0MboYiWSxs5NUTakO2yvSRXSWtFQEGVJ5SeGRmrV0CxoIV4Z9AZi0k1TC+vPJhEzY
         WX0loyfb9c41FK1AFteTD1wlddICHtjBa71PmYJgO+T1s3yEsQXAUllQtEaOONk6aXh4
         deU44XqkO3L+BZ+c9z5Adp4D15h/p/t5xCaDFMNjllfSlcmFU7uwVBkhMqtsNWN3uq0u
         jvQwYITy1Y99yI9VdODCY04+1CxA6Pn/GiESUTk6JV9ER2fsxDm8wCZFVPlS5aidEJu4
         vQwvEGi+G9wTFGqC5GW+nM7AFdBEM0flkR9zhh7Y5+msn+QuddvedaW4Gm6xoWx8GWbl
         e52A==
X-Gm-Message-State: AOJu0Ywm2Qo76mOKhAR0CvLu+edJo6Etth1QqaGWgLUcgtSVHFC6SXZc
	mVdHTERGXjrQRbMrpDIHu8dbo1Bt0HH8ro1AFO6ro0no8d7V2cApzq4TqiktKcop
X-Gm-Gg: ASbGnctWGauGfTG9JH29TezgTUdm5WO7R0tSjIZ1HcXMVRtXIHk7yl9q2Yx8VKFxWLF
	AkdNOEVu1bYsOwVOJcuPXkEdUNcSjdd2r3H0eGNdL6QwWux2Xm1cr+l2UiHipOutzBKRX2M8uyb
	rJytbOI3L080tNvSG32Ig1LjWNcdCCUw2IWE/qMnYuvfoQqwMY/2aicOv3dNwC+slTcDQh/7bUK
	EFXGdLlEFQEg/QNzJDL/MxmALnmrwxPgVyDkm/SfX4vz8kUUTt+xA0mH55FrfB197DUkIYUNxaj
	ohUPSbO4oc3U+fjbxy1iQTtdzf50uhqDj6LhBbgGDZJ9SDaqB5cGYObairhRqXE7dmqsdolqunz
	yHxyKOJgeDs0HIGYKVolSH6OG8k5sXkgVs/O3J44d24ff+Q==
X-Google-Smtp-Source: AGHT+IFAWLmtWVM5EBGnGCaXD98Ys2mJ6n7A9+96/hj6XjqpG7KFLZEg2LWeP/xd2x4o7fwM7CawYw==
X-Received: by 2002:a05:6a20:918e:b0:2e5:655c:7f86 with SMTP id adf61e73a8af0-32da839f1b2mr14664880637.39.1760080871668;
        Fri, 10 Oct 2025 00:21:11 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0965c3sm1926468b3a.52.2025.10.10.00.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 00:21:11 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v3] nvme/tcp: handle tls partially sent records in write_space()
Date: Fri, 10 Oct 2025 17:19:42 +1000
Message-ID: <20251010071939.709063-4-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251010_002112_848861_0E6AD2F3 
X-CRM114-Status: GOOD (  14.07  )
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

With TLS enabled, records that are encrypted and appended to TLS TX
list can fail to see a retry if the underlying TCP socket is busy, for
example, hitting an EAGAIN from tcp_sendmsg_locked(). This is not known
to the NVMe TCP driver, as the TLS layer successfully generated a record.

Typically, the TLS write_space() callback would ensure such records are
retried, but in the NVMe TCP Host driver, write_space() invokes
nvme_tcp_write_space(). This causes a partially sent record in the TLS TX
list to timeout after not being retried.

This patch fixes the above by calling queue->write_space(), which calls
into the TLS layer to retry any pending records.

Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
V2->V3: Minor Style Changes
---
drivers/nvme/host/tcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1413788ca7d5..9a96df1a511c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1081,6 +1081,9 @@ static void nvme_tcp_write_space(struct sock *sk)
 	queue = sk->sk_user_data;
 	if (likely(queue && sk_stream_is_writeable(sk))) {
 		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		/* Ensure pending TLS partial records are retried */
+		if (nvme_tcp_queue_tls(queue))
+			queue->write_space(sk);
 		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 	}
 	read_unlock_bh(&sk->sk_callback_lock);
-- 
2.51.0


