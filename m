Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB01C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:52:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7283F2078D
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RWOFtbf2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mlb1BGph";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWZFPZNv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7283F2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=W3ccHt3wceDW0cYbNxpcBhGqxcWMbpTBJu8BFChIdTY=; b=RWOFtbf20zlfGtXVZIXYn2TdT
	ngIRWV+MHKRXTEV2qfJfF36jxzOobMBX60co6fj8yNyi0D4XapAYVarxJ4kWZyZYn2JtEnAO7Tn3S
	CRlPAHMVYa6seXJroxwxawVLX/o/HIFrl8YJb+tfTkxBgBobQAyojAnQ/40zxiRu7hl5aUHtUuJnT
	VbC+JrsgQBOoN6RfuUzi3WIU3gokmXB/Y0dhQZApwOfyczFaEY1E7mA6A6q/ib4e6F/dvpFtYkWfB
	ssF6XSSJGxmVk9EqtU7mu5DZPhSG4+imMZ/oz6hm6eeUNiyrkm5nkwtLLILsqMyldsGsWXEHR0pBi
	Agd/2DECQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jomtl-0006Eh-3i; Fri, 26 Jun 2020 11:52:01 +0000
Received: from casper.infradead.org ([90.155.50.34])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolOK-00014E-VK
 for linux-nvme@merlin.infradead.org; Fri, 26 Jun 2020 10:15:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=s6hC/uBOZYIVMfjLPBI3yqi0794IBJS41qqMfIPOZZk=; b=mlb1BGphps6lvaKRLF6WoENo6H
 CtCxVVR6DyEHa4L9X+8DnQo1GDye4gq0Z519cK/qytHxUkU6Jrs8tsi0kbsKzV/io2YHODtfO9H3G
 tAJHJnviihtGZcbLIhuOovBBSqa+RYbrtQuJv1IvDwz21/jsEmAlVAQ2TPEuny9zV0Blwq/5+V2eR
 OoGk/cDRLmqUrZ//DHbrtjulXkY/YDBoI5yxrS0CMY0yAcf3jpnxrgVJ/53CyKFEgGJjdioEapVjS
 p1V2VCpYlDC5YNBY6C3FhEBYzYSO181yzMtSSflxMTEqaYrURHLR3awHMPY1nVS84ptna9njqS0Re
 whcG6EjA==;
Received: from mail.kernel.org ([198.145.29.99])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joZkM-00017z-9U
 for linux-nvme@lists.infradead.org; Thu, 25 Jun 2020 21:49:28 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 224AF20709;
 Thu, 25 Jun 2020 21:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593121763;
 bh=0kQClpfN+7bHE6QT6+asDHd2oJRChHBrwWMSwfQoLy0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EWZFPZNvupekAoID/cPmCOZ49p3EvPk+F/4UKVdDJFvZqwlm4LmuFGJZU/wjsrHEa
 Yq5Q+wkrPiEokOmPbYOpNLBVHcbUPJjDIRH8mXTqNFNZrSTqzQDrHTj4QyuXKawC6H
 OUN1GXhGjhi1WS5OlxR2qrSMvrZ+x8O14JFvxIh0=
Date: Thu, 25 Jun 2020 14:49:21 -0700
From: Keith Busch <kbusch@kernel.org>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Subject: Re: [PATCH 6/6] nvme: Add consistency check for zone count
Message-ID: <20200625214921.GA1773527@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-7-javier@javigon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200625122152.17359-7-javier@javigon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200625_224926_644362_5E82526E 
X-CRM114-Status: GOOD (  14.47  )
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
Cc: axboe@kernel.dk, SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org,
 Nitesh Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>, hch@lst.de
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jun 25, 2020 at 02:21:52PM +0200, Javier Gonz=E1lez wrote:
>  drivers/nvme/host/zns.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> =

> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 7d8381fe7665..de806788a184 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -234,6 +234,13 @@ static int nvme_ns_report_zones(struct nvme_ns *ns, =
sector_t sector,
>  		sector +=3D ns->zsze * nz;
>  	}
>  =

> +	if (nr_zones < 0 && zone_idx !=3D ns->nr_zones) {
> +		dev_err(ns->ctrl->device, "inconsistent zone count %u/%u\n",
> +				zone_idx, ns->nr_zones);
> +		ret =3D -EINVAL;
> +		goto out_free;
> +	}
> +
>  	ret =3D zone_idx;

nr_zones is unsigned, so it's never < 0.

The API we're providing doesn't require zone_idx equal the namespace's
nr_zones at the end, though. A subset of the total number of zones can
be requested here.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
