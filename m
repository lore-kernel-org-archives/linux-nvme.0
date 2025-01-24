Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71378C02181
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 18:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YEtlMU2LVA4ZfmH2lP33mJI86LNP9DhvLnmv4lopNA4=; b=J5kWL2KNf+pZmPAoorpRZWtT/f
	B78gP3Zz5J9JBW9KYhazU8jv4A4a38XFeXzfnzK+V3/RAfkKYFnoEALlxPJcNxcfNWjOrDuO1uzBl
	YKZO0NZxwmsZnMl6Vs9++U6zo07/M//okJxCQmDvp2+lNPwMbu0yp9cxeL4QpAKeFfoG2j24xIQCd
	xvSpWhfeZdicfE4gGXcMPW5NQ88ISwGi+55ZUrAZ5ZQ5qJkZukUQaidVKB5PU3mpl6ldtznYuseKy
	P51U2hdUaqGF2tONuhWSZ98tSAQDiPpdj20iYF+hQ664VYjfpulo9TuV3BlSFPdCg/LDDWHEJO1WK
	hd05lKPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbOen-0000000FJjl-3jQv;
	Fri, 24 Jan 2025 18:43:53 +0000
Received: from mail-pl1-x662.google.com ([2607:f8b0:4864:20::662])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbOel-0000000FJjN-4BDw
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 18:43:53 +0000
Received: by mail-pl1-x662.google.com with SMTP id d9443c01a7336-21644db9f3cso5641655ad.2
        for <linux-nvme@lists.infradead.org>; Fri, 24 Jan 2025 10:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1737744231; x=1738349031; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YEtlMU2LVA4ZfmH2lP33mJI86LNP9DhvLnmv4lopNA4=;
        b=UbutOsIuzdZ63gN5yua8PlBZk06ncWjdpcSj2li99e5ioY712ZhHl031keZdVV9Jfz
         k9lFOE57EGzu8rlY3nhOM+49vctkovF2sFuFrnTGQSkiBC1VI/6KVrvwYvkbxh0rRLGl
         uZQG+lHLKXJuFZLrGEbwfvXF+vvbmdqDsP1O93H07HFei/0stOmUMSLouGDz+T0TK18S
         y1Kw2bNZb+IxmyTeiMeudKJJo18964xn1oljvApq3RNdO2LvO1cF2Kt7ZJaVz5EuLztZ
         CS2DhgmK6uPXXsqokqZVkF5cw6lgAwAYBjVdqDBdASSTlGQzGBrgTXAztcFBXsje8Dgw
         er0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737744231; x=1738349031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YEtlMU2LVA4ZfmH2lP33mJI86LNP9DhvLnmv4lopNA4=;
        b=Ex0J1T5zghSuTGDWWNlRSvHQSv/TeD0SghGgDmsxVO9GYBLYafYX2+bkw3MgOWnTdA
         I5q8enEfLC+PsKmYmHjLM6okkFNmk+t1zPdkTz4Y5nSLqeu+5feGkuppUmeKqGIq8++R
         96XRtdWCr1Ak6LH5XBR1nhKRu6SwLcJZK47+2sBi+rJbWORs7i4eJLqVPnx4xS+dLnmH
         rgmo4r8/ZHFKVCW9kVh/oPzvcG1VSOgbdFDjudY2W65puV5Hdp3/qZHU7BlsiAE6gAr6
         DTbwKu1v1VIKgcd1pWg8N/XpZUolpgmlT+djBZFhvzBF5w6uj5DZbfEXY21vOZZyZVPx
         /8PQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6dyT9enbwhnJIUzWxeE5bX971lkAyU0ZgTl0z5iKLNO/Yo7Nx7Qy3ulxu+XzZoqBPfAnkuutbgYOA@lists.infradead.org
X-Gm-Message-State: AOJu0YzAPaRJv06bw1m4R4m6KpHHbWh4F0C8seMicu/tqG3QghLdfGXW
	Io+ffyON9iGww5OthYz5wOFF1ToiuilTtfFlqwEISzj7+h/oY3PoLLkMDuCFCbWclvbLMiLpDy0
	mpCB47qrNGdzrYRpzP/OAImn+WzOlf7RmhvYHAdsW+CUXU+75
X-Gm-Gg: ASbGncuSoqfmGVSqDGtxvEr8CEPq0n7Pih9oXI4GC4XQRiJFWYjqG82kdO5yCtzVzBq
	tPnJv7pLmUaKfw6Cu99pjYt7E1bpu9km0WI0Cj7GrfWNWWYeLrgAkVvC7KUBmHkcd828xWVBQOR
	Osg5SumvzdGmOBAG/+zm6x0OdvwwvfXjL1kR0TDXqmv1+xKht/dkix9ItB73/zhTL+lF1BnHFsr
	+VkPqb3Hh7YBuS08C1l8FhxMn+QPeruE+ZJFpT32twUz0uZ124onTX3/VmiqfDf0YmwZhY/Ti1t
	qXCCyWdmPgYa
X-Google-Smtp-Source: AGHT+IE1qFlx4fc9QJayOTXsUhZ9jV8XdHUSzKo0DrxG505CrhSSM8S84FMdGkAQnA4S19wF+OQyiQN4dZ4C
X-Received: by 2002:a17:902:d4c3:b0:21b:d105:26ca with SMTP id d9443c01a7336-21c35560010mr179634065ad.4.1737744230854;
        Fri, 24 Jan 2025 10:43:50 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-21da3ea1e27sm991625ad.34.2025.01.24.10.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 10:43:50 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2C7633401C3;
	Fri, 24 Jan 2025 11:43:50 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 33E75E41077; Fri, 24 Jan 2025 11:43:20 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] nvme-tcp: fix connect failure on receiving partial ICResp PDU
Date: Fri, 24 Jan 2025 11:43:10 -0700
Message-ID: <20250124184311.1642797-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_104352_032636_233E48BD 
X-CRM114-Status: GOOD (  16.41  )
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
Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
---
v4: keep recvmsg() error return value
v3: fix return value to indicate error
v2: add Fixes tag

 drivers/nvme/host/tcp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index e9ff6babc540..56679eb8c0d6 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1446,15 +1446,18 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
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
+		if (ret >= 0)
+			ret = -ECONNRESET;
 		goto free_icresp;
 	}
 	ret = -ENOTCONN;
 	if (nvme_tcp_queue_tls(queue)) {
 		ctype = tls_get_record_type(queue->sock->sk,
-- 
2.45.2


