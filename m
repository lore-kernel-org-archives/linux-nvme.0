Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC02C77B75
	for <linux-nvme@archiver.kernel.org>; Tue,  9 May 2023 23:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h70vVXjhA0qIU7n5ToEITFWXNEpzgnDuFUEOkbC24S0=; b=MC9Sa0ate1MQoTiJakQj9+pdC/
	fTxvMDGbZDOCD03X9tI4JKt6zMaxvoBukcjsa3a2Eyacgij9sN1DidQ7ALCyR9NUZpV4yatJ9OhVd
	FQVH9o+550aXJAExQ56cjiZzy2pMQOvgp9eZfN8suWHetDeJEDQHl88WSjlQ19rCBhXdtnuFTJFvF
	f1W6QN6uRQbeoncvOo/uoi79GOFOyj4CHAxFjw4O/WjkNekcZr+LeKlpxYucOhH+z0j6raWomg8B6
	fv63krU0ZmUD2VCgViqkmWI8XvdQQI9e6vgk0QQiNUUvYRuO5cA7ud//gatdV07l/dkE8lLnkVign
	wu4TIH0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwWgy-004V6e-1P;
	Tue, 09 May 2023 23:24:24 +0000
Received: from mail-pg1-f182.google.com ([209.85.215.182])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwWgv-004V5o-04
	for linux-nvme@lists.infradead.org;
	Tue, 09 May 2023 23:24:22 +0000
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-517ca8972c5so1123108a12.0
        for <linux-nvme@lists.infradead.org>; Tue, 09 May 2023 16:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683674659; x=1686266659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h70vVXjhA0qIU7n5ToEITFWXNEpzgnDuFUEOkbC24S0=;
        b=S70tUDGz+gdRbZydlg19JDfIk82d1CJHwHPeTRX5wQh/ybecB8sFzE1nCGjeWlvp/J
         winVkypJo49NOJ7bYhEHy/XECH1qqouC97v++/Cy3cNrznWlChIzFqJR9t9NIcyA3kwP
         xKNvdzCWC5KDfoJv/FOVQrGrH+A8TsKnLPjWF2v5hdrozOBSAXek6ATRsAPtAnhn7lOo
         /FP+ffNV7AaqU9cwFXXNSbBj3Z/45ptkr06P2jf1M7t0rtbVluvlGOLMcM9lLGRKL08E
         AlCbOQESDZSjZrQadSqlmGcMQATYGDoy8IvxkB8Qtl9SCIPA0+kx/ujFKyIhV5vMa7pz
         VD/Q==
X-Gm-Message-State: AC+VfDyaDr4E2+VfCpegiQheEFrVSAif7BtRgpvtZ6tGxddZNiVco5FS
	jlAezpGzRq6hpMTo5Isc+3Q=
X-Google-Smtp-Source: ACHHUZ5Xel8XAcg3tMVC0IPKEBlueY2EBkHUK6mOyTz8LLK6zTHYIztOP93g2edH+ZWa3kzB7+GEpA==
X-Received: by 2002:a17:90a:1a5c:b0:250:9af3:4f89 with SMTP id 28-20020a17090a1a5c00b002509af34f89mr5524488pjl.4.1683674659069;
        Tue, 09 May 2023 16:24:19 -0700 (PDT)
Received: from ?IPV6:2001:4958:15a0:30:c6ee:a400:39c6:2a73? ([2001:4958:15a0:30:c6ee:a400:39c6:2a73])
        by smtp.gmail.com with ESMTPSA id dt20-20020a17090afa5400b00247601ce2aesm12308845pjb.20.2023.05.09.16.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 16:24:18 -0700 (PDT)
Message-ID: <8355cb08-08fc-d3c2-8fba-520d294ac38f@grimberg.me>
Date: Tue, 9 May 2023 16:24:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] nvmet-rdma: Suppress a class of lockdep complaints
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Max Gurtovoy <maxg@mellanox.com>, Hannes Reinecke <hare@suse.de>
References: <20230509135615.2061227-1-bvanassche@acm.org>
 <ycdptic5i3aerzpzml7eitzb7wn7wj3vwk3bric2ogus6m3uaz@33zh62c3mmco>
 <a7458945-5187-ad13-e75c-bfa6966c5e44@acm.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <a7458945-5187-ad13-e75c-bfa6966c5e44@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230509_162421_077023_E18F3908 
X-CRM114-Status: GOOD (  21.44  )
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


>> Bart, thank you very much for this immediate action after the 
>> discussion at LSF.
>> This is encouraging. I applied the patch on top of v6.4-rc1 and ran 
>> the test
>> case with various transports. Unfortunately, I observed kernel panics 
>> with rdma
>> and siw transports [1][2]. Also I observed another lockdep WARN with tcp
>> transport [3]. It looks that your fix unveiled more hidden issue/s.
> 
> Please use siw instead of rxe when running blktests - there are known 
> issues with the rxe driver.
> 
> Please apply these patches on top of kernel v6.3 instead of v6.4-rc1. 
> The hrtimer_interrupt() crash shown below is a v6.4-rc1 regression and 
> does not occur with the v6.3 kernel.
> 
> Since my patch is for the RDMA transport, it is not clear to me why a 
> report for the TCP transport is included in a reply to my patch?

Agree,

The same fundamental issue exists in nvmet-tcp as well.

Copying to nvmet-tcp (compile-tested only) gives:
--
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index ed98df72c76b..a4367fa6f55b 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -163,7 +163,9 @@ struct nvmet_tcp_queue {
         struct sockaddr_storage sockaddr;
         struct sockaddr_storage sockaddr_peer;
         struct work_struct      release_work;
-
+#ifdef CONFIG_LOCKDEP
+       struct lock_class_key   key;
+#endif
         int                     idx;
         struct list_head        queue_list;

@@ -1472,6 +1474,10 @@ static void nvmet_tcp_release_queue_work(struct 
work_struct *w)
         list_del_init(&queue->queue_list);
         mutex_unlock(&nvmet_tcp_queue_mutex);

+#ifdef CONFIG_LOCKDEP
+       lockdep_unregister_key(&queue->key);
+#endif
+
         nvmet_tcp_restore_socket_callbacks(queue);
         cancel_work_sync(&queue->io_work);
         /* stop accepting incoming data */
@@ -1654,6 +1660,11 @@ static int nvmet_tcp_alloc_queue(struct 
nvmet_tcp_port *port,
         if (ret)
                 goto out_destroy_sq;

+#ifdef CONFIG_LOCKDEP
+       lockdep_register_key(&queue->key);
+       lockdep_init_map(&queue->release_work.lockdep_map,
+                        "nvmet_tcp_release_work", &queue->key, 0);
+#endif
         return 0;
  out_destroy_sq:
         mutex_lock(&nvmet_tcp_queue_mutex);
--

