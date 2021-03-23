Return-Path: <SRS0=jrCY=IV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDEBC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 02:58:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B47646191F
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 02:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47646191F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1xuc0GDrFIzGf1P4HzxXMamBL63Bp8+uEjTNpLj0v58=; b=IKxMFydHDK+8TB//aYwQppNwm
	rlhTxmMVe+OMQTZwN/AO+2RsgxNhHMm/Bz0x9wejUF5MffA5wqSabBCTR/8EAjt4tkS/j2of2jswY
	MWND2xTFUzPTOOb5AOAoitrOj3mT0DqcQKRDIos+hbB8FUlZ1X7qlzyzfY9vy5/FrsixFFYP3CZSu
	0Aq172v8XjDjkhFOE1c5E5nyne0xBg2aMwcqvvqGCoVD8Az0SJvE+60C+QdTuXmdb7vYIA8GFCVGw
	HfXvkBHlQqBl+jWlxGie6brkRYV1sE/kesTBOSG+uFAxZJ3lxZALFjluxi60YpVe9fd0yEDdYIip8
	dCOpdR+Pg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOXEi-00DTdF-DY; Tue, 23 Mar 2021 02:57:40 +0000
Received: from mail-pg1-f178.google.com ([209.85.215.178])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOXEb-00DTaf-6U
 for linux-nvme@lists.infradead.org; Tue, 23 Mar 2021 02:57:35 +0000
Received: by mail-pg1-f178.google.com with SMTP id n11so10262863pgm.12
 for <linux-nvme@lists.infradead.org>; Mon, 22 Mar 2021 19:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Kvm4q3zalYNM8O+zRR4Rd5kXy+GZmAFyX+0xXfMGNz4=;
 b=clx0bKhsujBZkwgnGmw/LbdFleUgG+4B/UNwd5tmg2J7TD3m2KLuo1LBw2vh6vpSqK
 3KAFCyft8H0VjG118XpKSxZ/69IuPErS9nLrAayi6TA2FTTpOv4HHU6TKQtJaPhyslMr
 KbENOI/q/P66aWtozTA8wUPIaB5Pxe+CgATePAMGwyeggKWQD1fIhAwBjwQGSIxXe7KU
 YjfAsnBKk78ieorl7v5UPDJzjp4JuCDSaanCsltNZhygPqcUe82NHpTP0cKsOgVdH9qd
 pIodpYiLcsq1BXz6FfIXVOzxHerGi9vrN5+eScjXnuZvlZTCwOxsnpENTQcvWOXyh3tg
 YhFQ==
X-Gm-Message-State: AOAM5329Y8N4DKbFTmEfJo6FsarjWuQZdXpOAOXbnuTpPxH0OHmPA09i
 jaaivYdxj9ngWkN2pLeZ8Y/2qbsc5MY=
X-Google-Smtp-Source: ABdhPJweFTzSLBeakpKf2HO47bAEHyYf3l0VYABI84qKJx7KCzcYaKtn6IpMU+NKcERirQ9tDnC6Vg==
X-Received: by 2002:a63:504a:: with SMTP id q10mr2126463pgl.188.1616468249220; 
 Mon, 22 Mar 2021 19:57:29 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:2a1:40ef:41b6:3cf0?
 ([2601:647:4802:9070:2a1:40ef:41b6:3cf0])
 by smtp.gmail.com with ESMTPSA id f19sm14558261pgl.49.2021.03.22.19.57.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Mar 2021 19:57:28 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of the
 underlying device
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>
Cc: Chao Leng <lengchao@huawei.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-3-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me>
Date: Mon, 22 Mar 2021 19:57:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210322073726.788347-3-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210323_025733_593581_EAAB4243 
X-CRM114-Status: GOOD (  26.03  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> When we reset/teardown a controller, we must freeze and quiesce the
> namespaces request queues to make sure that we safely stop inflight I/O
> submissions. Freeze is mandatory because if our hctx map changed between
> reconnects, blk_mq_update_nr_hw_queues will immediately attempt to freeze
> the queue, and if it still has pending submissions (that are still
> quiesced) it will hang.
> 
> However, by freezing the namespaces request queues, and only unfreezing
> them when we successfully reconnect, inflight submissions that are
> running concurrently can now block grabbing the nshead srcu until either
> we successfully reconnect or ctrl_loss_tmo expired (or the user
> explicitly disconnected).
> 
> This caused a deadlock when a different controller (different path on the
> same subsystem) became live (i.e. optimized/non-optimized). This is
> because nvme_mpath_set_live needs to synchronize the nshead srcu before
> requeueing I/O in order to make sure that current_path is visible to
> future (re-)submisions. However the srcu lock is taken by a blocked
> submission on a frozen request queue, and we have a deadlock.
> 
> In order to fix this use the blk_mq_submit_bio_direct API to submit the
> bio to the low-level driver, which does not block on the queue free
> but instead allows nvme-multipath to pick another path or queue up the
> bio.

Almost...

This still has the same issue but instead of blocking on
blk_queue_enter() it is blocked on blk_mq_get_tag():
--
  __schedule+0x22b/0x6e0
  schedule+0x46/0xb0
  io_schedule+0x42/0x70
  blk_mq_get_tag+0x11d/0x270
  ? blk_bio_segment_split+0x235/0x2a0
  ? finish_wait+0x80/0x80
  __blk_mq_alloc_request+0x65/0xe0
  blk_mq_submit_bio+0x144/0x500
  blk_mq_submit_bio_direct+0x78/0xa0
  nvme_ns_head_submit_bio+0xc3/0x2f0 [nvme_core]
  __submit_bio_noacct+0xcf/0x2e0
  __blkdev_direct_IO+0x413/0x440
  ? __io_complete_rw.constprop.0+0x150/0x150
  generic_file_read_iter+0x92/0x160
  io_iter_do_read+0x1a/0x40
  io_read+0xc5/0x350
  ? common_interrupt+0x14/0xa0
  ? update_load_avg+0x7a/0x5e0
  io_issue_sqe+0xa28/0x1020
  ? lock_timer_base+0x61/0x80
  io_wq_submit_work+0xaa/0x120
  io_worker_handle_work+0x121/0x330
  io_wqe_worker+0xb6/0x190
  ? io_worker_handle_work+0x330/0x330
  ret_from_fork+0x22/0x30
--

--
  ? usleep_range+0x80/0x80
  __schedule+0x22b/0x6e0
  ? usleep_range+0x80/0x80
  schedule+0x46/0xb0
  schedule_timeout+0xff/0x140
  ? del_timer_sync+0x67/0xb0
  ? __prepare_to_swait+0x4b/0x70
  __wait_for_common+0xb3/0x160
  __synchronize_srcu.part.0+0x75/0xe0
  ? __bpf_trace_rcu_utilization+0x10/0x10
  nvme_mpath_set_live+0x61/0x130 [nvme_core]
  nvme_update_ana_state+0xd7/0x100 [nvme_core]
  nvme_parse_ana_log+0xa5/0x160 [nvme_core]
  ? nvme_mpath_set_live+0x130/0x130 [nvme_core]
  nvme_read_ana_log+0x7b/0xe0 [nvme_core]
  process_one_work+0x1e6/0x380
  worker_thread+0x49/0x300
--



If I were to always start the queues in nvme_tcp_teardown_ctrl
right after I cancel the tagset inflights like:
--
@@ -1934,8 +1934,7 @@ static void nvme_tcp_teardown_io_queues(struct 
nvme_ctrl *ctrl,
         nvme_sync_io_queues(ctrl);
         nvme_tcp_stop_io_queues(ctrl);
         nvme_cancel_tagset(ctrl);
-       if (remove)
-               nvme_start_queues(ctrl);
+       nvme_start_queues(ctrl);
         nvme_tcp_destroy_io_queues(ctrl, remove);
--

then a simple reset during traffic bricks the host on infinite loop
because in the setup sequence we freeze the queue in
nvme_update_ns_info, so the queue is frozen but we still have an
available path (because the controller is back to live!) so nvme-mpath
keeps calling blk_mq_submit_bio_direct and fails, and
nvme_update_ns_info cannot properly freeze the queue..
-> deadlock.

So this is obviously incorrect.

Also, if we make nvme-mpath submit a REQ_NOWAIT we basically
will fail as soon as we run out of tags, even in the normal path...

So I'm not exactly sure what we should do to fix this...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
