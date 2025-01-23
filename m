Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA79C02182
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jan 2025 17:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vkqhkym4WZhQHcqhRX5xEhxIT/Tytg4NVdG2sTTxj3A=; b=kDkyu9dw8n/3PnwXazJp2ZByMt
	t2nl0LYmAemUeHxPxQ8tHlkL1UU1yLn8yChz/4Iw2kgVC15m/OCramzD1y4Hw0xdVDk6POeEO7f+5
	VCIAFmR/CYU4/ilg3gqV00oz07/VjWc5vIW9TzUQGhrkqcTVWjMXRpUZZ4bxbsk/XPD4y8GIZezFo
	T3EWDWA70p+nWxTF7briGv4PeBNuVvA59ojUr9NB3WEJ6xg9oM/D8aKNaYgX2pBginaKZ8qcGjC2p
	bhATocyCXUXQtPebTfgpjAw2qvQOCnX3HR1qAb+Hyp3AucuCajDCFajKGk3cRUO8YgMxMhG6a5Gel
	hhWJ9KPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tb1LL-0000000Cz2h-48ZE;
	Thu, 23 Jan 2025 17:50:15 +0000
Received: from mail-il1-x161.google.com ([2607:f8b0:4864:20::161])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tb1LJ-0000000Cz1n-0XjN
	for linux-nvme@lists.infradead.org;
	Thu, 23 Jan 2025 17:50:14 +0000
Received: by mail-il1-x161.google.com with SMTP id e9e14a558f8ab-3ce301bc7ccso311935ab.2
        for <linux-nvme@lists.infradead.org>; Thu, 23 Jan 2025 09:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1737654612; x=1738259412; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vkqhkym4WZhQHcqhRX5xEhxIT/Tytg4NVdG2sTTxj3A=;
        b=Iv0VgEIY/9fjFKqFzaMwjRQ2ESHtWP0vmXxbLLgfi1KAtMNdzVjrYYOiKxbZFvBStT
         P1cdrLWfqJwq97y0OOOtloJ4qT8k7rrithe56FyphaA13p8nlFHTJilY2emqFz9rDkp3
         AfIx+oosaKN8BiAWIK9s5+utfSuoh9dH44uEe4KTGiUXr6XzT6wIfwSTvgsNGyDL2Cm/
         zFokyk7/bJaccHi2l08REGF75uLnpWfSVbcnt6+QgF4I+t/SCKkfCn6iA/t7JtLHLcMR
         qZtRpXLc24yTDuv7J+KhB0mPksUZSQVRUZO9Ol+ZV1sypBnHPjvtG6tTGB3NIqS4P/Sr
         Biyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737654612; x=1738259412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vkqhkym4WZhQHcqhRX5xEhxIT/Tytg4NVdG2sTTxj3A=;
        b=UE3Snd0xRI7Dswgut6AdwBYUm3D/84oQn8Hwui0FR25Y5PO/cpFG7bYbjwmAxlFaTW
         xa+8fTUVwmmXsfeoijFAo7EcnLbGszzDFyu8/c7Uypmj2hwiM5Pd9i+Lx6o6aSbkShHe
         j/3/LEroFZ/tyyqOU+63CN41lFy45OAQONw9HIHIyAcY+8RajMITECLz0d4UO5WpE6mx
         4WC056HBIn+VEUazkDYTDBWQmUUWmVhTlZwLAWmAyL5JbHe/+TQZw2XfNJ7V6jPhQi2x
         Savzh1JFqHhcXt6o61mMKRU08s7IAd1Gggu0JKUuK7CiwJYKCBvqkI97U9fb+8nl1Qr3
         Hrag==
X-Forwarded-Encrypted: i=1; AJvYcCWYVeITX4OvzLK1RwpaSmyBMt/mKzwUIYRWying2RkD9GKZMCnLmon5NIhiHa1A9B4ISbcWRZZwzFyy@lists.infradead.org
X-Gm-Message-State: AOJu0YxaeHFs1Zv6mhG0AchTTkb51QY+p7Yk8RY9BSfjZfHyMb8a1WTc
	ghVJH8Q2aiRIut5HSVd+qOU964OAqqWWSEPV5yE4bor4+fyJU/pYZSpgkHXI8/QnYdI4eVSEd1b
	MbUy+rsW7czjxo9Ycik8iOa8yWzZDN4Dx
X-Gm-Gg: ASbGncv+12RhYJxD9l1rGbuwx253fmzwupkgAFzn6lSF1b9x0ymNhKMDUNyH+Pg8hto
	5SL0hsYTW6N5qJI9BLq7sJaWxyvw4iuSi+fE14Ccs9rmW4yUo3OLPGBo7UMCO/aRXa+ML8XxcJf
	tGpYyPJkfMgUFeCBSlB4wDjYIVT7ARV8EoZEy7DPoOIWqMXu7oo/IXTIHE9kGQyPl/eF2RcV4GN
	MRGmNc8HK7Z3l/UvG66OCIEnf95UrqV7HFhZJPIOU5L/fhpMc6CEvWfVQGKx2UFETozfJrWKeMu
	5xnVZsuXL2s5NTqmIMeCoX8JCbo=
X-Google-Smtp-Source: AGHT+IH0w/taoWhrutymqxi/03488RjZxNI4WngpXFVkXtL3ahX1RvTVkPlQ2ayCNX+aeIkYfIEOFqsl+X4m
X-Received: by 2002:a05:6e02:3dc8:b0:3ce:6c17:ec5e with SMTP id e9e14a558f8ab-3cfb193faf8mr24874645ab.7.1737654610309;
        Thu, 23 Jan 2025 09:50:10 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3cfc7509e98sm108245ab.56.2025.01.23.09.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 09:50:10 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id A08E334039C;
	Thu, 23 Jan 2025 10:50:09 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 912EBE41418; Thu, 23 Jan 2025 10:49:39 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-tcp: check that full ICResp is received
Date: Thu, 23 Jan 2025 10:48:58 -0700
Message-ID: <20250123174905.1252949-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250123_095013_258456_F4B6BFB3 
X-CRM114-Status: GOOD (  14.43  )
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

nvme_tcp_init_connection() attempts to receive an ICResp PDU but only
checks that the return value from recvmsg() is non-negative. If the
sender closes the TCP connection or sends fewer than 128 bytes, this
check will pass even though the full PDU wasn't received.

Ensure the full ICResp PDU is received by checking that recvmsg()
returns the expected 128 bytes.

Additionally set the MSG_WAITALL flag for recvmsg(), as a sender could
split the ICResp over multiple TCP frames. Without MSG_WAITALL,
recvmsg() could return prematurely with only part of the PDU.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/host/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index dc5bbca58c6d..d23c6243da5d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1447,13 +1447,14 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	iov.iov_len = sizeof(*icresp);
 	if (nvme_tcp_queue_tls(queue)) {
 		msg.msg_control = cbuf;
 		msg.msg_controllen = sizeof(cbuf);
 	}
+	msg.msg_flags = MSG_WAITALL;
 	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
 			iov.iov_len, msg.msg_flags);
-	if (ret < 0) {
+	if (ret < sizeof(*icresp)) {
 		pr_warn("queue %d: failed to receive icresp, error %d\n",
 			nvme_tcp_queue_id(queue), ret);
 		goto free_icresp;
 	}
 	ret = -ENOTCONN;
-- 
2.45.2


