Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDABC433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 14:47:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AA0E206D4
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 14:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FceelmGk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HE8c3kMl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ZNclUPxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA0E206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:In-Reply-To:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	 bh=Ogyml0VW1kBr/c1r38sZEz+TA6AtA2D7ZlABEa5eNeQ=; b=FceelmGkDSP/AO3B2pYoIPld1
	M/VJrlWprUWRmy9BPuWXujiPyiJhCMl9m8cvx5pPBZqsslDmM+lHB7f0+eKNexk/Z0Af65ccok68v
	LmUPtZ13sLva47Kof/UpilxPDyROjyZUM8zUj51yuqYA7ZnW4QjsWxltAOdkrWcawENJmJlVntvYG
	jjMikmdOb3+RXgxHVVTM2u/8Y9ZkUVvpEulHmzTI0ICx+t2H2BZCZydGEbAQJ/65qjxtJ0bKpZ1xK
	o5mT/AowfME3V5ebwngIZqKni7kufIHb2hXV55ffgqun7ZOisci7MbgXipHlKp17VchSjpXi4G+OC
	DsGjB5hfg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0Qsy-0002yJ-IR; Tue, 28 Jul 2020 14:47:20 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0Qsw-0002y5-Mw
 for linux-nvme@merlin.infradead.org; Tue, 28 Jul 2020 14:47:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Date:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:References;
 bh=VvRog1H8sHTBC8+3X19pzVr2N1A0Tm2jd+84Hz2KBj4=; b=HE8c3kMlz2VM/ohPi3Q8IDsFZB
 eHbT3Q/u/0NM1PD9MU5gzUg1tlGSNjsz7q6lFzhuSjpaYwcKGjw7o/sM203nzIs1GsPO4TPrgwrIu
 vcm8c0+pATHmuV0/2UhNchHFxEVQR1c7l7/dML/9O+IC/G6tlpQ+3LNA3mWH5R9W7l0zpstl2A7iN
 hu0SyOeDO+Ax2zh/gSDB/j7E7WHGJ1zZwDV5+8HO4jgjvAnN/HmRyKzVpcy17w+lIg+succcBhkVX
 5rfPJ5s/MHqpTOd5tpJg8q4t3tYvnr6/ruhw2wdoRkvb03AS8HYG3zviJiVv3TCRPFi2+N7XsG/L/
 IX55WgPA==;
Received: from mout.web.de ([212.227.17.11])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0Qst-0000yb-E9
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 14:47:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1595947618;
 bh=3yl99S+hB/YPmr8JsvFaO96PXM1hWykSDzCbK0UBdpA=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:In-Reply-To:Date;
 b=ZNclUPxz7uzvfyKYe9EWsWW+27Xl68lc4ifyd8kJjmDFBGbSy/zlZtmQQFwJDWNF/
 u4o+GpLUkssZr1GIK2rhfSQeW5rEBQs6Wa1YfK1s9z8thksPhPX9CL/50G1juoeDbl
 ly47m8T7kuE0/NNGxcjTJ3JDBTUa9bZe8dGwlR8Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from ingo ([84.143.237.253]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lh6UN-1kXFJT0kb9-00oZfm; Tue, 28
 Jul 2020 16:41:32 +0200
From: Ingo Brunberg <ingo_brunberg@web.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] nvme: Namepace identification descriptor list is optional
In-Reply-To: <20200728110825.GA20833@infradead.org> (message from Christoph
 Hellwig on Tue, 28 Jul 2020 12:08:25 +0100)
Date: Tue, 28 Jul 2020 16:41:14 +0200
Message-ID: <m3zh7jhfcl.fsf@web.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:BWuAkAfXbUyQyds5E3cCxfOvdvB+kCRt63lWDg3Wzm1dJAdX2YQ
 R0mYk1YQNIv/P+luhNMSb7mOAxjJRINZpy8AOgNGoVT7z/bSutj8kRTXFViQxy4kL/WP/gm
 ApVyYzR+fIMHoJtCI4YdAxWn1+v09RlRCvwrIeZQQhTqkk/BoTid+phQB1V7ObTk8icN7J5
 UuoVWgEdDbOiYCYb4XWQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F0K3pHIPXf8=:OvHT3qTSo3OPHSc/x4tQ9H
 y/X288DbnzgDLth9FcVJK0K/XfCclleHYWQi6Tu/Bfk2Q/Za9L2oULOeXLecEnS/VX4JJckCS
 D52gFwVyOe/CFsQ/y3O1pNBlagbvhHTSfP9yC9CMSzxU3+eNJslXN09R7Hdxn/F0bC4Bkv+8p
 qlRviynM9eWFrBV4yDCD2fq6R4WQ+uLWSeFim/lJjm/MEBcJ/YdrR1/UIVdBfakOOWeC9sfuK
 Jn2WhZBBLQW9aHnJAtMWPTYo9k1yIM2qwi5unolm/ZsfVWxV9NZmgVcn39yc85RUpcvQzKoGM
 csD5zBvgS3SPvPmKFeYl6WibJwGJQtSs5hwVOYqIIGe3bTFcMWTvYBj8O/CAfehia5tZX2KWP
 imG4fVRHwYoI9ze7IKq4bdvskZTcpKKNKhy1euC2qfrNjySjjN4u6jm5AHpZtsJzlS3i9wSPe
 skkNAZwblXdXK/k6f5FQa9fRl6v7WJVnA4Vn2wixfJ6MiiZVDNInOcMRUze7R9q8HY/q6UHKS
 dGorM1sx1OUF3L7D9v3bF9lBtufEBD88o77jtPi6NKdoqaeEi1heTNiDHcerVfMrZpszyoqHJ
 ofuCmsmmz8YTUJobSNd4XrJeGs2lYn/tIAtUdlgoJmexWKvFlGGJkDHAazc+bSDhxm7DLPWuy
 S1fYV/jiEPnemkrNCtOhDVtpUjlWp5ibzF1cN6MAxifEaM6ZepONx+oTSgYBuzBDcR0UgwBhT
 Znh4OekLbrdX069uiHYUrInqyZgMvlBV7ITJ0HfPM4/fCjDtuYlHJeYa16wCVJM5PJKfVChUz
 8tLe8bQMJxlqEMVXjNPAkuieWr7yonaFCi+RIIRajrproAxchuw6JS6yvXjteX9cFiQUR947L
 Yh5j3nQ7tGBL5HFjyMTXtsnRAfxg7TypNdMh45YcOG6CJQ/iPMNGrROxAPXUcB5OpiOqyB5UR
 4NRXkUB5fTaq9H+6yGb5XZi0yIn+pyKhMuivqiht22O1nOAo+L3jZJkd56cI5NYmVuiNjXn9q
 /JBtP75tLqE8Km8vFCfyTlu+Umhj/bkAajiQQMdZnCSGDSadD4UK9w3sKfSC+wlqSYCundwaq
 wr2FaGD+hk9C4R2g49bMlQjRBNOSQxk7eBEdtelhMEYCjHmknwmwTEPuV1fsjURADRfpfaj9B
 6H6GH20Hv+K5esLiJUTxSFQEJoX9W3WuyoBGF7oTKhNmPMGDAX7/TmYK0o4n+VB/Ya09Iecri
 QYOo0r5iZD8DLwoZ3dyQTDUiVk5uM3j0HqrEENA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_154715_716925_D93BA892 
X-CRM114-Status: GOOD (  22.02  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Christoph Hellwig <hch@infradead.org> writes:

> Please try this patch:
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 05aa568a60af62..0602e0f3e77de9 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1287,18 +1287,6 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
>  	if (status) {
>  		dev_warn(ctrl->device,
>  			"Identify Descriptors failed (%d)\n", status);
> -		 /*
> -		  * Don't treat non-retryable errors as fatal, as we potentially
> -		  * already have a NGUID or EUI-64.  If we failed with DNR set,
> -		  * we want to silently ignore the error as we can still
> -		  * identify the device, but if the status has DNR set, we want
> -		  * to propagate the error back specifically for the disk
> -		  * revalidation flow to make sure we don't abandon the
> -		  * device just because of a temporal retry-able error (such
> -		  * as path of transport errors).
> -		  */
> -		if (status > 0 && (status & NVME_SC_DNR) && !nvme_multi_css(ctrl))
> -			status = 0;
>  		goto free_data;
>  	}
>
> @@ -1888,7 +1876,9 @@ static int nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
>  		memcpy(ids->eui64, id->eui64, sizeof(id->eui64));
>  	if (ctrl->vs >= NVME_VS(1, 2, 0))
>  		memcpy(ids->nguid, id->nguid, sizeof(id->nguid));
> -	if (ctrl->vs >= NVME_VS(1, 3, 0) || nvme_multi_css(ctrl))
> +	if (nvme_multi_css(ctrl) ||
> +	    (ctrl->vs >= NVME_VS(1, 3, 0) &&
> +	     !(ctrl->quirks & NVME_QUIRK_NO_NS_DESC_LIST)))
>  		return nvme_identify_ns_descs(ctrl, nsid, ids);
>  	return 0;
>  }
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index c5c1bac797aa5a..4cadaea9034ae4 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -137,6 +137,13 @@ enum nvme_quirks {
>  	 * Don't change the value of the temperature threshold feature
>  	 */
>  	NVME_QUIRK_NO_TEMP_THRESH_CHANGE	= (1 << 14),
> +
> +	/*
> +	 * The controller doesn't handle the Identify Namespace
> +	 * Identification Descriptor list subcommand despite claiming
> +	 * NVMe 1.3 compliance.
> +	 */
> +	NVME_QUIRK_NO_NS_DESC_LIST		= (1 << 15),
>  };
>
>  /*
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 61e612d52d61d6..bac3a3f9c79e0d 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3181,6 +3181,8 @@ static const struct pci_device_id nvme_id_table[] = {
>  	{ PCI_DEVICE(0x1cc1, 0x8201),   /* ADATA SX8200PNP 512GB */
>  		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
>  				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
> +	{ PCI_DEVICE(0x126f, 0x2263),
> +		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST, },
>  	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001),
>  		.driver_data = NVME_QUIRK_SINGLE_VECTOR },

Thanks, the patch works. Maybe it is not too late to make its way into
kernel 5.8.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
