Return-Path: <SRS0=LCWA=KG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C562C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 16:42:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C10AC61182
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 16:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10AC61182
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nLk5NVYk5yP7ariAqonzYCH/FmqZbmI53o7UlVmu8iQ=; b=GF6zwf1iuSFmjKPXeggiM61nD
	s94mpEbfLLVsYMWI9O5e/N8Y7Au/zz3jUj+lG11Q0BfBe6Gj1iLgP2FUIHkgSARTso5O2dRlu0QEP
	hqlzzc9kFPb6jCPwooKVwDiDFHSEIYekBYZHUed898VUsG0SGIdpPrjrwO8V5ZYzhpNn13sEnzOFS
	V3BIKBR08rwT8P20LZiUlsur9uioB0S+h2mAHvih7SMPC4zb+J5yXbAyNurah5Om0R6QryicsoH/r
	g6hIgUtJF+yC5LfkQpKgXx74Fm0cSihsan4Yvi1KAir9OLr/pqwfPvMf5AvgWohi7PhK0NX3+aa97
	VfLA6Rw5A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgVSb-000n7H-7D; Tue, 11 May 2021 16:42:17 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgVD7-000jWU-Sn
 for linux-nvme@desiato.infradead.org; Tue, 11 May 2021 16:26:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=YUIaV3XVUF7IHfRKR6Qfx13INGgsy97HvbkfyxUCiyM=; b=hdIwhxMtySbTMrrnNG74Ek+UsK
 SEefXX39k4GHmeo+AQEJKbBcgmGzZbv6J30dAPdv3tjrfNxP+wW4buUv9NsWtojzmuX232giDtLmK
 H+oeIniK8tA1GB9M3i9UGDaFZR90hBbuA2y1MrzdSFKl5jrhvL8h2EE+kMyHPkGDtVOM6QTQejXn9
 qyLQkzeav3gMaOVL+PyalDVneKcOgHdAuabSjm78xQFokT41y429KVzLuL2z4fzA2MRTUxmR+oFPa
 NYStbHGD6lY7ujySrCg9gKQOHMOtWe+n1G8xiNJCowyFfOba0V6pwIOSETFaaz6IMfBmHyMrSSf3f
 PwAYqGwg==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgVD5-009lL4-5T
 for linux-nvme@lists.infradead.org; Tue, 11 May 2021 16:26:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E261267373; Tue, 11 May 2021 18:26:11 +0200 (CEST)
Date: Tue, 11 May 2021 18:26:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv3] nvme: allow to re-attach namespaces after all paths
 are down
Message-ID: <20210511162611.GA17617@lst.de>
References: <20210511075919.139624-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210511075919.139624-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210511_092615_370582_BFD4545E 
X-CRM114-Status: GOOD (  13.43  )
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

>  	} else {
>  		ret = -EINVAL;
> +		/*
> +		 * If multipath is enabled we might hit an ns head with no
> +		 * paths, but that doesn't indicate it's a shared namespace.
> +		 */
> +		if (nvme_ns_head_multipath(head) &&
> +		    list_empty(&head->list))
> +			goto check_ids;
>  		if (!is_shared || !head->shared) {
>  			dev_err(ctrl->device,
>  				"Duplicate unshared namespace %d\n", nsid);
>  			goto out_put_ns_head;
>  		}
> +check_ids:

I think this should simply be:

		if (!list_empty(&head->list) && (!is_shared || !head->shared)) {
 			dev_err(ctrl->device,
  				"Duplicate unshared namespace %d\n", nsid);
  			goto out_put_ns_head;
  		}

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
