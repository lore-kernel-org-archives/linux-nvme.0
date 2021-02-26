Return-Path: <SRS0=j6C5=H4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9A1C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 09:10:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3A5E64E6B
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 09:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A5E64E6B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lWCGvyIIlZnv/axTMZUeaSAe5k+b1xbYKaZvURSqQ40=; b=JpYmUxKI9/QKjKYqlSF3f5UfJ
	kauAqP6zWXckkyQeHAjIdwVxY9r8z63HpgahJAJEnUrpm5fdYxD0EsfkkVV/q9fJxP2xjKELBe8hp
	dp/h+iqIk32Hlgi/VjzkNtKlVzKFT39zEwEEXTh2hD7PHQwo+mAsmvYjDTLXli/S0cho3GnhzRxAh
	cB728YZKKX3X8+x0gVKI0aC69gnktylnTn83Zk5vLRimbY8RBaCLtoQWh5+zOocody2wSnE+lbGlR
	/0Pur4jl6Yi5OG2ccIbAZThlK3lwKM83aF0Qrzmh/HWJqAc2HaKkZgJUM+UVjNZlQJsvFbM8QSME7
	Iwe+CMTcw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFZ8U-0001cB-5I; Fri, 26 Feb 2021 09:10:10 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFZ8Q-0001bM-E7
 for linux-nvme@lists.infradead.org; Fri, 26 Feb 2021 09:10:07 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id EC56EAAAE;
 Fri, 26 Feb 2021 09:10:01 +0000 (UTC)
Date: Fri, 26 Feb 2021 10:10:01 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/4] nvme: simplify error logic in nvme_validate_ns()
Message-ID: <20210226091001.jywzp35yjpr6ng4d@beryllium.lan>
References: <20210226071728.106923-1-hare@suse.de>
 <20210226071728.106923-2-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210226071728.106923-2-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210226_041006_594008_873277E6 
X-CRM114-Status: GOOD (  14.67  )
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
Cc: Keith Busch <kbusch@kernel.org>, Keith Busch <keith.busch@wdc.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Hannes,

On Fri, Feb 26, 2021 at 08:17:25AM +0100, Hannes Reinecke wrote:
> @@ -4045,7 +4045,7 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
>  	if (ret)
>  		goto out;
>  
> -	ret = -ENODEV;
> +	ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
>  	if (!nvme_ns_ids_equal(&ns->head->ids, ids)) {
>  		dev_err(ns->ctrl->device,
>  			"identifiers changed for nsid %d\n", ns->head->ns_id);
> @@ -4063,7 +4063,7 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
>  	 *
>  	 * TODO: we should probably schedule a delayed retry here.
>  	 */
> -	if (ret && ret != -ENOMEM && !(ret > 0 && !(ret & NVME_SC_DNR)))
> +	if (ret > 0 && (ret & NVME_SC_DNR))
>  		nvme_ns_remove(ns);

I think Chao's comment still holds, nvme_update_ns_info() can return
-EINVAL, -IEO or -ENODEV. Don't we have to remove the NS in these
cases?

Thanks,
Daniel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
