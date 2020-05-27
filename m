Return-Path: <SRS0=KSy6=7J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MISSING_HEADERS,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776D2C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2020 23:55:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35374206A1
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2020 23:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rpDYLjx5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35374206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Cc:Subject
	:From:Reply-To:To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Jao+RqF2TYoBJWy8VMa9Mgmy1zvrflkrkljb87aJMj0=; b=rpDYLjx5HRmZzo
	+cUhN2epPg4hgXqXbcg9Am/WiqRh53ui5lV7Gz3yUxa2H2ThjlTI7hNd2E55a8JgYyGKGZVNeuhMj
	DHYTsmokxDbKTF+zl65qcUzn6JByeojEHFxoIK1ekfYBV6ekhfAdf8PSXk9cwfL72gsqyoVBjiePZ
	cBKIfRAVOo6v/KQUpp/QrLbLlX65qf0JZDoxsJSynnXUZ/lFNGACFMFMhf6+lbUncSyGcxWm8iriB
	w8zBpK3pcs2W3rfshS+2zFEDW2fsRd0dyyONB2DmcsEm//sLxjat+K6lbetm9gO7PwJykxzmIwuL2
	pM9/KR7kGBLoDHsI22ow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1je5td-0007m3-RZ; Wed, 27 May 2020 23:55:41 +0000
Received: from mail-pl1-f171.google.com ([209.85.214.171])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1je5tb-0007la-OG
 for linux-nvme@lists.infradead.org; Wed, 27 May 2020 23:55:41 +0000
Received: by mail-pl1-f171.google.com with SMTP id i17so2283095pli.13
 for <linux-nvme@lists.infradead.org>; Wed, 27 May 2020 16:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:cc:autocrypt:message-id:date
 :user-agent:mime-version:content-language:content-transfer-encoding;
 bh=kHSe4d1L9Ir9BgcMEM57KTFkKGTNY7hhq8klG2GpDiI=;
 b=qxAI+7QvBJU+PVRDd9EqWzuVnVaonOTfahaBKJlA7HrhwzswD+MZ1Ia43kSOtWq8/r
 Y/Z2ajdNgJPQzuYdb/LBMBrqVutbFPjvHk5YWVZH6SpghMBPgmhlLN2MV60CUUStVngL
 ePnyQ5B6eyiKYACIeIB0uxiBYEkNbMGOeKwazSeAYIhYDYzHgMA8kkbBzmAkZ6VRzVUN
 nE34eHaLTgs+A+c/vzys/H3Dmqyn7J/OSvT7SNHGXDMYABchGh+162CTblfaB+oC5YaX
 ioTOXbTXNWE/Ptvr3LY62MguqwRntZD5a61DtbBkSI57gKukcrzA+JU9a3gmHK8Dryyq
 kwsA==
X-Gm-Message-State: AOAM533QQDteJxwtdI0Zg0e2ltH9UIEH8ItxoikV4X6Z/alHXg2qbMkS
 jVIcSXLFn/yyZwgxMsDMRLev714S
X-Google-Smtp-Source: ABdhPJwseBBGz5Ek7ogZ+AOsx6w/JyAMiudRjTiE6LXwSGKeE3SspSepaeveLkpbsW8uOqf+r2yShQ==
X-Received: by 2002:a17:902:bf08:: with SMTP id
 bi8mr754609plb.319.1590623738072; 
 Wed, 27 May 2020 16:55:38 -0700 (PDT)
Received: from [192.168.50.147] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id q201sm3035180pfq.40.2020.05.27.16.55.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2020 16:55:36 -0700 (PDT)
From: Bart Van Assche <bvanassche@acm.org>
Subject: blktests test nvme/003 fails
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <a2b9e92a-f499-b54c-a275-c08a23467866@acm.org>
Date: Wed, 27 May 2020 16:55:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200527_165539_792606_CE4F5BDF 
X-CRM114-Status: UNSURE (   9.58  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

This morning I updated my local copy of Jens' for-next branch. Since
that update test nvme/003 fails. Is this perhaps a regression? This
is what appears in the system log if I run that test:

 run blktests nvme/003 at 2020-05-27 16:33:49
loop: module loaded
nvmet: adding nsid 1 to subsystem blktests-subsystem-1
nvmet: creating controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:47f11c7a-c9c3-4964-b450-d1818ee33113.
nvme nvme0: new ctrl: "nqn.2014-08.org.nvmexpress.discovery"
nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
nvmet: ctrl 1 keep-alive timer (15 seconds) expired!
nvmet: ctrl 1 fatal error occurred!
INFO: task nvme:992 blocked for more than 122 seconds.
      Not tainted 5.7.0-rc7-dbg+ #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
nvme            D27584   992    917 0x00004000
Call Trace:
 __schedule+0x4e4/0xf80
 schedule+0x7f/0x170
 schedule_timeout+0x171/0x1b0
 wait_for_completion+0x126/0x1b0
 nvmet_sq_destroy+0x85/0x100 [nvmet]
 nvme_loop_destroy_admin_queue+0x47/0x90 [nvme_loop]
 nvme_loop_shutdown_ctrl+0xbc/0xd0 [nvme_loop]
 nvme_loop_delete_ctrl_host+0x19/0x20 [nvme_loop]
 nvme_do_delete_ctrl+0x97/0xb0 [nvme_core]
 nvme_sysfs_delete+0xb8/0xd0 [nvme_core]
 dev_attr_store+0x42/0x60
 sysfs_kf_write+0x8b/0xb0
 kernfs_fop_write+0x158/0x250
 __vfs_write+0x4c/0x90
 vfs_write+0x14b/0x2d0
 ksys_write+0xdd/0x180
 __x64_sys_write+0x47/0x50
 do_syscall_64+0x6f/0x310
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x7f6f8115b057
Code: Bad RIP value.
RSP: 002b:00007fff13095688 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6f8115b057
RDX: 0000000000000001 RSI: 0000557079b5e9a7 RDI: 0000000000000004
RBP: 0000000000000004 R08: 0000557079b5f470 R09: 00007fff130957a0
R10: 0000000000000000 R11: 0000000000000246 R12: 000055707a99a3f0
R13: 00007fff13096da0 R14: 0000000000000003 R15: 00007fff130956e0

Showing all locks held in the system:
1 lock held by khungtaskd/52:
 #0: ffffffff827e5140 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire.constprop.0+0x0/0x30
3 locks held by nvme/992:
 #0: ffff8881dfac8430 (sb_writers#6){.+.+}-{0:0}, at: vfs_write+0x27b/0x2d0
 #1: ffff8881f20d3488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write+0xfa/0x250
 #2: ffff8881e132b3f8 (kn->count#167){++++}-{0:0}, at: kernfs_remove_self+0x1b7/0x250


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
