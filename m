Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DD6C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 23:51:45 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49C6464F0C
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 23:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C6464F0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8AT08lSoo/SZJqP1ixzSkiUd8B1q8CoEUTQVA0my1nU=; b=pAGN40WPZMfO7keTV9GPQUgys
	m4UgYLk/SuMwKufZm9rlrJRwNi0KUdOGadbqh3eiqhjeQpbipo0kCu4xgKV5vR0jYUzOmO2aStFLS
	QWdqBERgrPLVxOOFzPHHERQzwv6dpilb8avJri1obw2cWe0fMA1/vBbJzSxxwHQ6htcS+ho3WJGOg
	bZC3L3K1uLp+Nn91HKESHHTvbdwalC0AQzBBnDlW3pWzN1a/7h0Js5ZPMMwQC9tupDbRSaSQ7wahK
	hjH31xN9yaDA8KvHMSUnBmC3tnvY9km1fWTmkWJ6KpnBN8kKLshUJSEbYcK3kMio1A5to2QcGt9Te
	Sd5y/q4jQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMJTN-0022Vr-3n; Tue, 16 Mar 2021 23:51:37 +0000
Received: from mail-pj1-f52.google.com ([209.85.216.52])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMJTH-0022VP-OK
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 23:51:34 +0000
Received: by mail-pj1-f52.google.com with SMTP id
 lr10-20020a17090b4b8ab02900dd61b95c5eso2198964pjb.4
 for <linux-nvme@lists.infradead.org>; Tue, 16 Mar 2021 16:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0Lr+QMBZziin5NE4DcBsUse59sKsWAOhb60A91h9WyI=;
 b=SGLtWYxVV3SMrwrkWhqwo75/NZ5QUmaCclpBcYtEoPcMDra3xycomYNJAowmMoLyE/
 UyFD3qT4ylYZas3YCfyKGSB5+XAP1DrpnCJ/9b2hdFSq7hV8UUsd7AFmOaSWJZ9yOAH4
 JCzuR5fjaNDOv4yiknChAnrLZWP5JUH+I1nuAs1Tx8KSB7eEA5wxDOzou50udXtScsJn
 7mZGI1VLAmadkSo54bef49XyhUqjT7+FV1STO9AnClC1W2a6qDB+eLEa9rQIIJPtTXPH
 7T+NsGI984NyVLXtZ8CLadJ+ND0jHO/pxG94nM7WqRgyNTOlGzsT6C2do9l1BI1MM1NM
 EuOw==
X-Gm-Message-State: AOAM532xM5/v61CmgGyoBYuNkM/GnyseQqRLaI2A9MqgYCI/bq4Dp2Go
 XFh9tTa1ejKuRkBWqPZ515PS0/6AYWU=
X-Google-Smtp-Source: ABdhPJw6fEu34Rw0FrgoDLzvEV7yS0TxoASBgbuwZDw6K9hlcnkRoJTOAIU1pN0rTrwETOV8OksaIQ==
X-Received: by 2002:a17:90b:909:: with SMTP id
 bo9mr1445779pjb.107.1615938690491; 
 Tue, 16 Mar 2021 16:51:30 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:52e4:89ef:d916:a3a6?
 ([2601:647:4802:9070:52e4:89ef:d916:a3a6])
 by smtp.gmail.com with ESMTPSA id d124sm18036991pfa.149.2021.03.16.16.51.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Mar 2021 16:51:29 -0700 (PDT)
Subject: Re: [PATCH 0/3 rfc] Fix nvme-tcp and nvme-rdma controller reset hangs
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20210315222714.378417-1-sagi@grimberg.me>
 <1b2ccda9-5789-e73a-f0c9-2dd40f320203@grimberg.me>
 <20210316204204.GA23332@redsun51.ssa.fujisawa.hgst.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <59f7a030-ea33-5c31-3c18-197c5a12e982@grimberg.me>
Date: Tue, 16 Mar 2021 16:51:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210316204204.GA23332@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_235131_908454_F1BBCCE0 
X-CRM114-Status: GOOD (  21.71  )
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


>>> These patches on their own are correct because they fixed a controller reset
>>> regression.
>>>
>>> When we reset/teardown a controller, we must freeze and quiesce the namespaces
>>> request queues to make sure that we safely stop inflight I/O submissions.
>>> Freeze is mandatory because if our hctx map changed between reconnects,
>>> blk_mq_update_nr_hw_queues will immediately attempt to freeze the queue, and
>>> if it still has pending submissions (that are still quiesced) it will hang.
>>> This is what the above patches fixed.
>>>
>>> However, by freezing the namespaces request queues, and only unfreezing them
>>> when we successfully reconnect, inflight submissions that are running
>>> concurrently can now block grabbing the nshead srcu until either we successfully
>>> reconnect or ctrl_loss_tmo expired (or the user explicitly disconnected).
>>>
>>> This caused a deadlock [1] when a different controller (different path on the
>>> same subsystem) became live (i.e. optimized/non-optimized). This is because
>>> nvme_mpath_set_live needs to synchronize the nshead srcu before requeueing I/O
>>> in order to make sure that current_path is visible to future (re)submisions.
>>> However the srcu lock is taken by a blocked submission on a frozen request
>>> queue, and we have a deadlock.
>>>
>>> For multipath, we obviously cannot allow that as we want to failover I/O asap.
>>> However for non-mpath, we do not want to fail I/O (at least until controller
>>> FASTFAIL expires, and that is disabled by default btw).
>>>
>>> This creates a non-symmetric behavior of how the driver should behave in the
>>> presence or absence of multipath.
>>>
>>> [1]:
>>> Workqueue: nvme-wq nvme_tcp_reconnect_ctrl_work [nvme_tcp]
>>> Call Trace:
>>>    __schedule+0x293/0x730
>>>    schedule+0x33/0xa0
>>>    schedule_timeout+0x1d3/0x2f0
>>>    wait_for_completion+0xba/0x140
>>>    __synchronize_srcu.part.21+0x91/0xc0
>>>    synchronize_srcu_expedited+0x27/0x30
>>>    synchronize_srcu+0xce/0xe0
>>>    nvme_mpath_set_live+0x64/0x130 [nvme_core]
>>>    nvme_update_ns_ana_state+0x2c/0x30 [nvme_core]
>>>    nvme_update_ana_state+0xcd/0xe0 [nvme_core]
>>>    nvme_parse_ana_log+0xa1/0x180 [nvme_core]
>>>    nvme_read_ana_log+0x76/0x100 [nvme_core]
>>>    nvme_mpath_init+0x122/0x180 [nvme_core]
>>>    nvme_init_identify+0x80e/0xe20 [nvme_core]
>>>    nvme_tcp_setup_ctrl+0x359/0x660 [nvme_tcp]
>>>    nvme_tcp_reconnect_ctrl_work+0x24/0x70 [nvme_tcp]
>>>
>>>
>>> In order to fix this, we recognize the different behavior a driver needs to take
>>> in error recovery scenarios for mpath and non-mpath scenarios and expose this
>>> awareness with a new helper nvme_ctrl_is_mpath and use that to know what needs
>>> to be done.
>>
>> Christoph, Keith,
>>
>> Any thoughts on this? The RFC part is getting the transport driver to
>> behave differently for mpath vs. non-mpath.
> 
> Will it work if nvme mpath used request NOWAIT flag for its submit_bio()
> call, and add the bio to the requeue_list if blk_queue_enter() fails? I
> think that looks like another way to resolve the deadlock, but we need
> the block layer to return a failed status to the original caller.

But who would kick the requeue list? and that would make 
near-tag-exhaust performance stink...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
