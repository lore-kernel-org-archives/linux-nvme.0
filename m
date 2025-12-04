Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0D9D29FB1
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Dec 2025 19:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jQN2fEgrBkhsowinCilKqYK0evmlbFzMR5NLRS9YTE4=; b=2C7il4jpwIZSchQ7aApb6l28Tv
	0sgX/MwTasYH98kmOigmRsvdIRaVP/MVeZKHD+RJ3yebA03+GmUtKf3iYNdjm3ORs7UjUGc3V+XyF
	R6FbzrWbmus0VB0mkVvMy56NjZTJDTsA4C6jz3vij9VjHDDGftnU9q/MsXc4iWMUjQ3Ch1uaNTz3S
	xFoEkQn/qfqtPCWYQJLtNVh57d4aBanEwb0rY8cfNNtrMH5CA08fFHHcH4f+sIBW6f1twoeoVcF5N
	c2ibL7x4AaouhNdTRR202udXlFoipaH1RfrPWvz33ekmrDOLMJisRYifZLAdYqqmTJBMG5CBimiKf
	Dpj89s4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vREo8-00000008UY5-0U28;
	Thu, 04 Dec 2025 19:16:04 +0000
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vREo5-00000008UXf-1REp
	for linux-nvme@lists.infradead.org;
	Thu, 04 Dec 2025 19:16:03 +0000
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-6419b7b4b80so1942154a12.2
        for <linux-nvme@lists.infradead.org>; Thu, 04 Dec 2025 11:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764875759; x=1765480559; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jQN2fEgrBkhsowinCilKqYK0evmlbFzMR5NLRS9YTE4=;
        b=eZPMiFKOJSOgjnSJ0rN7JAee42JALq4LXglybvM57fU68l32W7aaNP7yJku01OizOD
         mz2b0BnIbf0KR7GRKo/86+xCXHQ79HOz+3Amcyyx2zAG4r17i069/PV2e8awdV/yY2rN
         WLAU3AB5h5REPluMXvJbYNzrCbzG73zO2omihi0av1+k41fTIu+RHqsffKrnw3kY63BH
         YCeH46WA8jEfA/LLQym67SOiWaRc4f1v47QKMijV3I3LlYAnRUU8zFUmUm80JTj8+oLR
         Q37ibgEXkDo3O6vBn7+fReLSieeWbPFl8Ijv3lm+ltjMyJdm01R824t94UD6/MxVeh/7
         keHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764875759; x=1765480559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQN2fEgrBkhsowinCilKqYK0evmlbFzMR5NLRS9YTE4=;
        b=IMX1P+jSP/GZX1dZdTwOH/NFoGhVPERkWCg0S7Scea73Gx8QNjCFyIyF3/KZvfkop+
         OmnreYfScrzS2Lc+ldWbEQvgKvryydXBvREJ4MEIIduulRyujeR2hJ0oEB4yB6xI5PF6
         bSr4KlFRvZO5tCEWquHr2TS8FfTaw4AUaysL7k9/0758NawZtekKovVt5kKMdXPHegoU
         kkp7T9P9HSRD2aTF2V4W+qI1Yz6djUvme8+cWUc7vMMd1ma0qhBknN9hkJc5DqNAdQXv
         ORzG1DVWZ2qF5q8xzwQ8Ohw64NRprYyslT3+aD76527HohxcJ/79I5WujaBDuZEaRIf0
         rRfA==
X-Forwarded-Encrypted: i=1; AJvYcCUbEbJbEPjuOSyaZOfNtOPdcgZf5cniuDpM1DEZ5FAFpfW5hS8VDI8hp8qBH/fovZOD/OWajCyHxtX9@lists.infradead.org
X-Gm-Message-State: AOJu0YwnFdnWODw//ajn2FxIKvdxOmnWBAodGHSKWOp2xJJhH1EbSTUz
	vZPKS3G1CfXaq7SW+ukZnRUPJN1X8DFZH95FswJnyXY0adWQebEIw+HSJuCLgusdHoc=
X-Gm-Gg: ASbGncsqYNJFT0PFwxAbldGSpATf4mj2YuxCOWZyTLxSNZBq06WOkHQGSlnkUvzynJ1
	3TScmTswBzFb4b7AGRSKOxUQKSmjV+gDLElPFgKFZKacp1sirGfcjioenFV4F2L5nBFuq0WsrM+
	IVLiWv4w4h70FUOHgzkn1Dv+jTbXsPfIm+TVHdtz2ff5iASViU7aRK0/I5/+wLfek/TSrAQMwX5
	pl6b8ZDbNPQ7vimH0wlLtQHMYNUrA4PM+8seUaLiCccLGS8Yii5TemrqUTVyuZ0nYgi9o30LQ6s
	TZj9glaxDpYRqFLqy6tOZh77Q/0U7KyuyHPqcVXz1JDPIzZL7NydXSA8v2xV147IZYBCkDT3AiR
	jLMU1BZQ39vnYjWzyjR3P44AeeDZwStDbvOznezM4Tp+Y/VOMMV2LodiTLmzTbohh/VIKuPYjtl
	urPdxWSBZyFyYJuoQjss50tylu6NVnytQ=
X-Google-Smtp-Source: AGHT+IHL6tGdhWSxZOBpGzxYkgMsvc9YA0cw/P9oR/fGekUj57QPqKqoOkBbrrdnfzqv0m64xMgyoQ==
X-Received: by 2002:a05:6402:1ecc:b0:645:c6b1:5f9d with SMTP id 4fb4d7f45d1cf-6479c4720f4mr6210793a12.5.1764875759172;
        Thu, 04 Dec 2025 11:15:59 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id 4fb4d7f45d1cf-647b2eda768sm1887014a12.8.2025.12.04.11.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 11:15:58 -0800 (PST)
Date: Thu, 4 Dec 2025 11:15:55 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Casey Chen <cachen@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
	Waiman Long <llong@redhat.com>, Hillf Danton <hdanton@sina.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] block: Use RCU in blk_mq_[un]quiesce_tagset()
 instead of set->tag_list_lock
Message-ID: <20251204191555.GB337106-mkhalfella@purestorage.com>
References: <20251204181212.1484066-1-mkhalfella@purestorage.com>
 <20251204181212.1484066-2-mkhalfella@purestorage.com>
 <5450d3fa-3f00-40ae-ac95-1f08886de3b6@acm.org>
 <20251204184243.GZ337106-mkhalfella@purestorage.com>
 <71e9950f-ace7-4570-a604-ceca347eea20@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71e9950f-ace7-4570-a604-ceca347eea20@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251204_111601_910633_9FD06C3B 
X-CRM114-Status: GOOD (  16.91  )
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

On Thu 2025-12-04 09:06:47 -1000, Bart Van Assche wrote:
> On 12/4/25 8:42 AM, Mohamed Khalfella wrote:
> > Is blk_mq_del_queue_tag_set() performance sensitive such that it can not
> > take synchronize_rcu()? It is not in IO codepath, right?
> 
> Introducing a new synchronize_rcu() call almost always slows down some 
> workload so it should be avoided if possible.
> 
>  > I can not think of an easy way to do that. Suggestions are welcomed.
> 
> I can't find the implementation of nvme_dev_disable_locked(). What
> kernel tree does your patch apply to?
> 
> $ git grep -w nvme_dev_disable_locked axboe-block/for-next | wc -l
> 0

The stacktraces are from old 6.6.9 kernel. However, the issue is still
applicable to recent kernels. This is an example from 6.13 kernel.

Oct  1 15:19:30 hostname kernel: INFO: task kworker/151:1H:2442 blocked for more than 122 seconds.
Oct  1 15:19:30 hostname kernel:      Tainted: G            E       6.13.2-ge5f37b497f62 #1
Oct  1 15:19:30 hostname kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct  1 15:19:30 hostname kernel: task:kworker/151:1H  state:D stack:0     pid:2442  tgid:2442  ppid:2      flags:0x00004000
Oct  1 15:19:30 hostname kernel: Workqueue: kblockd blk_mq_timeout_work
Oct  1 15:19:30 hostname kernel: Call Trace:
Oct  1 15:19:30 hostname kernel: <TASK>
Oct  1 15:19:30 hostname kernel: __schedule+0x47c/0xbb0
Oct  1 15:19:30 hostname kernel: ? timerqueue_add+0x66/0xb0
Oct  1 15:19:30 hostname kernel: schedule+0x1c/0xa0
Oct  1 15:19:30 hostname kernel: schedule_preempt_disabled+0xa/0x10
Oct  1 15:19:30 hostname kernel: __mutex_lock.constprop.0+0x271/0x600
Oct  1 15:19:30 hostname kernel: blk_mq_quiesce_tagset+0x25/0xc0
Oct  1 15:19:30 hostname kernel: nvme_dev_disable+0x9c/0x250
Oct  1 15:19:30 hostname kernel: nvme_timeout+0x1fc/0x520
Oct  1 15:19:30 hostname kernel: blk_mq_handle_expired+0x5c/0x90
Oct  1 15:19:30 hostname kernel: bt_iter+0x7e/0x90
Oct  1 15:19:30 hostname kernel: blk_mq_queue_tag_busy_iter+0x27e/0x550
Oct  1 15:19:30 hostname kernel: ? __blk_mq_complete_request_remote+0x10/0x10
Oct  1 15:19:30 hostname kernel: ? __blk_mq_complete_request_remote+0x10/0x10
Oct  1 15:19:30 hostname kernel: ? __call_rcu_common.constprop.0+0x1c0/0x210
Oct  1 15:19:30 hostname kernel: blk_mq_timeout_work+0x12d/0x170
Oct  1 15:19:30 hostname kernel: process_one_work+0x12e/0x2d0
Oct  1 15:19:30 hostname kernel: worker_thread+0x288/0x3a0
Oct  1 15:19:30 hostname kernel: ? rescuer_thread+0x480/0x480
Oct  1 15:19:30 hostname kernel: kthread+0xb8/0xe0
Oct  1 15:19:30 hostname kernel: ? kthread_park+0x80/0x80
Oct  1 15:19:30 hostname kernel: ret_from_fork+0x2d/0x50
Oct  1 15:19:30 hostname kernel: ? kthread_park+0x80/0x80
Oct  1 15:19:30 hostname kernel: ret_from_fork_asm+0x11/0x20
Oct  1 15:19:30 hostname kernel: </TASK>
Oct  1 15:19:30 hostname kernel: INFO: task python:37330 blocked for more than 122 seconds.
Oct  1 15:19:30 hostname kernel:      Tainted: G            E       6.13.2-ge5f37b497f62 #1
Oct  1 15:19:30 hostname kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct  1 15:19:30 hostname kernel: task:python          state:D stack:0     pid:37330 tgid:37330 ppid:37329  flags:0x00004002
Oct  1 15:19:30 hostname kernel: Call Trace:
Oct  1 15:19:30 hostname kernel: <TASK>
Oct  1 15:19:30 hostname kernel: __schedule+0x47c/0xbb0
Oct  1 15:19:30 hostname kernel: ? xas_find+0x161/0x1a0
Oct  1 15:19:30 hostname kernel: schedule+0x1c/0xa0
Oct  1 15:19:30 hostname kernel: blk_mq_freeze_queue_wait+0x3d/0x70
Oct  1 15:19:30 hostname kernel: ? destroy_sched_domains_rcu+0x30/0x30
Oct  1 15:19:30 hostname kernel: blk_mq_update_tag_set_shared+0x44/0x80
Oct  1 15:19:30 hostname kernel: blk_mq_exit_queue+0x141/0x150
Oct  1 15:19:30 hostname kernel: del_gendisk+0x25a/0x2d0
Oct  1 15:19:30 hostname kernel: nvme_ns_remove+0xc9/0x170
Oct  1 15:19:30 hostname kernel: nvme_remove_namespaces+0xc7/0x100
Oct  1 15:19:30 hostname kernel: nvme_remove+0x62/0x150
Oct  1 15:19:30 hostname kernel: pci_device_remove+0x23/0x60
Oct  1 15:19:30 hostname kernel: device_release_driver_internal+0x159/0x200
Oct  1 15:19:30 hostname kernel: unbind_store+0x99/0xa0
Oct  1 15:19:30 hostname kernel: kernfs_fop_write_iter+0x112/0x1e0
Oct  1 15:19:30 hostname kernel: vfs_write+0x2b1/0x3d0
Oct  1 15:19:30 hostname kernel: ksys_write+0x4e/0xb0
Oct  1 15:19:30 hostname kernel: do_syscall_64+0x5b/0x160
Oct  1 15:19:30 hostname kernel: entry_SYSCALL_64_after_hwframe+0x4b/0x53
Oct  1 15:19:30 hostname kernel: RIP: 0033:0x7f12cf2fe02f
Oct  1 15:19:30 hostname kernel: RSP: 002b:00007f12311f78e0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
Oct  1 15:19:30 hostname kernel: RAX: ffffffffffffffda RBX: 00007f12311ff5c8 RCX: 00007f12cf2fe02f
Oct  1 15:19:30 hostname kernel: RDX: 000000000000000c RSI: 00007f12081c19a0 RDI: 000000000000003b
Oct  1 15:19:30 hostname kernel: RBP: 000000000000000c R08: 0000000000000000 R09: 0000000000000002
Oct  1 15:19:30 hostname kernel: R10: 0000000000000002 R11: 0000000000000293 R12: 00007f12cae00700
Oct  1 15:19:30 hostname kernel: R13: 00007f12081c19a0 R14: 000000000000003b R15: 00007f1220219990
Oct  1 15:19:30 hostname kernel: </TASK>

> 
> Thanks,
> 
> Bart.

