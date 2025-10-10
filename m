Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A73CAC5BB
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Oct 2025 04:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jch11Bu3wI9Xf6VNMlwdSI3EJI5QLIUQJkMhWN2GBUE=; b=VxxA3PZL526q62SEjwtmLsrkla
	OGMvL5GJNXZxplBAqyz595gyEs9c3j+eY25oRRD0ONNiE83vpGRRsDyM5xwhd6oR5e8zoOlxsQJRd
	I/O7cuTBNy1CtiPsPtVSR82BM/DB4W2ikh9zGzbHmHYuS8mmwhUl/h69gptGQKvvc2aylyn4L+ctH
	mWFR6ZYCHwgxm3UZ2rwSOYQsDzOLkCZYpR1QWwQRUtkhIXADcBYukAW2pYBPE2q9j+0RsCn/+749i
	cSAL5KSUHls3U5AIQPnaLp6TSozoQUDtL545rjiriRwXRrjd3Hxyh3jVyyAFc2Jz9m2OTtZcSlvI0
	zhpq4//w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v74hn-00000007epT-3XJ3;
	Fri, 10 Oct 2025 04:26:11 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v74hf-00000007ep6-1X3S
	for linux-nvme@lists.infradead.org;
	Fri, 10 Oct 2025 04:26:07 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-77f1f29a551so2252019b3a.3
        for <linux-nvme@lists.infradead.org>; Thu, 09 Oct 2025 21:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760070362; x=1760675162; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jch11Bu3wI9Xf6VNMlwdSI3EJI5QLIUQJkMhWN2GBUE=;
        b=OH0lM6QrkI+XxOc8Slto+7aaqMTaMXDKOBMtCQDOJ64DSaXKbui/5tzb88eEURqITU
         OaU8U1l4S/Uc/mYxLerf8F+ctiFwKQRjHFoi7oynyPNHi/KUOXwYlIvkSoxBveXQ8ULq
         kb679PzUAonUfK4JNwMwn3YdUXuVP6cN/whWFGjnSJvEhI16pGCKNlTFvNdRNDmjD5TY
         ggDAleEzJouFgdwt9jRTb4HLvEaa/v4S2qY58vF+NhrC8joaK8zTHf05+ROTc09KOUj8
         5uw/IXAqHr5jre4iOhU+isnYi7/BILiwCZahuNdBN/VBlEcjGBs6palDwR+oaeDs4N0k
         QAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760070362; x=1760675162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jch11Bu3wI9Xf6VNMlwdSI3EJI5QLIUQJkMhWN2GBUE=;
        b=tBZgYAOtxQ0fDF5CHztOxrCGv6sxHi/lVaAK5kXUxIYW5faSaGedDSQEmhg2wnou+v
         WVTwU82UpNFwHOuC7dDx43LVA9MIP3WqEVOtTi817pu9C4HI5Dq2W5jWCWzV+MaEksjt
         6MMVpKvDID4RW3bzaubnM3KXpKhq7t7h8c+3qeuJvZFcOUqG6CgKGFmJ10635Ue0nW34
         /qXUOqgyql2nWVM+Qf55swO3jkl5V0ZpirikygVOstpfJIQja7/aYN2aRatqHtGgBVcL
         J/TEyUh4f1GtpcWEZNo/ODH1XRiBn7I522CAwLtqq8LQ8bAq0VIje4Dv38CGpvdxUf34
         jboQ==
X-Gm-Message-State: AOJu0YyQ+j/396g0qoyxdJFIA9tGyiWRslCdiZTqJR22TdTaIZqudj85
	Zff7/gdD4XaD0RIVOffTPyXtBz10ZI3ILsSt4yw3AslgNJFymZ/crQ33GVquGcJ6
X-Gm-Gg: ASbGnct8FR1kP4fpCvpVojpZZUFDNsFjKQoIX+EHjCLmb5O2RVeTDHKZ9jxV4pnQ2c5
	XQ7YUiEQ0gCl1ltPSsqAwyQ0CALs8a2vMb5H4Bay6FgTDyVXpX8Xw47+hqtZWPix1WSh9wMi3E4
	wFTFUO0jxHoyKn97jUIYcgDZtdddmjFktnegW9RWSNG729Ja53/p6gMF7DxOqh9gx6NTVD5Nff9
	TYuNHe9HHswzHgWjTw4dUNFRkchtCIZAUvO/yKscArhH5TAKT62NC02h4gFBR8nrDHp6pUV7Nmv
	t9Y2O5h5FISiUnLn2eyvN1BsO53IOwbw5nDo2B/XluqH9kG0wbPMollUqPtbSGl+r/4uPlUZ8nG
	TWMfCh16Q1ywzlmk5zej65xvxZTIrehyEMWzsL7+JApJ+PI43q5/pSoi+Ba8MzSMGsrI=
X-Google-Smtp-Source: AGHT+IGEkqIzhQuL3f5LTjx03nPrTKH8siuoV4YI/aI1YU/01DZQX0TA2yC06xsJawbIkzuIWPaPQg==
X-Received: by 2002:a05:6a20:9389:b0:251:9f29:4553 with SMTP id adf61e73a8af0-32da80db3a8mr12916317637.10.1760070361997;
        Thu, 09 Oct 2025 21:26:01 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b8285ddsm1414005b3a.23.2025.10.09.21.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 21:26:01 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v2] nvme/tcp: handle tls partially sent records in write_space()
Date: Fri, 10 Oct 2025 14:25:15 +1000
Message-ID: <20251010042514.704249-2-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251009_212603_426544_8EAD5AB1 
X-CRM114-Status: GOOD (  14.63  )
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
V2:
    - Unconditionally invoke TLS write_space(). This means we don't need
      to export tls_is_partially_sent_record()
---
drivers/nvme/host/tcp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1413788ca7d5..6016510577bd 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1079,8 +1079,13 @@ static void nvme_tcp_write_space(struct sock *sk)
 
 	read_lock_bh(&sk->sk_callback_lock);
 	queue = sk->sk_user_data;
+
 	if (likely(queue && sk_stream_is_writeable(sk))) {
 		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		/* Ensure pending TLS partial records are retried */
+		if (nvme_tcp_queue_tls(queue))
+			queue->write_space(sk);
+
 		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 	}
 	read_unlock_bh(&sk->sk_callback_lock);
-- 
2.51.0


