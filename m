Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E69FC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 17:29:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF57064EAC
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 17:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF57064EAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nEihfxdxIaf10arO6FH1ESaTHfTsEgJOs8LPcgih9cY=; b=m9reXOnPcr/nQoC6+UZkK5D62
	OJQIDT27JZrJ5dCvsiRiYOAhWoH2AVXzCFmuUFBzBLwaIa2OvRYIqRrVk7dhYBvJR/5P4A9JHnCqp
	Y0Tmoe6i8JIw4AettLgCgzr8r7VAdv991FZndzZZ5CTdJ8UP5Tuj1SHHvX0W/mgMNhm+R3405Gp8+
	63JEp3hwZz6vhsSUUS3HSbgYStMfRGBM/rbiPPUDwkz2KJojmQsjGvMCLBXXFgu8A9FfIMBFW6bCG
	g+pK1uIGBgH12XzHuLRJY9zg5hXZA7tRHLwbQatml3aHhX0NybQl6rUBh870ExQ/0vo4I3vgiCurG
	vFOq5Cpow==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6d0v-0006Aa-Ev; Mon, 01 Feb 2021 17:29:25 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6d0t-0006A0-7B
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 17:29:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A4DAA6736F; Mon,  1 Feb 2021 18:29:21 +0100 (CET)
Date: Mon, 1 Feb 2021 18:29:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 06/10] nvmet: add helper to report invalid opcode
Message-ID: <20210201172921.GE12054@lst.de>
References: <20210201054138.34324-1-chaitanya.kulkarni@wdc.com>
 <20210201054138.34324-7-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210201054138.34324-7-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_122923_377817_2306CF37 
X-CRM114-Status: GOOD (  12.25  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Jan 31, 2021 at 09:41:34PM -0800, Chaitanya Kulkarni wrote:
> +static inline u16 nvmet_report_invalid_opcode(struct nvmet_req *req)
> +{
> +	char *backend;
> +
> +	if (req->ns->bdev)
> +		backend = "bdev";
> +	else if (req->ns->file)
> +		backend = "file";
> +	else if (nvmet_req_passthru_ctrl(req))
> +		backend = "passthru";
> +	else
> +		backend = "unknown";
> +
> +	pr_err("unhandled cmd %d on qid %d for %s backend\n",
> +		req->cmd->common.opcode, req->sq->qid, backend);

I think we can just skip reporting the backend, as this doesn't
really add much value.  In fact given that this can be triggered
remotely it should probably be downgraded to a pr_debug.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
