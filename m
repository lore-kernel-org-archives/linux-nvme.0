Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF20C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Dec 2021 13:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QD8l7YLu811U3wfygcKrUGGmeRfMb4d75ZgmzAhZf48=; b=oNLR8qz1D/5keF36vgvH4KxbhT
	iEnFisYUKimOJ21m6ECVatkeKh7KTzdRf5oBiZxXnF+Po9M7UQI2WtRbp+sj2MGefV2QDz18hvmWS
	me5L/3HYQEYnx205MeYe/doWL339M22K11hUbZbYCglbhNqHIbYsBnb7jQRHutSJxJJYiSTlxJRRS
	WYaY+44UKzVwkFxHUeWwon2VdTgD2/4t+CovIwSS+AhmIg7HZflNEPhZLluObjBi7xU5M74Yrw7ke
	X/c89flP8VQOYlS+kDjuezahd5yNSSvhKHe173qh/XQhEvxwQ0Sqk3KEJb/6CJMUhKD8Tfw/vzc5X
	FfWM5hBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1muwdq-00CekT-JX; Wed, 08 Dec 2021 13:05:50 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1muwdk-00Ceju-Cl
 for linux-nvme@lists.infradead.org; Wed, 08 Dec 2021 13:05:46 +0000
Received: by mail-wm1-f47.google.com with SMTP id o29so1742043wms.2
 for <linux-nvme@lists.infradead.org>; Wed, 08 Dec 2021 05:05:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QD8l7YLu811U3wfygcKrUGGmeRfMb4d75ZgmzAhZf48=;
 b=P9UhNeeoIiPTzV2bqejIFIZLxqBwrBFE+pXypWdCNFFRSbeZYSx9x7jOxJ6TyiLeuZ
 URvfm8GcGajXBZhqg0QtkRkYm0Vgves4ur+9hfj6PBEJCU/UEy9rfsxKk1QjKdYQSJVQ
 DGNF6rD3DRgSVZaI+H6QmtepbVKwUtHY5Ni7YHeEgdSSBt9H3OPPP4fIbwZurI3upvEk
 NC0nYdXhAwydIS0HeQi5Mk4pJpkt4WljustfhD6JzJJfzLc/ocDuWq/s4dur7V/sEqtk
 dztCJai8bsU6bWso4s6U7TaDlbMDOQkrtdRDwlurrY8m5qaD46SopjlnXlJNSeXazS40
 vdnA==
X-Gm-Message-State: AOAM5338W5InZiEv6PbumB7Zd/zv4mHGaxud5yfbj8VgXuPCw43fOyDX
 fVspxojMEUv0Y0jrzfdVD6usHep4lmk=
X-Google-Smtp-Source: ABdhPJyWGSUZTgQrdVg0BYw/OagHPDuRcb1sbYqipd3eVGtK9AaXCZT7jXPm8gPvL6sxVxT2YSPe8A==
X-Received: by 2002:a05:600c:3489:: with SMTP id
 a9mr15969833wmq.53.1638968742194; 
 Wed, 08 Dec 2021 05:05:42 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id l5sm3689153wrs.59.2021.12.08.05.05.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Dec 2021 05:05:41 -0800 (PST)
Subject: Re: [Bug 215157] New: nvme delete-ns over nvme-tcp to nvmet-tcp error
To: Keith Busch <kbusch@kernel.org>, bugzilla-daemon@bugzilla.kernel.org
Cc: linux-nvme@lists.infradead.org
References: <bug-215157-95461@https.bugzilla.kernel.org/>
 <20211129180141.GB3582042@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b006562f-01f7-4359-0d3c-9de346d75241@grimberg.me>
Date: Wed, 8 Dec 2021 15:05:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211129180141.GB3582042@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211208_050544_480783_621E6442 
X-CRM114-Status: GOOD (  25.70  )
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



On 11/29/21 8:01 PM, Keith Busch wrote:
> [adding Sagi & linux-nvme mailing list]
> 
> On Sat, Nov 27, 2021 at 11:24:57PM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
>> https://bugzilla.kernel.org/show_bug.cgi?id=215157
> 
> <snip>
> 
>> Reproduction:
>>
>>
>> modprobe nvmet
>> modprobe nvmet-tcp
>> truncate --size 1G /tmp/foo1.img
>> DEV=$(losetup --find /tmp/foo1.img)
>>
>> mkdir /sys/kernel/config/nvmet/subsystems/testsubsystem
>> cd /sys/kernel/config/nvmet/subsystems/testsubsystem
>> echo 1 > attr_allow_any_host
>> echo "${DEV}" > device_path
>> echo 1 > enable
>>
>> mkdir /sys/kernel/config/nvmet/ports/1
>> cd /sys/kernel/config/nvmet/ports/1
>> echo 4420 > addr_trsvcid
>> echo 127.0.0.1 > addr_traddr
>> echo tcp > addr_trtype
>> echo ipv4 > addr_adrfam
>> ln -s /sys/kernel/config/nvmet/subsystems/testsubsystem/
>> /sys/kernel/config/nvmet/ports/1/subsystems/testsubsystem
>>
>> modprobe nvme-tcp
>> nvme connect -t tcp -n testsubsystem -a 127.0.0.1 -s 4420
>> nvme list
>> nvme delete-ns -n 1 /dev/nvmeX
>>
>>
>> Eventually will finish with Interuptted, but the device will be unusable after
>> this.
>>
>> The nvme-tcp shows issues in dmesg:
>>
>> [10638.139221] nvmet: creating nvm controller 1 for subsystem testsubsystem for
>> NQN nqn.2014-08.org.nvmexpress:uuid:88a968b7-a5d7-4549-aaa8-a31f1d25aa4b.
>> [10638.139677] nvme nvme2: creating 32 I/O queues.
>> [10638.141556] nvme nvme2: mapped 32/0/0 default/read/poll queues.
>> [10638.145884] nvme nvme2: new ctrl: NQN "testsubsystem", addr 127.0.0.1:4420
>> [10678.676734] nvmet_tcp: failed cmd 00000000fdc07f80 id 4100 opcode 13, data_len: 0
>> [10684.129665] nvme nvme2: queue 0: timeout request 0x0 type 4
> 
> The target sees the opcode 13 (0xd) for the delete namespace management
> command and correcty decides it is unsupported, so the request
> initialization fails. Here's where it looks like the target code goes
> wrong:
> 
> nvmet_tcp_try_recv_one
>    nvmet_tcp_done_recv_pdu
>      nvmet_req_init
>        __nvmet_req_complete
>          nvmet_tcp_queue_response <- cmd is added to the queue resp_list
>      nvmet_tcp_handle_req_failure() -> rcv_state set to NVMET_TCP_RECV_DATA, flags set to NVMET_TCP_F_INIT_FAILED

nvmet_tcp_handle_req_failure will not do anything if the command does
not have any incapsule data (which is the case here).

>    nvmet_tcp_try_recv_data
>      nvmet_tcp_execute_request <- sees NVMET_TCP_F_INIT_FAILED
>        nvmet_tcp_queue_response <- cmd is added to the queue resp_list a 2nd time

There is a subtle case here as if this is a command that we are queueing
back is the current command being processed (which is the case if we
want to fail a command that we still need to accept the incapsule
data) we don't attach it to the resp_list. I do agree this is convoluted
and needs a cleaner failure handling...

> 
> That can't be right: the cmd shouldn't be added to the response list
> twice.
> 
> Sagi, am I missing something here?
> 
>> [10684.129673] nvme nvme2: starting error recovery
>> [10684.131074] nvme nvme2: failed nvme_keep_alive_end_io error=10
>> [10684.137695] nvme nvme2: Reconnecting in 10 seconds...
>> [10691.809468] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
>> [10691.809519] nvmet: ctrl 1 fatal error occurred!
>> [10756.832004] nvme nvme2: queue 0: timeout request 0x0 type 4
>> [10756.832137] nvme nvme2: Connect command failed, error wo/DNR bit: 881
>> [10756.832199] nvme nvme2: failed to connect queue: 0 ret=881
>> [10756.832222] nvme nvme2: Failed reconnect attempt 1
>> [10756.832225] nvme nvme2: Reconnecting in 10 seconds...
>> [10814.174824] INFO: task kworker/11:2:11273 blocked for more than 122 seconds.
>> [10814.174832]       Tainted: G            E     5.16.0-rc2 #1
>> [10814.174834] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
>> message.
>> [10814.174835] task:kworker/11:2    state:D stack:    0 pid:11273 ppid:     2
>> flags:0x00004000
>> [10814.174841] Workqueue: events nvmet_tcp_release_queue_work [nvmet_tcp]
>> [10814.174850] Call Trace:
>> [10814.174852]  <TASK>
>> [10814.174855]  __schedule+0x23f/0xe50
>> [10814.174861]  ? update_load_avg+0x77/0x4d0
>> [10814.174866]  schedule+0x50/0xd0
>> [10814.174869]  schedule_timeout+0x99/0xd0
>> [10814.174873]  ? raw_spin_rq_lock_nested+0x19/0x80
>> [10814.174876]  wait_for_completion+0x74/0xc0
>> [10814.174880]  __flush_work.isra.0+0x14b/0x210
>> [10814.174884]  ? flush_workqueue_prep_pwqs+0x110/0x110
>> [10814.174887]  nvmet_tcp_release_queue_work+0xc3/0x330 [nvmet_tcp]
>> [10814.174892]  process_one_work+0x1ad/0x310
>> [10814.174895]  worker_thread+0x48/0x3d0
>> [10814.174899]  ? process_one_work+0x310/0x310
>> [10814.174901]  kthread+0x155/0x180
>> [10814.174904]  ? set_kthread_struct+0x30/0x30
>> [10814.174907]  ret_from_fork+0x1f/0x30
>> [10814.174912]  </TASK>
>> [10830.558291] nvme nvme2: queue 0: timeout request 0x0 type 4
>> [10830.558422] nvme nvme2: Connect command failed, error wo/DNR bit: 881
>> [10830.558484] nvme nvme2: failed to connect queue: 0 ret=881
>> [10830.558507] nvme nvme2: Failed reconnect attempt 2
>> [10830.558510] nvme nvme2: Reconnecting in 10 seconds...
>> [10904.284728] nvme nvme2: queue 0: timeout request 0x0 type 4
>> [10904.284757] nvme nvme2: Connect command failed, error wo/DNR bit: 881
>> [10904.284818] nvme nvme2: failed to connect queue: 0 ret=881
>> [10904.284842] nvme nvme2: Failed reconnect attempt 3
>> [10904.284845] nvme nvme2: Reconnecting in 10 seconds...

The issue here seems to be that the controller fails the command but it
still times out for the host - which suggest that the error response is
not actually queued.

