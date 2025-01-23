Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9CFC02182
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jan 2025 22:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TYqG72Eb5Ow401LLShh/k1Lu/YVk568nsSQiPQFqa5w=; b=sSFB/TQF7rqhkb8QxxLYAVCSqD
	3Nr5wApRwKOREL6KYpcffpU+5ubL50pcG/+IHDahtO2/B1EbHJ2SEXi/f1IwD60ys9A4SIe/ncG6H
	e9gybimvosBw1CpdC+BTB17Hz7KbSyg1hIhxVuhG0nO0thIzgujE3R1ILDk/HfP7kB9Fy7MOOzDb3
	qcAlzCqusGgCszJxYa79jJ2NXzzB+MWJaZ0c7azJbHNVB0dQgDPCMpH9S7r1mVJM5PdujDxtO9Kax
	kxgbQsi9sWNpBCVebmOpY09KXmCOxezzjNbdPi9RBZFUh/7ROrvEHLsMiMK4CwNiZmJRkx3qJBQNi
	aFZCOv1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tb61a-0000000DRQR-0Ke6;
	Thu, 23 Jan 2025 22:50:10 +0000
Received: from mail-oi1-x263.google.com ([2607:f8b0:4864:20::263])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tb61X-0000000DRQ6-0d29
	for linux-nvme@lists.infradead.org;
	Thu, 23 Jan 2025 22:50:08 +0000
Received: by mail-oi1-x263.google.com with SMTP id 5614622812f47-3eba783ec88so223130b6e.3
        for <linux-nvme@lists.infradead.org>; Thu, 23 Jan 2025 14:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1737672606; x=1738277406; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TYqG72Eb5Ow401LLShh/k1Lu/YVk568nsSQiPQFqa5w=;
        b=gie7wUV4tl/v8rj82qjdr81Slt7glHmjuqg55dDCQNH1GHauGnte+IXPpPwT4pdczL
         I78SNd0t7Lz+oO7F3HZuhMmgLpJzVoP+CULXLu7A7hdhp1hDipC1+HqqoRid4RessvXT
         VTT8wmYQq9q+Szit00qbg4x8mowwLuy/xYQdevbfgOoK/oq97xBPy5INHvR9WKWZQD+Q
         mAP2pC4rk88nbDMuHhrVFhjcgLnhhY89rQyAw5luX9J2ARqXeIkp8+c1coUM2kuQTSHG
         6k8ZiydizpsHagE7NymTtvKT86poBHEbP3cYcbS7KFvXinuGXO5Moc3rTkD7D9xftduV
         5d7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737672606; x=1738277406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYqG72Eb5Ow401LLShh/k1Lu/YVk568nsSQiPQFqa5w=;
        b=EYwqAGQxY3JRJXVP6HQ5kPIEm61WlULSJrsLf2DhxQFO2BHrvvx7p/GEVVs61UmMvv
         kcTwB4grUfRZ+ud54QODSP7GYv/b0FzD5tTsh0DgpXNC4+6ZzYasilyejvYxJppRs2PY
         BGwt7Eb3kxtv18Pf/MxaQhSCr895KbjDd+XASwNKGkkgwy4j98SkEaSz4JoAJnXYEhoQ
         OWg1N50Aq5QzmsLF0Tr/jtI9ZPcvVLgEyFqTvDSBrujjGptFTRQZ2KZ1okWI2CtppyFV
         gBkfnrn9nd676/gUqU80/2AjPGrBHxtjlHxKpVl6GVzrhOtXIGeZS0uh9JJhhSNPWODN
         y3qA==
X-Forwarded-Encrypted: i=1; AJvYcCW/bm72Sbn+ztGtiV9bVForgC/y0SwyKw048hzI7fmJElvDmObb9W8BBGlm6WRFhgMdLXtDH85OB0h2@lists.infradead.org
X-Gm-Message-State: AOJu0Ywx5Dh+6p1BJezc00IRpDWTupMpeuDcTb8tcF6KHEsH5ybOVhfl
	jck33N1rrdh8RJis2UCJ6GFVPPZZCPOoaFrPXFjzWUbfVhc+Rp5tXyc4e54b2frQ4J2qj5lX8d5
	rEAdFIRnSQ9mP9aFl/AwjRvqW53DQ5upB
X-Gm-Gg: ASbGncsW47yLqg7BOf61yNgBzAMz7MAji9k9e9c4fhbrvmjzsADWjM7knkPfeqVv/m4
	wNxq782TtTrncS1Qd9jEwPAfsvZ9lg/MGwG0fR6T43mmvczLYzLMFxuXngecEtGjkzhKgwaSCR5
	0eGwIqF+V4bpFosTUAyhvAUomV8/TE9Mg+aA+EgMiemHl0g8Mkh2txExy8/XMKwVmQ4B9CcdOGu
	/AGv8b/ed1IhAXmJYen+N5vNuxvVluvclUZkTj1D1wSXQnKd7JLz6Uw5eIf9m8T5DzAqDAf20xh
	8uD2O3iP/EXDEW3RKnAm35oqhik=
X-Google-Smtp-Source: AGHT+IHpWJkZ+qtt5aMbV6lGk0QNXQn8vS9/dGclooytG0WLIfEst5DC13cDEF1gEAhdsLutrZ06MeYb3UcR
X-Received: by 2002:a05:6870:7190:b0:29e:6394:fd47 with SMTP id 586e51a60fabf-2b2518a4b04mr1781964fac.4.1737672606160;
        Thu, 23 Jan 2025 14:50:06 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-2b28f187fdasm40892fac.9.2025.01.23.14.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 14:50:06 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2431F340748;
	Thu, 23 Jan 2025 15:50:05 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 16F59E4105C; Thu, 23 Jan 2025 15:50:05 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] nvme-tcp: fix connect failure on receiving partial ICResp PDU
Date: Thu, 23 Jan 2025 15:49:40 -0700
Message-ID: <20250123224941.1359950-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250123_145007_233708_C7ED7CF3 
X-CRM114-Status: GOOD (  15.08  )
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


