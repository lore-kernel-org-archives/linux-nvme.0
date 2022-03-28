Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEB7C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Mar 2022 05:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+aGtkGdDVJJ9Z9yhfxHUBXEfz0Fw/HewXeY5U9qBn1I=; b=AFikkkWbXRZY2u6B8blwOOjek5
	SBhmMgfSe5FjAe8Jm+llZtq3OJcp8G0L2CcBlkxJ3WNWgbc4OnB/jpMWoi+Xjcxa8EJh7KET9Kkhp
	BgcTwWKcCxy1+cAno7if/wXQCN+bHBy24XOK8koKTE48r+i0Ozi4sityoMplYWf/uDrn25KSY+Lir
	6kh7u1B7vUuGnw+RIsz+alDddKlhIS7bTI5uJY/Nx+FhjtyDtwisdN9sjkFZem57y0wM64rcyuhJJ
	21q4Cf5l7EUePk41xKZR2tWnJlmH2CyfhJgfQ/r+BHKZq07bxgI0l36/+MrywD/+xwboPyShdSHHz
	1rBWKKuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nYi1m-007LHw-Da; Mon, 28 Mar 2022 05:34:54 +0000
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nYi1j-007LH3-4c
 for linux-nvme@lists.infradead.org; Mon, 28 Mar 2022 05:34:52 +0000
Received: by mail-ej1-x62d.google.com with SMTP id r13so26287732ejd.5
 for <linux-nvme@lists.infradead.org>; Sun, 27 Mar 2022 22:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=+aGtkGdDVJJ9Z9yhfxHUBXEfz0Fw/HewXeY5U9qBn1I=;
 b=CLkr4/RNZvrm9lTq213kyUZZZUPSAB1Iw8dDje2i/HDcLb2R6mCl5TdmDYGQkodDji
 shpmQ57qKNsqH5N4otEieiC7R5sT6VYNwcifaQ0DNOtVhJoQyTy8xlE776cry+GXq4bE
 eKtw+ZtwfWJ5fqMiNKkdfdEajB2lDKoeP0PylDklhb/oCTiOqlUGfEsMQpS+DGnHRJqN
 FaJnbrkSkh061tseJgfATJ665tP0qe73z1zYv3g6btvSIDEXYfdyx905MyHoSuZ9cZJc
 LBc2aLz+Hv1Rtd8maei72z4+eUp1zIQx2EMsp6v/3ZGc/6FlbMLp50bOAviv4RWCarjB
 Y6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+aGtkGdDVJJ9Z9yhfxHUBXEfz0Fw/HewXeY5U9qBn1I=;
 b=iCpb44AmOWsqOxXdW13bhAMO3wArz9ZPbJ9s45OhqaBBujHJS3lif1znlLXf3ePKHS
 DO5Zm/Xsxfuv+H45JCAXqmhf7TuLXajLuY/Ffk/Pz4xTePoYUo15FskYt9B8GHyjXsh5
 ue95NUfWCDrjxAGDiRpx8ZdStMTfwSiKNCLIjJGoMBRTVGfL2PRo/KVTPzetdadbna9O
 QzqYgy4Wa+BLtlmKU+l+iUUa8RWAZG873Ae/eyoLPUj2zkYVhMwt2xg8/G5LgfBdkYL1
 HwLj5DfzFhUMjevNuDU2YpEs1Qn1UBVOixF4rGDrMfhBOHqfnqhxHZh72DPQhlPXFMqD
 JibA==
X-Gm-Message-State: AOAM533AQ9S3n+1+48BACCjOKHvnGvqnW6COUaWmL+jWCoR9/IjsOZm6
 LUhjrJ/7LyQ6CQ+q63G8lOw=
X-Google-Smtp-Source: ABdhPJw3Gir9Zod6A60XVTQb3hGeOM47gFdIMWdg/+OF6CghS+Z0Bn+xOiUKszM43QOe+p3pk/aGRg==
X-Received: by 2002:a17:907:2ce3:b0:6df:d2cf:4d98 with SMTP id
 hz3-20020a1709072ce300b006dfd2cf4d98mr25936616ejc.139.1648445684961; 
 Sun, 27 Mar 2022 22:34:44 -0700 (PDT)
Received: from localhost ([217.116.228.11]) by smtp.gmail.com with ESMTPSA id
 k16-20020a17090646d000b006e093439cdfsm4466349ejs.89.2022.03.27.22.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Mar 2022 22:34:44 -0700 (PDT)
Date: Mon, 28 Mar 2022 07:34:41 +0200
From: Pankaj Raghav <pankydev8@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, kbusch@kernel.org, sungup.moon@samsung.com,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: allow duplicate NSIDs for the private namespaces
Message-ID: <20220328053441.v6kr7gza7nj2ldlj@quentin>
References: <20220324154314.1571239-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324154314.1571239-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220327_223451_217539_EDC4B382 
X-CRM114-Status: GOOD (  13.94  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Mar 24, 2022 at 04:43:14PM +0100, Christoph Hellwig wrote:
> From: Sungup Moon <sungup.moon@samsung.com>
> 
> +
> +/*
> + * NSID shall be unique for all shared namespaces, or if at least one of the
> + * following conditions is met:
> + *   1. Namespace Management is supported by the controller
> + *   2. ANA is supported by the controller
> + *   3. NVM Set are supported by the controller
> + *
> + * In other case, private namespace are not required to report a unique NSID.
> + */
> +static inline bool nvme_is_uniqueue_nsid(struct nvme_ctrl *ctrl,
> +		struct nvme_ns_head *head)
Is it s/uniqueue/unique/ ?
> +{
> +	return head->shared ||
> +		(ctrl->oacs & NVME_CTRL_OACS_NS_MNGT_SUPP) ||
> +		(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA) ||
> +		(ctrl->ctratt & NVME_CTRL_CTRATT_NVM_SETS);
> +}
> +
> 

