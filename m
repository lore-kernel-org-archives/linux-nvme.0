Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151D7F31E4A
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2026 15:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GTFwTS89KRQNt3AnDH61HwNCr5/JkQz2unkME9rYVy0=; b=mvjx/qmAqf3FfRLrl9lCf+PeEu
	Mnv9haz7LLZz7x7LEo4mJ38Y0kYRRfERYBnqzHuMjXtHSv8BO5a9LuvTM85GsbUALfVOyMrTqsnmm
	9GRFj2hGWIqmKNiKBi03k6Z/+aJeXpv9YfbDAF+GBhhpU7YTRUHzl5M4t0Nbtm14PKrtoiG7Jf2D3
	kfrtcxCfk6tgx+Zz9cD8h48tVeZvfFViwD/MeUyUWQTN6LQwzk0Vn6J8eV3ibFtOu2Ozyx4syP8dB
	NlMz1oipWthkSIb1fogHTfoc8VEDCSfoN0+MfNag0bHvrBiaUghJHte7ko2EVOD8dwm/Lx5tEJjDF
	qWjR3xaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wArdp-0000000As4Y-0wGV;
	Thu, 09 Apr 2026 15:50:01 +0000
Received: from out28-54.mail.aliyun.com ([115.124.28.54])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wArdk-0000000Arzt-35bl
	for linux-nvme@lists.infradead.org;
	Thu, 09 Apr 2026 15:49:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=alancui.cc; s=default;
	t=1775749793; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=GTFwTS89KRQNt3AnDH61HwNCr5/JkQz2unkME9rYVy0=;
	b=LjLhsyv8WKg+i9SrRfROaPLkYPgOPVpwBWpqhJ9Vh8cTUYqnd4t18DUnQu3bxCDAFDEL1MKaL0Qf0t+d+yjsBaoMalS4EVpYU8f5wNxmvIWEsMPL508gevpzXKFc71NlU9R2P4c+EfXy8LOb4r+i3RsL4eF0c08eHiULEiiriIdCDuqOrINz+3eTKnixbufAcWBYt1XJQgSO6NJBbCHKIvM3UmZT1S8JzDMJH47P/gCQuUtvacRVJkAwC0PeYmj6Phoont5numWUuCsfOaMkLZPSie43IPl5oJ5hgjnc4GvmcV8v4/tQyn/Ng5KgiQuPR2twgZJM00kc8YVt4aX41w==
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4877165|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0322866-0.00197673-0.965737;FP=10874171965506968118|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032027189;MF=me@alancui.cc;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.h8SdjTp_1775749792;
Received: from alanarchdesktop.localnet(mailfrom:me@alancui.cc fp:SMTPD_---.h8SdjTp_1775749792 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 09 Apr 2026 23:49:52 +0800
From: AlanCui4080 <me@alancui.cc>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: Re: Non-SGL transport mode warnings are set to dev_warn_once will cause
 confusion
Date: Thu, 09 Apr 2026 23:49:51 +0800
Message-ID: <1951542.TLkxdtWsSY@alanarchdesktop>
In-Reply-To: <ade5iAP4y94z0JDL@kbusch-mbp>
References: <4770779.LvFx2qVVIh@alanarchdesktop> <ade5iAP4y94z0JDL@kbusch-mbp>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260409_084956_978084_7B35DEE9 
X-CRM114-Status: GOOD (  18.18  )
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

On Thursday, 9 April 2026 22:36=EF=BC=8Cyou wrote=EF=BC=9A
> Fine with me. The warning was added in response to people filing CVE's
> against the driver as a sort of acknowledgement that yeah, this
> interface can't validate transfer lengths under these conditions, so
> we're trusting the user isn't abusing it. A sort of nudge that perhaps
> controller vendors might consider supporting the safer option.

Yes, in my opnion, the device node can be only access with privilege by=20
default. Change the premission of /dev/nvmexxx to 0666 is as dangerous as=20
change /etc/shadow to 0666. So, that's nothing really to worry, every devic=
e=20
on PCI-E that can DMA will able to corrupt the kernel unless IOMMU is used.

And as what i saw, the https://lore.kernel.org/linux-nvme/
20231013051458.39987-1-joshi.k@samsung.com/T/
#m2a5f9fe3a53322ab67c1dd40d5a448405308ea4b fixed this problem and make it's=
=20
safe even the user changed the premission to 0666.

> Anyway, it's fine with me to move the message and make it less scary.
> How about this:
>=20
> ---
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index b42d8768d2979..b6aec0e3fbfb8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3744,6 +3744,10 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl,
> bool was_suspended) ret =3D nvme_hwmon_init(ctrl);
>  		if (ret =3D=3D -EINTR)
>  			return ret;
> +
> +		if (!nvme_ctrl_sgl_supported(ctrl))
> +			dev_info(ctrl->device,
> +				"passthrough uses implicit buffer=20
lengths\n");
>  	}
>=20
>  	clear_bit(NVME_CTRL_DIRTY_CAPABILITY, &ctrl->flags);
> --

Since it was a response to a CVE, and if, as I mentioned above, there are=20
already patches to prevent unprivileged users from corrupting the kernel, t=
hen=20
downgrading it to informational might be reasonable? In fact, the CVE ratin=
g=20
was downgraded once after this vulnerability was submitted, due to the=20
difficulty of exploiting it.

What about saying "passthrough uses implicit and unchecked buffer lengths f=
or=20
privilege user" which may be more descriptive, and add comment which refers=
 to=20
the CVE number like:
```
		/* See CVE-2023-6238, malformed commands from root users=20
can overflow the buffer and corrupt the kernel */
		if (!nvme_ctrl_sgl_supported(ctrl))
			dev_info(ctrl->device,
				"passthrough uses implicit and=20
unchecked buffer lengths for privilege user");
```

I recently started back using a Linux desktop again, and this is at least m=
y=20
first time using Linux with NVMe drives. I feel that nvme module is a bit t=
oo=20
sensitive, even becoming a major source of warnings in my dmesg, including =
not=20
only this one, but also "missing or invalid SUBNQN field." And as https://
lwn.net/Articles/876209/, A warning indicates that the kernel cannot handle=
 a=20
certain situation and is running in a degraded manner based on certain=20
assumptions, which may lead to unexpected situations.I believe that a good=
=20
system administrator should review and ensure that each kernel warnings are=
=20
either negligible or an action has been taken to eliminate them. :)

Alan.





