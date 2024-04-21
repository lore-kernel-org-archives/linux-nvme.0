Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512C3C4345F
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Apr 2024 10:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zfeUcXgwH92Pvh+M60s2A0mg6povjUDG+rcqxfmA/so=; b=udlPJIMA9HfJ1V3kLXy/I7PoC1
	y+ISlh5OH/Ianlbo2eNjUWEEyL1E6m3VbhVB/oW6hr/E3p+bZaExHueuVvkYX49l55Wg2RHR+rH6C
	Z0WnEF1fZnur6yY7jZzAro6ZfMxSgQ0V3NrVLq6gdZkmKd0ZiDJ0vh+C8uffVRW8IwSzm3SwSmChJ
	OGMIiduJV/hboqrs3tcCmF4Jf4fJJIJR0/CHNBPVk3VJXLrpdOCHvUOa4qqcz/3QmoA+PRJlbCFl5
	qUd/fPja4Gi8IJ7S8Z6595hiEGAo91v+MfjM9BC58l9UM0HAMZj1q7qL/HpiaMK7fXKKYt/IOn2vi
	Jve6H42A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryURC-0000000AIoc-16pv;
	Sun, 21 Apr 2024 10:28:46 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryUR4-0000000AInV-28rk
	for linux-nvme@lists.infradead.org;
	Sun, 21 Apr 2024 10:28:40 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-346407b8c9aso944851f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 21 Apr 2024 03:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713695311; x=1714300111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zfeUcXgwH92Pvh+M60s2A0mg6povjUDG+rcqxfmA/so=;
        b=O+wTI+VQUYb2iO8pJLIlmjMXpGbjK4yO8I+Uq7B7v2CrKtTGJGMzZI2jJ9X+ypw1nm
         4zC3VYb0r4Lji94bKv7Z7R3j6zTyuS73VqC6RUbrprENjxlUJKqpFfuPP1MiPACTVmfK
         v4wbEIQRrPaLOJRJx0nAyoEz4YcdLumbV7aCObRL/J9TlImvvIajj+XCh0DZbCkaBn+4
         vbX6JgpLy7hQHHU8OgubcgQXTk3z/88X24MkFzCU7MuduN2u2oBSCeAZL0mhgbThoSYF
         zleynPj6XmAI1nbUf73iUjGUqViRDDLkJLq8hdTqk1/oU6fxr9F6Ex/UMR1SIH6MyDUo
         blXA==
X-Forwarded-Encrypted: i=1; AJvYcCXRQbMhYK7RVdra/MoYHJ9ruabsY8F+AxLzM8Rp9P33zBC/CN4Ey6gw/aLPD553i0+uJ0XsZverWQSNw45aOohrDSQa5Gc+2DRELgsWsRE=
X-Gm-Message-State: AOJu0YyAk784bk+v4agQrk1/70OjTqFTQ5r6yhm/Ph+lzYMiYpTZ3CQz
	T5CaVvNAe483pskLFTgGafVyFaC2QF6Shv4HYQd1+agCB/tQruir
X-Google-Smtp-Source: AGHT+IEl6WZyy+jrITEKu1jNUYTYw90dQPSXalte7ISlYBYOVpR5YJdQ0HhQaJvU2VsUhIkqlXeFmQ==
X-Received: by 2002:a5d:5090:0:b0:346:65dd:55e6 with SMTP id a16-20020a5d5090000000b0034665dd55e6mr4695093wrt.1.1713695310427;
        Sun, 21 Apr 2024 03:28:30 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c501100b00419e078677csm5390673wmr.16.2024.04.21.03.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 03:28:30 -0700 (PDT)
Message-ID: <579c82da-52a7-4425-81d7-480c676b8cbb@grimberg.me>
Date: Sun, 21 Apr 2024 13:28:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report] PCIe errinject and hot-unplug causes nvme driver
 hang
To: Nilay Shroff <nilay@linux.ibm.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 "axboe@fb.com" <axboe@fb.com>, Gregory Joyce <gjoyce@ibm.com>,
 Srimannarayana Murthy Maram <msmurthy@imap.linux.ibm.com>
References: <199be893-5dfa-41e5-b6f2-40ac90ebccc4@linux.ibm.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <199be893-5dfa-41e5-b6f2-40ac90ebccc4@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240421_032838_595404_091FE127 
X-CRM114-Status: GOOD (  20.59  )
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



On 18/04/2024 15:52, Nilay Shroff wrote:
> Hi,
>
> We found nvme driver hangs when disk IO is ongoing and if we inject pcie error and hot-unplug (not physical but logical unplug) the nvme disk.
>
> Notes and observations:
> ======================
> This is observed on the latest linus kernel tree (v6.9-rc4) however we believe this issue shall also be present on the older kernels.
>
> Test details:
> =============
> Steps to reproduce this issue:
>
> 1. Run some disk IO using fio or any other tool
> 2. While disk IO is running, inject pci error
> 3. disable the slot where nvme disk is attached (echo 0 > /sys/bus/pci/slots/<slot-no>/power)
>
> Kernel Logs:
> ============
> When we follow steps described in the test details we get the below logs:
>
> [  295.240811] nvme nvme1: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
> [  295.240837] nvme nvme1: Does your device have a faulty power saving mode enabled?
> [  295.240845] nvme nvme1: Try "nvme_core.default_ps_max_latency_us=0 pcie_aspm=off" and report a bug
> [  490.381591] INFO: task bash:2510 blocked for more than 122 seconds.
> [  490.381614]       Not tainted 6.9.0-rc4+ #8
> [  490.381618] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  490.381623] task:bash            state:D stack:0     pid:2510  tgid:2510  ppid:2509   flags:0x00042080
> [  490.381632] Call Trace:
> [  490.381635] [c00000006748f510] [c00000006748f550] 0xc00000006748f550 (unreliable)
> [  490.381644] [c00000006748f6c0] [c00000000001f3fc] __switch_to+0x13c/0x220
> [  490.381654] [c00000006748f720] [c000000000fb87e0] __schedule+0x268/0x7c4
> [  490.381663] [c00000006748f7f0] [c000000000fb8d7c] schedule+0x40/0x108
> [  490.381669] [c00000006748f860] [c000000000808bb4] blk_mq_freeze_queue_wait+0xa4/0xec
> [  490.381676] [c00000006748f8c0] [c00000000081eba8] del_gendisk+0x284/0x464
> [  490.381683] [c00000006748f920] [c0080000064c74a4] nvme_ns_remove+0x138/0x2ac [nvme_core]
> [  490.381697] [c00000006748f960] [c0080000064c7704] nvme_remove_namespaces+0xec/0x198 [nvme_core]
> [  490.381710] [c00000006748f9d0] [c008000006704b70] nvme_remove+0x80/0x168 [nvme]
> [  490.381752] [c00000006748fa10] [c00000000092a10c] pci_device_remove+0x6c/0x110
> [  490.381776] [c00000006748fa50] [c000000000a4f504] device_remove+0x70/0xc4
> [  490.381786] [c00000006748fa80] [c000000000a515d8] device_release_driver_internal+0x2a4/0x324
> [  490.381801] [c00000006748fad0] [c00000000091b528] pci_stop_bus_device+0xb8/0x104
> [  490.381817] [c00000006748fb10] [c00000000091b910] pci_stop_and_remove_bus_device+0x28/0x40
> [  490.381826] [c00000006748fb40] [c000000000072620] pci_hp_remove_devices+0x90/0x128
> [  490.381831] [c00000006748fbd0] [c008000004440504] disable_slot+0x40/0x90 [rpaphp]
> [  490.381839] [c00000006748fc00] [c000000000956090] power_write_file+0xf8/0x19c
> [  490.381846] [c00000006748fc80] [c00000000094b4f8] pci_slot_attr_store+0x40/0x5c
> [  490.381851] [c00000006748fca0] [c0000000006e5dc4] sysfs_kf_write+0x64/0x78
> [  490.381858] [c00000006748fcc0] [c0000000006e48d8] kernfs_fop_write_iter+0x1b0/0x290
> [  490.381864] [c00000006748fd10] [c0000000005e0f4c] vfs_write+0x3b0/0x4f8
> [  490.381871] [c00000006748fdc0] [c0000000005e13c0] ksys_write+0x84/0x140
> [  490.381876] [c00000006748fe10] [c000000000030a84] system_call_exception+0x124/0x330
> [  490.381882] [c00000006748fe50] [c00000000000cedc] system_call_vectored_common+0x15c/0x2ec
>
> NVMe controller state:
> ======================
> # cat /sys/class/nvme/nvme1/state
> deleting (no IO)
>
> Process State:
> ==============
> # ps -aex
>     [..]
>     2510 pts/2    Ds+    0:00 -bash USER=root LOGNAME=root HOME=/root PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin SHELL=/bin/bash TERM=xterm-256colo
>     2549 ?        Ds     0:14 fio --filename=/dev/nvme1n1 --direct=1 --rw=randrw --bs=4k --ioengine=psync --iodepth=256 --runtime=300 --numjobs=1 --time_based
>     [..]
>
> Observation:
> ============
> As it's apparent from the above logs that "disable-slot" (pid 2510) is waiting (uninterruptible-sleep)
> for queue to be freezed because the in-flight IO(s) couldn't finish. Moreover the IO(s) which were
> in-flight actually times-out however nvme_timeout() doesn't cancel those IOs but logs this error
> "Try "nvme_core.default_ps_max_latency_us=0 pcie_aspm=off" and report a bug" and returns BLK_EH_DONE.
> As those in-fligh IOs were not cancelled, the NVMe driver code which runs in the context of
> "disable-slot" couldn't forward progress and NVMe controller state remains in "deleting (no IO)"
> indefinitely. The only way we found to come out of this state is to reboot the system.
>
> Proposed fix:
> ============
> static void nvme_remove(struct pci_dev *pdev)
> {
> 	struct nvme_dev *dev = pci_get_drvdata(pdev);
>
> 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
> 	pci_set_drvdata(pdev, NULL);
>
> 	if (!pci_device_is_present(pdev)) {
> 		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
> 		nvme_dev_disable(dev, true);
> 	}
> 	flush_work(&dev->ctrl.reset_work);
> 	nvme_stop_ctrl(&dev->ctrl);
> 	nvme_remove_namespaces(&dev->ctrl); <== here cntrl state is set to "deleting (no IO)"
>          [..]
> }
>
> As shown above, nvme_remove() invokes nvme_dev_disable(), however, it is only invoked if the
> device is physically removed. As nvme_dev_disable() helps cancel pending IOs, does it makes
> sense to unconditionally cancel pending IOs before moving on? Or are there any side effect if
> we were to unconditionally invoke nvme_dev_disable() at the first place?

Shouldn't the correct place to handle the cancellation is 
nvme_error_detected() given that the
pci error is preventing the request from completing and the timeout 
handler from addressing it?

