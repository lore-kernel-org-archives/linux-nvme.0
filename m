Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A229D3B99E
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Dec 2025 22:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yH/5cvs+UmTlCnribn5clUV7CtQ4gzpYLZi6R77U9es=; b=XIvyKlYLRvgVAR/V5+EFnka/d0
	6atPWHLAxkjxvlHnBWKxXLMV8wSQ5X5BkksqrvQ8G5vfz2geq27FAbnh8PZ1zIuhL9812uY+b1FuU
	HKM+Kf1CjcOWdX2zk1I1XMAXkZKXpGRfgLakQT818MAavqO6bhzVQzvWJqAAgYgdhCEd/D7DEnQXR
	XBbpFXHhzyhAShVzGWCn18CBI5qS6i89dEwCLgfgc/yd/PhoaNIgjn1+orlYpZE/Gii4wcArudn5s
	CZzFR0c1q68MVgIPFL5kgS8Iy4uwmWdwibYy94gRG8Vv1hXn+9D3POIyc4KdK65OcAnMX1T4OvWxN
	UT6JX5NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vT5nX-0000000EqbI-2CPd;
	Tue, 09 Dec 2025 22:03:07 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vT5nU-0000000Eqat-3F7w
	for linux-nvme@lists.infradead.org;
	Tue, 09 Dec 2025 22:03:06 +0000
Received: from localhost (<unknown> [192.168.3.39])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id d7bd13a1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Dec 2025 23:02:59 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Dec 2025 23:02:59 +0100
Message-Id: <DEU0XC8J7X19.1WXWOJ173T4LZ@bsdbackstore.eu>
Cc: <bgurney@redhat.com>, <bvanassche@acm.org>,
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V2] nvme: expose active quirks in sysfs
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Maurizio Lombardi" <mlombard@redhat.com>, <kbusch@kernel.org>
X-Mailer: aerc
References: <20251103144406.1148401-1-mlombard@redhat.com>
In-Reply-To: <20251103144406.1148401-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251209_140305_149894_D747FDAD 
X-CRM114-Status: GOOD (  22.10  )
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

Hello Keith,

What do you think about this patch? Would you merge it?

Thanks,
Maurizio


On Mon Nov 3, 2025 at 3:44 PM CET, Maurizio Lombardi wrote:
> Currently, there is no straightforward way for a user to inspect
> which quirks are active for a given device from userspace.
>
> Add a new "quirks" sysfs attribute to the nvme controller device.
>
> Reading this file will display a human-readable list
> of all active quirks, with each quirk name on a new line.
> If no quirks are active, it will display "none".
>
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>
> V2: Do not expose kernel-internal constants to userspace.
>     Move the quirks attribute to the controller device, where it belongs.
>
>  drivers/nvme/host/nvme.h  | 54 +++++++++++++++++++++++++++++++++++++++
>  drivers/nvme/host/sysfs.c | 23 +++++++++++++++++
>  2 files changed, 77 insertions(+)
>
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 102fae6a231c..647f19dd57e9 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -180,6 +180,60 @@ enum nvme_quirks {
>  	NVME_QUIRK_DMAPOOL_ALIGN_512		=3D (1 << 22),
>  };
> =20
> +static inline char *nvme_quirk_name(enum nvme_quirks q)
> +{
> +	switch (q) {
> +	case NVME_QUIRK_STRIPE_SIZE:
> +		return "stripe_size";
> +	case NVME_QUIRK_IDENTIFY_CNS:
> +		return "identify_cns";
> +	case NVME_QUIRK_DEALLOCATE_ZEROES:
> +		return "deallocate_zeroes";
> +	case NVME_QUIRK_DELAY_BEFORE_CHK_RDY:
> +		return "delay_before_chk_rdy";
> +	case NVME_QUIRK_NO_APST:
> +		return "no_apst";
> +	case NVME_QUIRK_NO_DEEPEST_PS:
> +		return "no_deepest_ps";
> +	case NVME_QUIRK_QDEPTH_ONE:
> +		return "qdepth_one";
> +	case NVME_QUIRK_MEDIUM_PRIO_SQ:
> +		return "medium_prio_sq";
> +	case NVME_QUIRK_IGNORE_DEV_SUBNQN:
> +		return "ignore_dev_subnqn";
> +	case NVME_QUIRK_DISABLE_WRITE_ZEROES:
> +		return "disable_write_zeroes";
> +	case NVME_QUIRK_SIMPLE_SUSPEND:
> +		return "simple_suspend";
> +	case NVME_QUIRK_SINGLE_VECTOR:
> +		return "single_vector";
> +	case NVME_QUIRK_128_BYTES_SQES:
> +		return "128_bytes_sqes";
> +	case NVME_QUIRK_SHARED_TAGS:
> +		return "shared_tags";
> +	case NVME_QUIRK_NO_TEMP_THRESH_CHANGE:
> +		return "no_temp_thresh_change";
> +	case NVME_QUIRK_NO_NS_DESC_LIST:
> +		return "no_ns_desc_list";
> +	case NVME_QUIRK_DMA_ADDRESS_BITS_48:
> +		return "dma_address_bits_48";
> +	case NVME_QUIRK_SKIP_CID_GEN:
> +		return "skip_cid_gen";
> +	case NVME_QUIRK_BOGUS_NID:
> +		return "bogus_nid";
> +	case NVME_QUIRK_NO_SECONDARY_TEMP_THRESH:
> +		return "no_secondary_temp_thresh";
> +	case NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND:
> +		return "force_no_simple_suspend";
> +	case NVME_QUIRK_BROKEN_MSI:
> +		return "broken_msi";
> +	case NVME_QUIRK_DMAPOOL_ALIGN_512:
> +		return "dmapool_align_512";
> +	}
> +
> +	return "unknown";
> +}
> +
>  /*
>   * Common request structure for NVMe passthrough.  All drivers must have
>   * this structure as the first member of their request-private data.
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 29430949ce2f..16c6fea4b2db 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -601,6 +601,28 @@ static ssize_t dctype_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(dctype);
> =20
> +static ssize_t quirks_show(struct device *dev, struct device_attribute *=
attr,
> +                char *buf)
> +{
> +	int count =3D 0, i;
> +	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
> +	unsigned long quirks =3D ctrl->quirks;
> +
> +	if (!quirks)
> +		return sysfs_emit(buf, "none\n");
> +
> +	for (i =3D 0; quirks; ++i) {
> +		if (quirks & 1) {
> +			count +=3D sysfs_emit_at(buf, count, "%s\n",
> +					nvme_quirk_name(BIT(i)));
> +		}
> +		quirks >>=3D 1;
> +	}
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RO(quirks);
> +
>  #ifdef CONFIG_NVME_HOST_AUTH
>  static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
> @@ -742,6 +764,7 @@ static struct attribute *nvme_dev_attrs[] =3D {
>  	&dev_attr_kato.attr,
>  	&dev_attr_cntrltype.attr,
>  	&dev_attr_dctype.attr,
> +	&dev_attr_quirks.attr,
>  #ifdef CONFIG_NVME_HOST_AUTH
>  	&dev_attr_dhchap_secret.attr,
>  	&dev_attr_dhchap_ctrl_secret.attr,


