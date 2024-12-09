Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5DCE77182
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 13:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ffel0zzoF3o8TFYgj+fcyjNCq5omON6/XHoMw7Ks8to=; b=s9Z7GKKdm+Mh8Dyob4dch4G0Fw
	pT6gUsL/D94SgVY2ZKOv5xuxnP1lkCp4w1OXw4Li6XB181JInuiSHC7VjxKEYw42PJeTkV2K3DCUW
	kQP9viaZOXUrlfc7HqV5XrzTb9Hn0DeaPoFh8Hl0vt3t4CuKJHND7/6wwH8sxT/741W0JSKEn7e+i
	DAQ3cfvrG/hE6Y8KBrJySluCXKpy1lvTfNhKsm+k2mVkEhS6tUx0WkN/QIDo9ohGj+YaTZQDtjbFw
	zmx+G0h5492PahcIVkHgceggF3Kl2rw1JJX2NAs8+6s/Ac1rPMoQBKalZOKqCJLgQlj9pJDd4lpBL
	278XS7AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKdy2-0000000822H-0Y0Z;
	Mon, 09 Dec 2024 13:38:30 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKdy0-0000000821N-2Ixt
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 13:38:29 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-725ee27e905so985076b3a.2
        for <linux-nvme@lists.infradead.org>; Mon, 09 Dec 2024 05:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kookmin.ac.kr; s=google; t=1733751507; x=1734356307; darn=lists.infradead.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ffel0zzoF3o8TFYgj+fcyjNCq5omON6/XHoMw7Ks8to=;
        b=DZ64ZMCpfdu72D5n6WxrA1nqtTZ2zToLIuyuh8R51BF37Kadb4/kgHXSRURd/HWS8T
         ICIMDet3YhD99ljEN8hTuyfMh/jX2UlBl7NTEc9sEHOs0MDG0PNyTot37peUMwjP88Nf
         DWUkVlZnMU/KtTPV1HuojHfbR2B/wen9ya2B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733751507; x=1734356307;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ffel0zzoF3o8TFYgj+fcyjNCq5omON6/XHoMw7Ks8to=;
        b=J/xuKAQleomo02gTD0jsnZa60W/j83Ui+n/Z7jPWGLFjOWuHlvYLEnnTN9eg3fc9aY
         19OVfJL57G3SUOX15Cr8vUmsIw2HnGs3IHXg7VhMCa72op+o2yGZ/BkSy3J95I3fPvZd
         DBgRNfYEFKV4dSlN3U56CFX4sbWKVTvhhGlzTuECvz9YDa4TecQVDdrlpPmrwLb4SL9a
         155mJVJZAu+t+EnNyNaaVW3sKhyaXAypWvCt2umugYe0eChyTfKDt9Bwsc62E4asC+jy
         O9sWOAy/nuZ6qqFJ0PZfjnvAh7eHYpWl+ISpWjs6QLHlMwIXtrBkW0wcYjO9gBc6Gg4e
         gqNg==
X-Gm-Message-State: AOJu0YzVPrdOKVIuEtHqt3XejiIOpoLl0clUWLtkmpUJXxj19Jtb9GQc
	dsCwW6rK0Mp6+tJ3AeOiuTX39djsJudP87v1gqoTJEiUZGcYrTD2nN7RpUouQcNWSCCEkPgmkkW
	gye1oWpaNmHvVE7xA4SzgJcJOGSOb36bgKwO9XCguBx6no8vQrVqy4MDfhA==
X-Gm-Gg: ASbGncvCBiwvJTai78PcShzUmt/MP+njDVPk8MBaREh4+GmMfPfrQtVkT7cSbTmP3Xs
	pGPShwJlVJzgI6k14G3g6qRq2958dmRuHY1LLKIPmIkWXbfR36/TSgqzaYUYxiTT6hKekOenBbK
	+5/6E9E3cE6KFqF7Xf6pd5JSC53vIMOIDLpeCQPGsPXScGExthcVAUIE8pgW6xSrOPw3uIO5G1+
	uFLIMZSyFxDhJm1XChK3qDDXMX8XA2qHipSeyecgAzxkw==
X-Google-Smtp-Source: AGHT+IG5NVAotbGyHj/8KnTP/kbTxRTSQusO8AZ+qHdGMTqCkc6PZhyS39cjlDrKDKcPNcGmsE+iYA==
X-Received: by 2002:a05:6a00:410e:b0:725:d1d5:6d86 with SMTP id d2e1a72fcca58-725d1d576ffmr10337050b3a.19.1733751507687;
        Mon, 09 Dec 2024 05:38:27 -0800 (PST)
Received: from ubuntu.. ([210.123.42.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725ce382204sm4242755b3a.18.2024.12.09.05.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:38:27 -0800 (PST)
From: Yongsoo Joo <ysjoo@kookmin.ac.kr>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	Yongsoo Joo <ysjoo@kookmin.ac.kr>
Subject: [PATCH v2] nvme: change the return type of nvme_poll()
Date: Mon,  9 Dec 2024 13:33:44 +0000
Message-Id: <20241209133343.125885-1-ysjoo@kookmin.ac.kr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_053828_591594_C49BF978 
X-CRM114-Status: GOOD (  11.62  )
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

Change the return type of nvme_poll() to bool to reflect its boolean
return value.

Signed-off-by: Yongsoo Joo <ysjoo@kookmin.ac.kr>
---
Changes from v1 to v2:
- Changed the return type of nvme_poll() from int to bool, rather than
  modifying the internal return variable from bool to int (Christoph
  Hellwig).
- Updated the patch subject by replacing "fix" with "change" (Keith 
  Busch).

 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1a5ba80f1811..34650c03c120 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1206,7 +1206,7 @@ static void nvme_poll_irqdisable(struct nvme_queue *nvmeq)
 	enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
 }
 
-static int nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
+static bool nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 {
 	struct nvme_queue *nvmeq = hctx->driver_data;
 	bool found;
-- 
2.34.1


-- 


