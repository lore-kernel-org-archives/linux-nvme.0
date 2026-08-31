Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2687FC61DF0
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2026 03:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4c+RsoD9+II3cHrkxTAlyGXQJa9lVnbS0MKfyDhd8XI=; b=uEHsTYJFxtXkxxlbKWfpIOyTH5
	cgDDO+bAF9G5kvgjkH6JBbPn9okSQ5DJRFfEicYC0EwFq32/UcK1SYxSlTSeN7ZKPA1o6hsPwQe17
	0suM5CTQYusLf0zycY71ktJ5uiF4xrcM6/Jud9OME9unz+CV5DmD4JDK8AtOsurh+nn6+01SHrlrw
	ZrLQf0+Q3jeKXI62l/oJfXi4As93dBQBmOQg5eXQkGAoik1B984HNXq/Z8/ERbjMQCn1y9XDX5Pl7
	UvE4iGPdIINf5V47qlkMtHiuN+UN1sOPC3LgIJZpR2RBc6a29+5v7a7r+tQiCLxmBNZFexNbHUmuw
	nEdoYVQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0t9q-00000008QrJ-3PzX;
	Mon, 31 Aug 2026 03:58:06 +0000
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0t9o-00000008Qqy-2yoH
	for linux-nvme@lists.infradead.org;
	Mon, 31 Aug 2026 03:58:05 +0000
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-52d8679c149so27061321cf.2
        for <linux-nvme@lists.infradead.org>; Sun, 30 Aug 2026 20:58:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788148683; cv=none;
        d=google.com; s=arc-20260327;
        b=CVzC45DIzH7bEynS9DPbIgBgfqE/eCINE8blYP3JcRLdYe4BBNxN/3+dOUaEo+veok
         c8KBryCHgTmOCR1ka4FcjWNE0/UWBrUh188UUwgHKDjuj2jn0yMrhZMsPZO84BY3Wtbk
         tTGCjMRnHO4Rq8MwLpUMJgMiTpNdj0y/Y2uT9gpDEy38y0QdZDyOa2YojYIgo7qvYkTq
         uHnIUkFsXJE+vIAgeR2ycfsOmiWBlCe5e3M2HTT1yPuL7Au6NVA8n+GZOvLZOb7iUevz
         c3p813XaUW2SEzc9BYqWtpa+3CFto5rSSckJMm8XdB1qqMwn0S89S/2PXBvUMBJbGcMn
         5q/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=4c+RsoD9+II3cHrkxTAlyGXQJa9lVnbS0MKfyDhd8XI=;
        fh=4KbuBgSMA02ia1RRQyqL+rU0AfaJzrPoyg7gt+Bosvc=;
        b=kRoaBHlU0RK8IvC5NVnAlR5O7NXYnj41ZDnBR0nPb+UmyCvaj+VOMczBBr60puXWNl
         TDHQ4ZMlacgwerZOPr4fj6CKdSgYeH6cmcau2+m2qaF2WoMPi0eGRceFhyT585JJR7En
         UqZSjh23tQ8Fd3k78hXCEcgTqzJzoS+Auc7G3xHfqzsLFKLE+W86XRbgZHG6MrYv6P4s
         7ijble8VAS1cz4KMO4CW0/wsnDg7egHUZcZuK3cOkSOaVYDRohKspWNMVTk5hNPPCFYW
         HN4XMXVkhZeSBo/IiOAjHej1EjIQ1MYOLOYioN0/Eu47+E+uwtliz3crhCq8tbZK6ucR
         cvFw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788148683; x=1788753483; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4c+RsoD9+II3cHrkxTAlyGXQJa9lVnbS0MKfyDhd8XI=;
        b=XZRdKiZG5k5/APYyp0y7nKKbt0qZ8saHtZnbr2tGTgpbApP/w+zq0ayb47N4qcf0jL
         IAYHlQO8mgD8ULDZZt6dArwKrABr94C6shH5l/NKZ1Tn2vEOFr7ZOM9qMhp7IeFCFFjd
         iFQOw4V6pOrvOYLsDc5JWMWETTjER3BJK8f6k3ZjtIlTjG+oZq01yRbjqVeM9BkPU22u
         tMsi6OIor7S1LwewdEXNQEaR42sRFR7+BOX7zfhiINGLmsJa7JdR4OAUvdSf4ETwhB1S
         9/4ZKd2To9EJIizKAzI10Xpb3XpLaZqFUPvcKSJXLZ2xjenctk8eP33/AleU5hzQS85z
         PHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788148683; x=1788753483;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4c+RsoD9+II3cHrkxTAlyGXQJa9lVnbS0MKfyDhd8XI=;
        b=XDec+fbRwk7wawbB606sAU0l+CiabAA4K4mUzrzCx7jbuUH0rAuIn/fZH9mx4n2N2k
         XYNiF29BBvestesozBOFkpBW2RoXLSi9SIIXyyWoMrgOZhP0ATozo+e38v6f4xBdIugc
         SpirMiH4OpsLg+axhu6iCpg28sYVYI86wq0Qx5vi39usWXdjUlBsSwp2RLoLKrXd3Rae
         SVqsFgBVmj7jVgLW8jPbyV6a3+QZhcqLIG+HkQYjQJLLSEVVPtVa4wYm3PTTwHOjyPEd
         yG5IJWl/qIE3ZO7lRuA/EMPm5by74DRzywl0ym/Urwsyu8ct2EVSK/6b0TDR4jheCh8C
         XjCQ==
X-Gm-Message-State: AFuF++kEySXmfctd4EGd/y0PgoOZ/9DpfuZ9XlCqN7wHqhMq61TSDY1f
	jLcBrzYBmJzDccexYpDvOYKumUQ7frdGNjhVqHsp2caO9wgbbDTyHxL7YxwGi55Xpi0w2SDc0iX
	2wJLjvXAB3EAAhBfolnTlrZEhWwdUxmI=
X-Gm-Gg: AR+sD10TcQWFqEOzw2XNLqdOsU4sU1zVBr6683XPfSED0NRohzcL/sDhM8fzbOoR/pv
	cQBx8na1WPccA0SBX7tjBE2D70Mb5W8eLldt5Oy+2tWwNTXFCEgA/1wCz0hAuy7Qnn0MEPtKCZ1
	LMyb28XtZsk8Y5MSHaFYPuQLGETzLVdthc8/CXyTIP/qjPCZ9WZ3HioL6b42tRb2ibL+kd4A6rD
	g5I5igabipcsQecnsqkoMmxSQzzQpM3W2kEvBlNj905WHl3XCl0sLSzJOnPhmZJj5pdJIW6012Q
	sVauiFkSmMjo+xwrWs3GtUffU9tg1n4ljo4E4FxKXdri5FOqZRyeiR3FEN/TB0nLS7wlMAm/8D7
	Z1/4ogZf2ysF5HHWGJrpU+f8m3CYNbJhZwXJI+n76uAf8ZNCe
X-Received: by 2002:ac8:5a06:0:b0:52b:4e1f:941d with SMTP id
 d75a77b69052e-52fb9374694mr266748461cf.6.1788148682642; Sun, 30 Aug 2026
 20:58:02 -0700 (PDT)
MIME-Version: 1.0
From: ZW Tang <tangzw515@gmail.com>
Date: Mon, 31 Aug 2026 11:57:51 +0800
X-Gm-Features: AcwNN1UlLAAe-jLwhlyyvq1Inj8sGqFww0HtJyfJLkVnL2nqFBrYPyn0YlJZXbM
Message-ID: <CAA2SOT45iFOrqCArQ8izfMO8npM-L-VjPctCoLrHaGZG=OD81w@mail.gmail.com>
Subject: [BUG] nvmet: NULL pointer dereference in nvmet_file_ns_enable without device_path
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_205804_770718_70CC55DC 
X-CRM114-Status: GOOD (  10.71  )
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

I am reporting a NULL pointer dereference triggered by a syzkaller
reproducer on Linux 7.2.0-rc3. A similar issue appears to have been
reported before, but I can still reproduce it on Linux 7.2.0-rc3 with HEAD
commit 1137d8b5df06137fb49513cc923b3b24d94cb809.

The reproducer mounts configfs, creates an NVMe target subsystem and a
namespace, sets buffered_io to 1, and then enables the namespace without
setting a device_path. During the enable path, nvmet_ns_enable_store()
calls nvmet_ns_enable(), which then reaches nvmet_file_ns_enable().
nvmet_file_ns_enable() passes ns->device_path to filp_open(), but
ns->device_path is NULL. This eventually reaches do_getname_kernel() and
strlen(), causing a NULL pointer dereference.

This looks like an nvmet configfs validation issue. Enabling a namespace
without a configured device_path should be rejected cleanly instead of
passing a NULL path to filp_open().

Reproducer:

syz reproducer: https://pastebin.com/raw/HheWvkXb
console output: https://pastebin.com/raw/K1ppzMhe
kernel config: https://pastebin.com/raw/EhG6vG6K

Kernel:

HEAD commit: 1137d8b5df06137fb49513cc923b3b24d94cb809
git tree: torvalds/linux
kernel version: 7.2.0-rc3 #1 PREEMPT(full) (QEMU Ubuntu 24.10)

Relevant log:

nvmet: adding nsid 1 to subsystem testnqn

Oops: general protection fault, probably for non-canonical address
0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI

KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]

CPU: 0 UID: 0 PID: 10781 Comm: syz.0.17 Not tainted 7.2.0-rc3 #1 PREEMPT(full)
Hardware name: QEMU Ubuntu 24.10 PC (i440FX + PIIX, 1996)

RIP: 0010+0x1e/0xa0

Call Trace:
<TASK>
do_getname_kernel+0x1d/0x250
filp_open+0x1d/0x50
nvmet_file_ns_enable+0x97/0x4a0
nvmet_ns_enable+0x494/0x6b0
nvmet_ns_enable_store+0x11c/0x150
configfs_write_iter+0x2f4/0x4c0
vfs_write+0xbaf/0x1160
ksys_write+0x121/0x240
do_syscall_64+0xc4/0x7a0
entry_SYSCALL_64_after_hwframe+0x76/0x7e
</TASK>

Kernel panic - not syncing: Fatal exception

