Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C183C4332F
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Dec 2022 15:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zgGtpVP+iIo5tSB5DTf8/1qr3KZlO2K3XZ60QlXU2sQ=; b=sPR46B8EGt+oFNgm0ef7ZBmc45
	W02PYogJqkWh97DcTICytkw91rLhzGBfpI7g1HTSAbBpz4hSdn6s/F3Y76jkMztN87ykMWGtCQmBV
	QdcVrosSuO9Aq/s6TT35N8BXbcG/BSx7sOEZ2DlE51YBu/OaSR8pBZS4ujfhqHm/YiBpEpfO7uCCY
	gsk/3GbToPKp2b2svwyyqBPGz1L594BbwuWdW+02aFgSu8URUoiJLEdFR/K8KsE+TW53WaiLn4rA0
	EVyoz7S/VPHPzSMr3Yf7sZcpUodtYCrGhxPiiaiqF37xYMFwhWgtaVSelxf/kSyB8rtf4DTX3s11Q
	pItulZ6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2DV8-004wpR-Gy; Mon, 05 Dec 2022 15:35:26 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2DV5-004wlB-3e
	for linux-nvme@lists.infradead.org; Mon, 05 Dec 2022 15:35:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 87CD761188;
	Mon,  5 Dec 2022 15:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545DEC433D6;
	Mon,  5 Dec 2022 15:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670254522;
	bh=Yv+NuKym0hvYAxNdUhOJfpVZAp1KJ2uafez95xj/bEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fneJSiwMe1MWg4wE+/2VJbn061da4GPgVAe7o5b8Omc1VXUOB3+00lZmVuiv80zIx
	 KZtZYmbwa9pQ81HcpWUGq9c2aZ1Oo1mcINNmZudW5VgGY9mMjbsRolepUGtDnVEV20
	 28+8C7eFHeGDNqK2m2CPhJ5pVUuxg84cTe9JuZinvBK7rs0v2g/rcEXq6ts0e7dlSN
	 SS2haYsMtuHnSnBmZPXrWSkBG/9qK8JqtQoEcGESh7I1C+vr1mm0O8f7+vIAjtYCfW
	 M0Qgr97jL9ZT38A/Lznef+N2JpS4po3Qgg3+rcC+PxWYVBbhI/41WTpEt7W6dyXA1q
	 gYvPE4WcPI7/g==
Date: Mon, 5 Dec 2022 15:35:17 +0000
From: Keith Busch <kbusch@kernel.org>
To: Joel Granados <j.granados@samsung.com>
Cc: hch@lst.de, chaitanyak@nvidia.com, sagi@grimberg.me,
	p.raghav@samsung.com, javier.gonz@samsung.com, joshi.k@samsung.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v5 1/1] nvme : Add ctrl id to allowed passthru commands
Message-ID: <Y44PtQ1uWtbBhx4X@kbusch-mbp.dhcp.thefacebook.com>
References: <20221205142746.1026912-1-j.granados@samsung.com>
 <CGME20221205143143eucas1p2c4044196a8ff0cb9b563f99d2a5183ce@eucas1p2.samsung.com>
 <20221205142746.1026912-2-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205142746.1026912-2-j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221205_073523_226891_91401424 
X-CRM114-Status: GOOD (  17.45  )
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

On Mon, Dec 05, 2022 at 03:27:46PM +0100, Joel Granados wrote:
> Add NVME_ID_CNS_CS_CTRL and NVME_ID_CNS_CTRL to the nvme admin commands
> that are allowed in unprivileged passthru. This will allow access to
> attributes that are needed to effectively write to the char device in
> passthru.
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>

I initially thought just open the entire nvme_identify_controller
opcode, but this looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

> ---
>  drivers/nvme/host/ioctl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 9550a69029b3..9ddda571f046 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -34,6 +34,8 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
>  			case NVME_ID_CNS_NS:
>  			case NVME_ID_CNS_CS_NS:
>  			case NVME_ID_CNS_NS_CS_INDEP:
> +			case NVME_ID_CNS_CS_CTRL:
> +			case NVME_ID_CNS_CTRL:
>  				return true;
>  			}
>  		}
> -- 
> 2.30.2
> 

