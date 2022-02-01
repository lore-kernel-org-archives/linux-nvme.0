Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AAE7C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Feb 2022 08:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1lQWCqlMYlUqNiap8sRi0jp+zWuhFYRw45WbnzjiS/E=; b=SBjeeL0LSlUQINoPRuhQMGQz3w
	sqiI2wk1ak3IlyqnA1ZDsGXhRoy5HqnrMNxYkf53L4QB1ztLxpZ3t4ULjDlAk1saN8eLzqxH5Oo7I
	LPNUYcc44IKGe5sxEpvEgYgaW7pfTEqbb/7smk3BGhrTjkhekL+OgKMvu54VMqx7FOUF+0IHoHTe9
	j5SfzT98vmozoB+3ZcaWefXy4Blx+O0IJF96EJrrC9cR5W07s2REhR/MCR5EFhhtnbJM7gal2G5QM
	/4Kvi/8SaHvFy/4Dz+VTR/zKHqYHEoZBXkIh2DoSjXxmba6T3a3qlHGJzSV0SiYxatXqFd1gQTSpZ
	tdh1pf+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEo76-00BRek-OC; Tue, 01 Feb 2022 08:02:08 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEo74-00BReG-2X
 for linux-nvme@lists.infradead.org; Tue, 01 Feb 2022 08:02:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6EE8E68AFE; Tue,  1 Feb 2022 09:02:02 +0100 (CET)
Date: Tue, 1 Feb 2022 09:02:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, kch@nvidia.com,
 linux-nvme@lists.infradead.org, joshiiitr@gmail.com
Subject: Re: [PATCH v2] nvme: add vectored-io support for user-passthru
Message-ID: <20220201080202.GA29518@lst.de>
References: <CGME20220131142354epcas5p3ff940846a88ae6fcfd8f9b3acb421913@epcas5p3.samsung.com>
 <20220131141847.4791-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131141847.4791-1-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_000206_291429_87A8B485 
X-CRM114-Status: GOOD (  12.06  )
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

> +static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> +			struct nvme_passthru_cmd64 __user *ucmd)
> +{
> +	return nvme_user_cmd64_common(ctrl, ns, ucmd, false);
> +}
> +
> +static int nvme_user_cmd64_vec(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> +			struct nvme_passthru_cmd64 __user *ucmd)
> +{
> +	return nvme_user_cmd64_common(ctrl, ns, ucmd, true);
>  }

I think we cn skip these tiny wrappers.

>  static bool is_ctrl_ioctl(unsigned int cmd)
> @@ -341,6 +369,8 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
>  		return nvme_submit_io(ns, argp);
>  	case NVME_IOCTL_IO64_CMD:
>  		return nvme_user_cmd64(ns->ctrl, ns, argp);
> +	case NVME_IOCTL_IO64_CMD_VEC:
> +		return nvme_user_cmd64_vec(ns->ctrl, ns, argp);

Maybe add a rationale why we don't need a new ioctl for admin
commands to the commit log.

