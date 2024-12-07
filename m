Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5332E77179
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Dec 2024 04:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=luo/i03U2KX1qm/WMpvsr913RdZNml3QRZqP+vNpJYI=; b=hjRE4ljOAJK1zkGJSidM++j0Xp
	fo1nB1+ILzEz32JlI/qKU0oQdda9WStmOX3YCM7DoSVy+txpKxc70c0GM0TR3P+676rLQnh0r9tou
	osV6afaUA2KcsTimjX9eImHPPC2+GobOS/9bdGyzAm38NFUPm9Ya9P7oTM8+bNIk3Xyb5+g8vmsZn
	sj4F8BH22gZ7bvPBHjkrDF2WMS+8l8S6bkqbRqzMUB8QWJCygnKRoLWTSN2AM4e3/bUNDXIgAnY7c
	0lB1KYZBd8FmfcsCGM9C9L5Gpibus0JvmWZzvHTeCGg71GAj1liY+lRPfc6J+YELEcp6YRzt4S3Iv
	9yTE8cEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJmrR-00000003OkO-2t3C;
	Sat, 07 Dec 2024 04:56:09 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJmrL-00000003Oic-0oRn
	for linux-nvme@lists.infradead.org;
	Sat, 07 Dec 2024 04:56:08 +0000
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-7fd1403fcbfso2104758a12.0
        for <linux-nvme@lists.infradead.org>; Fri, 06 Dec 2024 20:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kookmin.ac.kr; s=google; t=1733547361; x=1734152161; darn=lists.infradead.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=luo/i03U2KX1qm/WMpvsr913RdZNml3QRZqP+vNpJYI=;
        b=InHVguD8z6K2jpvHyF06Gv2DSVT4FKblxwBe6JhSa9rMyFySe+Ktwi/vtLUNMSxFYH
         1WYisZWASDFhKSFBUH4apGn46vPgdB/RNw5mHEaNgjgTKFC0Lxa5q/lsjrW0RjblXKC5
         NiwYo4H1pax3B6LKbRwM6+DayNU8tlqEmRd14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733547361; x=1734152161;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=luo/i03U2KX1qm/WMpvsr913RdZNml3QRZqP+vNpJYI=;
        b=t6LzHwaG4yq6r0XKtK+95+PbDNdqguqC5GRLIvSR24I/jo7SVAgHdR8AiZSzDSDsQZ
         q1I0nRuk9OyCY2+D217VdSBiLsVWemAaJrm7FnC2bWu1Y56kJ5KSqrbIYlkemy4WFrm6
         lmHVG37CYp4/x9fLWHYvfcE9RmNPbyhcPSG+Jbjh7DCNMbbz3uPW/g4Y2U5bEUVQ9afP
         LFpwm7O29GdHaFVZY2w85s1fe6E+qiPpoj7PCN8f3kRuyMek0FCc43nmp+6oSohNOD5x
         O95YVsh0664savzpeCkerTflCnl0yxElqLa5CJED2NYPUemsnLSSV5JslqGBQyob1qjr
         K97Q==
X-Gm-Message-State: AOJu0Yz1wSJ90nxZZgYlkKFYW93FkI7iTpsloETMCUxS6YxL4x0utG6U
	UKgJA2+/9Z719W4U0bJifXdGGIGaUix9qHepsPctnrjBmQkuTJrz4HqBzVC1TVYyv41u+RPlaR0
	fTEWDfmUiMBmAvRc+jvBchCkVrT9p+L4hwCUaiQUcZwlYhV7Wjkwy/VNBFQ==
X-Gm-Gg: ASbGncsh4haUZvskL0pPrkLnGayDgl6atEhNUeUHi9TUvcHoKXVswStv+8MUQb6yKgs
	zsDnY666/MDnYdpyd7uogH3o7Y+IBvOtrIPm5gFG+R20rR6c7BXTYJfuUSnUz5yzld7eFdHxU7V
	oNpr8/P3AO1WA2nwL1aihbo15IdQYlP6lipLwaWJermY8cqF8+hNbWpkRDx3MEYm7L59kPqZ2BB
	rNaolOK9BHJrQpfOXpDcdPiXekjFfTV0/W33RKPHm7RyQ==
X-Google-Smtp-Source: AGHT+IH9DiElk58te+LI6ZCSoTrPMEj6IafNv5QeuHuharp8iGr0fjnZVKstyuYoKKUmQ0AC7BAyxg==
X-Received: by 2002:a05:6a20:6a0f:b0:1e1:72ce:fefc with SMTP id adf61e73a8af0-1e1870cb3e9mr8609639637.22.1733547361175;
        Fri, 06 Dec 2024 20:56:01 -0800 (PST)
Received: from ubuntu.. ([210.123.42.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2ca6752sm3740049b3a.154.2024.12.06.20.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 20:56:00 -0800 (PST)
From: Yongsoo Joo <ysjoo@kookmin.ac.kr>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	Yongsoo Joo <ysjoo@kookmin.ac.kr>
Subject: [PATCH] nvme: fix return type of nvme_poll()
Date: Sat,  7 Dec 2024 04:55:46 +0000
Message-Id: <20241207045546.119933-1-ysjoo@kookmin.ac.kr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241206_205603_535640_4CDDE823 
X-CRM114-Status: GOOD (  11.34  )
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

Change the type of the return variable 'found' from bool to int so
that any interested caller can see not only whether at least one
CQE was processed, but also the total number of CQEs processed.

Signed-off-by: Yongsoo Joo <ysjoo@kookmin.ac.kr>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1a5ba80f1811..a51869899385 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1209,7 +1209,7 @@ static void nvme_poll_irqdisable(struct nvme_queue *nvmeq)
 static int nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 {
 	struct nvme_queue *nvmeq = hctx->driver_data;
-	bool found;
+	int found;
 
 	if (!nvme_cqe_pending(nvmeq))
 		return 0;
-- 
2.34.1


-- 


