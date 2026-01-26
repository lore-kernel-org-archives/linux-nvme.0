Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F1BC88E58
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jan 2026 06:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FgYLIsXviutSN7PTNv2Iyl9d0HW1SISqmO6vE1C4JDk=; b=sZxtffnymZDORGqHIXSxkkto8y
	FQlRRqGSUEC6AtRetGXTDaI1V6CyGNyC5CR7I+QJ3oUMWANCgBcPZh3Tt8uaFXOPh8chIxJzMuZDq
	3LNgTHgpL+rBPvXGeW00UT/BUOLgwYsYGTxknm0sm8hasCc1RcjGUS3qRZ9fM24yeOVHOBTRKoBb/
	Jb20V1i+erfBQERaZMyO2C7IE5D4uxU6XCx538dZrzswmRYyZhFsBR0YhTzTl+D4181qCQ3yExle6
	13k8YVLYMT+LZ2V95BiRFCKT0fhlFNm14Bjr435LbWXja9UKT8ys6s49D87VScDKLPdT7N8qgXbPj
	XIjtBjmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkGJV-0000000C0Of-47wb;
	Mon, 26 Jan 2026 06:43:05 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkGJT-0000000C0OF-3rWm
	for linux-nvme@lists.infradead.org;
	Mon, 26 Jan 2026 06:43:05 +0000
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-c54f700b5b1so2826033a12.0
        for <linux-nvme@lists.infradead.org>; Sun, 25 Jan 2026 22:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769409782; x=1770014582; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgYLIsXviutSN7PTNv2Iyl9d0HW1SISqmO6vE1C4JDk=;
        b=EbAh+RjuiM4LM2qVPW6XHKBBABk9djGsmnwdh/BlkE6EldkwOnomxIfSEvsiZpajAt
         TvAKGnMz+027ol9Z2TJPuOf9lEDM1u8l6SqEoLY1MybbSKqAcVfO3Rfc95rquG2E6wkf
         HSGC4/iuXrDxbG/8rZusRbk/IwuMWQlLc7i9xOUfxVztZFKwh4gPwC6mSAqS8AsdUgRs
         pQyfDvcZ9hxHy91Jw0i5zxGnZI/9U69Gy0m7p3a0LOKPSX9fr0H8trjGlgxQUWYTZUZ9
         d3mDwY3+sUGbdFp5X/kQO+LLHq2tdOE/3JfqyVwftL98pSnI9vW/IvaXbAbj5Csmhlnm
         5fvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769409782; x=1770014582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FgYLIsXviutSN7PTNv2Iyl9d0HW1SISqmO6vE1C4JDk=;
        b=wXUPbBtyYyxakjvEnJS3elBk9IdIROhErzRjkQmtAGN5MI7WjAk4UtXE4wuKwhQuKR
         J+184cZee9zNY1W2BB0H8vzFX4706BD6kvH3b870ffWrSxpJaej1IBqywzO67IhUJgmr
         zZf4e7KX+GmqzJo1lNM3KDG0uNWCEVDdAMT0BmrAXHAbBkk73Apy9pr6f1zgUdQ8CVtZ
         5V6Uke/Mto2bUnbXagyZNmL7rAXwqGJv8h3W5+C3DcckzUZ27GEQj1s4kcvBcrZAH+go
         Ns5V6DeyIVCncJh8SfU4gxSpqEOAbJZKguIPUvrGh+M4waEcm3IQxlZF3u65rAiCVZsi
         Wxcg==
X-Gm-Message-State: AOJu0YwMbytQsoU8N31aOxQRkHZqNCkR4vJg4zxRIspht1yJ5kGMYNEL
	9U1sw3Q+wRcLMe93m/R7AYUsUTSuK1e9h8eMBhO4DRVm/aoMJtB/sZg3
X-Gm-Gg: AZuq6aJtyzXYUPnu7X2jHmkSa00DNrAmHnhwmeAFoTN4cDP+/MJh7PdZVsY/hRARlFR
	Ib8J0aAl13JhoJOnQ1ayy77huZ20TVk3rk5kPPNhb6BRAOK08BVl2C8PiZbXTBUU62VsuXomiUO
	02v1htR7R6lb90I+3kFvMazDDz6lKKXu6vE67Ni6Av6v8k7obg+8hQ1S6IdW7j/uMb6Dx+FVffC
	RYImXa89SrcAFiMLq6iBL7UK05HkC9Yur4DxSii5y0CJAygyubo6ts8sGjCJVS99qkFa38cg6vl
	6A7AhgC2wr/4eFQGG+GJoqZVIFh5A+L+kndxK7cPNng+OMVRdrdt/DUspEzSO3vjVhnlk/ZHRPR
	WvssEA/gvS8cjZC/w7S+KE1OYIJUaQYttI+iNsYb0uieYiUlsPdyZvBW786occWUORe6oDOeA9E
	N0YEN60kzGSUH3DsxQZh7tP2/Zpzf7o7jh
X-Received: by 2002:a05:6a21:398e:b0:38e:9cc5:217e with SMTP id adf61e73a8af0-38e9f16c589mr2976427637.32.1769409782371;
        Sun, 25 Jan 2026 22:43:02 -0800 (PST)
Received: from user-System-Product-Name.. ([210.121.152.246])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c635a42a3fasm7516499a12.30.2026.01.25.22.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 22:43:01 -0800 (PST)
From: YunJe Shin <yjshin0438@gmail.com>
X-Google-Original-From: YunJe Shin <ioerts@kookmin.ac.kr>
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me,
	gregkh@linuxfoundation.org,
	security@kernel.org,
	YunJe Shin <ioerts@kookmin.ac.kr>
Subject: [PATCH v3] nvmet-tcp: reject H2CData before ICReq
Date: Mon, 26 Jan 2026 15:41:52 +0900
Message-ID: <20260126064248.591202-1-ioerts@kookmin.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1a3d4d2d-db0c-4358-8229-c7d6f5e83bbe@grimberg.me>
References: <1a3d4d2d-db0c-4358-8229-c7d6f5e83bbe@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260125_224303_963490_99595504 
X-CRM114-Status: GOOD (  11.80  )
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

If H2CData arrives before ICReq/CONNECT, queue->connect is used but its
iov is not initialized yet, which can lead to a NULL dereference when
building the PDU iovec. Reject such requests early with -EPROTO.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Signed-off-by: YunJe Shin <ioerts@kookmin.ac.kr>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/tcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 15416ff0eac4..e272d38f285b 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -961,6 +961,9 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 		cmd = &queue->cmds[data->ttag];
 	} else {
 		cmd = &queue->connect;
+		/* H2CData before ICReq/CONNECT: connect has no iov. */
+		if (!cmd->iov)
+			goto err_proto;
 	}
 
 	if (le32_to_cpu(data->data_offset) != cmd->rbytes_done) {
-- 
2.43.0


