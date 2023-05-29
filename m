Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BE2C77B7A
	for <linux-nvme@archiver.kernel.org>; Mon, 29 May 2023 10:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=63KAqVVdXGOoTrSylFFLhnHQleDcSgfdSMcTbn9SMvM=; b=Nwoyf1NM0BbJqFL0HEZpBLG8VW
	8HsvfL4lgz66+aaYft4+JPxvLaqIYH2ux02beaCZ5qFvezlLKouEuLw559PIsKxoxgQVm/X9rZyVR
	5/4Z91eOpuON7qUDNaWiqB5YljKWRt1TtogAI03YrqAw9JjiiR+fQC0cbsM+f7cZ5eW3SpAgTbqrt
	ZcjX1zaZwy5KBbojnzlMo7/PRNhAMYiRiinLmQrGE48VUyz9j+DgbbrDHyGjhPYuqbHJTbdxO2VP/
	fiqMj3lHhnU8wkmo/RlcZmYkzFLNx9OxgmK3gqGRezKDtiLy/RmygXZIQKYg6fZALgaI/+BNoTCCg
	Q6WqmKJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q3abB-00ACyr-13;
	Mon, 29 May 2023 10:59:37 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q3ab9-00ACxq-1d
	for linux-nvme@lists.infradead.org;
	Mon, 29 May 2023 10:59:36 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d341bdedcso2299016b3a.3
        for <linux-nvme@lists.infradead.org>; Mon, 29 May 2023 03:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685357974; x=1687949974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63KAqVVdXGOoTrSylFFLhnHQleDcSgfdSMcTbn9SMvM=;
        b=oiRjRhuNdihyDtRj+itgk5qVaD+34X0RfxNTyBxmlm4vY8ELsjSxUz0O1elP8t9f0S
         yl3FEaNNR3nohNXCGbFai7uzra7YrPJWEy8wft+1ozLwGRaK8tgIGyq7mBG7Dxm/qi1P
         P+gTHnb9AaarJWzOpYCrYC7Az8hBU8y14pKdc/YuH/3DL9AUNmqaJZYNUOa6W0EQ69n3
         u67bXvHhHso46v+9DH55bCwp3UA7FDUsOyAe3Vs66Mt4VqH6e6aO7ZHsLZaCSN+UnLqp
         ruOyNwYAcwzLPgF49it5/8CDzSqj3yt77nHPZxLaH4ZSOGG2i4lGlgW0vPNt/AKPgwBk
         /4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685357974; x=1687949974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63KAqVVdXGOoTrSylFFLhnHQleDcSgfdSMcTbn9SMvM=;
        b=RoJl18z9tFI0PGvl9J51LvKrOtS1SzqdhlP5Yxm6eJ09ZNJ1aw/3tK8oMwbGE/JM43
         gNqALdRX+aRn4PIYGsgsgK26aAJvbkqX+3iCsZNI87qSQ2dRcIZ0X1HLwmq/HPbM//D+
         ZoA519F1vm68emgaiHVmGxqeR7v1FnGCjEOkRQJ16Yhqqq9b7v4BfJgu7BU1wrm1N9YW
         XLUddqZIVnZT3sy/wgiXxcrXNoDKhBRTV9WcJpcX0Db1kGJK6jiufUx+rAgKanbFth+l
         PhBKeh36zrupkafRHkoC5aZPTDvLTcb+EdFhIRO3pcYNmYjxbnwHNG1m++PZpgpVDqZt
         rs/Q==
X-Gm-Message-State: AC+VfDzqxxK3eioumQIfXtWxj0jlIxT3LI2jjp9YvI1mhi0TIRHhHOMV
	ohJD68yrrgHqFCzL4nd/g+s=
X-Google-Smtp-Source: ACHHUZ4h0oIv5BoInIChTF6doTA25m5LmNP6412qwvIAH1L0J0bj9+NiqrJQcu5Qd3qNfQLeOGhhQg==
X-Received: by 2002:a05:6a21:32a2:b0:10f:96aa:9e4a with SMTP id yt34-20020a056a2132a200b0010f96aa9e4amr9774800pzb.2.1685357974245;
        Mon, 29 May 2023 03:59:34 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id v7-20020a63d547000000b0053f22b76cdcsm6863110pgi.82.2023.05.29.03.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 03:59:33 -0700 (PDT)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/4] nvme: donot retry request for NVME_CTRL_DELETING_NOIO
Date: Mon, 29 May 2023 18:59:24 +0800
Message-Id: <41041f049985675f95a38bdd8bb998c5a4ab140c.1685350577.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685350577.git.chunguang.xu@shopee.com>
References: <cover.1685350577.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230529_035935_542063_CE0555C5 
X-CRM114-Status: GOOD (  12.89  )
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

From: Chunguang Xu <chunguang.xu@shopee.com>

According to NVME_CTRL_DELETING_NOIO definition, we should
not requeue any request while controller at this state.

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1f0cbb77b249..304eb4eda6c4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -346,6 +346,8 @@ enum nvme_disposition {
 
 static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 {
+	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
+
 	if (likely(nvme_req(req)->status == 0))
 		return COMPLETE;
 
@@ -362,7 +364,8 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 		    blk_queue_dying(req->q))
 			return FAILOVER;
 	} else {
-		if (blk_queue_dying(req->q))
+		if (ctrl->state == NVME_CTRL_DELETING_NOIO ||
+		    blk_queue_dying(req->q))
 			return COMPLETE;
 	}
 
-- 
2.25.1


