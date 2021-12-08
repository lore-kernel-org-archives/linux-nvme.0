Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C14EC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Dec 2021 13:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j//aF/gPRsSU19VnWtE7gs3WDvJmQ1PvDkHR3JtgVus=; b=2xVaMOlUHWmWmfXkCPuUcHWPDi
	PkoF7qzRxSuL84tR2m1hPN9pNLlWxSSWXaTKwYu7W/6wh+3Bnd3Rv2QPZFZywEaHwTMuzqrT4A+zo
	rywBcrprTU68xw0JMg3dwGRnE4EcoMDZ/P9bXCgH0uyczwXdMO9n8Ra3B2nJSe3KPKs26JxP54+9A
	mvHA64TruQ2C8vPg8TlCMD8kT/2rk6oEBf7vNr2s0UCV8R70NtHXMeyO1qTmyb1nlAv34V0Z0kLk8
	U8YaLwbglccsJ3SV+BQpR6ehGnauZJvDHE4Nfw21l10yqiWxVFC1hhwxkeTf0UtGQ9brS3zv9RnAM
	MGBMwnnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1muwvh-00Ckuq-Oc; Wed, 08 Dec 2021 13:24:17 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1muwva-00Ckt2-Q4
 for linux-nvme@lists.infradead.org; Wed, 08 Dec 2021 13:24:12 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 c6-20020a05600c0ac600b0033c3aedd30aso1764815wmr.5
 for <linux-nvme@lists.infradead.org>; Wed, 08 Dec 2021 05:24:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=j//aF/gPRsSU19VnWtE7gs3WDvJmQ1PvDkHR3JtgVus=;
 b=HMjf8Fn8DE/HrEe1jPjbRP1E2nzry6qpczg4uwnT+P52IOmbRrP53ER8lI84BaR3FK
 rf5/aWbG+O+NaQFbQsUqGnlMFOfhqje7LVS+RCDci0JNZXUhgKuPHUnvYeBfQZL5yEWz
 JJ1IwZpmL4xvdTreGAH3kyZAfnnj3qbDgawFYPokmxa/wokX60VBfowHCNceW7Ja8o3Z
 /Kg9sBkHVt7Vttyh/6xhQcsFwiuaNW6wC5BVZKlo1eNyDvu5/xC+m/fIVGmB4p42Bcv9
 RNIcRBQHvI4BCMUcOo+EfhO/bfhG07JX/HSxIhEuvIm96Vq1Ba00owfJBYMKpXoRw+en
 1NeA==
X-Gm-Message-State: AOAM533KCWPtmwabnlA76nhg52jXaFBFPQ4EzhFvA2YE5ANF4ubWstiN
 jx/lqOJRs7zKRZIfFP8r8Xpy6T4f/6A=
X-Google-Smtp-Source: ABdhPJzwlDTJ9v4rcutKrw8gyozgQsAgvwp0bPlpgB9mLyJOOtSyIdadjqWm5gSZ99LRxd6kgoSrHg==
X-Received: by 2002:a7b:c157:: with SMTP id z23mr15938606wmi.113.1638969847284; 
 Wed, 08 Dec 2021 05:24:07 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id t16sm2661233wrn.49.2021.12.08.05.24.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Dec 2021 05:24:06 -0800 (PST)
Subject: Re: [Bug 215157] New: nvme delete-ns over nvme-tcp to nvmet-tcp error
From: Sagi Grimberg <sagi@grimberg.me>
To: Keith Busch <kbusch@kernel.org>, bugzilla-daemon@bugzilla.kernel.org
Cc: linux-nvme@lists.infradead.org
References: <bug-215157-95461@https.bugzilla.kernel.org/>
 <20211129180141.GB3582042@dhcp-10-100-145-180.wdc.com>
 <b006562f-01f7-4359-0d3c-9de346d75241@grimberg.me>
Message-ID: <9e23a882-5271-926d-6584-fe0f8a15d208@grimberg.me>
Date: Wed, 8 Dec 2021 15:24:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <b006562f-01f7-4359-0d3c-9de346d75241@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211208_052410_892323_F8F5FB2C 
X-CRM114-Status: GOOD (  14.06  )
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


>>> [10814.174841] Workqueue: events nvmet_tcp_release_queue_work 
>>> [nvmet_tcp]
>>> [10814.174850] Call Trace:
>>> [10814.174852]  <TASK>
>>> [10814.174855]  __schedule+0x23f/0xe50
>>> [10814.174861]  ? update_load_avg+0x77/0x4d0
>>> [10814.174866]  schedule+0x50/0xd0
>>> [10814.174869]  schedule_timeout+0x99/0xd0
>>> [10814.174873]  ? raw_spin_rq_lock_nested+0x19/0x80
>>> [10814.174876]  wait_for_completion+0x74/0xc0
>>> [10814.174880]  __flush_work.isra.0+0x14b/0x210
>>> [10814.174884]  ? flush_workqueue_prep_pwqs+0x110/0x110
>>> [10814.174887]  nvmet_tcp_release_queue_work+0xc3/0x330 [nvmet_tcp]
>>> [10814.174892]  process_one_work+0x1ad/0x310
>>> [10814.174895]  worker_thread+0x48/0x3d0
>>> [10814.174899]  ? process_one_work+0x310/0x310
>>> [10814.174901]  kthread+0x155/0x180
>>> [10814.174904]  ? set_kthread_struct+0x30/0x30
>>> [10814.174907]  ret_from_fork+0x1f/0x30
>>> [10814.174912]  </TASK>
>>> [10830.558291] nvme nvme2: queue 0: timeout request 0x0 type 4
>>> [10830.558422] nvme nvme2: Connect command failed, error wo/DNR bit: 881
>>> [10830.558484] nvme nvme2: failed to connect queue: 0 ret=881
>>> [10830.558507] nvme nvme2: Failed reconnect attempt 2
>>> [10830.558510] nvme nvme2: Reconnecting in 10 seconds...
>>> [10904.284728] nvme nvme2: queue 0: timeout request 0x0 type 4
>>> [10904.284757] nvme nvme2: Connect command failed, error wo/DNR bit: 881
>>> [10904.284818] nvme nvme2: failed to connect queue: 0 ret=881
>>> [10904.284842] nvme nvme2: Failed reconnect attempt 3
>>> [10904.284845] nvme nvme2: Reconnecting in 10 seconds...
> 
> The issue here seems to be that the controller fails the command but it
> still times out for the host - which suggest that the error response is
> not actually queued.

This should resolve the issue:
--
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index cb6a473c3eaf..a91ae06abce0 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -922,7 +922,7 @@ static void nvmet_tcp_handle_req_failure(struct 
nvmet_tcp_queue *queue,
         size_t data_len = le32_to_cpu(req->cmd->common.dptr.sgl.length);
         int ret;

-       if (!nvme_is_write(cmd->req.cmd) ||
+       if (!nvme_is_write(cmd->req.cmd) || !data_len ||
             data_len > cmd->req.port->inline_data_size) {
                 nvmet_prepare_receive_pdu(queue);
                 return;
--

