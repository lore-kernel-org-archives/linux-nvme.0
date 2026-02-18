Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E014EE9A03B
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Feb 2026 12:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mVrFz150HLuD/pb4UMBevksGbFoLDbuJMsoQKLPXtWE=; b=rck9JiCiHM0IewMM7e57LhLGlE
	mBahOvcQXqGFE81aHkyzfJQBDFq1bwc3TXkjThgJtq0AdP370tmSV7FFUJPdquISstY6mwue3cRAP
	PbUDVD9pfaJAwzUGVC38yNI70eTrX+oNUiZT+o0BGwoJwSMsZk68aumv3uZQ0NzQu+XLnOV2/qL9b
	AAGRZNNyymMEQWSV18ugiKIeQHCN+vcdHImnXq1cDdkhsauf6UTAdV1rGkoG9SxpGBkokC/GOJOVI
	TzzeWTp4/Y/xB/rlQnSPIYOqIaApfnBo7rFtG6TZhVKysJtN2yONx81c6QeUdNKh8TMEq05n7o6hs
	74Em2H0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsgr9-00000009ncp-36PH;
	Wed, 18 Feb 2026 12:40:39 +0000
Received: from fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com ([63.178.143.178])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsgr3-00000009ncN-3Zt4
	for linux-nvme@lists.infradead.org;
	Wed, 18 Feb 2026 12:40:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1771418433; x=1802954433;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=mVrFz150HLuD/pb4UMBevksGbFoLDbuJMsoQKLPXtWE=;
  b=VByzS6pkG4JS/TOjbOXUlDVCDMEuYOoeVpXk14U8PdfWHlI2fzfOik5z
   LDhE5jMHeinvIDisG5Yy+EnUj056j9OShijWfWhyWo6nJ9brBTLaJWyy+
   iCreHbdvVaiLzjOwIFgGdamZ3FrQqPFE9JHY5Nc64cPQb74WTdOAKd5Si
   4cy6H0e4QcUzrrR0wNUWUKOsa+cPuqoHGGvsXhJkNTB2p5YXWkQHkXbCj
   SoDy/vrTLR6JIKzj5itW4L3knNnVIsuMh/FOkdnEuxCHEiT1bxlxfR6tr
   jR1IRL5pWeiIC3N1Q0XyKQ/DWSpsB7Ya3F2fNSyMCQGy6PmpfDMlup8GR
   w==;
X-CSE-ConnectionGUID: Z6awkMWfTrG4zYWC4SoO7g==
X-CSE-MsgGUID: LCfQlpfwSA+LZJGcC5rtCg==
X-IronPort-AV: E=Sophos;i="6.21,298,1763424000"; 
   d="scan'208";a="9516847"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 12:40:29 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.233:29364]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.5.167:2525] with esmtp (Farcaster)
 id 0fabc589-286d-4b76-ac94-f541a5ea04f2; Wed, 18 Feb 2026 12:40:29 +0000 (UTC)
X-Farcaster-Flow-ID: 0fabc589-286d-4b76-ac94-f541a5ea04f2
Received: from EX19D008EUC004.ant.amazon.com (10.252.51.148) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 18 Feb 2026 12:40:27 +0000
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19D008EUC004.ant.amazon.com (10.252.51.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 18 Feb 2026 12:40:27 +0000
Received: from EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1]) by
 EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1%3]) with mapi id
 15.02.2562.035; Wed, 18 Feb 2026 12:40:27 +0000
From: "Heyne, Maximilian" <mheyne@amazon.de>
To: Maurizio Lombardi <mlombard@redhat.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "emilne@redhat.com"
	<emilne@redhat.com>, "jmeneghi@redhat.com" <jmeneghi@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"dwagner@suse.de" <dwagner@suse.de>, "mlombard@bsdbackstore.eu"
	<mlombard@bsdbackstore.eu>
Subject: Re: [PATCH RFC 2/5] nvme: add sysfs attribute to change admin timeout
 per nvme controller
Thread-Topic: [PATCH RFC 2/5] nvme: add sysfs attribute to change admin
 timeout per nvme controller
Thread-Index: AQHcoNPC2i5f5gOirUSr533vTn2g4g==
Date: Wed, 18 Feb 2026 12:40:27 +0000
Message-ID: <20260218-sag-snack-a5ed56a2@mheyne-amazon>
References: <20260212120951.79738-1-mlombard@redhat.com>
 <20260212120951.79738-3-mlombard@redhat.com>
In-Reply-To: <20260212120951.79738-3-mlombard@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.253.68.42]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3C4571E9942F174FB4C4FBEABA59FDDF@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260218_044034_202689_4236D73D 
X-CRM114-Status: GOOD (  18.57  )
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

On Thu, Feb 12, 2026 at 01:09:48PM +0100, Maurizio Lombardi wrote:
> Currently, there is no method to adjust the timeout values
> on a per controller basis with nvme admin queues.
> Add an admin_timeout attribute to nvme so that different
> nvme controllers which may have different timeout
> requirements can have custom admin timeouts set.
> =

> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>

What would it take to have a "queue" directory representing the
admin_queue for an nvme controller like we have "queue" for the io
queues of the namespaces? This way we could change/inspect more than
just the admin_timeout for the admin queue. Or does this not make any
sense?

> ---
>  drivers/nvme/host/sysfs.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> =

> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 29430949ce2f..149cd1ab3b3d 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -601,6 +601,36 @@ static ssize_t dctype_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(dctype);
>  =

> +static ssize_t nvme_admin_timeout_show(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%u\n",
> +				jiffies_to_msecs(ctrl->admin_q->rq_timeout));
> +}
> +
> +static ssize_t nvme_admin_timeout_store(struct device *dev,
> +			struct device_attribute *attr,
> +			const char *buf, size_t count)
> +{
> +	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
> +	u32 timeout;
> +	int err;
> +
> +	err =3D kstrtou32(buf, 10, &timeout);
> +	if (err || !timeout)
> +		return -EINVAL;
> +
> +	blk_queue_rq_timeout(ctrl->admin_q, msecs_to_jiffies(timeout));
> +
> +	return count;
> +}
> +
> +static struct device_attribute dev_attr_admin_timeout =3D  \
> +	__ATTR(admin_timeout, S_IRUGO | S_IWUSR, \
> +	nvme_admin_timeout_show, nvme_admin_timeout_store);

Why not

  DEVICE_ATTR(admin_timeout, S_IRUGO | S_IWUSR, nvme_admin_timeout_show
  nvme_admin_timeout_store);

?

> +
>  #ifdef CONFIG_NVME_HOST_AUTH
>  static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
> @@ -742,6 +772,7 @@ static struct attribute *nvme_dev_attrs[] =3D {
>  	&dev_attr_kato.attr,
>  	&dev_attr_cntrltype.attr,
>  	&dev_attr_dctype.attr,
> +	&dev_attr_admin_timeout.attr,
>  #ifdef CONFIG_NVME_HOST_AUTH
>  	&dev_attr_dhchap_secret.attr,
>  	&dev_attr_dhchap_ctrl_secret.attr,
> -- =

> 2.53.0
> =

> =




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


