Return-Path: <SRS0=Oc5T=LJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D0DC48BDF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 23:04:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4E6461055
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 23:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E6461055
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=jU3+v7cssN+h9Str6xaO/nc14ou17TDW1fKZ0TKEyv8=; b=AtZFoSus2NubJd
	pcRdtj39k7NLmQYZyz9oie8XiPOW+Q9DV3eL/IVfNlYws6oPjxLP9nWxsyiV6irP39c7YIsWqyHhN
	yQhaHTYGA9Tg58JGiZWaElEzeRbR9jqUeHVukIbHZ7pFZKEL29QT1QYDwpRClCuyjvptzpYoaKHpr
	NjhEgbBSrdbaZHHHkdBUnLvXZdLA56KPqK1yzatwtJf0qVIzEomrizQ6IXw3JSS6aF6u2xw9NScI0
	HcG5n2pEA3YQSrVwzOGOrRbLbZsevEAguCsuiol2atAzTxl0kzINLpbtSFxDyNDwuZKNVgvdfF4To
	zFfNqeS7MwMXbUEHkv2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltI68-003l2J-4Z; Tue, 15 Jun 2021 23:03:56 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltH4B-003N0t-K7
 for linux-nvme@lists.infradead.org; Tue, 15 Jun 2021 21:57:54 +0000
Received: by mail-pj1-x1031.google.com with SMTP id
 o10-20020a17090aac0ab029016e92770073so506269pjq.5
 for <linux-nvme@lists.infradead.org>; Tue, 15 Jun 2021 14:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purestorage.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=8tQi+bwX7I5h9aIC9zMAYuI8wQZ79E3nv5cO2ZJ9/UE=;
 b=I4fyMssdjE1XCH7Cjvi+YRVBzR2Of6SmevqSE4AmifShJ1yEFMl6e3AgUsOERzDR8a
 4Ged7cVQccEfoyZPTvcdipI+xUzVJG5SeZ0kVWvGXzFrhcxtb9hCy00kTUt+SeFPQLnd
 9IaM0Mq77SRCqvUmQ08PHpTSLw/G8JwUP/ZDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=8tQi+bwX7I5h9aIC9zMAYuI8wQZ79E3nv5cO2ZJ9/UE=;
 b=OP6k5pX7odYvfEsNCEZzmId/avIAgOMPv2iarrFwL+cHdWsf/5lk7C/93CCorh8w32
 YbSTl3nZGuEQzxUllRZdPaJl+Kn2SSkqndDfgzwAdko4WujyCk3go55+0+dfEScTJGGn
 VHM3zEloLkYFa/gF2ScDKV2sjjjsYowD3vZzn1nIkAgb9Y+Oyx3ML64C+naZIsyz7uyq
 FSKUyVq8UZITIIAeSyAtQjky/BEtG1t07+AipGieFLsDK6/C0HNcg0NEKKfF5WRTs5Ij
 T6A23Z3oaMU2Ty/Pgd19K9lDii5smgHOV8rsxkkKmFC+6OgVhoQWxkul4jTUg4jd/b3u
 egGw==
X-Gm-Message-State: AOAM532cSuuDU/L66jesHUQ3LcoBLX7wVQC9tdphp4jKPdZLs3030bsy
 O+LGUtZQaAoEGvSY1NAJgZTnTzcyJfpIsQCjI1X+UZ+rXSjNXwyXGLCb5F7q6ASvv2Z4p2bFA/w
 AyyXTDLMQqs15tnB8PbCDKiRe2fXZPZdv8mpdDSDjTALsAEmKMsBDLfNzREsJ2polGtlJlCErt0
 fXoG53TSo=
X-Google-Smtp-Source: ABdhPJyqW/7RZXoRfSZ7Bc6LOTK5JZ8MVKdgSjx6dwoYvlM0CtmHZ1lnddWjw08R4bqrsGIPLw/ABw==
X-Received: by 2002:a17:90a:f015:: with SMTP id
 bt21mr7228779pjb.37.1623794270531; 
 Tue, 15 Jun 2021 14:57:50 -0700 (PDT)
Received: from yoga.purestorage.com ([192.30.189.3])
 by smtp.googlemail.com with ESMTPSA id w59sm113651pjj.13.2021.06.15.14.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jun 2021 14:57:50 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: linux-nvme@lists.infradead.org
Cc: yzhong@purestorage.com,
	ashishk@purestorage.com
Subject: Review Request: nvme-pci: Fix multiple races in nvme_setup_io_queues()
Date: Tue, 15 Jun 2021 14:57:40 -0700
Message-Id: <20210615215741.26844-1-cachen@purestorage.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210615_145752_649060_D57BE967 
X-CRM114-Status: UNSURE (   6.04  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

All tests and fix are based on tag nvme-5.14-2021-06-08 of repo
http://git.infradead.org/nvme.git

Testing method
while :; power off one drive;
    sleep $((RANDOM%3)).$((RANDOM%10));
    power on the same drive;
    sleep $((RANDOM%3)).$((RANDOM%10));
done

Sample crash call trace
[11668.533431] pcieport 0000:87:08.0: pciehp: Slot(402): Card present
...
[11668.681298] nvme nvme12: pci function 0000:8c:00.0
[11668.681354] nvme 0000:8c:00.0: enabling device (0100 -> 0102)
[11669.046142] pcieport 0000:87:08.0: pciehp: Slot(402): Link Down
[11669.046146] pcieport 0000:87:08.0: pciehp: Slot(402): Card not present
[11669.077428] ------------[ cut here ]------------
[11669.077431] kernel BUG at drivers/pci/msi.c:348!
[11669.077555] invalid opcode: 0000 [#1] SMP KASAN
[11669.077658] CPU: 31 PID: 716 Comm: irq/127-pciehp Not tainted 5.13.0-rc3+
[11669.077869] Hardware name: <MASKED OFF>
[11669.078022] RIP: 0010:free_msi_irqs+0x28a/0x2d0
...
[11669.093982] Call Trace:
[11669.096850]  pci_free_irq_vectors+0xe/0x20
[11669.099695]  nvme_dev_disable+0x140/0x760 [nvme]
[11669.102503]  ? _raw_spin_lock_irqsave+0x9c/0x100
[11669.105271]  ? trace_hardirqs_on+0x2c/0xe0
[11669.107994]  nvme_remove+0x191/0x1e0 [nvme]
[11669.110689]  pci_device_remove+0x6b/0x110
[11669.113316]  device_release_driver_internal+0x14f/0x280
[11669.115939]  pci_stop_bus_device+0xcb/0x100
[11669.118515]  pci_stop_and_remove_bus_device+0xe/0x20
[11669.121079]  pciehp_unconfigure_device+0xfa/0x200
[11669.123597]  ? pciehp_configure_device+0x1c0/0x1c0
[11669.126049]  ? trace_hardirqs_on+0x2c/0xe0
[11669.128444]  pciehp_disable_slot+0xc4/0x1a0
[11669.130771]  ? pciehp_runtime_suspend+0x40/0x40
[11669.133054]  ? __mutex_lock_slowpath+0x10/0x10
[11669.135289]  ? trace_hardirqs_on+0x2c/0xe0
[11669.137462]  pciehp_handle_presence_or_link_change+0x15c/0x4f0
[11669.139632]  ? down_read+0x11f/0x1a0
[11669.141731]  ? pciehp_handle_disable_request+0x80/0x80
[11669.143817]  ? rwsem_down_read_slowpath+0x600/0x600
[11669.145851]  ? __radix_tree_lookup+0xb2/0x130
[11669.147842]  pciehp_ist+0x19d/0x1a0
[11669.149790]  ? pciehp_set_indicators+0xe0/0xe0
[11669.151704]  ? irq_finalize_oneshot.part.46+0x1d0/0x1d0
[11669.153588]  irq_thread_fn+0x3f/0xa0
[11669.155407]  irq_thread+0x195/0x290
[11669.157147]  ? irq_thread_check_affinity.part.49+0xe0/0xe0
[11669.158883]  ? _raw_read_lock_irq+0x50/0x50
[11669.160611]  ? _raw_read_lock_irq+0x50/0x50
[11669.162320]  ? irq_forced_thread_fn+0xf0/0xf0
[11669.164032]  ? trace_hardirqs_on+0x2c/0xe0
[11669.165731]  ? irq_thread_check_affinity.part.49+0xe0/0xe0
[11669.167461]  kthread+0x1c8/0x1f0
[11669.169173]  ? kthread_parkme+0x40/0x40
[11669.170883]  ret_from_fork+0x22/0x30

From: Casey Chen <cachen@purestorage.com>
Reply-To: 
Subject: Review Request: nvme-pci: Fix multiple races in nvme_setup_io_queues()
In-Reply-To: 



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
