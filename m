Return-Path: <SRS0=DxE/=PW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E215DC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 09:28:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A29086112D
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 09:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A29086112D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fhOHc1uBB2RK51TvnKXb0tWy+auOqKG95dnpI2t4cZ4=; b=cl9tdu1Bcn8TOfI1lbZDIf6B2X
	XeilqR8/p+xEHwvtNHSbPz+dpn1uYIUxUUAlBD1bPUZeSBFzRQ1Ih6B15hF5/XM6pkzifpY4mv5Xq
	zrRbsz1vNRqH0HYe4kKszN2rItHhULdcKWGygdkewh9IJ5mvBccOeIINzwhwKOyHI7POMtzJqbsJb
	7aaQhayOv/cx4FHN2qUPVTcJf0Vu6Bh3iEK0ytRCPYhIhKwDSXAstIDrziCXovQ0U5aIPYZSkBns4
	BbwbWYaZWAJJa5BkzDwGeI989nwqY8uZm/pWvvgB3A9nAkBRBI+QcsehkDyExGDPce8XclFU9E9Z9
	3XSMhzaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1miCZV-004ikf-Sf; Wed, 03 Nov 2021 09:28:41 +0000
Received: from mail-ed1-f50.google.com ([209.85.208.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1miCZS-004ijB-ND
 for linux-nvme@lists.infradead.org; Wed, 03 Nov 2021 09:28:40 +0000
Received: by mail-ed1-f50.google.com with SMTP id w1so6778449edd.10
 for <linux-nvme@lists.infradead.org>; Wed, 03 Nov 2021 02:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fhOHc1uBB2RK51TvnKXb0tWy+auOqKG95dnpI2t4cZ4=;
 b=SuDWo7jxzJf9rmxLeyxBzvYvHYC4ZYZK/f9vuTUJr/1/NGtq0dzWhGE5TFSEFvkZc6
 mDlPJdvnjOHfp1XUrEXmwhtQNpga11vLbITOvfUtK++0/V+WiQlqYjordfrbOG8CCuqo
 AH6rUugMTT/nG4IoTQOgpvOLjWuhJ9FORhbgUvB3w6NVWcsAX/UpjUDiG3M6oQQFdgG7
 Ic5n0hmkeF8kC3+TC07prIgyHpVla6EvQ6TXeiANhsfCSpzOyzzg0WJ9Qknc8HxIMFuo
 fEWN7LY3zl8PD9wBEV7CHnuRpJhFmewh3cUyH52tsN9bilePjDh+FMuZLI1oSvJtqdgh
 BHRQ==
X-Gm-Message-State: AOAM531CXCS9X1f96TZPgKE176fvPCosTXlnzK0BqpP3/7BakLajk6AH
 PzHB2A+yhf5sJQAonEOjvwwjAWyNnOU=
X-Google-Smtp-Source: ABdhPJwodJ4aVzCfyP3AxXqZO0JVZEa7ZVw7mHgq4IVV5SmUm0x9a2D4ZJ1gAZWbcgo4UWoKaLZS6g==
X-Received: by 2002:a05:6402:348d:: with SMTP id
 v13mr21298877edc.337.1635931717231; 
 Wed, 03 Nov 2021 02:28:37 -0700 (PDT)
Received: from [10.100.102.14] (109-186-251-144.bb.netvision.net.il.
 [109.186.251.144])
 by smtp.gmail.com with ESMTPSA id x3sm1031704edd.67.2021.11.03.02.28.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Nov 2021 02:28:36 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvmet: fix a race condition between release_queue and
 io_work
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, hare@suse.de,
 chaitanya.kulkarni@wdc.com, jmeneghi@redhat.com
References: <20211021084155.16109-1-mlombard@redhat.com>
 <20211021084155.16109-3-mlombard@redhat.com>
 <54e0464e-0d05-4611-10d9-7b706900af28@grimberg.me>
 <20211028075531.GA4904@raketa>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <68b69eee-c08c-a449-7e18-96e67a3c0c9d@grimberg.me>
Date: Wed, 3 Nov 2021 11:28:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211028075531.GA4904@raketa>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211103_022838_808459_791A12CA 
X-CRM114-Status: GOOD (  33.44  )
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



On 10/28/21 10:55 AM, Maurizio Lombardi wrote:
> Hi Sagi,
> 
> On Tue, Oct 26, 2021 at 06:42:02PM +0300, Sagi Grimberg wrote:
>> On 10/21/21 11:41 AM, Maurizio Lombardi wrote:
>>> If the initiator executes a reset controller operation while
>>> performing I/O, the target kernel will crash because of a race condition
>>> between release_queue and io_work;
>>
>> Can you add the stack trace?
> 
> Yes, this is an example:
> 
> [  526.368376] nvmet: creating controller 1 for subsystem test-nqn for NQN nqn.2014-08.org.nvmexpress:uuid:119cb961-04c6-5845-9ed0-66a692ae0ddd.
> [  526.598367] nvmet: creating controller 2 for subsystem test-nqn for NQN nqn.2014-08.org.nvmexpress:uuid:119cb961-04c6-5845-9ed0-66a692ae0ddd.
> [  526.827356] nvmet: creating controller 1 for subsystem test-nqn for NQN nqn.2014-08.org.nvmexpress:uuid:119cb961-04c6-5845-9ed0-66a692ae0ddd.
> [  526.837836] general protection fault, probably for non-canonical address 0x893b50fb71133fa5: 0000 [#1] SMP PTI
> [  526.840045] CPU: 1 PID: 225 Comm: kworker/1:1H Kdump: loaded Not tainted 5.14.0_nvme1+ #1
> [  526.841814] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> [  526.843064] Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]
> [  526.844398] RIP: 0010:__kmalloc+0xed/0x3f0
> [  526.845300] Code: 08 65 4c 03 05 94 ad 2e 45 49 83 78 10 00 4d 8b 20 0f 84 95 02 00 00 4d 85 e4 0f 84 8c 02 00 00 8b 45 28 48 8b 7d 00 4c 01 e0 <48> 8b 18 48 89 c1 48 33 9d b8 00 00 00 4c 89 e0 48 0f c9 48 31 cb
> [  526.849296] RSP: 0018:ffffaf66c014fc38 EFLAGS: 00010286
> [  526.850427] RAX: 893b50fb71133fa5 RBX: ffff8e1c83f02450 RCX: 0000000000000000
> [  526.851959] RDX: 000000000009de38 RSI: 0000000000000cc0 RDI: 00000000000311c0
> [  526.853496] RBP: ffff8e1d80042e00 R08: ffff8e1eb7d311c0 R09: 0000000000000000
> [  526.855027] R10: 00000000000035ee R11: 0000000000000000 R12: 893b50fb71132fa5
> [  526.856561] R13: 0000000000000cc0 R14: 0000000000000000 R15: ffffffffc072a240
> [  526.858092] FS:  0000000000000000(0000) GS:ffff8e1eb7d00000(0000) knlGS:0000000000000000
> [  526.859804] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  526.860913] CR2: 000055aa6316b0e8 CR3: 0000000052010001 CR4: 00000000007706e0
> [  526.862292] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  526.863658] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  526.865023] PKRU: 55555554
> [  526.865564] Call Trace:
> [  526.866059]  nvmet_tcp_map_data+0xc0/0x110 [nvmet_tcp]
> [  526.867052]  nvmet_tcp_done_recv_pdu+0x13b/0x2b0 [nvmet_tcp]
> [  526.868144]  nvmet_tcp_try_recv_pdu+0x17d/0x210 [nvmet_tcp]
> [  526.869222]  nvmet_tcp_try_recv.constprop.0+0x67/0x300 [nvmet_tcp]
> [  526.870414]  ? inet_sendpage+0x4f/0x80
> [  526.871156]  nvmet_tcp_io_work+0x44/0xa69 [nvmet_tcp]
> [  526.872134]  ? dequeue_task_fair+0xb1/0x370
> [  526.872952]  ? finish_task_switch.isra.0+0xb1/0x290
> [  526.873904]  process_one_work+0x1e6/0x380
> [  526.874694]  worker_thread+0x53/0x3d0
> [  526.875420]  ? process_one_work+0x380/0x380
> [  526.876233]  kthread+0x10f/0x130
> [  526.876872]  ? set_kthread_struct+0x40/0x40
> [  526.877686]  ret_from_fork+0x22/0x30
> 
> if you want to reproduce it just run something like $watch -n 0.1 "echo 1 > reset_controller"
> while you do some I/O with dd
> 
> 
>>
>>> nvmet_tcp_uninit_data_in_cmds() may be executed while io_work
>>> is running, calling flush_work(io_work) was not sufficient to
>>> prevent this because io_work could requeue itself.
>>
>> OK, then this should be sufficient to fix it right?
> 
> with "this" you mean calling cancel_work_sync() before nvmet_tcp_uninit_data_in_cmds()
> and after nvmet_sq_destroy(), without checking sk_user_data in nvmet_tcp_queue_response() ?
> 
> If yes, I tried that; it's not sufficient, it still crashes:
> 
> [  374.050932] nvmet_tcp: failed cmd 00000000ba978688 id 50 opcode 1, data_len: 1310720
> [  374.052699] nvmet_tcp: failed cmd 000000004ba3f36e id 60 opcode 1, data_len: 1310720
> [  374.054465] nvmet_tcp: failed cmd 0000000071ea477d id 61 opcode 1, data_len: 1310720
> [  374.056253] BUG: kernel NULL pointer dereference, address: 000000000000000c
> [  374.057836] #PF: supervisor read access in kernel mode
> [  374.059009] #PF: error_code(0x0000) - not-present page
> [  374.060178] PGD 0 P4D 0
> [  374.060777] Oops: 0000 [#1] SMP PTI
> [  374.061578] CPU: 1 PID: 226 Comm: kworker/1:1H Kdump: loaded Not tainted 5.14.0_nvme1+ #1
> [  374.063427] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> [  374.064749] Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]
> [  374.066137] RIP: 0010:nvmet_tcp_map_pdu_iovec+0x66/0x110 [nvmet_tcp]
> [  374.067573] Code: 00 00 48 c1 e8 0c 41 c1 ef 0c 44 89 bf e8 01 00 00 48 63 c8 49 c1 e7 05 4c 03 7f 30 89 87 ec 01 00 00 85 ed 0f 84 9d 00 00 00 <45> 8b 67 0c 49 8b 1f 45 29 ec 41 39 ec 44 0f 47 e5 48 83 e3 fc 49
> [  374.071780] RSP: 0018:ffffa98c8016fc48 EFLAGS: 00010206
> [  374.072965] RAX: 0000000000000140 RBX: ffff91c1da819208 RCX: 0000000000000140
> [  374.074579] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff91c1da819208
> [  374.076188] RBP: 0000000000140000 R08: 0000000000010230 R09: 0000000000017e3a
> [  374.077788] R10: 0000000000000125 R11: 0000000000000010 R12: 0000000000000000
> [  374.079396] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  374.081004] FS:  0000000000000000(0000) GS:ffff91c2f7d00000(0000) knlGS:0000000000000000
> [  374.082835] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  374.084117] CR2: 000000000000000c CR3: 000000010c79a003 CR4: 00000000007706e0
> [  374.085669] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  374.087147] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  374.088586] PKRU: 55555554
> [  374.089214] Call Trace:
> [  374.089807]  nvmet_tcp_done_recv_pdu+0x24c/0x2b0 [nvmet_tcp]
> [  374.090971]  nvmet_tcp_try_recv_pdu+0x17d/0x210 [nvmet_tcp]
> [  374.092101]  ? update_load_avg+0x7a/0x5a0
> [  374.092969]  nvmet_tcp_try_recv.constprop.0+0x67/0x310 [nvmet_tcp]
> [  374.094323]  ? set_next_entity+0xac/0x1e0
> [  374.095149]  ? pick_next_task_fair+0x18e/0x3b0
> [  374.096057]  nvmet_tcp_io_work+0x44/0xabd [nvmet_tcp]
> [  374.097141]  ? dequeue_task_fair+0xb1/0x370
> [  374.098087]  ? finish_task_switch.isra.0+0xb1/0x290
> [  374.099088]  process_one_work+0x1e6/0x380
> [  374.099922]  worker_thread+0x53/0x3d0
> [  374.100670]  ? process_one_work+0x380/0x380
> [  374.101631]  kthread+0x10f/0x130
> [  374.102336]  ? set_kthread_struct+0x40/0x40
> [  374.103194]  ret_from_fork+0x22/0x30
> [  374.103974] Modules linked in: nvmet_tcp nvmet t10_pi rfkill intel_rapl_msr intel_rapl_common isst_if_common nfit libnvdimm i2c_piix4 pcspkr joydev virtio_balloon drm fuse xfs libcrc32c ata_generic crct10dif_pclmul crc32_pclmul crc32c_intel virtio_net ghash_clmulni_intel net_failover ata_piix virtio_blk libata serio_raw failover dm_mirror dm_region_hash dm_log dm_mod
> [  374.110690] CR2: 000000000000000c
So this means we still get data from the network when
we shouldn't. Maybe we are simply missing a kernel_sock_shutdown
for SHUT_RD?

> 
>>
>>> * Fix this bug by preventing io_work from being enqueued when
>>> sk_user_data is NULL (it means that the queue is going to be deleted)
>>
>> This is triggered from the completion path, where the commands
>> are not in a state where they are still fetching data from the
>> host. How does this prevent the crash?
> 
> io_work is also triggered every time a nvmet_req_init() fails and when
> nvmet_sq_destroy() is called, I am not really sure about the state
> of the commands in those cases.

But that is from the workqueue context - which means that
cancel_work_sync should prevent it right?

> 
> 
>>
>>> * Ensure that all the memory allocated for the commands' iovec is freed
>>
>> How is this needed to prevent a crash?
> 
> It's not really needed to prevent the crash, but without this
> you will see massive memory leaks.
> It happened sometimes that it exhausted the entire system memory
> before hitting the crash.

But that needs to be a separate fix and not combined with other
fixes.

