Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBAAC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 16:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6Tj0kcb3j5cCULBgD4lk+GgHhPr630VCSJ5Yh0zDqx4=; b=mv7B+QqRS1AyLWMPSOcRhXLV5r
	pPWluO3JU7zGkKcNFzc7AMEkScMYJMz+OFv1SLXH3chjFYZf5ahImuypnHo29uP+k0LFGY++pjh6J
	IXkNCqVij+ys3HeRIii1Dxq4Q4bMkSsDejj1lh6jBJ3ZM1SoQCfZOmMWxc+hI1YcHW/eZZIA8rKc4
	81vvAYb9r6cIYD3U42rNtXspJhiAGeqx/XFObnhWyKhD0ueh86h7eBwmRgDx0OeuSMhvwvw4fQU+o
	6hykqod/yLwJ+Dwk2js37pXXIiIzVgeJRJQZ1J/Sg1Tfub540/nZjQ49GmIWiASDosPGc/c6fwUkX
	Zx8IUnyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olYHO-000GJB-4b; Thu, 20 Oct 2022 16:20:22 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olYHJ-000GFU-LN
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 16:20:19 +0000
Received: by mail-wm1-f44.google.com with SMTP id l32so235983wms.2
        for <linux-nvme@lists.infradead.org>; Thu, 20 Oct 2022 09:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Tj0kcb3j5cCULBgD4lk+GgHhPr630VCSJ5Yh0zDqx4=;
        b=YTQtHjchT+xe/VGccMyGB9uVCAaakDE7++Cq4WojKTc8GONKOY06qmov5NkdimGEjW
         Yxfk32JHGwNhFlaufqcoD1qtcusES7jqLOkaMoi8vqgFR6eU37W06T3MXrAwcaa7/4HG
         tLOMyL0w2eGnIxHgV9CLZIF7bz3qhXMfsAnImkkZctsLV8FAVjpzrLqLt16poP973sp0
         x2EokElxL4Pt9NoHEmnOiRArQmM4L1U3xdgfwvhZ9Xv2WhekUB0haQwTg4bT02fkFJ22
         A240ytfMNr79tfxvfKbu/9ko2euYO5RWGV2SU5bxtGpBbjdbu8vyHhg3IGTmrszn4UsT
         5PbQ==
X-Gm-Message-State: ACrzQf14OFQaka0omIhnzz1UQSCxQk1+vNFvrc16LHvduTY+/76tYW3S
	Qwasr+lew1Exwn1NnZXjLGXXda2RhGM=
X-Google-Smtp-Source: AMsMyM4FZm5217VkLsHmA0YyBUuWU6x+tOIsxMcNGSoZQo6m5fBGR4a3m1SwDQssLwYR5Sizreob8w==
X-Received: by 2002:a05:600c:1e2a:b0:3c3:d770:1756 with SMTP id ay42-20020a05600c1e2a00b003c3d7701756mr10222619wmb.134.1666282814942;
        Thu, 20 Oct 2022 09:20:14 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h5-20020adfe985000000b002322bff5b3bsm20354422wrm.54.2022.10.20.09.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 09:20:14 -0700 (PDT)
Message-ID: <370e8446-14d6-b916-6383-785b34c378bc@grimberg.me>
Date: Thu, 20 Oct 2022 19:20:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: lockdep warning: fs_reclaim_acquire vs tcp_sendpage
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20221019075138.ff2sfahovionh72v@carbon.lan>
 <c30b24b9-e80f-9e8a-5754-caa7dc7bfe8b@grimberg.me>
 <20221019093712.2d2g36wcwwcl7zat@carbon.lan>
 <20221019113517.wv27jqp7lyskfbqb@carbon.lan>
 <96978c5e-369b-a010-f9b5-6b4675836e47@grimberg.me>
 <20221019160147.ij3nc44n5ppmzifp@carbon.suse.asia>
 <8c564393-f5e6-57e7-c2a2-8ddd58187a0b@grimberg.me>
 <20221020081002.z2qvzlq3du7qef4b@carbon.lan>
 <930775bf-4e8f-5580-8216-d2f28e369cb3@grimberg.me>
 <20221020141658.x63rk7ymtduw2q7o@carbon.lan>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221020141658.x63rk7ymtduw2q7o@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_092017_825460_7D60823F 
X-CRM114-Status: GOOD (  13.33  )
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


>> Just for the experiment, can you try with this change:
> 
> Good call, this seems to do the trick. The splat is gone with it.

OK, it doesn't say much because it is just one of many conditions
that can make a socket release to allocate an skb and send a tcp
RST, which can happen under memory pressure.

It's also not a great option to set a minimum linger of 1, which means
that if the controller is not accessible, we can block for 1 second
per queue, which is awful.

Does this change also make the issue go away?
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c5bea92560bd..5bae8914c861 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1300,6 +1300,7 @@ static void nvme_tcp_free_queue(struct nvme_ctrl 
*nctrl, int qid)
         struct page *page;
         struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
         struct nvme_tcp_queue *queue = &ctrl->queues[qid];
+       unsigned int noreclaim_flag;

         if (!test_and_clear_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
                 return;
@@ -1312,7 +1313,11 @@ static void nvme_tcp_free_queue(struct nvme_ctrl 
*nctrl, int qid)
                 __page_frag_cache_drain(page, 
queue->pf_cache.pagecnt_bias);
                 queue->pf_cache.va = NULL;
         }
+
+       noreclaim_flag = memalloc_noreclaim_save();
         sock_release(queue->sock);
+       memalloc_noreclaim_restore(noreclaim_flag);
+
         kfree(queue->pdu);
         mutex_destroy(&queue->send_mutex);
         mutex_destroy(&queue->queue_lock);
--

