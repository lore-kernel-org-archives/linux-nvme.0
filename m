Return-Path: <SRS0=yQ2W=6E=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15A2C55181
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2020 22:34:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E1620857
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2020 22:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ebX9xBBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E1620857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wNY8TgWTVsl/ivLqMLzHup5uS83Qza9eJutDIxMoKDE=; b=ebX9xBBn/40bDx
	9rfFAGlcZQaV9IzrgF2sCNizP0i3qDaSxfePI+Mx2GJX9G0Fa+5rwCyaG8mIHKKLydZ/EkvFVZZQk
	srr5t7Lqgfn36wquPlsNNpomwtWuAKp5Lbl2BDas5XDE7Z8/+AsL3r1cOclpM0PSPKsqrJwLg+BfT
	wrBd+14dQY9Rw+PPBsZmL/yEgBit1nrZxxhFp8AOZCfD2fLuaJLLEtR6knq0jBK8HAcCKDApQQnm+
	CQvfbOFL2EeyZowcbogtTLlxUo/yfuEfzGhbXVFTTdKIRp4IhA2E8WtnQmOKC4NvxGltnMEEFQCh8
	vmLaGh2ZB9g+JzA/NTHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQezm-0007u9-Dd; Mon, 20 Apr 2020 22:34:30 +0000
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQezj-0007sT-Hm
 for linux-nvme@lists.infradead.org; Mon, 20 Apr 2020 22:34:28 +0000
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1jQezX-00056i-9U; Mon, 20 Apr 2020 16:34:16 -0600
To: Keith Busch <kbusch@kernel.org>
References: <20200420164700.21620-1-logang@deltatee.com>
 <20200420164700.21620-2-logang@deltatee.com>
 <20200420222646.GA11115@redsun51.ssa.fujisawa.hgst.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ce687c5d-eb19-e9b5-e03a-97dd2a04b4ea@deltatee.com>
Date: Mon, 20 Apr 2020 16:34:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200420222646.GA11115@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, maxg@mellanox.com,
 Chaitanya.Kulkarni@wdc.com, axboe@fb.com, sagi@grimberg.me, hch@lst.de,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 kbusch@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v12 1/9] nvme-core: Clear any SGL flags in passthru
 commands
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200420_153427_586589_B49AA32C 
X-CRM114-Status: GOOD (  15.05  )
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-04-20 4:26 p.m., Keith Busch wrote:
> On Mon, Apr 20, 2020 at 10:46:52AM -0600, Logan Gunthorpe wrote:
>> The host driver should decide whether to use SGLs or PRPs and they
>> currently assume the flags are cleared after the call to
>> nvme_setup_cmd(). However, passed-through commands may erroneously
>> set these bits; so clear them for all cases.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>  drivers/nvme/host/core.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 91c1bd659947..f5283b300e87 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -756,6 +756,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
>>  	case REQ_OP_DRV_IN:
>>  	case REQ_OP_DRV_OUT:
>>  		memcpy(cmd, nvme_req(req)->cmd, sizeof(*cmd));
>> +		/* passthru commands should let the driver set the SGL flags */
>> +		cmd->common.flags &= ~NVME_CMD_SGL_ALL;
>>  		break;
> 
> Is this really necessary? The passthrough handler currently rejects user
> commands that set command flags:

Yes, the flags coming from the passthru target's host (in subsequent
patches in this series) may have these set and we need to clear them
somewhere. The passthru code submits the requests directly using
blk_execute_rq_nowait() and thus the check in nvme_user_cmd() doesn't apply.

If I recall correctly, we had originally cleared the flags in the target
code, but Christoph had suggested it should be done more generally in
nvme_setup_cmd().

Logan

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
