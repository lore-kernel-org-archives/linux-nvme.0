Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3F7C43217
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 09:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9xXKJFGMmNMyk8ENLLw+AsSUkE1jYfzBjrhtdVosowg=; b=h1FJsNy+PdSlE2p8MBtDV2PRz+
	xzUcGA8GElcHu18mr2t/uGmCZKQIJUoM9pKUSoB+ddeBWZFptdGeZXilJ1dSy9O25qYsCi2HfvYTe
	g1oQxr+X4q5dA6gZJWGMyPCZCokCDeGWyZfOAHfOffLUBD0eugi1d9XkQZphFo1vV6HIve2WAB4/j
	sWzpqkuQasJYo4WAJ1dTpap13T7AjAAX9XBp3aOM7dpW9eGIOHJ5iNuPzBAywSWRZaYNh5wegpjr0
	hpRg9yTsjqAwpCRDTHjl1gusblOKoXBakwbVeH4Y74t5uGebxNaNUIj/314FNjtAIXLvp+g7OD4Rx
	imGaWKkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol4zE-00H7Zq-T8; Wed, 19 Oct 2022 09:03:40 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol4zC-00H7VL-23
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 09:03:39 +0000
Received: by mail-wm1-f43.google.com with SMTP id n16-20020a05600c4f9000b003c17bf8ddecso545067wmq.0
        for <linux-nvme@lists.infradead.org>; Wed, 19 Oct 2022 02:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9xXKJFGMmNMyk8ENLLw+AsSUkE1jYfzBjrhtdVosowg=;
        b=C711MqcS20Z9gdfbns5sjaXg3uBzEPpdihtLG9BK2i39azR1/uTr+CT4mFh6SvNOcz
         dhZAN4pQhHBh5rXfEUv1ik5A0Q3BVxhYJKc+pXr27DcXS2WYuOntbKb5Wqgc51DSX4Fd
         yeFneS8BucazetXItx2uc/m6HLitSRwxVfGCOdIcugFh91p1FA0ds2K7bj+sdJkOdOB0
         MbgyOFD2vMjZ7b3Kec8L5sZvCSLsqjyXiqvY8rNsy2grqcrPwyqIdSD5AJrQ2Jee3/EV
         AAtHia+OzrvTfVBXiyhqPNz6qmKaCGvdYDu+eC6PA/xm97/Sl0k/3Mu55o7UJ0fsH/dj
         p4eQ==
X-Gm-Message-State: ACrzQf3frwuV3+dWyGcVFHjAPAkYXUUQp8bpVJ+Wi0ZehGYpQOldA6gh
	tdkx+av69tGuETaos3IrTzfWoKPHsqo=
X-Google-Smtp-Source: AMsMyM642/9XKw9Ef7gurrV+zLp7gY6SpupQ0yiz71AsXSYNy09DQ+/PJaViXKVQ5CEnNC6vNwzgqQ==
X-Received: by 2002:a05:600c:4fd2:b0:3c6:db8a:4d2a with SMTP id o18-20020a05600c4fd200b003c6db8a4d2amr4656116wmq.178.1666170214828;
        Wed, 19 Oct 2022 02:03:34 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bv16-20020a0560001f1000b0022e6f0d0d7csm15626083wrb.18.2022.10.19.02.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 02:03:34 -0700 (PDT)
Message-ID: <c30b24b9-e80f-9e8a-5754-caa7dc7bfe8b@grimberg.me>
Date: Wed, 19 Oct 2022 12:03:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: lockdep warning: fs_reclaim_acquire vs tcp_sendpage
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20221019075138.ff2sfahovionh72v@carbon.lan>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221019075138.ff2sfahovionh72v@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_020338_135420_EC48AFEA 
X-CRM114-Status: GOOD (  22.39  )
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


> Hi Sagi,

Thanks for reporting.

> While working on something else I got the lockdep splat below. As this
> is a dirty tree and not latest greatest it might be a false alarm.
> 
> I haven't really looked into yet, this is just to let you know that
> there might be something going on.

I didn't see anything similar to this one yet.

> 
> Cheers,
> Daniel
> 
>   ======================================================
>   WARNING: possible circular locking dependency detected
>   6.0.0-rc2+ #25 Tainted: G        W
>   ------------------------------------------------------
>   kswapd0/92 is trying to acquire lock:
>   ffff888114003240 (sk_lock-AF_INET-NVME){+.+.}-{0:0}, at: tcp_sendpage+0x23/0xa0
>   
>   but task is already holding lock:
>   ffffffff97e95ca0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x987/0x10d0
>   
>   which lock already depends on the new lock.
> 
>   
>   the existing dependency chain (in reverse order) is:
>   
>   -> #1 (fs_reclaim){+.+.}-{0:0}:
>          fs_reclaim_acquire+0x11e/0x160
>          kmem_cache_alloc_node+0x44/0x530
>          __alloc_skb+0x158/0x230
>          tcp_send_active_reset+0x7e/0x730
>          tcp_disconnect+0x1272/0x1ae0

Here tcp_disconnect is using gfp_any() down to alloc_skb, which
overrides the socket allocation flags.

>          __tcp_close+0x707/0xd90
>          tcp_close+0x26/0x80
>          inet_release+0xfa/0x220
>          sock_release+0x85/0x1a0
>          nvme_tcp_free_queue+0x1fd/0x470 [nvme_tcp]
>          nvme_do_delete_ctrl+0x130/0x13d [nvme_core]
>          nvme_sysfs_delete.cold+0x8/0xd [nvme_core]
>          kernfs_fop_write_iter+0x356/0x530
>          vfs_write+0x4e8/0xce0
>          ksys_write+0xfd/0x1d0
>          do_syscall_64+0x58/0x80
>          entry_SYSCALL_64_after_hwframe+0x63/0xcd
>   
>   -> #0 (sk_lock-AF_INET-NVME){+.+.}-{0:0}:
>          __lock_acquire+0x2a0c/0x5690
>          lock_acquire+0x18e/0x4f0
>          lock_sock_nested+0x37/0xc0
>          tcp_sendpage+0x23/0xa0
>          inet_sendpage+0xad/0x120
>          kernel_sendpage+0x156/0x440
>          nvme_tcp_try_send+0x48a/0x2630 [nvme_tcp]
>          nvme_tcp_queue_rq+0xefb/0x17e0 [nvme_tcp]
>          __blk_mq_try_issue_directly+0x452/0x660
>          blk_mq_plug_issue_direct.constprop.0+0x207/0x700
>          blk_mq_flush_plug_list+0x6f5/0xc70
>          __blk_flush_plug+0x264/0x410
>          blk_finish_plug+0x4b/0xa0
>          shrink_lruvec+0x1263/0x1ea0
>          shrink_node+0x736/0x1a80
>          balance_pgdat+0x740/0x10d0
>          kswapd+0x5f2/0xaf0
>          kthread+0x256/0x2f0
>          ret_from_fork+0x1f/0x30
>   
>   other info that might help us debug this:
> 
>    Possible unsafe locking scenario:
> 
>          CPU0                    CPU1
>          ----                    ----
>     lock(fs_reclaim);
>                                  lock(sk_lock-AF_INET-NVME);
>                                  lock(fs_reclaim);
>     lock(sk_lock-AF_INET-NVME);

Indeed. I see the issue.
kswapd is trying to swap out pages, but if someone were to delete
the controller (like in this case), sock_release -> tcp_disconnect
will alloc skb that may need to reclaim pages.

Two questions, the stack trace suggests that you are not using
nvme-mpath? is that the case?

Given that we fail all inflight requests before we free the socket,
I don't expect for this to be truly circular...

I'm assuming that we'll need the below similar to nbd/iscsi:
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4f5dcfe5357f..c5bea92560bd 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1141,6 +1141,7 @@ static int nvme_tcp_try_send_ddgst(struct 
nvme_tcp_request *req)
  static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
  {
         struct nvme_tcp_request *req;
+       unsigned int noreclaim_flag;
         int ret = 1;

         if (!queue->request) {
@@ -1150,12 +1151,13 @@ static int nvme_tcp_try_send(struct 
nvme_tcp_queue *queue)
         }
         req = queue->request;

+       noreclaim_flag = memalloc_noreclaim_save();
         if (req->state == NVME_TCP_SEND_CMD_PDU) {
                 ret = nvme_tcp_try_send_cmd_pdu(req);
                 if (ret <= 0)
                         goto done;
                 if (!nvme_tcp_has_inline_data(req))
-                       return ret;
+                       goto out;
         }

         if (req->state == NVME_TCP_SEND_H2C_PDU) {
@@ -1181,6 +1183,8 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue 
*queue)
                 nvme_tcp_fail_request(queue->request);
                 nvme_tcp_done_send_req(queue);
         }
+out:
+       memalloc_noreclaim_restore(noreclaim_flag);
         return ret;
  }
--

