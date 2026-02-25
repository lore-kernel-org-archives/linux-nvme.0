Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C14DEFD238
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Feb 2026 09:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uAByRfr7ewiBBVvBmkyaY0k7/koLw3YsEQknVmeMbr8=; b=OPjhbZbO8ByvcV7tWzJbB2Ya/n
	zCgRtlr6pshgIN2ij8AWO02ymxvNjLlDujo9XRk8FsRw7C5T8x3oZoz4OgKu5Bko5oFuZ8Sr+DI2W
	ollEAnlbkahJj/puKbCeTL3Bhz74LLducX5r9E5kB1/KixTjcZjrWh6F0p/XAVA0e/y+cQlCs2121
	kaJMQvZmFoEGZKZPnxMmGmUxqCtKHa2IQ7pDNi08p93WSr1YiSJ7dkqgnPpGRfPM1cOTydoGoIb1F
	LmvdRXXbqwiqZ443CPoeZ2rncILpdvdJcOCit44E8B6R0DrwRHV9ooBbq05XTigPxDuX8OZas9LPP
	JVj/kGXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvBXd-00000003j4B-3Nlr;
	Wed, 25 Feb 2026 09:50:49 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvBXa-00000003j3e-2qvG
	for linux-nvme@lists.infradead.org;
	Wed, 25 Feb 2026 09:50:48 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 765adac0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 25 Feb 2026 10:50:40 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Feb 2026 10:50:40 +0100
Message-Id: <DGNY74KW07IJ.1KYHECYVFPIVP@arkamax.eu>
Subject: Re: [PATCH] nvme/ioctl: allow 64-bit results in io-passthru command
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Tokunori Ikegami" <ikegami.t@gmail.com>,
 <linux-nvme@lists.infradead.org>
X-Mailer: aerc 0.21.0
References: <20260224185159.20247-1-ikegami.t@gmail.com>
In-Reply-To: <20260224185159.20247-1-ikegami.t@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_015047_070295_A6102F99 
X-CRM114-Status: GOOD (  16.15  )
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

On Tue Feb 24, 2026 at 7:51 PM CET, Tokunori Ikegami wrote:
> Deprecated NVME_IOCTL_IO_CMD ioctl on the char device.
> But nvme-cli still uses it and NVME_IOCTL_IO64_CMD for now.
> So add NVME_IOCTL_IO64_CMD also to allow it.
>   Note: 32/62-bit ioctl duplicated code should be refactored.

Indeed nvme_dev_user_cmd() seems identical.

Wouldn't make sense to add a "bool is64bit" parameter to
nvme_dev_user_cmd() and then just do

if (is64bit)
	ret =3D nvme_user_cmd64(ctrl, ns, argp, 0, open_for_write);
else
	ret =3D nvme_user_cmd(ctrl, ns, argp, 0, open_for_write);

?

Maurizio

>
> Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
> ---
>  drivers/nvme/host/ioctl.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 8844bbd39515..ff7df944ef53 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -845,6 +845,43 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl,=
 void __user *argp,
>  	return ret;
>  }
> =20
> +static int nvme_dev_user_cmd64(struct nvme_ctrl *ctrl, void __user *argp=
,
> +		bool open_for_write)
> +{
> +	struct nvme_ns *ns;
> +	int ret, srcu_idx;
> +
> +	srcu_idx =3D srcu_read_lock(&ctrl->srcu);
> +	if (list_empty(&ctrl->namespaces)) {
> +		ret =3D -ENOTTY;
> +		goto out_unlock;
> +	}
> +
> +	ns =3D list_first_or_null_rcu(&ctrl->namespaces, struct nvme_ns, list);
> +	if (ns !=3D list_last_entry(&ctrl->namespaces, struct nvme_ns, list)) {
> +		dev_warn(ctrl->device,
> +			"NVME_IOCTL_IO64_CMD not supported when multiple namespaces present!\=
n");
> +		ret =3D -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	dev_warn(ctrl->device,
> +		"using deprecated NVME_IOCTL_IO64_CMD ioctl on the char device!\n");
> +	if (!nvme_get_ns(ns)) {
> +		ret =3D -ENXIO;
> +		goto out_unlock;
> +	}
> +	srcu_read_unlock(&ctrl->srcu, srcu_idx);
> +
> +	ret =3D nvme_user_cmd64(ctrl, ns, argp, 0, open_for_write);
> +	nvme_put_ns(ns);
> +	return ret;
> +
> +out_unlock:
> +	srcu_read_unlock(&ctrl->srcu, srcu_idx);
> +	return ret;
> +}
> +
>  long nvme_dev_ioctl(struct file *file, unsigned int cmd,
>  		unsigned long arg)
>  {
> @@ -859,6 +896,8 @@ long nvme_dev_ioctl(struct file *file, unsigned int c=
md,
>  		return nvme_user_cmd64(ctrl, NULL, argp, 0, open_for_write);
>  	case NVME_IOCTL_IO_CMD:
>  		return nvme_dev_user_cmd(ctrl, argp, open_for_write);
> +	case NVME_IOCTL_IO64_CMD:
> +		return nvme_dev_user_cmd64(ctrl, argp, open_for_write);
>  	case NVME_IOCTL_RESET:
>  		if (!capable(CAP_SYS_ADMIN))
>  			return -EACCES;


