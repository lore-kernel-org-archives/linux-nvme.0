Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9C7C4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Nov 2022 02:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:From:Message-Id:
	Content-Transfer-Encoding:Content-Type:Subject:To:Date:Reply-To:Cc:
	MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=dpZj7X5Two18D9Vasgv7AH793WdduwGaJXYn74NdXF0=; b=p4KqGpC4eoFall
	yaBrLDl3xONIx3HvMRJe3Cl2dVtxqzmtzQSwGRGqD6h6poVSMOkKFEiFFa0swDtEThJ64xq6/il9l
	bESEoJah8UFp7XaI7z42DMbfy6SEQHJfznMp8fhFM/ag43ynPlu3m7eDrUq0RwsV+mFoBtypFghdx
	LyIRbTsHhEGB+GQdGwGaZyHQKi8tGmyouKy/bmYLijXmwkFTB1kbWW1Oo29eVmwVfr/1byWwV5enB
	vfKKQorYIENb9OcUiSO/q99VhlLDuD6jMeyOtEz4Oz/V4KWxMv4aEK6o2F9vgsGEG8IuLvIl6IoU7
	PkOKsI7p+5KkGOJHq7FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osEmd-002BlH-S1; Tue, 08 Nov 2022 02:56:15 +0000
Received: from mail-pf1-x464.google.com ([2607:f8b0:4864:20::464])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osEmW-002Bk3-5S
	for linux-nvme@lists.infradead.org; Tue, 08 Nov 2022 02:56:10 +0000
Received: by mail-pf1-x464.google.com with SMTP id m6so12638831pfb.0
        for <linux-nvme@lists.infradead.org>; Mon, 07 Nov 2022 18:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:message-id:content-transfer-encoding:user-agent:subject:to
         :date:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpZj7X5Two18D9Vasgv7AH793WdduwGaJXYn74NdXF0=;
        b=dZfrqyRXY27hnpryzTJV3HVXv31EkqE06GhDwQVTQCOHfSj5UdRlYrVmLPlv01N5qn
         TNW5vhw4t+XvYPAROtL0tPIbRy8ZqX0qzVHaNSlc+SJrWs5exdwcrn2ywZUNbujyJj0k
         w5ynyW01IvryCueFWvzR9wudLF4OMpFl2JtOPB2Z8Q5VUCd2oSOvrnVNlr1PJatLLRf8
         s6CX9IeHCcgb4CbUlZ1xQfHoQ6eV7eB9S08G6VgHoO7S/ljFIW8VuvaG9BS6hY/gA3Nv
         EsYp6it5efYGOhn8tWdkvQjDdgY042wQnfaB0zlTGWq4B1c4NjvvCeSFtgswfGMueBdK
         3+hA==
X-Gm-Message-State: ACrzQf0drCF2deNOJhhK56Da1oaBIPNZwSDQ7CX/AsknIY211aCqmuzC
	tIZlsrR7jFT21hVeATvgLfJBuRj3xyFI441szznAHW4K2bXv
X-Google-Smtp-Source: AMsMyM4COWnw3wwSCUAGBvsyIOyTaG7HIX3TjoVA/GwYBqGU3aWe9BW8AcwELEU/DOZhlb+ZJ87PWskHFEjN
X-Received: by 2002:a63:5559:0:b0:464:a987:8365 with SMTP id f25-20020a635559000000b00464a9878365mr46076556pgm.479.1667876163471;
        Mon, 07 Nov 2022 18:56:03 -0800 (PST)
Received: from smtp.aristanetworks.com (mx.aristanetworks.com. [162.210.129.12])
        by smtp-relay.gmail.com with ESMTPS id mz9-20020a17090b378900b00212e4b57315sm517742pjb.16.2022.11.07.18.56.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Nov 2022 18:56:03 -0800 (PST)
X-Relaying-Domain: arista.com
Received: from us226.sjc.aristanetworks.com (us226.sjc.aristanetworks.com [10.243.208.9])
	by smtp.aristanetworks.com (Postfix) with ESMTP id 1AF17400F81;
	Mon,  7 Nov 2022 18:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-B; t=1667876163;
	bh=dpZj7X5Two18D9Vasgv7AH793WdduwGaJXYn74NdXF0=;
	h=Date:To:Subject:From:From;
	b=LDOk7VQNpXA5rV0gRrb/JFDyNBCzKnW/VsL8NIApQQ674/1UKnQNPFgsSiK4tXk0I
	 stqfPCdOGSAST93pDoYOhqBj5Nk17fT4/Xqf2Mn00bHOuAH/4I0Y8kFmACApQWZhuD
	 ZqWB7ZvfeHz0yxCmH3TzE+RBIny+JG11fFShBdb8=
Received: by us226.sjc.aristanetworks.com (Postfix, from userid 10189)
	id E48005EC04F9; Mon,  7 Nov 2022 18:56:02 -0800 (PST)
Date: Mon, 07 Nov 2022 18:56:02 -0800
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, hch@lst.de, axboe@fb.com, kbusch@kernel.org,
 fruggeri@arista.com
Subject: nvme: hung task in blk_mq_freeze_queue_wait
User-Agent: Heirloom mailx 12.5 7/5/10
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20221108025602.E48005EC04F9@us226.sjc.aristanetworks.com>
From: fruggeri@arista.com (Francesco Ruggeri)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221107_185608_345050_1A81E626 
X-CRM114-Status: GOOD (  10.95  )
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

We are running into hung tasks in blk_mq_freeze_queue_wait, sometimes
in nvme_reset_work and sometimes in nvme_scan_work.
In some cases we also see a warning in blk_mq_unfreeze_queue
(WARN_ON_ONCE(q->mq_freeze_depth < 0)):
WARNING: CPU: 10 PID: 152 at block/blk-mq.c:199 blk_mq_unfreeze_queue+0x26/0x5a
The hung tasks are preceded by two instances of nvme_timeout racing in
nvme_dev_disable after a device becomes unresponsive.
The first nvme_dev_disable blocks in wait_for_completion_io_timeout, and
a while later a second instance blocks in mutex_lock(&dev->shutdown_lock).
When the timeout expires and the first instance releases the mutex,
the two instances start racing.
We have seen the hung tasks in 4.19, but from a quick look at the
latest 6.1 code the issue is probably there as well.
There seem to be two different scenarios where unbalanced
blk_freeze_queue_start/blk_mq_unfreeze_queue could be the cause.

1) In this case we have an unfreeze without a corresponding freeze
preceding it.

TIMEOUT 1	TIMEOUT 2	RESET WORK 1	RESET WORK 2

state = NVME_CTRL_LIVE
nvme_timeout
nvme_dev_disable
mutex_lock
nvme_start_freeze
blk_freeze_queue_start
nvme_disable_io_queues
wait_for_completion_io_timeout
		nvme_timeout
		nvme_dev_disable
		mutex_lock
mutex_unlock
nvme_reset_ctrl
state = NVME_CTRL_RESETTING
queue_work(nvme_reset_work)
				nvme_reset_work
				state = NVME_CTRL_CONNECTING
		(state != NVME_CTRL_LIVE and
		state != NVME_CTRL_RESETTING)
		skips nvme_start_freeze
		mutex_unlock
		nvme_reset_ctrl
		state = NVME_CTRL_RESETTING
		queue_work(nvme_reset_work)
				nvme_unfreeze (matches
				nvme_start_freeze in
				TIMEOUT 1)
						nvme_reset_work
						nvme_unfreeze (no
						match in TIMEOUT 2)


2) In this case a freeze has no corresponding unfreeze following it.
TIMEOUT 2 cannot schedule nvme_reset_work because TIMEOUT 1's is already
scheduled but not yet running.

TIMEOUT 1	TIMEOUT 2	RESET WORK 1	RESET WORK 2

state = NVME_CTRL_LIVE
nvme_timeout
nvme_dev_disable
mutex_lock
nvme_start_freeze
blk_freeze_queue_start
nvme_disable_io_queues
wait_for_completion_io_timeout
		nvme_timeout
		nvme_dev_disable
		mutex_lock
mutex_unlock
nvme_reset_ctrl
state = NVME_CTRL_RESETTING
queue_work(nvme_reset_work)
		(state == NVME_CTRL_LIVE or
		state == NVME_CTRL_RESETTING)
		nvme_start_freeze
		blk_freeze_queue_start
		mutex_unlock
		nvme_reset_ctrl
		state = NVME_CTRL_RESETTING
		queue_work(nvme_reset_work)
		fails because nvme_reset_work
		is not running yet
				nvme_reset_work
				nvme_unfreeze (matches
				nvme_start_freeze in
				TIMEOUT 1)
						It gets never
						scheduled.


Following is one such backtrace.

[ 4390.119745] INFO: task kworker/u80:2:8279 blocked for more than 300 seconds.
[ 4390.471456]       Tainted: P           O      4.19.142.Ar-29007847.buytenhb7335070 #1
[ 4390.832568] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 4391.193663] kworker/u80:2   D    0  8279      2 0x80000000
[ 4391.526603] Workqueue: nvme-reset-wq nvme_reset_work
[ 4391.853272] Call Trace:
[ 4392.149696]  __schedule+0x75b/0x7c2
[ 4392.458627]  schedule+0x78/0x8c
[ 4392.763399]  blk_mq_freeze_queue_wait+0x8b/0xb6
[ 4393.084849]  ? wait_woken+0x92/0x92
[ 4393.393791]  nvme_wait_freeze+0x39/0x4e
[ 4393.706900]  nvme_reset_work+0x1464/0x1665
[ 4394.023142]  ? dequeue_entity+0x694/0x6a3
[ 4394.338340]  process_one_work+0x1c2/0x30f
[ 4394.511642]  worker_thread+0x1e9/0x2cc
[ 4394.556626]  ? rescuer_thread+0x2b7/0x2b7
[ 4394.604738]  kthread+0x15d/0x165
[ 4394.643460]  ? kthread_park+0x98/0x98
[ 4394.687396]  ret_from_fork+0x1f/0x30



