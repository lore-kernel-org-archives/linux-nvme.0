Return-Path: <SRS0=MxcY=4O=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27C7C4BA0B
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 10:44:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2AFD24673
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 10:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dUEvlT66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2AFD24673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X63oBf8Ff/xoyFRxK+UTn4gPceBOFlMD5sd8zC0onkk=; b=dUEvlT66tY2pI6
	lFkm7jPKusSkv8A2d+IZSqJxoZO0nGGiWH3wqWsSgVTQCuBzyzZL9SFOH4LwuYtFeeVot8fwqP2KR
	s+ScrQHgmHe5ViOXe5UBBYRYAIuZ2tB+mgK2OmsHMB0F9cIi+KC7qPTNqGbysM8Y4HO+4oCxfcMcN
	2woPTF8jTfDpjVvJbqk+P2KACoJOA5wj8opWLXXNfOlsDJr5te4eJ0jh8JPKrz+LIs7ZUEGLLq2/T
	NctDBM7OFL6TP+leTAKw84Ja1NksUuGy9YXxY6pxOK/vyU+7Fro6H0Gk0Y9rCNwOQ5Lmv3NRBVo70
	o7+7vdOMx0IiElgiRIEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j6uAl-0006N7-Gf; Wed, 26 Feb 2020 10:44:11 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6uAj-0006Mh-Dq
 for linux-nvme@lists.infradead.org; Wed, 26 Feb 2020 10:44:10 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5C95BB028;
 Wed, 26 Feb 2020 10:44:05 +0000 (UTC)
Message-ID: <285681d11e1164693666eeaead4926159d89549f.camel@suse.com>
Subject: Re: [PATCH RFC] nvme/fc: sq flow control
From: Martin Wilck <mwilck@suse.com>
To: Hannes Reinecke <hare@suse.de>, Keith Busch <keith.busch@wdc.com>
Date: Wed, 26 Feb 2020 11:44:04 +0100
In-Reply-To: <20200225235956.28475-1-hare@suse.de>
References: <20200225235956.28475-1-hare@suse.de>
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200226_024409_614150_D107EFF5 
X-CRM114-Status: GOOD (  15.38  )
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
Cc: linux-nvme@lists.infradead.org, John Meneghini <john.meneghini@netapp.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, 2020-02-26 at 00:59 +0100, Hannes Reinecke wrote:
> As per NVMe-oF spec sq flow control is actually mandatory, and we
> should
> be implementing it to avoid the controller to return a fatal status
> error, and try to play nicely with controllers using sq flow control
> to implement QoS.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/nvme/host/fc.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index a19ddb61039d..628397bd5065 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> ...
> @@ -2177,6 +2181,18 @@ nvme_fc_unmap_data(struct nvme_fc_ctrl *ctrl,
> struct request *rq,
>  	freq->sg_cnt = 0;
>  }
>  
> +static int nvme_fc_update_sq_tail(struct nvme_fc_queue *queue, int
> incr)
> +{
> +	int old_sqtl, new_sqtl;
> +
> +	do {
> +		old_sqtl = queue->sq_tail;
> +		new_sqtl = (old_sqtl + incr) % queue->ctrl-
> >ctrl.sqsize;
> +	} while (cmpxchg(&queue->sq_tail, old_sqtl, new_sqtl) !=
> +		 old_sqtl);

Shouldn't you use READ_ONCE() to update old_sqtl, or better even, use
the return value of cmpxchg()?

Regards
Martin



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
