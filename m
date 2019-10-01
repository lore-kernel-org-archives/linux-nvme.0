Return-Path: <SRS0=wdCx=X2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB39FA373E
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Oct 2019 08:07:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07A722133F
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Oct 2019 08:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gCGB1Poy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="LtDkmyX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A722133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:To:
	Date:Message-Id:Subject:Mime-Version:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IiznXO/LJ7a6Y48wVxhhrDIl5/XRnxg87ZbFRRQuQ2s=; b=gCGB1Poy1yB7fB8jrn3QPlcdWd
	Vodcc3BYJfDMDFKLahD3g6UwhaYRsN6ZpmdoKkH5CPYNTqyehFO28kgTK7MLUHYL2/rSJML06ByRD
	Gf03sVKK39cpnAdF+xB2uB9s9PBu0boLUq9WG4fUIp92lQhc+cixX/zOTbrnhGlFwb1GsZOIoDXzW
	UX45tJ+EVZ2Ao48jHONbiOqJ785Y/WEmPqNNnUSzpZaC21/2emMOuyrzqVmshhHs7X4FvmT8rW7wQ
	ulR1KtJZPL/gZCfgaANG4SMdo9YH9Te6vFVnKkHbPXnn9PP7SuXXDE76V2MKT4vZK1PySq3eC7/bj
	Plb8zIPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iFDC3-0006NW-35; Tue, 01 Oct 2019 08:07:35 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iFDBz-0006MQ-SI
 for linux-nvme@lists.infradead.org; Tue, 01 Oct 2019 08:07:34 +0000
Received: by mail-ed1-x542.google.com with SMTP id v38so11005800edm.7
 for <linux-nvme@lists.infradead.org>; Tue, 01 Oct 2019 01:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:mime-version:subject:message-id:date:cc:to;
 bh=idrtVN+4AE6Oqdx2Fn21bBxp2ZPJwAJI5gXUiWdQqGg=;
 b=LtDkmyX9d7Xk10P8V9FGUqr6TOoxAsbzfAtEzEULaL3jmxdTsfnY9Dg3i2oqoUMy/K
 GMxaeCPX9NMfsiuWdo2pFsGyT47ddSGHpqp4sjd7GHOy4fAvpkBsiuf19/qL91vQb2jj
 RFfyiZrDcQLGfo57T1BUELETOzUbtjThLHhGHBJz1gMHGBakBRK3PljjyOtbHaN1MoB6
 MAlLrTCVVYft29nJ6Lmq3rss7vVzyCW3o5xBJ9r8+PKsWppxhxTsAPzy0N2mfMax0ukX
 t47fDmvQRWg8TmHK58TN904WGCPDq8wY3S3r5aZekikxMyOWZzyNNvXFNIpQtVgHAi4/
 DEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:mime-version:subject:message-id:date:cc:to;
 bh=idrtVN+4AE6Oqdx2Fn21bBxp2ZPJwAJI5gXUiWdQqGg=;
 b=IqMoTQKgapoTwo5LtJR5f0QTV4QQ4c98j7ASWj3wHNwp9mF2RevwWY1Hyv0gA/yDQq
 j+YwDoZvGyKibsZYq5JbQM21F0JZUxJpN/Cro3okkKrpoJboQArLD39iGvXpWTMd12+Q
 qVE4lBeM1uDGr0djzUBc4Q1XS5jBGN1ePBzAehCiavZMctBIF6urbspdDZepqXJAPxmM
 cCKlPPxgxq0aNMla6nXnQLHy1wocw7b8W5aa4oNElD3zwYSTqD5FnXdDYsgu3P4+A3s1
 InORj2rK5FHX43xTjDAmuSnlb2Lcnlm+h2raGDDMblkN6yxByp/XvbfDoHIaiARbi7LY
 3emQ==
X-Gm-Message-State: APjAAAX+25rlG+x1JpOnUZt+HYgQnNvQGXcmtFgbH2Lhb9n1y+3pbeHP
 X28We0iwRcZCchuaNoU6dZMBBOkqdsCp5Ihe
X-Google-Smtp-Source: APXvYqx1ODa9Ip7BCVHN3VGj44DjbtILDQLJG8UkB9k6YR5U1ojyItz8pLeEgOo2HngfukNNV9TyNg==
X-Received: by 2002:a17:906:19d9:: with SMTP id
 h25mr22979595ejd.43.1569917248479; 
 Tue, 01 Oct 2019 01:07:28 -0700 (PDT)
Received: from macbook-pro.gnusmas ([194.62.217.57])
 by smtp.gmail.com with ESMTPSA id e39sm2986624edb.69.2019.10.01.01.07.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 01 Oct 2019 01:07:27 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: : name: possible deadlock in nvme_ns_remove 
Message-Id: <04580CD6-7652-459D-ABDD-732947B4A6DF@javigon.com>
Date: Tue, 1 Oct 2019 10:07:26 +0200
To: linux-nvme@lists.infradead.org
X-Mailer: Apple Mail (2.3445.104.11)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191001_010732_065315_43324758 
X-CRM114-Status: GOOD (  12.81  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Judy Brock <judy.brock@samsung.com>
Content-Type: multipart/mixed; boundary="===============2276670997678335235=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


--===============2276670997678335235==
Content-Type: multipart/signed;
	boundary="Apple-Mail=_DCA99086-BBF4-4B41-A2FD-6DB46695FB3F";
	protocol="application/pgp-signature";
	micalg=pgp-sha256


--Apple-Mail=_DCA99086-BBF4-4B41-A2FD-6DB46695FB3F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Sending this bug report from Judy, who is having problems with the =
mailing list.

=E2=80=94

Hi,

We are running test cases to stress our device that seem to hit race =
conditions / deadlocks  - every couple of days or so - where multiple =
threads are trying to acquire ctrl->subsystem->lock or ctrl->scan_lock.

We'd like to know if our test is valid. If not, we are hoping for some =
overall guidelines about what a host is not permitted/expected not to =
do.

We are sending a lot of nvme cli requests to do Sanitize, Format, FW =
Download, FW Activate, Flush, Get Log, Identify, and reset requests to =
two controllers that share a namespace - some of those commands target a =
namespace, some target a controller.  They're sent in random order / =
random mix to the two controllers.

We DO NOT WAIT for nvme cli requests to finish before sending more. So =
for example, there could be multiple reset requests, multiple format =
requests, outstanding at the same time as a sanitize, on both paths at =
the same time, etc. Combos that don't really make sense - it's just =
meant to create as much stress as possible.

=46rom looking at kernel driver sources and various hang traces, they =
all go thru the nvme_user_cmd, many have effects (e.g. =
NVME_CMD_EFFECTS_LBCC, NVME_CMD_EFFECTS_NCC), launch things like =
namespace invalidation, new scans, etc. as part of processing of those =
effects.

I've tried to understand various old threads on the nvme_linux reflector =
and see several that seem to address issues similar to some of the hang =
traces we've seen.  For example, these threads:

- nvme namespace scanning might race with controller reset
- shorten race window in nvme_ns_remove() -
- nvme: fix a possible deadlock when passthru commands sent to a =
multipath device

We are see hang traces that look like some of those addressed in the =
threads above (so maybe we are hitting some deadlock scenarios not yet =
discovered .) - for ex. we see multiple blocked scans, and/or  threads =
stuck in nvme_ns_remove / nvme_scan_queue / nvme_passthru_start at the =
same time waiting on the same mutex.

I've pasted one such trace below.

I know normally people paste not just problems but solutions on this =
reflector - we are not Linux kernel devs though so what we're trying to =
do is find out what we need to do to move forward. We need to be able to =
avoid any potential deadlocks on the OS side so we can do multi-day =
stress testing of our devices. If we need to change things on our side, =
that's fine - we just aren't sure of next steps. By the way, forgot to =
mention that everything always looks clean on the drive side - no =
commands outstanding, etc.

If there is additional information we should/could provide or other =
outlets we should direct our inquiries to, please let me know.

Thank any/all of you for your time and please see the trace below:

2019-09-19 02:42:11,610 INFO nvmeSanitize:: >>> Executing the =
command:nvme sanitize /dev/nvme0 --sanact=3D4  PID:13559 childPID:19919

2019-09-19 02:43:11,610 ERROR stopTest:: Function:nvmeSanitize cmd:nvme =
sanitize /dev/nvme0 --sanact=3D4  timeout occurred ourPid:13559 =
childPID:19919; Test run will be stopped Sep 19 02:44:21 IOP-Z370-026 =
kernel: INFO: task nvme:19919 blocked for more than 122 seconds.
Sep 19 02:44:21 IOP-Z370-026 kernel:      Not tainted 5.3.0-rc6 #1
Sep 19 02:44:21 IOP-Z370-026 kernel: "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Sep 19 02:44:21 IOP-Z370-026 kernel: nvme            D    0 19919  13559 =
0x00004080
Sep 19 02:44:21 IOP-Z370-026 kernel: Call Trace:
Sep 19 02:44:21 IOP-Z370-026 kernel: ? __schedule+0x2a9/0x650 Sep 19 =
02:44:21 IOP-Z370-026 kernel: schedule+0x39/0xa0 Sep 19 02:44:21 =
IOP-Z370-026 kernel: schedule_preempt_disabled+0xa/0x10
Sep 19 02:44:21 IOP-Z370-026 kernel: __mutex_lock.isra.11+0x233/0x4e0 =
Sep 19 02:44:21 IOP-Z370-026 kernel: nvme_ns_remove+0x2d/0x130 =
[nvme_core] Sep 19 02:44:21 IOP-Z370-026 kernel: =
nvme_remove_invalid_namespaces+0xf1/0x120 [nvme_core] Sep 19 02:44:21 =
IOP-Z370-026 kernel: nvme_user_cmd+0x2c4/0x390 [nvme_core] Sep 19 =
02:44:21 IOP-Z370-026 kernel: nvme_dev_ioctl+0x10d/0x1d0 [nvme_core] Sep =
19 02:44:21 IOP-Z370-026 kernel: do_vfs_ioctl+0xa9/0x620 Sep 19 02:44:21 =
IOP-Z370-026 kernel: ksys_ioctl+0x60/0x90 Sep 19 02:44:21 IOP-Z370-026 =
kernel: __x64_sys_ioctl+0x16/0x20 Sep 19 02:44:21 IOP-Z370-026 kernel: =
do_syscall_64+0x5b/0x1d0

2019-09-19 02:42:16,790 INFO nvmeFormat:: >>> Executing the command:nvme =
format /dev/nvme0n1 --lbaf=3D0 --pil=3D0 --ms=3D0 --ses=3D0 --pi=3D0  =
PID:13591 childPID:20094

Sep 19 02:44:21 IOP-Z370-026 kernel: INFO: task nvme:20094 blocked for =
more than 122 seconds.
Sep 19 02:44:21 IOP-Z370-026 kernel:      Not tainted 5.3.0-rc6 #1
Sep 19 02:44:21 IOP-Z370-026 kernel: "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Sep 19 02:44:21 IOP-Z370-026 kernel: nvme            D    0 20094      1 =
0x00000080
Sep 19 02:44:21 IOP-Z370-026 kernel: Call Trace:
Sep 19 02:44:21 IOP-Z370-026 kernel: ? __schedule+0x2a9/0x650 Sep 19 =
02:44:21 IOP-Z370-026 kernel: schedule+0x39/0xa0 Sep 19 02:44:21 =
IOP-Z370-026 kernel: schedule_preempt_disabled+0xa/0x10
Sep 19 02:44:21 IOP-Z370-026 kernel: __mutex_lock.isra.11+0x233/0x4e0 =
Sep 19 02:44:21 IOP-Z370-026 kernel: nvme_user_cmd+0x330/0x390 =
[nvme_core] Sep 19 02:44:21 IOP-Z370-026 kernel: nvme_ioctl+0x92/0xb0 =
[nvme_core] Sep 19 02:44:21 IOP-Z370-026 kernel: =
blkdev_ioctl+0x8f5/0x9a0 Sep 19 02:44:21 IOP-Z370-026 kernel: ? =
selinux_file_ioctl+0x13b/0x1f0 Sep 19 02:44:21 IOP-Z370-026 kernel: =
block_ioctl+0x3d/0x40 Sep 19 02:44:21 IOP-Z370-026 kernel: =
do_vfs_ioctl+0xa9/0x620 Sep 19 02:44:21 IOP-Z370-026 kernel: =
ksys_ioctl+0x60/0x90 Sep 19 02:44:21 IOP-Z370-026 kernel: =
__x64_sys_ioctl+0x16/0x20 Sep 19 02:44:21 IOP-Z370-026 kernel: =
do_syscall_64+0x5b/0x1d0

2019-09-19 02:42:17,380 INFO nvmeFormat:: >>> Executing the command:nvme =
format /dev/nvme0n1 --lbaf=3D0 --ses=3D1  PID:13625 childPID:20113

Sep 19 02:44:21 IOP-Z370-026 kernel: INFO: task nvme:20113 blocked for =
more than 122 seconds.
Sep 19 02:44:21 IOP-Z370-026 kernel:      Not tainted 5.3.0-rc6 #1
Sep 19 02:44:21 IOP-Z370-026 kernel: "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Sep 19 02:44:21 IOP-Z370-026 kernel: nvme            D    0 20113      1 =
0x00000080
Sep 19 02:44:21 IOP-Z370-026 kernel: Call Trace:
Sep 19 02:44:21 IOP-Z370-026 kernel: ? __schedule+0x2a9/0x650 Sep 19 =
02:44:21 IOP-Z370-026 kernel: schedule+0x39/0xa0 Sep 19 02:44:21 =
IOP-Z370-026 kernel: schedule_preempt_disabled+0xa/0x10
Sep 19 02:44:21 IOP-Z370-026 kernel: __mutex_lock.isra.11+0x233/0x4e0 =
Sep 19 02:44:21 IOP-Z370-026 kernel: nvme_user_cmd+0x330/0x390 =
[nvme_core] Sep 19 02:44:21 IOP-Z370-026 kernel: nvme_ioctl+0x92/0xb0 =
[nvme_core] Sep 19 02:44:21 IOP-Z370-026 kernel: =
blkdev_ioctl+0x8f5/0x9a0 Sep 19 02:44:21 IOP-Z370-026 kernel: ? =
selinux_file_ioctl+0x13b/0x1f0 Sep 19 02:44:21 IOP-Z370-026 kernel: =
block_ioctl+0x3d/0x40 Sep 19 02:44:21 IOP-Z370-026 kernel: =
do_vfs_ioctl+0xa9/0x620 Sep 19 02:44:21 IOP-Z370-026 kernel: =
ksys_ioctl+0x60/0x90 Sep 19 02:44:21 IOP-Z370-026 kernel: =
__x64_sys_ioctl+0x16/0x20 Sep 19 02:44:21 IOP-Z370-026 kernel: =
do_syscall_64+0x5b/0x1d0

2019-09-19 02:42:22,268 INFO nvmeFormat:: >>> Executing the command:nvme =
format /dev/nvme0n1 --lbaf=3D0 --pil=3D0 --ms=3D0 --ses=3D0 --pi=3D0  =
PID:13586 childPID:20230

Sep 19 02:46:24 IOP-Z370-026 kernel: INFO: task nvme:20230 blocked for =
more than 122 seconds.
Sep 19 02:46:24 IOP-Z370-026 kernel:      Not tainted 5.3.0-rc6 #1
Sep 19 02:46:24 IOP-Z370-026 kernel: "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Sep 19 02:46:24 IOP-Z370-026 kernel: nvme            D    0 20230      1 =
0x00000080
Sep 19 02:46:24 IOP-Z370-026 kernel: Call Trace:
Sep 19 02:46:24 IOP-Z370-026 kernel: ? __schedule+0x2a9/0x650 Sep 19 =
02:46:24 IOP-Z370-026 kernel: schedule+0x39/0xa0 Sep 19 02:46:24 =
IOP-Z370-026 kernel: schedule_preempt_disabled+0xa/0x10
Sep 19 02:46:24 IOP-Z370-026 kernel: __mutex_lock.isra.11+0x233/0x4e0 =
Sep 19 02:46:24 IOP-Z370-026 kernel: nvme_user_cmd+0x330/0x390 =
[nvme_core] Sep 19 02:46:24 IOP-Z370-026 kernel: nvme_ioctl+0x92/0xb0 =
[nvme_core] Sep 19 02:46:24 IOP-Z370-026 kernel: =
blkdev_ioctl+0x8f5/0x9a0 Sep 19 02:46:24 IOP-Z370-026 kernel: ? =
selinux_file_ioctl+0x13b/0x1f0 Sep 19 02:46:24 IOP-Z370-026 kernel: =
block_ioctl+0x3d/0x40 Sep 19 02:46:24 IOP-Z370-026 kernel: =
do_vfs_ioctl+0xa9/0x620 Sep 19 02:46:24 IOP-Z370-026 kernel: =
ksys_ioctl+0x60/0x90 Sep 19 02:46:24 IOP-Z370-026 kernel: =
__x64_sys_ioctl+0x16/0x20 Sep 19 02:46:24 IOP-Z370-026 kernel: =
do_syscall_64+0x5b/0x1d0

the 2 nvme scan worker kernel threads are also blocked waiting for the =
same mutex:

Sep 19 02:44:21 IOP-Z370-026 kernel: INFO: task kworker/u24:3:5351 =
blocked for more than 122 seconds.
Sep 19 02:44:21 IOP-Z370-026 kernel:      Not tainted 5.3.0-rc6 #1
Sep 19 02:44:21 IOP-Z370-026 kernel: "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Sep 19 02:44:21 IOP-Z370-026 kernel: kworker/u24:3   D    0  5351      2 =
0x80004080
Sep 19 02:44:21 IOP-Z370-026 kernel: Workqueue: nvme-wq nvme_scan_work =
[nvme_core] Sep 19 02:44:21 IOP-Z370-026 kernel: Call Trace:
Sep 19 02:44:21 IOP-Z370-026 kernel: ? __schedule+0x2a9/0x650 Sep 19 =
02:44:21 IOP-Z370-026 kernel: schedule+0x39/0xa0 Sep 19 02:44:21 =
IOP-Z370-026 kernel: schedule_preempt_disabled+0xa/0x10
Sep 19 02:44:21 IOP-Z370-026 kernel: __mutex_lock.isra.11+0x233/0x4e0 =
Sep 19 02:44:21 IOP-Z370-026 kernel: ? =
nvme_identify_ctrl.isra.58+0x6a/0xb0 [nvme_core] Sep 19 02:44:21 =
IOP-Z370-026 kernel: nvme_scan_work+0xa9/0x380 [nvme_core] Sep 19 =
02:44:21 IOP-Z370-026 kernel: ? check_preempt_curr+0x6b/0x90 Sep 19 =
02:44:21 IOP-Z370-026 kernel: ? try_to_wake_up+0x203/0x5e0 Sep 19 =
02:44:21 IOP-Z370-026 kernel: process_one_work+0x171/0x380 Sep 19 =
02:44:21 IOP-Z370-026 kernel: worker_thread+0x49/0x3f0 Sep 19 02:44:21 =
IOP-Z370-026 kernel: kthread+0xf8/0x130

Sep 19 02:46:24 IOP-Z370-026 kernel: INFO: task kworker/u24:1:2229 =
blocked for more than 122 seconds.
Sep 19 02:46:24 IOP-Z370-026 kernel:      Not tainted 5.3.0-rc6 #1
Sep 19 02:46:24 IOP-Z370-026 kernel: "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Sep 19 02:46:24 IOP-Z370-026 kernel: kworker/u24:1   D    0  2229      2 =
0x80004080
Sep 19 02:46:24 IOP-Z370-026 kernel: Workqueue: nvme-wq nvme_scan_work =
[nvme_core] Sep 19 02:46:24 IOP-Z370-026 kernel: Call Trace:
Sep 19 02:46:24 IOP-Z370-026 kernel: ? __schedule+0x2a9/0x650 Sep 19 =
02:46:24 IOP-Z370-026 kernel: schedule+0x39/0xa0 Sep 19 02:46:24 =
IOP-Z370-026 kernel: schedule_preempt_disabled+0xa/0x10
Sep 19 02:46:24 IOP-Z370-026 kernel: __mutex_lock.isra.11+0x233/0x4e0 =
Sep 19 02:46:24 IOP-Z370-026 kernel: ? =
nvme_identify_ctrl.isra.58+0x6a/0xb0 [nvme_core] Sep 19 02:46:24 =
IOP-Z370-026 kernel: nvme_scan_work+0xa9/0x380 [nvme_core] Sep 19 =
02:46:24 IOP-Z370-026 kernel: ? __switch_to_asm+0x40/0x70 Sep 19 =
02:46:24 IOP-Z370-026 kernel: ? __switch_to_asm+0x34/0x70 Sep 19 =
02:46:24 IOP-Z370-026 kernel: ? __switch_to_asm+0x34/0x70 Sep 19 =
02:46:24 IOP-Z370-026 kernel: ? __switch_to_asm+0x40/0x70 Sep 19 =
02:46:24 IOP-Z370-026 kernel: ? __switch_to_asm+0x34/0x70 Sep 19 =
02:46:24 IOP-Z370-026 kernel: ? __switch_to_asm+0x40/0x70 Sep 19 =
02:46:24 IOP-Z370-026 kernel: ? __switch_to_asm+0x34/0x70 Sep 19 =
02:46:24 IOP-Z370-026 kernel: ? __switch_to_asm+0x34/0x70 Sep 19 =
02:46:24 IOP-Z370-026 kernel: ? __switch_to+0x7a/0x400 Sep 19 02:46:24 =
IOP-Z370-026 kernel: ? __switch_to_asm+0x34/0x70 Sep 19 02:46:24 =
IOP-Z370-026 kernel: process_one_work+0x171/0x380 Sep 19 02:46:24 =
IOP-Z370-026 kernel: worker_thread+0x49/0x3f0

Thank you,
Judy Brock, Samsung
p.s. - I tried to post an email about this a few days ago so if it =
finally goes thru, sorry for the redundancy.



--Apple-Mail=_DCA99086-BBF4-4B41-A2FD-6DB46695FB3F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAl2TCT4ACgkQPEYBfS0l
eOCI4xAA4HmqZ98CKz2JpvWrAnnXxB4/zqWn8ko+rmvzf/7UpcwHSEwRCG6Y2INk
DDssHzS8ObPckO1bEZiANpm6ve96tUCadPA03PY/0MNZPLiutHj67le9NeZtyjOg
aXF4UOQZrVXE82fyUh8eD4wXlyRQ4xibrxsrUdrFTVTAWtQ6199JcOaIq+F4gBqZ
4ARzHtcJZK8XXVEFpZ9vHzXX9TGuVCS1sxhp5/CaLR/ndflmbuWXg3rn/9BL6ILH
rm/kgyJPFkdAtt3GHwGbn5W/7QPRgzu125JL6kwsQ/xvNIy0u1TdHuujW9fNGrDv
HkDL1Bc2p4O9MgBj12GSDLfolw00NNEf/s3HeH/ku1y0xE3zPKsg95Uc5MCycEUP
N2Mq8ESUkQhRk7k0/mj/YuVaW5IGHkfD6xDsBYh2S9a4KWiqa+d/IdSA6i52Vmzj
cjhikR/upVmwFufvK9yud7H9XhbhZWJk0vkVtlCYJxvUryRVFozD5pbF5repKDZe
rQR9BsPz8siVQlQvTRO9v7bL7j+sGam9EJhzR8Wk1XMLVZ9jxtMR7G/bZLKu6keZ
unU39HSHuUCuECNx8UZ4mUvLM7rYlRItj1Q0bUaLNogXGJypR/xrXn6juEBxSKUm
Fcvc/lMrXNWzDD0Niqr3cbLtshk4j3cNxLh7r5g7JMnC0LfsVgY=
=08oq
-----END PGP SIGNATURE-----

--Apple-Mail=_DCA99086-BBF4-4B41-A2FD-6DB46695FB3F--


--===============2276670997678335235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============2276670997678335235==--

