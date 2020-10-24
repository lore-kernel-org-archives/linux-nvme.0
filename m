Return-Path: <SRS0=DIRN=D7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34A4C2D0A3
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Oct 2020 07:36:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D54BC20936
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Oct 2020 07:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KYaSpI3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54BC20936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UiBShZW9NZASxR6DC9Z8ER9DeFoYhARV3UqB1flg4k0=; b=KYaSpI3gZZ6S+rr+tbLO5wFdl
	hCPpYBnltQUGUsQtMoNHqXKw1mbzigvoGLHE2I+6grI9us8km8muzUjDNKGPv+NmcyIUH/lr+dXoY
	PfQUcPdsWV1UeRR+DOZLb5cflu1ohQzMUZ/sG+qLnx3J5R4TU8me1U7ARr4zz3hRn0VvZR6xJ3X7n
	p5eT6Runqr1M3aL/wwiDoIhWpcRjNTom51ujjvgYRu2dJMoXdhH8nMzeG1A9x6o3ZEyIT1VJZDOdz
	f8S2NhAMWzkcwy8M8ASKaFbGsz9NB/1nur43ABk4cMa7o7PWCDSKr8bSXHXEzTnQj+OubYbZr/hEV
	kncXuGDNw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kWE6P-0006ve-Gm; Sat, 24 Oct 2020 07:36:37 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kWE6F-0006vE-Uv
 for linux-nvme@lists.infradead.org; Sat, 24 Oct 2020 07:36:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A6AAA68AFE; Sat, 24 Oct 2020 09:36:21 +0200 (CEST)
Date: Sat, 24 Oct 2020 09:36:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2] nvme-rdma: handle nvme completion data length
Message-ID: <20201024073621.GA28151@lst.de>
References: <20201023065910.1358586-1-pizhenwei@bytedance.com>
 <d23e33e7-d545-2ad0-d163-5182dd5430b1@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d23e33e7-d545-2ad0-d163-5182dd5430b1@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201024_033628_116092_8EAA107D 
X-CRM114-Status: GOOD (  13.29  )
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
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, axboe@fb.com,
 zhenwei pi <pizhenwei@bytedance.com>, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Oct 23, 2020 at 11:01:40AM -0700, Sagi Grimberg wrote:
>>   +	/* received data length checking */
>> +	if (unlikely(wc->byte_len < len)) {
>> +		/* zero bytes message could be ignored */
>> +		if (!wc->byte_len) {
>> +			nvme_rdma_post_recv(queue, qe);
>> +			return;
>> +		}
>
> Nothing in the spec defines zero-length messages, hence we cannot
> support something that is not standard. If your array needs this,
> please submit a TPAR to the NVMe TWG.

We'll still need sanity checking instead of the recount underflow,
I think tearing down the connection here and kicking off error recovery
is probably the best idea.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
