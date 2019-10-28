Return-Path: <SRS0=TJkX=YV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A556CA9EC1
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2019 16:59:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5885F208C0
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2019 16:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KxcLlf9A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5885F208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H3sX9YZoG/dbs2lq6AIMYEJDfceLvCow2E2lrrOdJew=; b=KxcLlf9A7aI0Kz
	jKopnBk3Ulv7Uln3WaR3jYYxzBn5PcfmzDlnLWmk5U1Cq8IZ7lzB5eUZrbZ4OugGtnALS1kzyCp4H
	p3W+xWOJ7lUZ0iAjsXXzgHKadiM2fyav5lKMzlfRraVrlAPQH3exA44dvb/8p9/SVPLCCmuCnbzEF
	okbOOsdva1z+R/CBOPHsAFs16F93As2oy3eds8w+0uH81GlHKTjyZyzx9BlaMhdZOVPvkit8ro/7h
	P5pgq/VDbrkMwhAudHRtn2dP1Cj4ff0SuCN7STIiam+yZ3eUGUyPtZTpp3NKW5KG3RVD6GB2IdZc4
	tcawKD2EB4XnK6FXEBnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iP8ML-0000dT-Bv; Mon, 28 Oct 2019 16:59:13 +0000
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iP8MG-0000bl-W9
 for linux-nvme@lists.infradead.org; Mon, 28 Oct 2019 16:59:10 +0000
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.89)
 (envelope-from <logang@deltatee.com>)
 id 1iP8M5-00089J-Ka; Mon, 28 Oct 2019 10:58:58 -0600
To: Christoph Hellwig <hch@lst.de>
References: <20191025202535.12036-1-logang@deltatee.com>
 <20191025202535.12036-4-logang@deltatee.com> <20191027150937.GC5843@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <94c1e177-4848-c88b-ec26-3da118fd18dc@deltatee.com>
Date: Mon, 28 Oct 2019 10:58:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191027150937.GC5843@lst.de>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, maxg@mellanox.com,
 Chaitanya.Kulkarni@wdc.com, kbusch@kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH 3/3] nvme: Introduce nvme_execute_passthru_rq_nowait()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191028_095909_391015_4B0DD194 
X-CRM114-Status: GOOD (  19.35  )
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
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2019-10-27 9:09 a.m., Christoph Hellwig wrote:
> On Fri, Oct 25, 2019 at 02:25:35PM -0600, Logan Gunthorpe wrote:
>> This function is similar to nvme_execute_passthru_rq() but does
>> not wait and will call a callback when the request is complete.
>>
>> The new function can also be called in interrupt context, so if there
>> are side effects, the request will be executed in a work queue to
>> avoid sleeping.
> 
> Why would you ever call it from interrupt context?  All the target
> submission handlers should run in process context.

Oh, I mis-understood this a bit and worded that incorrectly. The intent
is to avoid having to call nvme_passthru_end() in the completion handler
which can be in interrupt context.

>> +void nvme_execute_passthru_rq_nowait(struct request *rq, rq_end_io_fn *done)
>> +{
>> +	struct nvme_command *cmd = nvme_req(rq)->cmd;
>> +	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
>> +	struct nvme_ns *ns = rq->q->queuedata;
>> +	struct gendisk *disk = ns ? ns->disk : NULL;
>> +	u32 effects;
>> +
>> +	/*
>> +	 * This function may be called in interrupt context, so we cannot sleep
>> +	 * but nvme_passthru_[start|end]() may sleep so we need to execute
>> +	 * the command in a work queue.
>> +	 */
>> +	effects = nvme_command_effects(ctrl, ns, cmd->common.opcode);
>> +	if (effects) {
>> +		rq->end_io = done;
>> +		INIT_WORK(&nvme_req(rq)->work, nvme_execute_passthru_rq_work);
>> +		queue_work(nvme_wq, &nvme_req(rq)->work);
> 
> But independent of the target code - I'd much rather leave this to the
> caller.  Just call nvme_command_effects in the target code, then if
> there are not side effects use blk_execute_rq_nowait directly, else
> schedule a workqueue in the target code and call
> nvme_execute_passthru_rq from it.

Ok, that seems sensible. Except it conflicts a bit with Sagi's feedback:
presumably we need to cancel the work items during nvme_stop_ctrl() and
that's going to be rather difficult to do from the caller. Are we saying
this is unnecessary? It's not clear to me if passthru_start/end is going
to be affected by nvme_stop_ctrl() which I believe is the main concern.

Logan


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
