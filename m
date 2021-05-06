Return-Path: <SRS0=D26X=KB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF04C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 07:38:16 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99F6D61185
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 07:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F6D61185
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xZNpuMUtbMwI6KrsypZCc1wuZnKVi0kwA4LCYzGRWD0=; b=lm/BEhztrMAWNQaXP8WmU8IJv
	AJ2XH+nFrNeJi58XJDJOGMyIcKImqikvuYjuJmCjjIAlY4eUE5AkuA6kJCAPePVlXZhznaBP6tHV+
	cQV6AO9CNdiLbLmi4KjDgNQP5pVOmJDNF/IPlZvrU4SIkfBHSF8LTO2r4ySATmBfk5Lw89/PpzeHn
	Yrr5iesb5cJhcNkgoUPsuajwBV0bJhTJbg33hKMxdVkzGvBpjUaPNCgCtSUJk0dmCjMlVNrJv0U1w
	EYEROMjBHL1eAUTsD8qBrNFWywC3JC1pLk0fUr78Udq2TxZ/fsfDGcxr9xdIS+NgaKR9DSXDZ2hLq
	8ioE7hklw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leYa1-003Vee-RO; Thu, 06 May 2021 07:37:54 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leYZz-003Ve5-UA
 for linux-nvme@desiato.infradead.org; Thu, 06 May 2021 07:37:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=nACelbEvlRYo4RrQHFXIFTaTQ6ypT78ITNr4Vf4tKcA=; b=WTIrqn7nyIA0JIQlLb1gi7TBdJ
 n3/C6ze93koWFvrWBXrxpzC+i+xNjRiqrBKP2KGf0k2VENUbGWIekfjbu+tQyBCoVsn15bdTGK3t8
 brc64yN0N0+hS0LpzOmRbaJEeHFQfSpAiNtdjI/fVoAECQ5sUs79jReXDakDnEXxyIfDZokXCEFnO
 YwGaEsEcjkwIL5BTFidXgpDat2RfRhUAaFoexvxB9dlzvuIJxEqtbbzTEtR1zhm7b/fOFdAAqeIhI
 2VVOd4Y7YsFzeVXvEZ7yXxLbxjnFGqamL4jWqYcAWml9lxaiaVReOiXt9FtvwDbV6AkEmSvwoJIrH
 0sBcU/gQ==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leYZx-005fkw-1M
 for linux-nvme@lists.infradead.org; Thu, 06 May 2021 07:37:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 155B96736F; Thu,  6 May 2021 09:37:41 +0200 (CEST)
Date: Thu, 6 May 2021 09:37:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: generate uevent once a multipath namespace is
 operational again
Message-ID: <20210506073740.GB14615@lst.de>
References: <20210505103305.107475-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210505103305.107475-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210506_003749_263043_FE336D5B 
X-CRM114-Status: GOOD (  14.75  )
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

On Wed, May 05, 2021 at 12:33:05PM +0200, Hannes Reinecke wrote:
> In an all paths down scenario I/O will be requeued or aborted, so no
> further I/O will be ongoing on this namespace.
> This leaves upper layers like MD unable to determine if the namespace
> becomes operational again after a successful controller reset.
> This patch will send an uevent per multipathed namespace once the
> underlying controller is LIVE, allowing MD to start resync.

Do we have any documentation or other exampes for this KOBJ_CHANGED
magic?  I've seen it in a few places, but it always seemed rather
cargo cult to me.  If you have a more insights any chance you could
document it?

> +		if (ctrl->state == NVME_CTRL_LIVE)
> +			kobject_uevent(&disk_to_dev(ns->head->disk)->kobj,
> +				       KOBJ_CHANGE);

Also this should probably use disk_uevent to also notify partitions.
Maybe also for other existing callers.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
