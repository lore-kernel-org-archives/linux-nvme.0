Return-Path: <SRS0=VrRv=6P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C74C4724C
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 16:19:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98B8E2166E
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 16:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RzrpWGYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B8E2166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TzJvMCxkDoV+DpHa5HpF13AYMyk+PMGN+++dYAfgQ8Y=; b=RzrpWGYEzF39Di
	c3roaZV9fJVWUu3QB62XHi9GgmgNVJMMGq2bHfY1f3y6WJrBXb/wrBDP+BWv5nKXrposoWMZC/cxF
	i5QjurymHIvQ2cKTZ56KPYbszscSpym3FAsOhYcUoMLLw7eDEyLw3Vw8QzjaCjhXDCYz3mDFtcRsk
	LAHQ4+sCq1yEMS+WO+dcBTZG3SCwr7CoMmn6U0/MxJCbVpaokeMBYOr7p29PW99rmEAiYO442sXMq
	VP28i4W2aqS0eoAkxGe5QnM/GQ0YI/jULx+4Nw/964N1sxCfhuB7E80RHAmm2eeYM0yJE+CgmKBY8
	xzlasUHEISY6dRqv76SA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jUYO8-0005TT-FT; Fri, 01 May 2020 16:19:44 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jUYO6-0005Sf-BW
 for linux-nvme@lists.infradead.org; Fri, 01 May 2020 16:19:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6BAF468BFE; Fri,  1 May 2020 18:19:39 +0200 (CEST)
Date: Fri, 1 May 2020 18:19:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 13/15] nvmet: add metadata/T10-PI support
Message-ID: <20200501161939.GD17680@lst.de>
References: <20200428131135.211521-1-maxg@mellanox.com>
 <20200428131135.211521-14-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200428131135.211521-14-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200501_091942_543786_2E4B7056 
X-CRM114-Status: UNSURE (   7.31  )
X-CRM114-Notice: Please train this message.
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
Cc: axboe@kernel.dk, jsmart2021@gmail.com, sagi@grimberg.me,
 martin.petersen@oracle.com, shlomin@mellanox.com, israelr@mellanox.com,
 vladimirk@mellanox.com, linux-nvme@lists.infradead.org, idanb@mellanox.com,
 oren@mellanox.com, kbusch@kernel.org, nitzanc@mellanox.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

>  
> +static inline u32 nvmet_rw_md_len(struct nvmet_req *req)
> +{
> +	return ((u32)le16_to_cpu(req->cmd->rw.length) + 1) *
> +			req->ns->metadata_size;
> +}

> +static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
> +{
> +	if (!IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY))
> +		return false;
> +	return ns->pi_type && ns->metadata_size == sizeof(struct t10_pi_tuple);
> +}

Nit: Can you add the nvmet_ns_has_pi no in the middle of the helpers
that parse the comment, but in a different place?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
