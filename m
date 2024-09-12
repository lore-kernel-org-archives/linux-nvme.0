Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED50EEB585
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 10:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yHJgICxWqQM0Ii90PasyqequifQXjylHWWr5/BUgMqw=; b=RhqNfqtjROjh+1tWCNrmYtWxoI
	P/mrJQnffJLBwa+aNMH27QqwlIAjcS8M8kllUEPioopEplK6TT5KLDYct6iytYrcbJ5aZUg/Te0r9
	SmOlFxwJqjUpd7Vwjo3xTDeCd2IXTDKGHOLDBq7GA0l+NBXFxPVwCvCP7isVfobpgiPbKgrOrbY4f
	o62Md7dzrA6Dd/IMT4cdatFietmilumbHI8qsWc1Zgo36sqQo/NiQCO+7Or5m/08JR2HfW34a/k92
	DXLFgd4BdmosV7icZbtz5SQi/U0b3CBBOqmBde3atg7vTIHnePoiXkp44Xpg1gSOBN63vJ/z+68qJ
	CI0gNzLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sogwc-0000000Cg6Q-2SYj;
	Thu, 12 Sep 2024 10:20:58 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sogwa-0000000Cg5G-0YNG
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 10:20:57 +0000
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-378c16a4d3eso945696f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 12 Sep 2024 03:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726136454; x=1726741254;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yHJgICxWqQM0Ii90PasyqequifQXjylHWWr5/BUgMqw=;
        b=A6TitFDobs8m+ZHnT41tUqcWgSrB2e0nAV6xGrSS+34pCM+La4wGrK8VJEqFaAzo7W
         Yvc0JzxeQOQWL3iqBw3OFHz8+82V5Kbp1ExzRavNaM/rQwQG28mSIWPjxoR2tbA/88uv
         XPr8l+WecTqsqRB1AMB9LxyxL05wKcA9Ki84wSjbSfaW3P06MNPAKkyg5mfmssM+lZ/b
         eJi2/g1Upu1XLpOG3OndRnMcxkvaKT5auA46peRWU8JSQWve05JIBr2kxglVP6Pbd0fD
         CTP1hXSaM1GYwCffiqTyOSrOxvqay4s8g5SRthZ3mfohcKdK6yjmjux0djh2X5CSHrSR
         ndAg==
X-Forwarded-Encrypted: i=1; AJvYcCUIFUpqL32t7fwSCz0v+6+MZ49mbDop9q/ON4LOzdNLI+oX2cUWPuANLs+ggg5gjE0cqGNe6+afaGHm@lists.infradead.org
X-Gm-Message-State: AOJu0YxGn2I2DCjv4aG6koibzCehEXC2Je/GQzqhKcTrzSefxps0WMCS
	mBRZZGUBsgMjhBJeQosWRyxMD9Lb7G7fXLyH+Znu28Ljjq0FlzkXVIKyw5ab
X-Google-Smtp-Source: AGHT+IGyzyCfO2ECotXxLrSy5jCdJYZxNKsa6CkHQaxRQMCiELjwU4cVMtCnUwMB55Cei6zuVdo9OQ==
X-Received: by 2002:a05:6000:1cc:b0:374:c7d2:4d76 with SMTP id ffacd0b85a97d-378c2d57c2bmr1841812f8f.50.1726136453681;
        Thu, 12 Sep 2024 03:20:53 -0700 (PDT)
Received: from [10.100.102.74] (89-138-71-253.bb.netvision.net.il. [89.138.71.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb81611sm170772575e9.32.2024.09.12.03.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 03:20:53 -0700 (PDT)
Message-ID: <1eefa343-e2c3-4a50-8bce-16b451bea3cf@grimberg.me>
Date: Thu, 12 Sep 2024 13:20:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: tcp: avoid race between lock and destroy of
 queue_lock
To: Hannes Reinecke <hare@suse.de>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
 Martin Belanger <martin.belanger@dell.com>,
 Christoph Hellwig <hch@infradead.org>
References: <20240912062707.1759715-1-shinichiro.kawasaki@wdc.com>
 <f32b1c7f-4c63-4333-9f43-f777115de9ce@grimberg.me>
 <0a699cf1-66a1-4793-874d-05902149f727@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <0a699cf1-66a1-4793-874d-05902149f727@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_032056_200209_63032445 
X-CRM114-Status: GOOD (  21.17  )
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




On 12/09/2024 12:16, Hannes Reinecke wrote:
> On 9/12/24 08:59, Sagi Grimberg wrote:
>>
>>
>>
>> On 12/09/2024 9:27, Shin'ichiro Kawasaki wrote:
>>> Commit 76d54bf20cdc ("nvme-tcp: don't access released socket during
>>> error recovery") added a mutex_lock() call for the queue->queue_lock
>>> in nvme_tcp_get_address(). However, the mutex_lock() races with
>>> mutex_destroy() in nvme_tcp_free_queue(), and causes the WARN below.
>>>
>>> DEBUG_LOCKS_WARN_ON(lock->magic != lock)
>>> WARNING: CPU: 3 PID: 34077 at kernel/locking/mutex.c:587 
>>> __mutex_lock+0xcf0/0x1220
>>> Modules linked in: nvmet_tcp nvmet nvme_tcp nvme_fabrics iw_cm ib_cm 
>>> ib_core pktcdvd nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib 
>>> nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct 
>>> nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 
>>> ip_set nf_tables qrtr sunrpc ppdev 9pnet_virtio 9pnet pcspkr netfs 
>>> parport_pc parport e1000 i2c_piix4 i2c_smbus loop fuse nfnetlink 
>>> zram bochs drm_vram_helper drm_ttm_helper ttm drm_kms_helper xfs drm 
>>> sym53c8xx floppy nvme scsi_transport_spi nvme_core nvme_auth 
>>> serio_raw ata_generic pata_acpi dm_multipath qemu_fw_cfg [last 
>>> unloaded: ib_uverbs]
>>> CPU: 3 UID: 0 PID: 34077 Comm: udisksd Not tainted 6.11.0-rc7 #319
>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
>>> 1.16.3-2.fc40 04/01/2014
>>> RIP: 0010:__mutex_lock+0xcf0/0x1220
>>> Code: 08 84 d2 0f 85 c8 04 00 00 8b 15 ef b6 c8 01 85 d2 0f 85 78 f4 
>>> ff ff 48 c7 c6 20 93 ee af 48 c7 c7 60 91 ee af e8 f0 a7 6d fd <0f> 
>>> 0b e9 5e f4 ff ff 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1
>>> RSP: 0018:ffff88811305f760 EFLAGS: 00010286
>>> RAX: 0000000000000000 RBX: ffff88812c652058 RCX: 0000000000000000
>>> RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
>>> RBP: ffff88811305f8b0 R08: 0000000000000001 R09: ffffed1075c36341
>>> R10: ffff8883ae1b1a0b R11: 0000000000010498 R12: 0000000000000000
>>> R13: 0000000000000000 R14: dffffc0000000000 R15: ffff88812c652058
>>> FS:  00007f9713ae4980(0000) GS:ffff8883ae180000(0000) 
>>> knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 00007fcd78483c7c CR3: 0000000122c38000 CR4: 00000000000006f0
>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> Call Trace:
>>>   <TASK>
>>>   ? __warn.cold+0x5b/0x1af
>>>   ? __mutex_lock+0xcf0/0x1220
>>>   ? report_bug+0x1ec/0x390
>>>   ? handle_bug+0x3c/0x80
>>>   ? exc_invalid_op+0x13/0x40
>>>   ? asm_exc_invalid_op+0x16/0x20
>>>   ? __mutex_lock+0xcf0/0x1220
>>>   ? nvme_tcp_get_address+0xc2/0x1e0 [nvme_tcp]
>>>   ? __pfx___mutex_lock+0x10/0x10
>>>   ? __lock_acquire+0xd6a/0x59e0
>>>   ? nvme_tcp_get_address+0xc2/0x1e0 [nvme_tcp]
>>>   nvme_tcp_get_address+0xc2/0x1e0 [nvme_tcp]
>>>   ? __pfx_nvme_tcp_get_address+0x10/0x10 [nvme_tcp]
>>>   nvme_sysfs_show_address+0x81/0xc0 [nvme_core]
>>>   dev_attr_show+0x42/0x80
>>>   ? __asan_memset+0x1f/0x40
>>>   sysfs_kf_seq_show+0x1f0/0x370
>>>   seq_read_iter+0x2cb/0x1130
>>>   ? rw_verify_area+0x3b1/0x590
>>>   ? __mutex_lock+0x433/0x1220
>>>   vfs_read+0x6a6/0xa20
>>>   ? lockdep_hardirqs_on+0x78/0x100
>>>   ? __pfx_vfs_read+0x10/0x10
>>>   ksys_read+0xf7/0x1d0
>>>   ? __pfx_ksys_read+0x10/0x10
>>>   ? __x64_sys_openat+0x105/0x1d0
>>>   do_syscall_64+0x93/0x180
>>>   ? lockdep_hardirqs_on_prepare+0x16d/0x400
>>>   ? do_syscall_64+0x9f/0x180
>>>   ? lockdep_hardirqs_on+0x78/0x100
>>>   ? do_syscall_64+0x9f/0x180
>>>   ? __pfx_ksys_read+0x10/0x10
>>>   ? lockdep_hardirqs_on_prepare+0x16d/0x400
>>>   ? do_syscall_64+0x9f/0x180
>>>   ? lockdep_hardirqs_on+0x78/0x100
>>>   ? do_syscall_64+0x9f/0x180
>>>   ? lockdep_hardirqs_on_prepare+0x16d/0x400
>>>   ? do_syscall_64+0x9f/0x180
>>>   ? lockdep_hardirqs_on+0x78/0x100
>>>   ? do_syscall_64+0x9f/0x180
>>>   ? lockdep_hardirqs_on_prepare+0x16d/0x400
>>>   ? do_syscall_64+0x9f/0x180
>>>   ? lockdep_hardirqs_on+0x78/0x100
>>>   ? do_syscall_64+0x9f/0x180
>>>   ? lockdep_hardirqs_on_prepare+0x16d/0x400
>>>   ? do_syscall_64+0x9f/0x180
>>>   ? lockdep_hardirqs_on+0x78/0x100
>>>   ? do_syscall_64+0x9f/0x180
>>>   ? do_syscall_64+0x9f/0x180
>>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>> RIP: 0033:0x7f9713f55cfa
>>> Code: 55 48 89 e5 48 83 ec 20 48 89 55 e8 48 89 75 f0 89 7d f8 e8 e8 
>>> 74 f8 ff 48 8b 55 e8 48 8b 75 f0 41 89 c0 8b 7d f8 31 c0 0f 05 <48> 
>>> 3d 00 f0 ff ff 77 2e 44 89 c7 48 89 45 f8 e8 42 75 f8 ff 48 8b
>>> RSP: 002b:00007ffd7f512e70 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
>>> RAX: ffffffffffffffda RBX: 000055c38f316859 RCX: 00007f9713f55cfa
>>> RDX: 0000000000000fff RSI: 00007ffd7f512eb0 RDI: 0000000000000011
>>> RBP: 00007ffd7f512e90 R08: 0000000000000000 R09: 00000000ffffffff
>>> R10: 0000000000000000 R11: 0000000000000246 R12: 000055c38f317148
>>> R13: 0000000000000000 R14: 00007f96f4004f30 R15: 000055c3b6b623c0
>>>   </TASK>
>>>
>>> The WARN is observed when the blktests test case nvme/014 is repeated
>>> with tcp transport. It is rare, and 200 times repeat is required to
>>> recreate in my test environment.
>>>
>>> To avoid the WARN, serialize the two functions nvme_tcp_get_address()
>>> and nvme_tcp_free_queue(). Add the flag NVME_TCP_Q_REFERRED and set it
>>> when nvme_tcp_get_address() starts. Have nvme_tcp_free_queue() wait the
>>> flag cleared so that it does not run until nvme_tcp_get_address() ends.
>>> Also check the NVME_TCP_Q_ALLOCATED flag when nvme_tcp_get_address()
>>> starts. This flag is cleared at the nvme_tcp_free_queue() start, 
>>> then it
>>> ensures that nvme_tcp_get_address() is not executed while
>>> nvme_tcp_free_queue() runs.
>>>
>>> Of note is that nvme_tcp_stop_queue() locks the queue->queue_lock in
>>> same manner as nvme_tcp_get_address(). However, 
>>> nvme_tcp_stop_queue() is
>>> called in sequence before nvme_tcp_free_queue(), then it is safe to
>>> assume that the queue->queue_lock is not yet destroyed at
>>> nvme_tcp_stop_queue() call. Therefore this fix does not touch
>>> nvme_tcp_stop_queue().
>>>
>>> Fixes: 76d54bf20cdc ("nvme-tcp: don't access released socket during 
>>> error recovery")
>>> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>> ---
>>>   drivers/nvme/host/tcp.c | 16 +++++++++++++++-
>>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index a2a47d3ab99f..1457ffda207b 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -127,6 +127,7 @@ enum nvme_tcp_queue_flags {
>>>       NVME_TCP_Q_ALLOCATED    = 0,
>>>       NVME_TCP_Q_LIVE        = 1,
>>>       NVME_TCP_Q_POLLING    = 2,
>>> +    NVME_TCP_Q_REFERRED    = 3,
>>>   };
>>>   enum nvme_tcp_recv_state {
>>> @@ -1365,6 +1366,9 @@ static void nvme_tcp_free_queue(struct 
>>> nvme_ctrl *nctrl, int qid)
>>>       if (!test_and_clear_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
>>>           return;
>>> +    wait_on_bit_io(&queue->flags, NVME_TCP_Q_REFERRED,
>>> +               TASK_UNINTERRUPTIBLE);
>>> +
>>>       if (queue->hdr_digest || queue->data_digest)
>>>           nvme_tcp_free_crypto(queue);
>>> @@ -2613,7 +2617,14 @@ static int nvme_tcp_get_address(struct 
>>> nvme_ctrl *ctrl, char *buf, int size)
>>>   {
>>>       struct nvme_tcp_queue *queue = &to_tcp_ctrl(ctrl)->queues[0];
>>>       struct sockaddr_storage src_addr;
>>> -    int ret, len;
>>> +    int ret, len = 0;
>>> +
>>> +    /* Serialize this function and nvme_tcp_free_queue() */
>>> +    if (test_and_set_bit(NVME_TCP_Q_REFERRED, &queue->flags))
>>> +        return 0;
>>> +
>>> +    if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
>>> +        goto out;
>>>       len = nvmf_get_address(ctrl, buf, size);
>>> @@ -2631,6 +2642,9 @@ static int nvme_tcp_get_address(struct 
>>> nvme_ctrl *ctrl, char *buf, int size)
>>>   done:
>>>       mutex_unlock(&queue->queue_lock);
>>> +out:
>>> +    clear_and_wake_up_bit(NVME_TCP_Q_REFERRED, &queue->flags);
>>> +
>>>       return len;
>>>   }
>>
>> This is really not needed.. You can already serialize with:
>> -- 
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index a2a47d3ab99f..91c19d06cae9 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -1365,6 +1365,10 @@ static void nvme_tcp_free_queue(struct 
>> nvme_ctrl *nctrl, int qid)
>>          if (!test_and_clear_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
>>                  return;
>>
>> +       /* make sure any concurrent .get_address completes */
>> +       mutex_lock(&queue->queue_lock);
>> +       mutex_unlock(&queue->queue_lock);
>> +
>>          if (queue->hdr_digest || queue->data_digest)
>>                  nvme_tcp_free_crypto(queue);
>
> Wouldn't it be sufficient to check for NVME_TCP_Q_LIVE outside of the 
> mutex?

I think its intentional, so this serializes against nvme_tcp_stop_queue()

