Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330ECEB64DD
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Jul 2023 14:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fi8HZWe00as6NY8cKM/Z1+nvL1s7YeXy199NqP9ShII=; b=BIfPtxpocytmUvBOgoaKa1ABvd
	JIMKH0qSUJqNeO7VY6O2XxxA0IdS4DoKsZnaBHHMrPH1ZrEqMFnWNl4Eqw8KJLS0lNW8doq7Y6WJx
	0LA54dIeV4/9O8FSP2jEXv87yEIksj+dGzshbBbt7dxGoa7QnGGYjaFL0tWMuHnuDgBfB0kUdMOpt
	TZvkliNVctCS0lVyk/Vt9kghNDwKycmN8zZKlsy6rdLzWn8+B8kKhmFczjGkTo/7pMzCwZCjd6lNG
	i286hDvNdg3lPhHI6BQwgmnVwE7YskT7w1D6u4blpzgYxhe9zFJMDm7efQ0WAndVPkReQOadquonr
	sfrXfVvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qIVT0-009G6z-0r;
	Sun, 09 Jul 2023 14:32:50 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qIVSv-009G6N-38
	for linux-nvme@lists.infradead.org;
	Sun, 09 Jul 2023 14:32:48 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3fa99b4f71fso7767255e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 09 Jul 2023 07:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688913160; x=1691505160;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fi8HZWe00as6NY8cKM/Z1+nvL1s7YeXy199NqP9ShII=;
        b=WyJja98r/CvrcPMfdu91leoeEwcIH9Eml7yifdKsD7365C0F8RD/Tj6V/DRUoZ28NG
         l80RB/z4Do3Z3EU8bRMWCvEenKhSlUJIiUQzzrittzq62OOvBgRlp6siykwbcUmtpg1j
         3XpJjg3Q90cvfo25aXrKAT9ZnOjtvcbmynURmrey2Ndgai/E4p1k5GnoZ2wFUARHASqt
         gr30mWJ2wl8Oful9RXBkk4zD/Fvpf+c7IP9QUzFdEVASjg4jDE+JugdhCD0C/qaSta13
         fkUkXwoh3z/ScOsbsOZkN/xwIKSS55QwYK5Tqhna/RhYEiJcg8NPBfopByFJs867l3va
         u8QA==
X-Gm-Message-State: ABy/qLbnlecZkyxxpt0oC6EtFd1OIwZ+IrBy7UapFrtfQvqsI612syxi
	SRS0YRzpd90xXVI7/ktHlSs=
X-Google-Smtp-Source: APBJJlFEIuFofQ1/SqOhdmpRu5JJopAnJyej4izHcf2ZEhE0zRT1k4+hi5QBs39TGI+uQYQcVh3POA==
X-Received: by 2002:a05:600c:4f56:b0:3fb:f025:9372 with SMTP id m22-20020a05600c4f5600b003fbf0259372mr9988489wmq.4.1688913160303;
        Sun, 09 Jul 2023 07:32:40 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c280400b003fc07e17d4esm3947099wmb.2.2023.07.09.07.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 07:32:39 -0700 (PDT)
Message-ID: <165eceaa-55d4-f9c7-7e02-18115e6df6fe@grimberg.me>
Date: Sun, 9 Jul 2023 17:32:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: blktests failures with v6.4
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <lkmloyrqpebispffur5udxdiubmevvodtsvnap3jz7tv5ihstr@jg7ejye3bein>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <lkmloyrqpebispffur5udxdiubmevvodtsvnap3jz7tv5ihstr@jg7ejye3bein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230709_073246_030807_E2C8E49E 
X-CRM114-Status: GOOD (  12.94  )
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


> #3: nvme/003 (fabrics transport)
> 
>     When nvme test group is run with trtype=rdma or tcp, the test case fails
>     due to lockdep WARNING "possible circular locking dependency detected".
>     Reported in May/2023. Bart suggested a fix for trytpe=rdma [4] but it
>     needs more discussion.
> 
>     [4] https://lore.kernel.org/linux-nvme/20230511150321.103172-1-bvanassche@acm.org/

This patch is unfortunately incorrect and buggy.

This will likely make the issue go away, but adds another
old issue where a client can DDOS a target by bombarding it
with connect/disconnect. When releases are async and we don't
have any back-pressure, it is likely to happen.
--
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 4597bca43a6d..8b4f4aa48206 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1582,11 +1582,6 @@ static int nvmet_rdma_queue_connect(struct 
rdma_cm_id *cm_id,
                 goto put_device;
         }

-       if (queue->host_qid == 0) {
-               /* Let inflight controller teardown complete */
-               flush_workqueue(nvmet_wq);
-       }
-
         ret = nvmet_rdma_cm_accept(cm_id, queue, &event->param.conn);
         if (ret) {
                 /*
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 868aa4de2e4c..c8cfa19e11c7 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1844,11 +1844,6 @@ static u16 nvmet_tcp_install_queue(struct 
nvmet_sq *sq)
         struct nvmet_tcp_queue *queue =
                 container_of(sq, struct nvmet_tcp_queue, nvme_sq);

-       if (sq->qid == 0) {
-               /* Let inflight controller teardown complete */
-               flush_workqueue(nvmet_wq);
-       }
-
         queue->nr_cmds = sq->size * 2;
         if (nvmet_tcp_alloc_cmds(queue))
                 return NVME_SC_INTERNAL;
--

