Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D908C19776
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 09:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=j1EmXzog6dpvM5CsDQvgfubk16lqeEYHkBYJ9o/E4yE=; b=Zsu6MQbyD+q9oUp3V1R8YXTG8s
	FGTRQ6BOkgUIT/zuf8Rc9Q0iHvdo9VSc35Hus07XJK9eS+9WIzlBRGYZvIhZn/rT8doI0bnPp39VD
	X/OxQNxywRBw6Td/FQ9VBwP9yLFJIANEVT150eYfywNtSX/Grx/YUq73sDMQzmim7LKjGrGSKWQNT
	h+zF4GM9m3qs5G3znQWm35tor4oWmCoBkEqirOI3vKlwmnGMQzHzR6+qL1Ut6hZevjlpMkgd4MddQ
	37jP4XYb+hjjQmJyE8+4iSWDz7dFEB2GNL4uLVMxGdpY11fTaZroWiC4ObnvfgUUVCYifFoOq2qX1
	mdhHn+yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnwqU-0000000APYh-0Akr;
	Fri, 28 Feb 2025 09:39:50 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnwqR-0000000APY1-3D7b
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 09:39:48 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5e0573a84fcso2712017a12.2
        for <linux-nvme@lists.infradead.org>; Fri, 28 Feb 2025 01:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740735586; x=1741340386; darn=lists.infradead.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j1EmXzog6dpvM5CsDQvgfubk16lqeEYHkBYJ9o/E4yE=;
        b=xsMXoUu8bgTl7QYcj52Iqvtqb6LpVTLiZOzLVKFL2zalvoQARGhVCIQpa3+napPdJW
         PISv6BgunpfPTEPHm5cXRhP1zdS351TEgsJFgNzVIWMwfhLm6MJ+n81H+pcby4zL/rIX
         3pL0OIYuUoRFHRvSb/QVSxSnxyiaAekrHOb96DWczj5/WSnVN/UOlKE7qWVzB2OvBzhC
         WHg56cVgMSV/TQi6FbM3wfVFk7/8PvBHlMy7YyXEPb6lqN93yk131M21U0jdch+NnLeD
         Y8Nx4DYTtkmMZHvU1FlF2CEDyPhqaSadyj4sxXoOTkNeh4WEnOjp1enfp8U+NOf94Nud
         VPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740735586; x=1741340386;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j1EmXzog6dpvM5CsDQvgfubk16lqeEYHkBYJ9o/E4yE=;
        b=vWLXSzCkhm32bP/NJJSjjW792jJsCepqxpSm4YesQdKmR2U2eJ19oz/yVXQO3JmhsC
         GLfYXv7KIxIRyTZf6EKZarKlYaLyttOeXe5vrKfmWDibI0bIX1sOtkMk4Isp+sLsCDEe
         cHm7kgB/C7X0FRo7GcQr+znVnNb02GufQQXZAk0atn+6u8IBurTXyUsQjAcgrs2QKPF7
         MBlpq3vYIV//QRqVnBzcLtx3xwu8YIEDHuMSgGcw1k4ZniM8u1vVAcEKTyWdiyYMgrQM
         qZjFikNXYcs+AMzNqc9FZNwelydZsx+jwL+vGueMdSw7qsngpJcTDlop17eI2YO1csIn
         9r7w==
X-Forwarded-Encrypted: i=1; AJvYcCVOtL4+d0lbA5CntIiUZ05ufjC84dTtHxHnHYLWdiLmWclQ1HUhXMyWFCp0pByNbELdA1wNAlnUc0T1@lists.infradead.org
X-Gm-Message-State: AOJu0YxYXt7fjLlfhJHSKraTn2G2WD13yMCSaOy/gRnPcnWvdpb2A2A/
	wWKxsoV6DLgnoKFXmKnLb4rDmOsc2xPfYygsO2u2Umx9dWja5tvgC0b8QOZ3AuQ=
X-Gm-Gg: ASbGnctQqyGkLjMNBOKkjaHh0ax4pFTyAHncUO92Fzgv388ILfLfgKH55i/A4z7JBOh
	3pfa3Lzm8tahLIFqpXt/E1oezQecpnOVSQrFBdxisZCn9miWR9kWn87pdsdx5x0VrNCjBH7/RnO
	jknqpfJ2vVXkSkABpl4loVnjxzug4LTdrJOaiQFeFdDyTCT6VVFHuUwLGAD56ii3yptjUMy7NjO
	LHu1AdqvU9F5qjDviSIryLlq97/xWiFd6y5FDZPbY1fzwlIzuHd9XWHvdTHtZW3oSVakyVDp5Mg
	cBSzOXGz8zyj9Y1CuMRzwTK6JE+c5xE=
X-Google-Smtp-Source: AGHT+IHJ9U6y6nhglkIHEC0ZWjrm3br0eCOOxp9U+sAhp0Pingxi86o1xuAOO8VfOthG6xXZZgYDuQ==
X-Received: by 2002:a17:907:3fa3:b0:abb:e961:ca32 with SMTP id a640c23a62f3a-abf2642bc10mr250079766b.21.1740735586007;
        Fri, 28 Feb 2025 01:39:46 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf0c6ed7f1sm261343266b.120.2025.02.28.01.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 01:39:45 -0800 (PST)
Date: Fri, 28 Feb 2025 12:39:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] nvme-tcp: fix signedness bug in nvme_tcp_init_connection()
Message-ID: <0f3be9ff-81a1-4c33-8960-75de2c239ae0@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250228_013947_800146_1E325E19 
X-CRM114-Status: GOOD (  15.63  )
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

The kernel_recvmsg() function returns an int which could be either
negative error codes or the number of bytes received.  The problem is
that the condition:

	if (ret < sizeof(*icresp)) {

is type promoted to type unsigned long and negative values are treated
as high positive values which is success, when they should be treated as
failure.  Add a cast so to avoid the type promotion.

Fixes: 578539e09690 ("nvme-tcp: fix connect failure on receiving partial ICResp PDU")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8a9131c95a3d..361b04ec5b5d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1495,7 +1495,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	msg.msg_flags = MSG_WAITALL;
 	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
 			iov.iov_len, msg.msg_flags);
-	if (ret < sizeof(*icresp)) {
+	if (ret < (int)sizeof(*icresp)) {
 		pr_warn("queue %d: failed to receive icresp, error %d\n",
 			nvme_tcp_queue_id(queue), ret);
 		if (ret >= 0)
-- 
2.47.2


