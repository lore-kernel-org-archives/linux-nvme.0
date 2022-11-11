Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF7BC4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Nov 2022 21:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xe9Tg8mBag1I2EiX2sCdTHOOHGBBZ0w1BlbKDfErPc0=; b=hhl1aInRzaPinbEy/BLFEUXQ3U
	psgPCz5kZTEDDAIX4gCVmF5KKdFu6KHGhSn4wWUMuQ0SecAPYDkFUDTjHOYbrt6hqhS0epXR9yqzL
	h8WBw3a42O1tfFbKqr+Wx0i3BDfdx1NycI5W8q5Wxu68GCUb3SPjnRMqc4hQXOKQAoDFXxlMkUStL
	xQnUy0PB4MNb23bKOdsuKm/aHMw59ZoA6fRYaB0UMJLbdbYTeEyXymFVTTLon5KUm08cbMnH8hULt
	bJXgRvV5kJWMyJcPYTUkNhSVvIik5J85+taAlgUfhYfqZpV7N6UpH0PzJSywlP3swetrgNcfrvjqz
	maGCytig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1otbvD-001JoB-Kf; Fri, 11 Nov 2022 21:50:47 +0000
Received: from out0.migadu.com ([2001:41d0:2:267::])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1otbv7-001Jlw-E5
	for linux-nvme@lists.infradead.org; Fri, 11 Nov 2022 21:50:43 +0000
Message-ID: <d4a25dc1-fd2b-8f25-9ec1-04b28dfac386@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1668203436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xe9Tg8mBag1I2EiX2sCdTHOOHGBBZ0w1BlbKDfErPc0=;
	b=bbwyUTRPkcCMc+vyJrmn0ctAVwNybnasLzGlN8E//2rvGc2Icw7c/NvRddYfnxYBW6Hah0
	EBJr9VjFKwfJHbLnVja+tG1MKyxFAdc5ZBxwtmJI/R86z9X7EBavfeeObeMJ1yeGvOcm+i
	QcNpMezfSiFpTc8X7OISL1Tc5FjEvmk=
Date: Fri, 11 Nov 2022 14:50:33 -0700
MIME-Version: 1.0
Content-Language: en-US
To: Keith Busch <kbusch@fb.com>, hch@lst.de, Sagi Grimberg
 <sagi@grimberg.me>, linux-nvme@lists.infradead.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: Resets during user commands leads to hung task and controller stuck
 in connecting
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221111_135042_501773_427AF57D 
X-CRM114-Status: UNSURE (   4.14  )
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

Hi,

I'm (again) seeing a hung task when doing resets and formats simultaneously.
Controller state is left in 'connecting'

Using nvme.git/nvme-6.2 as of 'nvme: implement the DEAC bit for the Write Zeroes command',
but I have also repro'd with Christoph's latest reset/probe-split set


ctrl="nvme0"
nsid=1
pci="/sys/block/${ctrl}n${nsid}/device/"
echo 30 > /proc/sys/kernel/hung_task_timeout_secs
while true; do
        nvme format -f /dev/${ctrl}n${nsid} &
        echo 1 > $pci/reset_controller &
done


[   79.195862] nvme nvme0: Ignoring bogus Namespace Identifiers
[  122.378580] INFO: task sh:7737 blocked for more than 30 seconds.
[  122.380329]       Not tainted 6.1.0-rc2+ #87
[  122.381594] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  122.383782] task:sh              state:D stack:0     pid:7737  ppid:1      flags:0x00000004
[  122.386078] Call Trace:
[  122.386909]  <TASK>
[  122.387659]  __schedule+0x320/0xb10
[  122.388772]  ? lock_release+0x22b/0x450
[  122.389920]  ? lock_acquired+0x1a2/0x400
[  122.391094]  ? wait_for_completion+0x83/0x160
[  122.392358]  schedule+0x53/0xd0
[  122.393337]  schedule_timeout+0x310/0x3b0
[  122.394517]  ? rcu_read_lock_held_common+0xe/0x50
[  122.395847]  ? rcu_read_lock_sched_held+0x23/0x80
[  122.397189]  ? lock_release+0x22b/0x450
[  122.398336]  ? lock_acquired+0x1a2/0x400
[  122.399484]  ? wait_for_completion+0x83/0x160
[  122.400763]  wait_for_completion+0xb5/0x160
[  122.401968]  __flush_work+0x293/0x4a0
[  122.403068]  ? flush_workqueue_prep_pwqs+0x120/0x120
[  122.404463]  ? rcu_read_lock_sched_held+0x23/0x80
[  122.405791]  ? trace_hardirqs_on+0x2b/0xd0
[  122.406977]  nvme_reset_ctrl_sync+0x2a/0x40 [nvme_core]
[  122.408473]  nvme_sysfs_reset+0x12/0x30 [nvme_core]
[  122.409856]  kernfs_fop_write_iter+0x142/0x1e0
[  122.411137]  vfs_write+0x357/0x4f0
[  122.412161]  ksys_write+0x5f/0xe0
[  122.413172]  do_syscall_64+0x3a/0x90
[  122.414238]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  122.415646] RIP: 0033:0x7f7980ced648
[  122.416710] RSP: 002b:00007ffc01ee6778 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  122.418794] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f7980ced648
[  122.420673] RDX: 0000000000000002 RSI: 0000563b40d93ca0 RDI: 0000000000000001
[  122.422550] RBP: 0000563b40d93ca0 R08: 000000000000000a R09: 00007f7980d3cda0
[  122.424385] R10: 000000000000000a R11: 0000000000000246 R12: 00007f7980fc06e0
[  122.426232] R13: 0000000000000002 R14: 00007f7980fbb880 R15: 0000000000000002
[  122.428067]  </TASK>
[  122.428821] INFO: lockdep is turned off.



