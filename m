Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3C7C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 17:03:49 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7267664F51
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 17:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7267664F51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8wcvpQZbx8aSECrt8npEoy6YNbwhapPFc9zijDdskPI=; b=OVeH+BhUVvAsHFoyUj1vnVkgD
	wQavE3yGcGN8+yMCjzm6TmQK2GN/gD4dbkp06TXNaaO4QpXF9MO1CnlIOW+oaF80WgAa9GLqDNIBB
	PQvDHACMutZVDKi1MHfDSTcvFX/UQ6VmRv5kpQDM+E+6vlArpoGJ7rKwvBT5lFm1TP6kOCSa+Ub6f
	EMf+Exv15vg5K0dOlfHn6trgCBfi9zpAo+mPjqgPwWML21tEr9BcU1uqhRFvKwkBWTVXE8ny1xKC7
	Ob8SbPqLNSoI0m3k4MloMC3OPBCFDkDDBskWVKCsg+mdBUnYYZvLFsMWIshfEY4wlgpCBWhvEGtnT
	O8INVoLAA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIDrS-00FiLg-6N; Fri, 05 Mar 2021 17:03:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIDrJ-00FiK5-N4
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 17:03:28 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4E106507C;
 Fri,  5 Mar 2021 17:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614963804;
 bh=0OnG4BzavkIkRsoSKPQtFcsTzHVmQDZ4N5dtwuYHgN0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ukML5YK/aJPrTlNjVOQYylt+jqBvZkOZ0jxxrISx4VZWHjPHZuvPM31wb+ta1uZcd
 D9ZTgcaZeoyjy4PzgM4VCtjNahBzmuSvqcuPatjMLs7PyOQRvgDtz8ncBRyUU0Tc2j
 B4H12FSgstGES6pojI+OkxaMdnlqnctSI8Vp5J6rQ6CQpOeZqh1Px2QimxVrmr+kQb
 0kuhCE9vhSORCR1BdO9SvfG/J1oh7R5oZGilD5wL1ehwusV60CRTBux99Ml5qIXC8N
 HG4McsBRNnXIQ4YuHTC2xQjyNPCkKRDo3NoPjLv3WKOBCS+1T0dRHBcIBpm8w6Ex77
 5eQ2fZPdtJAiQ==
Date: Sat, 6 Mar 2021 02:03:17 +0900
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: [PATCH] nvme: fix warning in nvme_update_zone_info()
Message-ID: <20210305170317.GA4512@redsun51.ssa.fujisawa.hgst.com>
References: <20210303224717.51633-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210303224717.51633-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_170326_777946_159B491E 
X-CRM114-Status: UNSURE (   4.76  )
X-CRM114-Notice: Please train this message.
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

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
