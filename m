Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA204C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 14:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PLjQ9hA4Z2U5fVD2kmAN+g2G1zH5tHZlYx6gRGEVz7s=; b=wd0NX5Kq/y7DTM9K5796L7OzZQ
	2dZXpzwmdm5HaRBwxUDe8zRIOfYjgHIUBX4g7OpyFny3QllKRXxRnXUKLfYn7mSYNTyTs3DmhB4/1
	dmTKJPKwgohecODbLVwpvWgf4x92I49x7Fs7Izv4DCwr9cvN7fwE0ti+KGhqsAY5PdEUwZjQmiE79
	4zNdbSpF4KYcooJl7Qa3g0xkINBBBov+AO07vLu60Hzf1w8RAE8ZJ4yHcYBkRjZbgEy47WQTEVs5M
	hwr1tqgAhDkFLeKRobj/I7JuINY6r6MwJyDaHNgiB8T48K9uAcg71dS/PKH/fQuznlGEnKvfj/dVk
	NFJl/RWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3fLl-0061Go-Ql; Tue, 21 Jun 2022 14:59:29 +0000
Received: from mail-ej1-f48.google.com ([209.85.218.48])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3fLj-0061FZ-Gp
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 14:59:29 +0000
Received: by mail-ej1-f48.google.com with SMTP id g25so28054193ejh.9
        for <linux-nvme@lists.infradead.org>; Tue, 21 Jun 2022 07:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=PLjQ9hA4Z2U5fVD2kmAN+g2G1zH5tHZlYx6gRGEVz7s=;
        b=GKFUxOdOMK2uyUi/bpqkrt86GeEcKstPQ+yuS/OtDmh81lYZnh5DKaMZJQfJPXYKU2
         OK9e5bf9Lv7cCDaAWuL6wED/QA/SvhCrH2n2yHiWBfsr9EkUwR94TT2YIAK9Gj30IM74
         Fk+I8KXFpl5uyvpsCA2/n0oMSqf5UJjQrUjLQf4fHcbhGj7OLS1WN3tMTe40kF2AraK6
         cQt6W1BwCtmGgw0ZbMLeunYD6nBks/vDdHG66OTYCvXFAWqT/VuhEhjqdzndQTc4L3CS
         S3q974+hcwIkim2wQQAXkyt0fqCU5Ra/QRR79X0UkjVzW+EbH4eKrh3tDTiUF93JEARe
         9Mow==
X-Gm-Message-State: AJIora8DBPgVOrbxTeKn3NB/LCja99lISFFlrcfcck7ZPu5NPNfOj+ss
	rvTZAxhSFE28ouNTdSzk074=
X-Google-Smtp-Source: AGRyM1tKPjeMRoac0C6K+jjpjO+Ij/2GD7wPt0Mx4jmroeDtMpp6C7i+qRkk1YOhbEB/XZCOHdDAvw==
X-Received: by 2002:a17:906:1109:b0:711:d8fe:fe56 with SMTP id h9-20020a170906110900b00711d8fefe56mr26442197eja.261.1655823564777;
        Tue, 21 Jun 2022 07:59:24 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id p3-20020a17090653c300b006fed93bf71fsm7944426ejo.18.2022.06.21.07.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 07:59:24 -0700 (PDT)
Message-ID: <a32afeac-983c-2ea4-e693-2d46411e7f4a@grimberg.me>
Date: Tue, 21 Jun 2022 17:59:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 06/11] nvme: Implement In-Band authentication
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220621090255.69549-1-hare@suse.de>
 <20220621090255.69549-7-hare@suse.de>
 <f8f0a631-6752-096c-4e85-bcde9bb2869e@grimberg.me>
 <22236c51-90cd-1707-05b8-3772ef4c548d@suse.de>
 <ab4aaf2b-444f-2b3c-091a-396de62afbd1@grimberg.me>
In-Reply-To: <ab4aaf2b-444f-2b3c-091a-396de62afbd1@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_075927_627812_1DDE5FF5 
X-CRM114-Status: UNSURE (   9.46  )
X-CRM114-Notice: Please train this message.
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


> Looks like if I pass a malformed ctrl key to nvme connect I am able to
> crash the system:

This was what I used in this:
$ nvme connect -a 192.168.123.1 -t tcp  -s 8009 -n testnqn1 -S 
"DHHC-1:00:QpxVGpctx5J+4SeW2MClUI8rfZO3WdP1llImvsPsx7e3TK+I:" -C 
"DHHC-1:00:Jc/My1o0qtLCWRp+sHhAVafdfaS7YQOMYhk9zSmlatobqB8C:"

The dhchap_ctrl_key is the offending string...

> -- 
> [   84.793307] Workqueue: nvme-wq __nvme_auth_work [nvme_core]
> [   84.794790] RIP: 0010:nvme_auth_transform_key+0x19/0x1f0 [nvme_common]
> [   84.796468] Code: bc f4 ff ff ff eb bf e8 f5 2f e1 ee 0f 1f 44 00 00 
> 0f 1f 44 00 00 41 57 41 56 41 55 49 89 f5 41 54 55 53 48 89 fb 48 83 ec 
> 08 <0f> b6 7f 10 e8 ce f9 ff ff 48 89 c7 0f b6 43 10 84 c0 0f 84 4c 01
> [   84.800112] RSP: 0018:ffffae5f8047bc78 EFLAGS: 00010296
> [   84.801048] RAX: ffff973b854ca0c0 RBX: 0000000000000000 RCX: 
> 0000000000000000
> [   84.802289] RDX: ffff973b8355b000 RSI: ffff973b84f568a0 RDI: 
> 0000000000000000
> [   84.803447] RBP: ffff973b842dd6b9 R08: 0000000000000003 R09: 
> ffff973bbec308a8
> [   84.804638] R10: 0000000000000147 R11: 0000000000000000 R12: 
> ffff973b842dd600
> [   84.805767] R13: ffff973b84f568a0 R14: 0000000000000000 R15: 
> ffff973b9e94250d
> [   84.806929] FS:  0000000000000000(0000) GS:ffff973bbec00000(0000) 
> knlGS:0000000000000000
> [   84.808220] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   84.809178] CR2: 0000000000000010 CR3: 00000000061ac003 CR4: 
> 0000000000370ef0
> [   84.810337] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
> 0000000000000000
> [   84.811432] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
> 0000000000000400
> [   84.812527] Call Trace:
> [   84.812974]  <TASK>
> [   84.813372]  nvme_auth_dhchap_setup_ctrl_response+0x4b/0x3b0 [nvme_core]
> [   84.814355]  ? preempt_count_add+0x68/0xa0
> [   84.815080]  ? _raw_spin_unlock_irq+0x16/0x28
> [   84.815840]  ? __wait_for_common+0x19f/0x1d0
> [   84.816587]  ? firmware_map_remove+0x87/0x87
> [   84.817333]  ? blk_mq_hctx_has_pending+0x38/0x70
> [   84.818123]  ? blk_mq_run_hw_queue+0x7d/0xe0
> [   84.818784]  ? __blk_mq_free_request+0x9b/0xa0
> [   84.819482]  ? blk_queue_exit+0xe/0x40
> [   84.820124]  ? __nvme_submit_sync_cmd+0xe8/0x160 [nvme_core]
> [   84.821096]  ? nvme_auth_submit+0x8f/0xd0 [nvme_core]
> [   84.821970]  __nvme_auth_work+0x1fb/0x480 [nvme_core]
> [   84.822869]  process_one_work+0x1e5/0x3b0
> [   84.823608]  worker_thread+0x1c4/0x3a0
> [   84.824343]  ? rescuer_thread+0x390/0x390
> [   84.825044]  kthread+0xe8/0x110
> -- 

