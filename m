Return-Path: <SRS0=ZkUF=BP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9C8C433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2020 07:10:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A8142075A
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2020 07:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zyxlp/u6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8142075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=chlSJ/FDtm6Ng3C7dhwh4OrwKR6/lYtQsr3SuzNL87k=; b=Zyxlp/u6IvBoxAERHu1/tbR12
	Fm5lMTucrtk/DUSDkn4FHH5lBbNOXYtK/HUy/Jo4SZlrNlg4P4OpbvLS2OH/CEXmbry60Z6durj7q
	835Io4Gakf7Nk8ehCMm1vJRGKOEaK2HUvaMqGnVjoKk8GvNzjXk89jeuCx6CtCqKvOLmhDR4h0762
	7Wkrg4T8E7ovz3yF81hTerrQG1Bg1iStYmc9zClhqvKwy/VWfEK0CBujTjQMok1k5DiA+KYU1m3dJ
	RSb+H1gwxPpqiwTXdggiL5ZI9bouLYPYXZKiMJsx9SEg02ihVCZrTt1ufrf1FjnFBhvJT0J8P5K87
	4H0k0wafw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3DZM-0006Qr-1w; Wed, 05 Aug 2020 07:10:36 +0000
Received: from mail-wm1-f66.google.com ([209.85.128.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3DYw-0006Dz-6L
 for linux-nvme@lists.infradead.org; Wed, 05 Aug 2020 07:10:33 +0000
Received: by mail-wm1-f66.google.com with SMTP id 3so5233421wmi.1
 for <linux-nvme@lists.infradead.org>; Wed, 05 Aug 2020 00:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tQHb/tp+KUm2C+jJYHJHAp2sHkCJ+K/mneQih4hLExE=;
 b=HapnXnpw9VrsGD46FQoA1h7mTK2Tl/IDPBpdVIwCpePY0sZkGkSG2LgDwCf+C9Caye
 Gt9Tk6BWRRSQVyPn7BCiZbqJUt3hlVNxYHdCNHDaBOqCW7blkYIIuB2qPO1w6G0YgftG
 bJasJPIQrEMPUONNnWFDQIhxuZCMKRTpF5Bw57JItefcMBwKCOZK2xC9fIHtMEhxLKW/
 24OaJ/F3spnn5PLyoX/5fLCh60AEuqo0yn/G6/ubUNrJCYePIZlo6+aRp0yh4pCGx0iT
 6+OCddf1sT1WckpzyzRuJKE3FlgEmlhKq69PAMzQ3EkysA1AlelUU2O6Nna+YHuGhe3M
 EsNQ==
X-Gm-Message-State: AOAM53089MwGHe7MwhQqLz+Y6FWo38qjBInTVT/G6zZeslTHbI4TJiOy
 BiEwh6a7DsL3/eJZ9GIowic=
X-Google-Smtp-Source: ABdhPJyv1s190f/nlssZQi9dNUMTWMpdeO4mX2gppRgH12GDmA/1hcDGLlijgyoxzVGZ66pMCmbdew==
X-Received: by 2002:a7b:c38e:: with SMTP id s14mr1931033wmj.124.1596611408041; 
 Wed, 05 Aug 2020 00:10:08 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:e1a8:cb16:c589:8b34?
 ([2601:647:4802:9070:e1a8:cb16:c589:8b34])
 by smtp.gmail.com with ESMTPSA id b203sm1530327wmc.22.2020.08.05.00.10.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2020 00:10:07 -0700 (PDT)
Subject: Re: [PATCH] nvme-core: fix deadlock when reconnect failed due to
 nvme_set_queue_count timeout
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
References: <20200805063335.19882-1-lengchao@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <02a20ae5-5af3-8595-c8b4-237449fbc1ee@grimberg.me>
Date: Wed, 5 Aug 2020 00:10:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805063335.19882-1-lengchao@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200805_031010_299530_BA69247E 
X-CRM114-Status: GOOD (  15.24  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> A deadlock happens When we test nvme over roce with link blink. The
> reason: link blink will cause error recovery, and then reconnect.If
> reconnect fail due to nvme_set_queue_count timeout, the reconnect
> process will set the queue count as 0 and continue , and then
> nvme_start_ctrl will call nvme_enable_aen, and deadlock happens
> because the admin queue is quiesced.

Why is the admin queue quiesced? if we are calling set_queue_count
it was already unquiesced?

> log:
> Aug  3 22:47:24 localhost kernel: nvme nvme2: I/O 22 QID 0 timeout
> Aug  3 22:47:24 localhost kernel: nvme nvme2: Could not set queue count
> (881)
> stack:
> root     23848  0.0  0.0      0     0 ?        D    Aug03   0:00
> [kworker/u12:4+nvme-wq]
> [<0>] blk_execute_rq+0x69/0xa0
> [<0>] __nvme_submit_sync_cmd+0xaf/0x1b0 [nvme_core]
> [<0>] nvme_features+0x73/0xb0 [nvme_core]
> [<0>] nvme_start_ctrl+0xa4/0x100 [nvme_core]
> [<0>] nvme_rdma_setup_ctrl+0x438/0x700 [nvme_rdma]
> [<0>] nvme_rdma_reconnect_ctrl_work+0x22/0x30 [nvme_rdma]
> [<0>] process_one_work+0x1a7/0x370
> [<0>] worker_thread+0x30/0x380
> [<0>] kthread+0x112/0x130
> [<0>] ret_from_fork+0x35/0x40
> 
> Many functions which call __nvme_submit_sync_cmd treat error code in two
> modes: If error code less than 0, treat as command failed. If erroe code
> more than 0, treat as target not support or other.

We rely in a lot of places on the nvme status being returned from
nvme_submit_sync_cmd (especially in nvme_revalidate_disk and for
path/aborted cancellations), and this patch breaks it. You need to find
a solution that does not hide the nvme status code from propagating
back.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
