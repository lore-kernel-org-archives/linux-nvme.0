Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A81D2F7DA
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 02:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Tf28K5E4lgzSS0A4NL9imRolfl4JXdC2fdNdBxBJiE=; b=m3JQuebxG3cOACJ2PBgsBedO7k
	xJGCFXDOV4deT1/uDgqvssSzGgtWgBIcwrOOK4ZjeaAecfPSQPmph5SwoXLthjUXl0wNc7Qq19B6r
	Fx0LXCDmfdJb3wN3ZkyV1sHPoNnUlHb3emtFmDc2d5BYDE1R8uFjsJUaGgJgay3E77SjwfbmyE0/D
	WZTLbVtw+BPXhmK0gDOv09kUkNXZzEt4MuD3VpF4BjiaAUI4kyp6MTmuxVdeLFbmZRnSwb7b5HZ9z
	8Zd85NWty7yyrh34zuaYZlwYMGMZFcFiGFrj8I/DooXAIrFr2HTxjXaaZ8U+wthzpwadZI71RsZRm
	LIpyFR5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Fxx-0000000DWSz-2NWJ;
	Thu, 17 Oct 2024 02:10:17 +0000
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Fxt-0000000DWSQ-09Yp
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 02:10:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729131006; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3Tf28K5E4lgzSS0A4NL9imRolfl4JXdC2fdNdBxBJiE=;
	b=eneEzsklnbFIdd+HTJNBQoIu7pFmmyxBpQaGiG6kEu0knZ8B3LMaJLdWQ6pEUFtc4tkec2WKfM8MCi/DcwfNIv8BV+b2+4K1gn4/XCKvYXwHG5f5AzDiLX04WW5LbVGp6UzWvlPwGbAQM7hASpikUTI3Jn3YFINTPwGRIjOBUe8=
Received: from 30.178.81.188(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WHJ4bHj_1729131003 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Oct 2024 10:10:04 +0800
Message-ID: <be9350cf-e713-4b2f-928c-099952ca884e@linux.alibaba.com>
Date: Thu, 17 Oct 2024 10:10:02 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v15 2/2] nvmet: support reservation feature
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: hch <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "kch@nvidia.com" <kch@nvidia.com>,
 "d.bogdanov@yadro.com" <d.bogdanov@yadro.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20241014061045.62436-1-kanie@linux.alibaba.com>
 <20241014061045.62436-3-kanie@linux.alibaba.com>
 <4l5bcjto47t7zb7ztnhyw2p4l6ygo3rcefgthgnformc6dofkw@j6j7w5vwazve>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <4l5bcjto47t7zb7ztnhyw2p4l6ygo3rcefgthgnformc6dofkw@j6j7w5vwazve>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241016_191013_569585_60046C70 
X-CRM114-Status: GOOD (  20.21  )
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


在 2024/10/16 14:59, Shinichiro Kawasaki 写道:
> On Oct 14, 2024 / 14:10, Guixin Liu wrote:
>> This patch implements the reservation feature, including:
>>    1. reservation register(register, unregister and replace).
>>    2. reservation acquire(acquire, preempt, preempt and abort).
>>    3. reservation release(release and clear).
>>    4. reservation report.
>>    5. set feature and get feature of reservation notify mask.
>>    6. get log page of reservation event.
>>
>> Not supported:
>>    1. persistent reservation through power loss.
>>
>> Test cases:
>>    Use nvme-cli and fio to test all implemented sub features:
>>    1. use nvme resv-register to register host a registrant or
>>       unregister or replace a new key.
>>    2. use nvme resv-acquire to set host to the holder, and use fio
>>       to send read and write io in all reservation type. And also
>>       test preempt and "preempt and abort".
>>    3. use nvme resv-report to show all registrants and reservation
>>       status.
>>    4. use nvme resv-release to release all registrants.
>>    5. use nvme get-log to get events generated by the preceding
>>       operations.
>>
>> In addition, make reservation configurable, one can set ns to
>> support reservation before enable ns. The default of resv_enable
>> is false.
> Hello Guixin. To test the blktests patches for the reservation feature, I
> applied this patch series on top of v6.1-rc3 kernel with lockdep enabled. When I
> ran the blktests test case nvme/004, I observed the kernel message "INFO: trying
> to register non-static key" [1]. I think the call trace indicates that the
> nvmet_ctrl_destroy_pr() calls xa_erase() for uninitialized ns->pr_per_ctrl_refs.
>
> [...]
>
>> +void nvmet_ctrl_destroy_pr(struct nvmet_ctrl *ctrl)
>> +{
>> +	struct nvmet_pr_per_ctrl_ref *pc_ref;
>> +	struct nvmet_ns *ns;
>> +	unsigned long idx;
>> +
>> +	kfifo_free(&ctrl->pr_log_mgr.log_queue);
>> +	mutex_destroy(&ctrl->pr_log_mgr.lock);
>> +
>> +	xa_for_each(&ctrl->subsys->namespaces, idx, ns) {
>                 if (!ns->pr.enable)
>                         continue;
>
> I added the two lines above here, and the INFO message disappeared. Please
> check if this change makes sense.

Yeah, I miss pr is not enable here, I will fix this and send a v16.

Thanks very much.

Best Regards,

Guixin Liu

>> +		pc_ref = xa_erase(&ns->pr_per_ctrl_refs, ctrl->cntlid);
>> +		if (pc_ref)
>> +			percpu_ref_exit(&pc_ref->ref);
>> +		kfree(pc_ref);
>> +	}
>> +}
>
> [1]
>
> [   39.842700] [   T1002] run blktests nvme/004 at 2024-10-16 15:24:52
> [   39.901831] [   T1046] loop0: detected capacity change from 0 to 2097152
> [   39.920817] [   T1049] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [   40.001028] [    T107] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> [   40.005448] [   T1056] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.
> [   40.007399] [   T1056] nvme nvme1: creating 4 I/O queues.
> [   40.009800] [   T1056] nvme nvme1: new ctrl: "blktests-subsystem-1"
> [   40.178428] [   T1078] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [   40.286197] [   T1078] INFO: trying to register non-static key.
> [   40.287630] [   T1078] The code is fine but needs lockdep annotation, or maybe
> [   40.288482] [   T1078] you didn't initialize this object before use?
> [   40.288930] [   T1078] turning off the locking correctness validator.
> [   40.289382] [   T1078] CPU: 3 UID: 0 PID: 1078 Comm: nvme Not tainted 6.12.0-rc3+ #338
> [   40.289942] [   T1078] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
> [   40.290624] [   T1078] Call Trace:
> [   40.290866] [   T1078]  <TASK>
> [   40.291078] [   T1078]  dump_stack_lvl+0x6a/0x90
> [   40.291414] [   T1078]  register_lock_class+0xe2a/0x10a0
> [   40.291790] [   T1078]  ? __lock_acquire+0xd1b/0x5f20
> [   40.292212] [   T1078]  ? __pfx_register_lock_class+0x10/0x10
> [   40.292619] [   T1078]  __lock_acquire+0x81e/0x5f20
> [   40.292970] [   T1078]  ? lock_is_held_type+0xd5/0x130
> [   40.293331] [   T1078]  ? find_held_lock+0x2d/0x110
> [   40.293679] [   T1078]  ? __pfx___lock_acquire+0x10/0x10
> [   40.294053] [   T1078]  ? lock_release+0x460/0x7a0
> [   40.294389] [   T1078]  ? __pfx_lock_release+0x10/0x10
> [   40.294752] [   T1078]  lock_acquire.part.0+0x12d/0x360
> [   40.295118] [   T1078]  ? xa_erase+0xd/0x30
> [   40.295412] [   T1078]  ? __pfx_lock_acquire.part.0+0x10/0x10
> [   40.295818] [   T1078]  ? rcu_is_watching+0x11/0xb0
> [   40.296161] [   T1078]  ? trace_lock_acquire+0x12f/0x1a0
> [   40.296531] [   T1078]  ? __pfx___flush_work+0x10/0x10
> [   40.296895] [   T1078]  ? xa_erase+0xd/0x30
> [   40.297187] [   T1078]  ? lock_acquire+0x2d/0xc0
> [   40.297509] [   T1078]  ? xa_erase+0xd/0x30
> [   40.297805] [   T1078]  _raw_spin_lock+0x2f/0x40
> [   40.298130] [   T1078]  ? xa_erase+0xd/0x30
> [   40.298421] [   T1078]  xa_erase+0xd/0x30
> [   40.298705] [   T1078]  nvmet_ctrl_destroy_pr+0x10e/0x1c0 [nvmet]
> [   40.299148] [   T1078]  ? rcu_is_watching+0x11/0xb0
> [   40.299492] [   T1078]  ? __pfx_nvmet_ctrl_destroy_pr+0x10/0x10 [nvmet]
> [   40.300676] [   T1078]  ? __pfx___might_resched+0x10/0x10
> [   40.301908] [   T1078]  nvmet_ctrl_free+0x2f0/0x830 [nvmet]
> [   40.303178] [   T1078]  ? lockdep_hardirqs_on+0x78/0x100
> [   40.304462] [   T1078]  ? __pfx_nvmet_ctrl_free+0x10/0x10 [nvmet]
> [   40.305771] [   T1078]  ? __pfx___cancel_work+0x10/0x10
> [   40.306974] [   T1078]  ? kfree+0x13e/0x4a0
> [   40.308051] [   T1078]  nvmet_sq_destroy+0x1f2/0x3a0 [nvmet]
> [   40.309248] [   T1078]  ? __pfx_sysfs_kf_write+0x10/0x10
> [   40.310396] [   T1078]  nvme_loop_destroy_admin_queue+0x6b/0x90 [nvme_loop]
> [   40.311701] [   T1078]  nvme_do_delete_ctrl+0x149/0x160 [nvme_core]
> [   40.312949] [   T1078]  nvme_delete_ctrl_sync.cold+0x8/0xd [nvme_core]
> [   40.314194] [   T1078]  nvme_sysfs_delete+0x92/0xb0 [nvme_core]
> [   40.315355] [   T1078]  kernfs_fop_write_iter+0x39e/0x5a0
> [   40.316466] [   T1078]  vfs_write+0x5e1/0xe70
> [   40.317475] [   T1078]  ? __pfx_vfs_write+0x10/0x10
> [   40.318497] [   T1078]  ? lockdep_hardirqs_on+0x78/0x100
> [   40.319550] [   T1078]  ? __call_rcu_common.constprop.0+0x345/0xed0
> [   40.320697] [   T1078]  ? __pfx___call_rcu_common.constprop.0+0x10/0x10
> [   40.321870] [   T1078]  ksys_write+0xf7/0x1d0
> [   40.322828] [   T1078]  ? __pfx_ksys_write+0x10/0x10
> [   40.323842] [   T1078]  do_syscall_64+0x93/0x180
> [   40.324814] [   T1078]  ? do_syscall_64+0x9f/0x180
> [   40.325788] [   T1078]  ? lockdep_hardirqs_on_prepare+0x16d/0x400
> [   40.326875] [   T1078]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   40.327958] [   T1078] RIP: 0033:0x7fdf35a1d984
> [   40.328906] [   T1078] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d c5 06 0e 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
> [   40.331891] [   T1078] RSP: 002b:00007ffce23c3ed8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> [   40.333291] [   T1078] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fdf35a1d984
> [   40.334651] [   T1078] RDX: 0000000000000001 RSI: 00007fdf35b40ed1 RDI: 0000000000000003
> [   40.336058] [   T1078] RBP: 00007fdf35b40ed1 R08: 0000000000000200 R09: 00000000ffffffff
> [   40.337426] [   T1078] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000037510610
> [   40.338802] [   T1078] R13: 00007ffce23c56c5 R14: 0000000037510610 R15: 0000000037510eb0
> [   40.340178] [   T1078]  </TASK>

