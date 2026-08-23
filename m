Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3DBC5DF8C
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 07:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WrN8kvP4uI4qFBhv531gRNlNE0CxVZhsWI0O8HK66AI=; b=qCObrUM/HwHuHA4yME2RFVf6IR
	z1KOoDy+IXHCkMsSMniCaPz2AvU1/+sG78P0XBGcHzNCMqTETvba65JOxazht9mGW2wI5r/dDmJJQ
	P3s7Q5S1XmWnLHGLGibhYp+dxRfuyLqw8pN4DGMLhF3PGHC56CPqvRdc1JkJgQ3/YmwRLwZqHFBaL
	uBJ3Q4aNerL5EPtLFEg9AS5nG6ipU3ibuvPp4FM+QSokXlNo+JSuOtmBndvvyzxBEYV2u9e3Zuv93
	vJDlAvIPy2Rxk1qotBRiHfnRtZyV96RiLZgw5nqH4mQWsVccRocIINI39JzwWdq1nDLdhdwFR8raP
	pJDSAU+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy2uZ-0000000F9kh-3EJh;
	Sun, 23 Aug 2026 07:46:35 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy2uV-0000000F9kD-2R43
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 07:46:33 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso3481123a91.1
        for <linux-nvme@lists.infradead.org>; Sun, 23 Aug 2026 00:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1787471189; x=1788075989; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WrN8kvP4uI4qFBhv531gRNlNE0CxVZhsWI0O8HK66AI=;
        b=kJcoanXJqs+kKX7qHw3XuoB1qXa/qLl236SuS6sLRrAt9Syjtq/vUD4ZHHVsAcl/YW
         /8CuuIzL4MubxuEfzZIlZz5vIXqx3nXJ+odknED4GjwhBsGHvDRsyE8jbG10CZLBHZ6Y
         tVburmzeuFXqcYN9jjhLpfb3y5grPdKTq3Go5K0zwkS3P4ZkdPCIv7CEz4daELO6FPLn
         1k6h2hMSYhsn6HjgksHDIZOAkYqKJLip66qhpoShgGhEZDofLOO027pGR7cLOLlwbxIc
         15owADyu6fSirWgiv5yQFPb6IRoMacVm9WVEWmKxlTbC+RURkwXpqsofQmASfXlaZ/kT
         LUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787471189; x=1788075989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WrN8kvP4uI4qFBhv531gRNlNE0CxVZhsWI0O8HK66AI=;
        b=VxmytJ9qYOvzFFV2vJtrnecL1NAyd9QRHdb6gUyokzZdDYPqwjXXKnYGoZbkNzoW9Z
         YriE6zEUoWVgVvUk0ea+KjwghAiDYVUAZ4DNLBEtEqaxpemiyo6nXSQmeFc+O+3WP546
         viuONLiBzferfzr34B4NVzedkS9sZk1Wqvzy7oPo6SYVIn6ci8L8D7I9Z8qRSFqZ2OqU
         OHsDPxKcdHs6oj/5BFoZiZ6NmLuGSgBPmqS0GZauSwgG4uSKO8ix2SthibHbDr4nDv3s
         GZBp5nVzJsrpDyvo3WkdB/DrMrIDiMxyt1pTcdEJOPK0LrmKYLe08xJOXVp6zw+Af7g2
         plQA==
X-Forwarded-Encrypted: i=1; AHgh+Rp4ttMGox4GJ3ykwQudlCg5dsQsTToFSS/pNRlN+m2QBGn++sf0ESH9oe1aF000M/9wkiWB55zKLRt9@lists.infradead.org
X-Gm-Message-State: AFuF++kH2Qntv/vwYlfEYwlqz064Gz3kz6R++2VqvhYbDaaKeZbmrbdB
	vre7TmUSMa+j2/MF/LSlsnba5PNKPQ45kwSYz1enncuHT5Eep0QXqKsalSOQNIbgEK4=
X-Gm-Gg: AR+sD12OTClzhZpIT1bJObmkTZLv9UGec9JIpqOkQSUoNk/yCIWJVq9sTyuXHXBaNdL
	AYBueWPCgx15TLk1Atb6sypEwQmUOkitK86EElx7LYSNLYM13olit6vFkE/r+UZewa4qXLjUSRT
	bRi25OfjVQJfxOORaVVTrl7xZeQLtpO92O4fhaXc9P49G0YsUARIXZgTe8AgFe5aDM8WyE6CXN3
	Gapc8XhGahH+K9Xp0SzRE70m0YkIogYldIEcHEtzHwlbTei/8aWOr/qjyl3TbLL5X1Gb9L/gTrr
	k0Fkh8BSmKdXQbm3vIzgz07vstCNpR5+4p24cl/Te69b7e66HS8/M05TPrUlRr4/IkwrCd4n1CF
	DaXOTkMYBotkwcpBQ7mI6AC8smONCEXii0qz1rF69X6LIfcVE15/VbvVk4fnoLuH4qxSl67Wujg
	AysIV5XTJHiNfwc27ugORFClYUDrVnI0Yvr6ZFPnSH+jVoaCw4JtCC7ll9pY1iYuiP3NvPG7L7y
	3p4seq9kz8=
X-Received: by 2002:a17:90b:1d49:b0:38e:70d5:b12d with SMTP id 98e67ed59e1d1-395c3566ba6mr36471978a91.6.1787471189598;
        Sun, 23 Aug 2026 00:46:29 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:4705:b458:47f4:d2e7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e494fa73sm5358247a91.4.2026.08.23.00.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 00:46:29 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: kbusch@kernel.org
Cc: sagi@grimberg.me,
	hch@lst.de,
	axboe@kernel.dk,
	linux-nvme@lists.infradead.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH] nvme-tcp: return -EPROTO for a C2HData on a write
Date: Sun, 23 Aug 2026 16:46:16 +0900
Message-ID: <20260823074616.1996509-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260823_004631_893603_CF78EEBC 
X-CRM114-Status: GOOD (  13.02  )
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

The direction check in nvme_tcp_handle_c2h_data() returns -EIO.  A
C2HData PDU naming a command that did not ask for data is a protocol
violation, and the check that rejects a PDU on those grounds a few
lines below it - SUCCESS set without LAST - returns -EPROTO.

No caller distinguishes the two, so this changes the error code alone.

Suggested-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
Measured on the test target: a write answered with C2HData changes the
log line from "receive failed:  -5" to "-71", and the neighbouring
payload check still reports -5.  Three runs each way.

Applies on top of "nvme-tcp: check the data direction of a C2HData PDU"
in nvme-7.3; squash into it if you prefer.  No Fixes: tag because that
commit has no upstream hash yet.

 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a62d6e48f7190..a865bd0688543 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -683,7 +683,7 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
 		dev_err(queue->ctrl->ctrl.device,
 			"queue %d tag %#x unexpected data for a write\n",
 			nvme_tcp_queue_id(queue), rq->tag);
-		return -EIO;
+		return -EPROTO;
 	}
 
 	req = blk_mq_rq_to_pdu(rq);
-- 
2.43.0


