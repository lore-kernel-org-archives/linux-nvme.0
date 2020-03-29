Return-Path: <SRS0=sr50=5O=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A591C43331
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Mar 2020 04:15:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC6B220663
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Mar 2020 04:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xok4Htp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6B220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rYe97o/eIoFBSt1w/YBfJ88Z616Yusq/ufwWTnlNAN4=; b=Xok4Htp03TsMvtYeBIstTKhZk
	A8dTFWb3tWbGhhVhhdM1niUKDbL/izlOX1rU7Dh8456p5ofIq3NA+9+TQNfJDVO2eZd2MEovaUWmj
	Xlx1X+bLl7WFkj3arU43KD6m2vNKhZhkp6VGR6lLhmuHePTx9m2q9Z1hnJMTrMT5Iuxy9gNwGyiUU
	HFbWqVQKW6Gv7l+ihI8QHbn4mUycqKWQo2bEyfTePCyLGq+ZGR2n3km8Qch89eA+lv1r7BpwNngSi
	Ei5BkOO9Sg0NBMXs5fZ+6wHVawG7HVcNP3/jLgvH5pZ/X7P3Ceh5/vCU6kWZvzOARSX74P3phvyJ2
	5We6cWbHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jIPLa-00074A-PA; Sun, 29 Mar 2020 04:14:54 +0000
Received: from mail-pj1-f50.google.com ([209.85.216.50])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jIPLY-00073b-57
 for linux-nvme@lists.infradead.org; Sun, 29 Mar 2020 04:14:53 +0000
Received: by mail-pj1-f50.google.com with SMTP id np9so5934939pjb.4
 for <linux-nvme@lists.infradead.org>; Sat, 28 Mar 2020 21:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MUtuUGfP/9/ZfmKaXQrVG2iW23FnFgI2fw3Ip2xDkC0=;
 b=c/FcnOhaQVnyuDqpqYAQNAgXrowKxmEYN4rVAgVMjS46X8luawfgsAmI9ias93/4xV
 C+0bS3RQbaqaGgme/H6K/GyZQ/EiCbYdKzndddDHhap73PIRPn7YVE/woNwgHBWZw5wd
 Fk1id1KnIb76+4HLA7fjPxLodIzsEIQq94yb+m+y6aGWcfFAJjhja2/OnS3B8GzmFHkC
 8HsRF2PgzgmyaL4xRO8E6eWQIioz282DcyiKGrlFhfxvTlLutJlK0lzoUq1z/MiG4Wc1
 XKLlC3ddaenDC92Qo8AhIkVnUAheQN0qWD4DfhAOvs4scwKSlWXxX+lNcMQ2mUlftjga
 +HJA==
X-Gm-Message-State: ANhLgQ14/nvXtoIwG1qVXuB5n/wdnIPoY7Xm6Q6EK8Iv+KUaZZium7e6
 GZb/21FJtSoATnZmkHUCNAWErhS5
X-Google-Smtp-Source: ADFU+vs7oMK/4ZCXnsuaOGaXhghseorpylwRvgyIVLZRc5g5oSshJSrLw9KLeGe64YLtejSq7dBzCg==
X-Received: by 2002:a17:902:aa06:: with SMTP id
 be6mr6811524plb.132.1585455288231; 
 Sat, 28 Mar 2020 21:14:48 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:28b8:4e08:f833:d12c?
 ([2601:647:4802:9070:28b8:4e08:f833:d12c])
 by smtp.gmail.com with ESMTPSA id o12sm7037034pjt.16.2020.03.28.21.14.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 28 Mar 2020 21:14:47 -0700 (PDT)
Subject: Re: NVMe Over Fabrics Disconnect Kernel error
To: Anton Brekhov <anton.brekhov@rsc-tech.ru>, linux-nvme@lists.infradead.org
References: <CABY-YC7eHFjb-TpKf2ioPJNhZ8RccYsrR-oU=wmt26z9AUNebg@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a7da72d0-ed3f-ab5c-a72b-1b0518436a2e@grimberg.me>
Date: Sat, 28 Mar 2020 21:14:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CABY-YC7eHFjb-TpKf2ioPJNhZ8RccYsrR-oU=wmt26z9AUNebg@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200328_211452_197801_27F5505B 
X-CRM114-Status: GOOD (  11.96  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Greetings!
> 
> We're using nvme-cli technology with ZFS and Lustre Filesystem on top of it.
> But we constantly come across a kernel error while disconnecting
> remote disks from switched off nodes:
> ```
> [  +0,000089] INFO: task kworker/u593:0:82293 blocked for more than 120 seconds.
> [  +0,001959] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  +0,001941] kworker/u593:0  D ffff90e8493fe2a0     0 82293      2 0x00000080
> [  +0,000031] Workqueue: nvme-delete-wq nvme_delete_ctrl_work [nvme_core]
> [  +0,000003] Call Trace:
> [  +0,000008]  [<ffffffff8177f229>] schedule+0x29/0x70
> [  +0,000010]  [<ffffffff81358e85>] blk_mq_freeze_queue_wait+0x75/0xe0
> [  +0,000007]  [<ffffffff810c61c0>] ? wake_up_atomic_t+0x30/0x30
> [  +0,000006]  [<ffffffff81359cb4>] blk_freeze_queue+0x24/0x50
> [  +0,000009]  [<ffffffff8134e0ef>] blk_cleanup_queue+0x7f/0x1b0
> [  +0,000012]  [<ffffffffc031158e>] nvme_ns_remove+0x8e/0xb0 [nvme_core]
> [  +0,000011]  [<ffffffffc031174b>] nvme_remove_namespaces+0xab/0xf0 [nvme_core]
> [  +0,000012]  [<ffffffffc03117e2>] nvme_delete_ctrl_work+0x52/0x80 [nvme_core]
> [  +0,000008]  [<ffffffff810bd0ff>] process_one_work+0x17f/0x440
> [  +0,000006]  [<ffffffff810be368>] worker_thread+0x278/0x3c0
> [  +0,000006]  [<ffffffff810be0f0>] ? manage_workers.isra.26+0x2a0/0x2a0
> [  +0,000005]  [<ffffffff810c50d1>] kthread+0xd1/0xe0
> [  +0,000006]  [<ffffffff810c5000>] ? insert_kthread_work+0x40/0x40
> [  +0,000006]  [<ffffffff8178cd1d>] ret_from_fork_nospec_begin+0x7/0x21
> [  +0,000006]  [<ffffffff810c5000>] ? insert_kthread_work+0x40/0x40
> ```
> Nodes characteristics:
> [root@s02p005 ~]# uname -srm
> Linux 3.10.0-1062.1.1.el7.x86_64 x86_64
> [root@s02p005 ~]# cat /etc/redhat-release
> CentOS Linux release 7.7.1908 (Core)
> 
> Where're using nvmet_rdma.
> Is there any workaround for such error?

It seems like queue freeze is stuck. Can you share more of the
trace so we can see what else is blocking? If not, when
it reproduces run echo t > /proc/sysrq-trigger and share the
log.

Thanks.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
