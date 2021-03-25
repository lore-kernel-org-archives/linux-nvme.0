Return-Path: <SRS0=zNYX=IX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E94C433C1
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 16:31:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A315361993
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 16:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A315361993
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=idUWwi11xp+DZnpV5JWU7TMNibM6C0cZ4tTX/26c9xI=; b=pbFCDyuQUgRkjdE+7yzNsdq+w
	5tXixqsNnO8ID0+jCz1VEqviN1uWv5F/1zT8LRdegeLKgH7ydMN6mkihLZg7BXy+ss+PVXLebR85T
	eNNYuHmA0zsNluGovlC5b2lOX/ZVb8s42U1Vk5MsaeSC+ZiVRRhZPI2pBgDoyuHanUUqEY8et4VKf
	zXRy1eFXE97AJpujzgp9cZhoTxM9wdIgFrLrwBIpK0ldHs461qXBImvQxojYR1QxCp+yDW20eucp2
	cgV1OHkd6sYf1366zcD1JJ1ZaNNwBhQvJm1UoTo8mbhvvcuaLsVwUyT0SE64eiVLZThXQ37Mc6E86
	M0hNuOq6A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lPSsW-001pSH-IK; Thu, 25 Mar 2021 16:30:36 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPSsS-001pRp-Hh
 for linux-nvme@lists.infradead.org; Thu, 25 Mar 2021 16:30:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6A9D268BEB; Thu, 25 Mar 2021 17:30:29 +0100 (CET)
Date: Thu, 25 Mar 2021 17:30:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>,
 "javier@javigon.com" <javier@javigon.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: disallow passthru cmd from targeting a nsid !=
 nsid of the block dev
Message-ID: <20210325163028.GA737@lst.de>
References: <20210325094807.328126-1-Niklas.Cassel@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210325094807.328126-1-Niklas.Cassel@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210325_163032_726569_F994EA14 
X-CRM114-Status: GOOD (  13.42  )
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

On Thu, Mar 25, 2021 at 09:48:37AM +0000, Niklas Cassel wrote:
> @@ -1632,6 +1632,8 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>  		return -EFAULT;
>  	if (cmd.flags)
>  		return -EINVAL;
> +	if (ns && cmd.nsid != ns->head->ns_id)
> +		return -EINVAL;

Shouldn't we log something to the kernel log including the device
and current->comm?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
