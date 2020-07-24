Return-Path: <SRS0=Gu9/=BD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BFAC433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 19:40:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56C772070B
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 19:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mPxjQzGN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="RK8P9qip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C772070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4xXG8MVOfKrJ95cXo3VYQF4hlvzXkCMmrKiJUsb4KKE=; b=mPxjQzGNQkOaRqfBDQ2zkHSgn
	YOdPXhXyGpVYOqHmYgn86qQUj96PZ66pz9anyeFjOTy7A/1io+4vdTxKcPob0AYTw0wRrtH0tKBM1
	H5dDjAjmaSIel10PDm5NelTowGBM+mPJHxg9B/PquMB5ht2KX5+QRnQgPqK9hERUtkZO1d+TtNnnw
	DEwTb43g2Ub8zzqNJnR5oyqRr+ZROKZzr6GU69rGR2UUvPDcyvaVNlDGacbhKGEAkqnAcXAVOUnUx
	TUpKT7CxvrRwh6M5NnZQsrKx/hF6r5lTf+AgHfgzbpzEz/HSkxqKXy6NFUwZxzJMZz/5sqouTvdyb
	5by9TPl9w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jz3Ya-0004KP-V6; Fri, 24 Jul 2020 19:40:37 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz3YZ-0004Jm-3W
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 19:40:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1+/vH/LNVq3z6IyOwmadh9LNf0EtvgbHbnnQfZcGz+s=; b=RK8P9qip85bzZhXDx0HGVg69BB
 RZr1EuZ7AxNgcRDhNl+yiYPUN/e3q7FftCv2bOWx7v4pJE3Vio3JKK4KyMdkKCwrSWJxsybtARvUY
 JADz0/l/bbHKzv1qIDqW9xrLam5tMqbfcntdvDzXKnUB3LSXtiq21mIPuiZdJW9lyLuO9p/AUC+7Q
 WGSU5yvbz1b6iIi/Vllc+/by9T5bo+kOaQ98imKJU2FZsaKgq4CKZ8T5Y6bJ/umucVltBTaodx18S
 5vxdDkr1MO/Z2e/PgN+/rYCniT2qDtmaMpi+nJHZjAdgQpMaFWlCwxiQ6QxTdGh552ffedRdFXEYO
 IFlnmb2Q==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1jz3YQ-0001DC-LM; Fri, 24 Jul 2020 13:40:27 -0600
To: Keith Busch <kbusch@kernel.org>
References: <20200724172520.16318-1-logang@deltatee.com>
 <20200724172520.16318-7-logang@deltatee.com>
 <20200724193351.GA2857771@dhcp-10-100-145-180.wdl.wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d5c64c38-066c-013c-7a79-46230e439c5e@deltatee.com>
Date: Fri, 24 Jul 2020 13:40:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724193351.GA2857771@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: sbates@raithlin.com, maxg@mellanox.com,
 Chaitanya.Kulkarni@wdc.com, axboe@fb.com, sagi@grimberg.me, hch@lst.de,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 kbusch@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v16 6/9] nvmet-passthru: Add passthru code to process
 commands
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200724_154035_165444_B81D6DDE 
X-CRM114-Status: GOOD (  16.52  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 Jens Axboe <axboe@fb.com>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-07-24 1:33 p.m., Keith Busch wrote:
> On Fri, Jul 24, 2020 at 11:25:17AM -0600, Logan Gunthorpe wrote:
>> +	/*
>> +	 * The passthru NVMe driver may have a limit on the number of segments
>> +	 * which depends on the host's memory fragementation. To solve this,
>> +	 * ensure mdts is limitted to the pages equal to the number of
> 
>                           limited
> 
>> +	/* don't support fuse commands */
>> +	id->fuses = 0;
> 
> If a host were to set a fuse, the target should return an Invalid Field
> error. Just to future-proof, rejecting commands with any flags set
> (other than SGL, which you handled in patch 1/9) is probably what should
> happen, like:

> 
>> +u16 nvmet_parse_passthru_io_cmd(struct nvmet_req *req)
>> +{
> 
> 	if (req->cmd->common.flags & ~NVME_CMD_SGL_ALL)
> 		return NVME_SC_INVALID_FIELD;


Yes, this seems like a good idea. I can add it.

> Or maybe we could obviate the need for 1/9 with something like:
> 
> 	req->cmd->common.flags &= ~NVME_CMD_SGL_ALL;
> 	if (req->cmd->common.flags)
> 		return NVME_SC_INVALID_FIELD;

We used to clear the SGL flags in the target passthru code but Christoph
asked that it be done in the host code, hence patch 1/9.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
