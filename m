Return-Path: <SRS0=7pRJ=KP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8AEC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 06:49:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5029B61019
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 06:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5029B61019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ImEqRBWZNjVU8byKS+3Iq2VaTPIFBgYq5wwLDHJ5YpM=; b=LTSDr2fe2UPGTF0pyPCfXYBJ8
	js86MvpnXR+LuHfylblbv/vy7MR9V9LUwEZYIazp4ClJb+NiqW8c4qp9VDWK2LqDbyIyxZyBov28E
	rCpGAeJKT+cqXLvcuSwd+kIh/IFKt0FSJJZnmexDoKrTseWHmAV5qLVp54S+wQeXmGru2MTQLIfhD
	E3XkvkWpxt3L12aarp/cpJiAY7f7xvcPaX6zXA2d0Uo1bKsjI0PaoaM+/tITv2zBQ/e1HEXIj6yWa
	+daEvf7vijtHrBrJv8z3wH34XwRldlcyRlnUJJIQ5F8tJqV47W06Ws60CRIOgJrCiY6Hf/rV9bKQU
	tDKl1R2TA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljcUm-0064Rj-Pv; Thu, 20 May 2021 06:49:24 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljcUl-0064Rb-0S
 for linux-nvme@desiato.infradead.org; Thu, 20 May 2021 06:49:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=tURR7V+vj7PVqDXVCezPcklR6V7uWJSh5thRoYTHN2o=; b=5C4FpAYfjoZaZ0nHJurgswGWpP
 NYvu87mHFSzBJe6OUdQ+9qb/b6B4iT8fvy0UzQpXIPsWjIMms/W5t+adaxXCWTEaH2BRfQG7rdER4
 poyiKTmDuhIWatw+Rb8NEQxUtMZfzCiDzforoez28/VsqFqqja4nAz2cPgcieOTDytzZC5sVpWdNE
 7k7ZeOheSCAUjDw/ItcQRx8tNPDDnrocZ4ls/JJXoUJBCrRP1d54cR1XH6Pdu73ieQ0hkm70ALNJ0
 D7XScmuFwCqb0qK2/FE9kCd89ml2V8pelbJcWnNuCYwiSMOVwiOfGpjCcSoqTWY8jpLPQTdiNsSKH
 gR/0OLYw==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljcUf-00G0B8-M4
 for linux-nvme@lists.infradead.org; Thu, 20 May 2021 06:49:21 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 88C00B016;
 Thu, 20 May 2021 06:49:14 +0000 (UTC)
Date: Thu, 20 May 2021 08:49:14 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v2 4/4] nvme: code command_id with a genctr for
 use-after-free validation
Message-ID: <20210520064914.dhzj3n6tmchs575v@beryllium.lan>
References: <20210519174340.1144806-1-sagi@grimberg.me>
 <20210519174340.1144806-5-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210519174340.1144806-5-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210519_234917_890161_48EC324A 
X-CRM114-Status: GOOD (  12.22  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Sagi,

On Wed, May 19, 2021 at 10:43:40AM -0700, Sagi Grimberg wrote:
> +static inline struct request *nvme_find_rq(struct blk_mq_tags *tags,
> +		u16 command_id)
> +{
> +	u8 genctr = nvme_genctr_from_cid(command_id);
> +	u16 tag = nvme_tag_from_cid(command_id);
> +	struct request *rq;
> +
> +	rq = blk_mq_tag_to_rq(tags, tag);
> +	if (unlikely(!rq)) {
> +		pr_err("could not locate request for tag %#x\n",
> +			tag);
> +		return NULL;
> +	}
> +	if (unlikely(nvme_genctr_mask(nvme_req(rq)->genctr) != genctr)) {
> +		dev_err(nvme_req(rq)->ctrl->device,
> +			"request %#x genctr mismatch (got %#x expected %#x)\n",
> +			tag, genctr, nvme_req(rq)->genctr);

'nvme_genctr_mask(nvme_req(rq)->genctr)' for the expected value too?

Thanks,
Daniel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
