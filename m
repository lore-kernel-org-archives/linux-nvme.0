Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD37D40CF7
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 05:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zwFFmbGF5h81RaZEmFYo2C/vpY9e12pit1eB0edjvpA=; b=Kys+pUxfTqdPyZfQ8pE+aJ9poT
	USRvGFHDddhNE/SkJeiL+pU0Uh61wGU5mPfsBWBn5G4fwjWW3D/Mscymshx4Jft4kR09qgUqdDY7g
	lvzq+zKXPCk+/G7WgwL0NsgcU/UQQ27bbiflQz8Krb/hwpVGgTBP94CFZk43t9NX77cD48Vijh01O
	BaKnOyClteZ+SkmUUbwPP7TVkku7k2Ujkek19vZr04+GGICXOMTJCjEvASvIX4+mrIPtAUdy/Ey99
	wnSqvQdQqw/++AnvCLGmzznZAnecDMDnPHn3yxRiUrWQ7L/GFudsv8TK+Q3+6N9IdXEvKhPRemuiI
	fCFfCKGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Yrv-00000001tuI-2WL7;
	Wed, 06 Nov 2024 05:46:15 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Yrs-00000001ttB-0V1z
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 05:46:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730871968; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zwFFmbGF5h81RaZEmFYo2C/vpY9e12pit1eB0edjvpA=;
	b=RcV+jS5eWVqk5UbJjCvw42d0fSGrBzafd1cQIyT6kYmrVrgj9CaNO99wQM/oVy+hQgPCHqptzN8O83rYE7IkAWJgjieqZUZ4K4Jc+IZZIprNHDKclfQq+OmvH9rfcdQ37VQiSIsatqfFEQy2v3v7RDtjhgi4K7NjpLbqTbxA8xQ=
Received: from 30.178.82.24(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIpzIxh_1730871965 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 06 Nov 2024 13:46:06 +0800
Message-ID: <676e7315-4360-42a7-8ff8-db617255d9c1@linux.alibaba.com>
Date: Wed, 6 Nov 2024 13:46:04 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCHv3 09/11] nvmet: support for csi identify ns
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, m@bjorling.me, matias.bjorling@wdc.com,
 Keith Busch <kbusch@kernel.org>
References: <20241105174904.3612888-1-kbusch@meta.com>
 <20241105174904.3612888-10-kbusch@meta.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20241105174904.3612888-10-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_214612_855916_9D36F3B5 
X-CRM114-Status: GOOD (  11.85  )
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


在 2024/11/6 01:49, Keith Busch 写道:
> From: Keith Busch <kbusch@kernel.org>
>
> Implements reporting the I/O Command Set Independent Identify Namespace
> command.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/target/admin-cmd.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
>
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index dba8940a85e35..9609bda7b5629 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -879,6 +879,35 @@ static void nvme_execute_identify_ns_nvm(struct nvmet_req *req)
>   	nvmet_req_complete(req, status);
>   }
>   
> +static void nvmet_execute_id_cs_indep(struct nvmet_req *req)
> +{
> +	struct nvme_id_ns_cs_indep *id;
> +	u16 status;
> +
> +	status = nvmet_req_find_ns(req);
> +	if (status)
> +		goto out;
> +
> +	id = kzalloc(sizeof(*id), GFP_KERNEL);
> +	if (!id) {
> +		status = NVME_SC_INTERNAL;
> +		goto out;
> +	}
> +
> +	id->nstat = NVME_NSTAT_NRDY;
> +	id->anagrpid = req->ns->anagrpid;
Should use cpu_to_le32(req->ns->anagrpid) here.
> +	id->nmic = NVME_NS_NMIC_SHARED;

Nit, id->nmic |= NVME_NS_NMIC_SHARED;

Best Regards,

Guixin Liu

> +	if (req->ns->readonly)
> +		id->nsattr |= NVME_NS_ATTR_RO;
> +	if (req->ns->bdev && !bdev_nonrot(req->ns->bdev))
> +		id->nsfeat |= NVME_NS_ROTATIONAL;
> +
> +	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
> +	kfree(id);
> +out:
> +	nvmet_req_complete(req, status);
> +}

