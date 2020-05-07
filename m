Return-Path: <SRS0=DRq2=6V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC99C4724C
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2020 20:07:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D145D20CC7
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2020 20:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XxGvXW5f";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOTbxaUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D145D20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lv9Ek1xJd8mshrMwVIkNzP205vgx49ylCSrUC4MgtOI=; b=XxGvXW5f5jKq5l
	k27HVYlJwJnNt1SXGvWChQc6l6qe+BPMYITAHI5EK1PQW3axzRV5Hvi8QDhq1weg8KLbqrewprYeI
	6ESqfeb4ejvjm6dww7F4h3sOQFLf7sLilMnajuDbYERuei3Mlwc7YwPiP9dYZ5OtKz9s0cYP3OU0T
	5YJ5h3Jhg+Ag6Wg/1keWdNio4gCYY+T4+mB9B/oC2snS1vEDhKJqKf9Ewowp9UlZCe3pF2sa7XDez
	5v31TisUmYjWh4BXP4aj9zKRW1VMXuX6TdpBmI9gzoQIW67gZrzidkMC32LzHl4MhAWHOakkV0DSS
	2XF2/Jr3xc2jCZV9yQ3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWmnZ-0008C6-0y; Thu, 07 May 2020 20:07:13 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWmnW-0008Bf-13
 for linux-nvme@lists.infradead.org; Thu, 07 May 2020 20:07:11 +0000
Received: by mail-wm1-x344.google.com with SMTP id 188so7907582wmc.2
 for <linux-nvme@lists.infradead.org>; Thu, 07 May 2020 13:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=78smtdaLuPseZ+/6yVajTxkk/bcdpg1VP4IF4Z1xiqM=;
 b=eOTbxaUOllMeTAhF47MjeTbUz6lOkLpP3eYG6H7yBak+sB+KIAbl5OEOPKPXvyE4D5
 FqdSII4CK2b7s3ZO7+YJMGOoGEDfJLiadptGifHrf7a+YjaKV164OsrCc5+3my439cbV
 2PNdrFvA0NYQuVn4CGd69eqZTeBTd8e5H90OECn+luNgERd/zH8ltD+b2JZU5YCkiOvG
 S4mQLTNFH03cggnn5Sw+/SSyZiMWng61EUE6cdtvtvO1Q4l7840DD1woD3pNKIWKWOm0
 1ww+vDTrlErb/Puejr7u38VKc9osGsHLNRr5C3pDnlmg45z++QPZFvfX2OWXcbeyRUv+
 exNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=78smtdaLuPseZ+/6yVajTxkk/bcdpg1VP4IF4Z1xiqM=;
 b=LQPmvl5tGaIn5WlcwkppuAp7tNqvwOjlPv1Z105BgXGb+GaknsRsgnM+oLcYo1CKPo
 INZcl/4LeluIIsVU5k9jkd7tFUqo0tl3MTW6xj0qvZ4SEJK555IGfsn2NLyGVG1lciGV
 Pjwh2WJQH3Y0pYmAAlb6g7c6GTWDXxDYy+6Mf3RwEj+WHo+wwC6hJIPIyctAp8/+giv5
 JMgbsuCkQbaJIr910Di5JB4KBU9m/3DqgF/RbrWjv441i6S0vADFqCwdFFwXGQvCe7t9
 8JYxWxQ0KT4gOotjJGDGVHAC+p3qnOkoWyosUxIXxclsgQXtER2fT7uB62mQxEaeSHwK
 WRTw==
X-Gm-Message-State: AGi0PuYM6L/ALwhEChY3W3CKREf8yAoVqmomWptJrQDTvsH5oT/zJEsY
 ug1F1GVVKPJ98oE5qbplEg==
X-Google-Smtp-Source: APiQypJkbCfcD3gohElvFp/T+/xwF1MRY/SHZoj3OgsgwBevQBd/8JW105hbmYRZbK/RBzyizt7iIg==
X-Received: by 2002:a1c:2ed3:: with SMTP id u202mr9640315wmu.77.1588882027585; 
 Thu, 07 May 2020 13:07:07 -0700 (PDT)
Received: from avx2 ([46.53.250.199])
 by smtp.gmail.com with ESMTPSA id 13sm4502428wmk.4.2020.05.07.13.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 13:07:06 -0700 (PDT)
Date: Thu, 7 May 2020 23:07:04 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-pci: fix "slimmer CQ head update"
Message-ID: <20200507200704.GA16009@avx2>
References: <20200228184519.GA2281@avx2>
 <20200229055351.GA542920@dhcp-10-100-145-180.wdl.wdc.com>
 <defb25c5-5ae5-5ff9-66db-efb129bd7743@huawei.com>
 <20200506124701.GA54933@C02WT3WMHTD6> <20200506132429.GA21451@avx2>
 <20200506144434.GB54933@C02WT3WMHTD6>
 <20200507155852.GB2621480@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200507155852.GB2621480@dhcp-10-100-145-180.wdl.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200507_130710_067921_92158468 
X-CRM114-Status: UNSURE (   9.77  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@fb.com, John Garry <john.garry@huawei.com>, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Pre-incrementing ->cq_head can't be done in memory because OOB value
can be observed by another context.

This devalues space savings compared to original code :-\

	$ ./scripts/bloat-o-meter ../vmlinux-000 ../obj/vmlinux
	add/remove: 0/0 grow/shrink: 0/4 up/down: 0/-32 (-32)
	Function                                     old     new   delta
	nvme_poll_irqdisable                         464     456      -8
	nvme_poll                                    455     447      -8
	nvme_irq                                     388     380      -8
	nvme_dev_disable                             955     947      -8

But the code is minimal now: one read for head, one read for q_depth,
one increment, one comparison, single instruction phase bit update and
one write for new head.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Reported-by: John Garry <john.garry@huawei.com>
Tested-by: John Garry <john.garry@huawei.com>
Fixes: e2a366a4b0feaeb ("nvme-pci: slimmer CQ head update")
---

 drivers/nvme/host/pci.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -973,9 +973,13 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 
 static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
 {
-	if (++nvmeq->cq_head == nvmeq->q_depth) {
+	u16 tmp = nvmeq->cq_head + 1;
+
+	if (tmp == nvmeq->q_depth) {
 		nvmeq->cq_head = 0;
 		nvmeq->cq_phase ^= 1;
+	} else {
+		nvmeq->cq_head = tmp;
 	}
 }
 

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
