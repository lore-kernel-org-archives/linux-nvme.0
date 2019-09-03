Return-Path: <SRS0=NjBy=W6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD5CC3A5A2
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 20:14:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A3AA21897
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 20:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hLHHiIxP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3AA21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8xTLhTPcwapnCBqrhWO094YrpYiNQ9PJbK4MAB3Dk+4=; b=hLHHiIxPt86hiX
	8X6V+F+XYT0Dn0K+OUZJx+cxbrTTd/oXTEZEgPoqTWjpDjusUjqQ1VUVxZj5m3G7qu5lVNDveA1S8
	+OQJd0nHijVzSYJb3YMu9FogjCY/zPo6NJFU19U9RSUjtxY72kFcfevKcss7UrItNSuhc8xiMECLa
	I4Xpv07T4VkI5JI/+SteoAoNK4yhFGRixSpFK7wqulJZ47TrEIzzAbYgwqHqzsSNhjToz7U/0NsES
	lJ2j/YmlFH32Ux5pr6PNebWOqcp3i+RqyUYl/+qkMLBwX+/fAiyOUiRU8WE2tcMs8WiJ91fS8RRGd
	9b3fPZNkWKQ5M7txmgsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5FBg-0000Ug-Rh; Tue, 03 Sep 2019 20:14:00 +0000
Received: from mga06.intel.com ([134.134.136.31])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5FBe-0000U9-S0
 for linux-nvme@lists.infradead.org; Tue, 03 Sep 2019 20:14:00 +0000
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Sep 2019 13:13:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,464,1559545200"; d="scan'208";a="184879027"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
 by orsmga003.jf.intel.com with ESMTP; 03 Sep 2019 13:13:55 -0700
Date: Tue, 3 Sep 2019 14:12:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: Edmund Nadolski <edmund.nadolski@intel.com>
Subject: Re: [PATCH] nvme: include admin_q sync with nvme_sync_queues
Message-ID: <20190903201222.GA21115@localhost.localdomain>
References: <20190903200847.3378-1-edmund.nadolski@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190903200847.3378-1-edmund.nadolski@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190903_131358_945964_6827FA7D 
X-CRM114-Status: GOOD (  14.17  )
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
Cc: keith.busch@intel.com, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 03, 2019 at 02:08:47PM -0600, Edmund Nadolski wrote:
> nvme_sync_queues currently syncs all namespace queues, but should
> also sync the admin queue, if present.
> 
> Signed-off-by: Edmund Nadolski <edmund.nadolski@intel.com>

Looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

> ---
>  drivers/nvme/host/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 4660505eded9..43c12f8c030f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3974,6 +3974,9 @@ void nvme_sync_queues(struct nvme_ctrl *ctrl)
>  	list_for_each_entry(ns, &ctrl->namespaces, list)
>  		blk_sync_queue(ns->queue);
>  	up_read(&ctrl->namespaces_rwsem);
> +
> +	if (ctrl->admin_q)
> +		blk_sync_queue(ctrl->admin_q);
>  }
>  EXPORT_SYMBOL_GPL(nvme_sync_queues);
>  
> -- 
> 2.20.1

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
