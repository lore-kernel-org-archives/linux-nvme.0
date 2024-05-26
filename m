Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB0DC25B7C
	for <linux-nvme@archiver.kernel.org>; Sun, 26 May 2024 19:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nI/4Uoxkp1yjD87zx09X3rurwAjTXd48EmR5vBacbfo=; b=GRN3/HExvlZZzdfUXAsh/bvhle
	UXhmdCuaH050ciLOmjVWLqUcSdV91dpNiOelFtVUm3ekyPfq16cZCt3L3wR+N8e1wCRY36lz2lnYy
	Z0VLFxGJ7wCDDvPCiFqvZv0PcLKYLtrHDLr6LD2anOSSO3U/l2SZPq5SpG/MjMo9DHPLG05lmyo3b
	agFThCt+sd3QZUe/SwYhHsVMdgla3WmXZz7bNNAWhfUbAO2RVQqTkoOWfz3S8GaD6F2GsmHDAdexI
	jROOyVQbqtEhk+f4bGJYDp0NtCKdfSfxESik6pe/xlO/CFEMpsrzyMlYLm2NlCF6AhNo5H3P4vJzn
	A62i2Bzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBJpp-0000000DBIx-19lf;
	Sun, 26 May 2024 19:47:13 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBJpm-0000000DBHs-1ELz
	for linux-nvme@lists.infradead.org;
	Sun, 26 May 2024 19:47:11 +0000
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42111cf2706so496375e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 26 May 2024 12:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716752827; x=1717357627;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nI/4Uoxkp1yjD87zx09X3rurwAjTXd48EmR5vBacbfo=;
        b=XDIlm8xGnQZaotNzkxnrRW0AUjBPFbSV3mWl8Ce/czO7FLuFgKpq+Go1MNgWLyRBJD
         ApzvfXxQXz0mzKH2u4VWbDtdI2jqrYSaghiLxV+nLxaIq4fr9SAq+HWd+sK6536WNuAA
         qRzPQOL5WziKvy+EH4ERUZxqGZpttFpjGpboureE7+ARtgNab7X+0EkbJ0gjuf+hfu3Z
         w9/k5kj2tmfrHKOIHo5/qO78ISaAQOWYTz3JzkylUE6X1pYdadiAx1R+dyPCxFo8d8Yy
         Xmlnfj4sy9SVWCioj8b83ewTT0u6ltdqpmz5pegAzYx3BUu0Q2Li+ihmjzGT86d7A8XO
         bACQ==
X-Gm-Message-State: AOJu0YypXbxZ8mxy1bvExgNNaTHLd6nXuMMWZMZzM2sKaFP6i6OExmMh
	5Wl+io13/XhfDyrvNnNyjcTzlgsPDdvczVbAuu6OSDZ5X2Q1zWCCYKl6HA==
X-Google-Smtp-Source: AGHT+IHogYcqSYtX/zIURfwhKx20DeCSWQtaxBC7FySOMmL12p+KGYDxrs682uJPn9sjkjRokg6PZg==
X-Received: by 2002:a05:600c:1391:b0:418:f770:ba0 with SMTP id 5b1f17b1804b1-42108960933mr57995435e9.0.1716752826756;
        Sun, 26 May 2024 12:47:06 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100ef1207sm117550055e9.10.2024.05.26.12.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 May 2024 12:47:06 -0700 (PDT)
Message-ID: <c4050a37-ecc9-462c-9772-65e25166f439@grimberg.me>
Date: Sun, 26 May 2024 22:47:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Subject: blktests nvme 041,042 leak memory
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240526_124710_359658_FEBAED09 
X-CRM114-Status: UNSURE (   4.56  )
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

Just noticed that these tests generate a kmemleak complaint.

--
[ 1889.516324] kmemleak: 2 new suspected memory leaks (see 
/sys/kernel/debug/kmemleak)
[13221.498042] loop6: detected capacity change from 0 to 8
^C
root@nvme:~# cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff91488fb07200 (size 256):
   comm "nvme", pid 29344, jiffies 4295069699
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 08 72 b0 8f 48 91 ff ff .........r..H...
     08 72 b0 8f 48 91 ff ff 00 d6 55 a2 ff ff ff ff .r..H.....U.....
   backtrace (crc 36f6c278):
     [<ffffffffa2b8b46a>] kmemleak_alloc+0x4a/0x90
     [<ffffffffa1e57897>] kmalloc_trace+0x2f7/0x3a0
     [<ffffffffa2562fd0>] device_add+0x510/0x8c0
     [<ffffffffa1ee5b9e>] cdev_device_add+0x4e/0xc0
     [<ffffffffc133b7a0>] nvme_init_ctrl+0x360/0x460 [nvme_core]
     [<ffffffffc13b0af6>] 0xffffffffc13b0af6
     [<ffffffffc120e565>] 0xffffffffc120e565
     [<ffffffffa1edeb14>] vfs_write+0x104/0x490
     [<ffffffffa1edf263>] ksys_write+0x73/0x100
     [<ffffffffa1edf319>] __x64_sys_write+0x19/0x30
     [<ffffffffa1a0553e>] x64_sys_call+0x7e/0x25c0
     [<ffffffffa2b7be01>] do_syscall_64+0x71/0x130
     [<ffffffffa2c0012b>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff91488ed7ea00 (size 256):
   comm "nvme", pid 37478, jiffies 4295155857
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 08 ea d7 8e 48 91 ff ff ............H...
     08 ea d7 8e 48 91 ff ff 00 d6 55 a2 ff ff ff ff ....H.....U.....
   backtrace (crc fc1acf5):
     [<ffffffffa2b8b46a>] kmemleak_alloc+0x4a/0x90
     [<ffffffffa1e57897>] kmalloc_trace+0x2f7/0x3a0
     [<ffffffffa2562fd0>] device_add+0x510/0x8c0
     [<ffffffffa1ee5b9e>] cdev_device_add+0x4e/0xc0
     [<ffffffffc133b7a0>] nvme_init_ctrl+0x360/0x460 [nvme_core]
     [<ffffffffc13707b7>] 0xffffffffc13707b7
     [<ffffffffc120e565>] 0xffffffffc120e565
     [<ffffffffa1edeb14>] vfs_write+0x104/0x490
     [<ffffffffa1edf263>] ksys_write+0x73/0x100
     [<ffffffffa1edf319>] __x64_sys_write+0x19/0x30
     [<ffffffffa1a0553e>] x64_sys_call+0x7e/0x25c0
     [<ffffffffa2b7be01>] do_syscall_64+0x71/0x130
     [<ffffffffa2c0012b>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
--

The culprit is when failing after device_initialize/cdev_device_add...
Thought I'd share it as I'm not going to address it today.

