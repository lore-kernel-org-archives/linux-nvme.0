Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD8BC47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 05:23:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E73356023E
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 05:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73356023E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wMCOXQkRgt4QVLebVFakZn/DZ73FA3Gxp+FhZjFbd60=; b=qBFqG+A+rr1iKb
	QttGzmP3DAD5HG/SXtRgfob+++ELCprayqhGFD4MB+kOBTKsYOjCWoewgtOUypkIkOCElkC2LdeRQ
	O0wzwrnCRG+uBbsc5UYklVbVzi0S/Pr78sy4hm1YwfmPuUtIL0ecGKNP/ZP97IVMKjQciSLlPpJxo
	2DeFTiO9DMZPod3X4MNWXBoIBdMNDW49iviKlcaS0tAXb2HaA3mEdbssdRd9GJGvRO0Druq2+EEnx
	LAZirwIynYxYwuCRrisLwCKolP2HLcizeiJ2OhwPrPLZu9eWtWlD5tT3KCawpRKIPYxRnKQVLno34
	osQc7+ncYgRv6eTW3tug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqUD6-006Wwh-UD; Tue, 08 Jun 2021 05:23:32 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqUD4-006WuN-CS
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 05:23:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E443E67373; Tue,  8 Jun 2021 07:23:20 +0200 (CEST)
Date: Tue, 8 Jun 2021 07:23:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Wu Bo <wubo40@huawei.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linfeilong@huawei.com
Subject: Re: [PATCH] nvme-multipath: combine grpid and ANA state checks in
 nvme_parse_ana_log()
Message-ID: <20210608052320.GA13828@lst.de>
References: <1623125616-629270-1-git-send-email-wubo40@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1623125616-629270-1-git-send-email-wubo40@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_222330_591509_5D867072 
X-CRM114-Status: GOOD (  10.90  )
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

On Tue, Jun 08, 2021 at 12:13:36PM +0800, Wu Bo wrote:
> -		if (WARN_ON_ONCE(desc->grpid == 0))
> +		if (WARN_ON_ONCE(desc->grpid == 0 ||
> +			le32_to_cpu(desc->grpid) > ctrl->anagrpmax))
>  			return -EINVAL;
> -		if (WARN_ON_ONCE(le32_to_cpu(desc->grpid) > ctrl->anagrpmax))
> -			return -EINVAL;
> -		if (WARN_ON_ONCE(desc->state == 0))
> -			return -EINVAL;
> -		if (WARN_ON_ONCE(desc->state > NVME_ANA_CHANGE))
> +		if (WARN_ON_ONCE(desc->state == 0 ||
> +			desc->state > NVME_ANA_CHANGE))

So besides making the code impossibl to read due to the incorrect
indentation this also makes each WARN_ON_ONCE cover multiple conditions.
Not very useful for debugging.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
