Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3533DD6D234
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Dec 2025 15:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LX4jpXCUq2VrUDy/DaSVkEpofBTmGalCqV3YihVbKak=; b=bK1BfvjaeCPlUu+NRbS5Mqusgt
	kvEUO6rBGN6K7TVsDHFxTEWMgyQrenkyadZZp+fSpYuhc7Tr7e/OtzhNlR+MKlpUdxm5c+a/kTlp8
	P0Ng24H8BABunc8dxHBIsPuEAcStoZ31HR5N36+LU1Dbhw0XrPNMkOyuf91IekGbHdv8bDLsOb5PZ
	PbGcGYnqamtr3bZgN2iz8Igq9fh3cEK6hfhWu6LQWRji42H4xThNrZRcfpY7zxZeXgOzpQMSn8arB
	4TABDig6Q/7LfOAAd9oi7b5sC8p0TzSbssU3oNeW321d120+Yofbqv1wvsSNLrpjGOhtxZhSG+ifx
	exz0cttw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWFqE-00000008geC-3WMo;
	Thu, 18 Dec 2025 15:22:58 +0000
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWFqB-00000008gco-0vIA
	for linux-nvme@lists.infradead.org;
	Thu, 18 Dec 2025 15:22:57 +0000
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-5dfa9c01c54so469496137.0
        for <linux-nvme@lists.infradead.org>; Thu, 18 Dec 2025 07:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1766071374; x=1766676174; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LX4jpXCUq2VrUDy/DaSVkEpofBTmGalCqV3YihVbKak=;
        b=K3YxVmR21UedN/a5n9YgI4CJVEu1G/cLOALbKZDvGqW9l/2StvfGgm2gbPwR4bpcEi
         6ouFl2HWAd8Hfd8kc68IhqjtRy+qGgsJg8lcgI4zY5Z68opwwu31UK4FcSQ1gQhPH2bL
         rcEftemii3q8mRgOfu5Ql7Eheh/F6RwaW0lVhWiUnDOLHo4Gian9FpOxyqVJr7vxaKaf
         U1MYEm9gPv0Ne7Q8YkUahJJjmTh/7FlGPAjvKxH3Qx47oW0X93ubeXUIT2fy3ggmg53m
         GOtt25Xrq4UHSelMHmxmZC6aQZaQC61vEZ657fq7sBYtb7vq3gBp2nOD1yUQRchr6cBI
         Vvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766071374; x=1766676174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LX4jpXCUq2VrUDy/DaSVkEpofBTmGalCqV3YihVbKak=;
        b=wSC0AAKbQk6L2pBpdje+3IXCrignY8r/XWfihjC5FXerafj/gHopN9wV4vcSI0h5z1
         oPeLfcyGrDDXInoKh7sYtSkM27GEf9kxfsALYQU6/foUap2fklxMZaq9U3HjLXzLf/Dm
         0Mvu4DHScadnSE7zcox1sGxJ41fPc4QqvUGykCG8iCqYZoRlMKzIcyT0kqKSOmcKMxWj
         rgFjexj3OYuSuFrjOh7pjsHUz7UYHxJdUEFb9KAR1YH068FYH12icskmAwxGzPW+3K1z
         15aiJ6TBXwYkwyx94gThtkk2Rq2TUrZTN/dVyZ4XHHJX2sipeVj9FG9LJ6PK6Pxkkio9
         0qPw==
X-Forwarded-Encrypted: i=1; AJvYcCX6GP8FF5jWJlw92Q9cvctHQKS3/PDLCCmNAfbszNmAax1/7vzNJKuzOtepD42hbO05hZOFAoi1JU0G@lists.infradead.org
X-Gm-Message-State: AOJu0YzL8kdsf3cGBO/6xkD+aFNsGWmm0HvWRkRE4noRlrwDXokj9O/x
	4UEbqJ/uRGYqCzxWjngu/4TbYyMqMDlFoHh2wvynC2i/QftP+92n1qpt14h33NGPOXo//vrJAiq
	AvHHcdeQfW38Y0t2my4AIfYPkZw3LrCenWNxYACbh8w==
X-Gm-Gg: AY/fxX4UzEA0QnaDaj5bPlau0o1x1F/tpnqb1UrIlykXeMP6vow7M5+cqqCBgCBmuUe
	2majhdHNlCj8fxSmzi+3soRM2UjK/NjCxnXjO4WpCeU0v48IExstk6yD0UlqHJouDGQYBAdHPJy
	JDlJCHaqF3CiPl0BL8BrXSP7hqMdZb9WL6VPxuW2Q0pBfP26ZcEXdxilLikr80PLtTdR73lRPx/
	KU+fBYNKXmIRgHwRqIh4PBlhgPsFgsmunLOfcJSER+5qJ2coChnFgbStrnfE+OZrNuWCiTH
X-Google-Smtp-Source: AGHT+IFgw0yZgQw4KgcAEfmzeBb6rfPQSzcD4ENcfrlKGKrHj6OSCpdEmqYIUGHtYeH5OsmR6YfNioF8WQywS40fGOA=
X-Received: by 2002:a05:6102:8021:b0:5d7:debc:ae81 with SMTP id
 ada2fe7eead31-5e827488509mr8044283137.4.1766071373344; Thu, 18 Dec 2025
 07:22:53 -0800 (PST)
MIME-Version: 1.0
References: <20251126021250.2583630-1-mkhalfella@purestorage.com> <20251126021250.2583630-7-mkhalfella@purestorage.com>
In-Reply-To: <20251126021250.2583630-7-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Thu, 18 Dec 2025 07:22:41 -0800
X-Gm-Features: AQt7F2r08A0LM4DSucGbNZuHBqnNpBcv2Mvjf4YVIZ3M9JGifR9NsmkjYN1wRR4
Message-ID: <CAPpK+O28VGH0BZA8Kw5p7g+1HvULhwuOOn4rr-zWWd1rq928OA@mail.gmail.com>
Subject: Re: [RFC PATCH 06/14] nvme: Rapid Path Failure Recovery read
 controller identify fields
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Aaron Dailey <adailey@purestorage.com>, John Meneghini <jmeneghi@redhat.com>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251218_072255_336093_F28F7E66 
X-CRM114-Status: GOOD (  21.83  )
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

On Tue, Nov 25, 2025 at 6:13=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> TP2028 Rapid path failure added new fileds to controller identify
TP8028
> response. Read CIU (Controller Instance Uniquifier), CIRN (Controller
> Instance Random Number), and CCRL (Cross-Controller Reset Limit) from
> controller identify response. Expose CIU and CIRN as sysfs attributes
> so the values can be used directrly by user if needed.
>
> TP4129 KATO Corrections and Clarifications defined CQT (Command Quiesce
> Time) which is used along with KATO (Keep Alive Timeout) to set an upper
> limite for attempting Cross-Controller Recovery.
"limite" -> "limit"
>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>  drivers/nvme/host/core.c  |  5 +++++
>  drivers/nvme/host/nvme.h  | 11 +++++++++++
>  drivers/nvme/host/sysfs.c | 23 +++++++++++++++++++++++
>  3 files changed, 39 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fa4181d7de73..aa007a7b9606 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3572,12 +3572,17 @@ static int nvme_init_identify(struct nvme_ctrl *c=
trl)
>         ctrl->crdt[1] =3D le16_to_cpu(id->crdt2);
>         ctrl->crdt[2] =3D le16_to_cpu(id->crdt3);
>
> +       ctrl->ciu =3D id->ciu;
> +       ctrl->cirn =3D le64_to_cpu(id->cirn);
> +       atomic_set(&ctrl->ccr_limit, id->ccrl);
Seems like it would be good for the target & init to use the same
name for these fields.  I have a preference for these over
instance_uniquifier and random because they are more concise, but
the preference is not strong.

> +
>         ctrl->oacs =3D le16_to_cpu(id->oacs);
>         ctrl->oncs =3D le16_to_cpu(id->oncs);
>         ctrl->mtfa =3D le16_to_cpu(id->mtfa);
>         ctrl->oaes =3D le32_to_cpu(id->oaes);
>         ctrl->wctemp =3D le16_to_cpu(id->wctemp);
>         ctrl->cctemp =3D le16_to_cpu(id->cctemp);
> +       ctrl->cqt =3D le16_to_cpu(id->cqt);
>
>         atomic_set(&ctrl->abort_limit, id->acl + 1);
>         ctrl->vwc =3D id->vwc;
I cannot discern an ordering to the attributes set here.  Any
particular reason, you placed cqt away from the others you added?

> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 29430949ce2f..ae36249ad61e 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -388,6 +388,27 @@ nvme_show_int_function(queue_count);
>  nvme_show_int_function(sqsize);
>  nvme_show_int_function(kato);
>
> +static ssize_t nvme_sysfs_uniquifier_show(struct device *dev,
> +                                         struct device_attribute *attr,
> +                                         char *buf)
> +{
> +       struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
> +
> +       return sysfs_emit(buf, "%02x\n", ctrl->ciu);
> +}
> +static DEVICE_ATTR(uniquifier, S_IRUGO, nvme_sysfs_uniquifier_show, NULL=
);
> +
> +static ssize_t nvme_sysfs_random_show(struct device *dev,
> +                                         struct device_attribute *attr,
> +                                         char *buf)
> +{
> +       struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
> +
> +       return sysfs_emit(buf, "%016llx\n", ctrl->cirn);
> +}
> +static DEVICE_ATTR(random, S_IRUGO, nvme_sysfs_random_show, NULL);
> +
> +
>  static ssize_t nvme_sysfs_delete(struct device *dev,
>                                 struct device_attribute *attr, const char=
 *buf,
>                                 size_t count)
> @@ -734,6 +755,8 @@ static struct attribute *nvme_dev_attrs[] =3D {
>         &dev_attr_numa_node.attr,
>         &dev_attr_queue_count.attr,
>         &dev_attr_sqsize.attr,
> +       &dev_attr_uniquifier.attr,
> +       &dev_attr_random.attr,
>         &dev_attr_hostnqn.attr,
>         &dev_attr_hostid.attr,
>         &dev_attr_ctrl_loss_tmo.attr,
> --
> 2.51.2
>

These are the names used in the target code (uniquifer & random.
I'd rather have them match (identify structure will have spec's
abbreviations; ctrl & debug/sysfs for target & initiator either be
ciu/cirn or uniquifer/random.

But this is small stuff.

Reviewed-by: Randy Jennings <randyj@purestorage.com>

