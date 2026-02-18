Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319D7E9A047
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Feb 2026 14:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:
	Subject:Cc:To:From:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UWc715FGP+Ciz+jurU2ZuvKteXjbKONK37vlZhWdK/g=; b=t7aJB+MiTM5J78noyviplo2Fn0
	eoOlxSgXjb0H95PwPEeocD2cbJ8BvwblA7Ynxk0lCf8yLn5QLb5XWrM0R3QwBBEiSVKeSpHz8wDzx
	VKrXuc5pp4PjMJ8W+tgTr6HyPTFMPNyd5hQ1OHSg1ol8PacbqV2DYdEnbzePIvMTvkevzq17Uj5oc
	2NtxKJSYDvl+aqZ7Zdq9R3jxh5iNEN7dytVXKx+XQWPI+IftHtHZZOX3rc6ye6iFSE59qlAkbFsmm
	oNd0zEr1ITlNIFpU8Yb1u2f2r1lM71FdiXz7k6Tw0MTKDL/Pep9SVs25p3rzkZewNDWXp76FaKGZv
	y0J6WFnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsiro-00000009y68-1pEE;
	Wed, 18 Feb 2026 14:49:28 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsirm-00000009y5n-23Cj
	for linux-nvme@lists.infradead.org;
	Wed, 18 Feb 2026 14:49:27 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id b77bd844 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Feb 2026 15:49:23 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Feb 2026 15:49:23 +0100
Message-Id: <DGI6613J8LV5.1MR81NYF6QS26@arkamax.eu>
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Heyne, Maximilian" <mheyne@amazon.de>, "Maurizio Lombardi"
 <mlombard@redhat.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "emilne@redhat.com"
 <emilne@redhat.com>, "jmeneghi@redhat.com" <jmeneghi@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "dwagner@suse.de" <dwagner@suse.de>, "mlombard@bsdbackstore.eu"
 <mlombard@bsdbackstore.eu>
Subject: Re: [PATCH RFC 2/5] nvme: add sysfs attribute to change admin
 timeout per nvme controller
X-Mailer: aerc 0.21.0
References: <20260212120951.79738-1-mlombard@redhat.com>
 <20260212120951.79738-3-mlombard@redhat.com>
 <20260218-sag-snack-a5ed56a2@mheyne-amazon>
In-Reply-To: <20260218-sag-snack-a5ed56a2@mheyne-amazon>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260218_064926_886530_BE5EBFB9 
X-CRM114-Status: UNSURE (   4.76  )
X-CRM114-Notice: Please train this message.
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

On Wed Feb 18, 2026 at 1:40 PM CET, Maximilian Heyne wrote:
>> +
>> +static struct device_attribute dev_attr_admin_timeout =3D  \
>> +	__ATTR(admin_timeout, S_IRUGO | S_IWUSR, \
>> +	nvme_admin_timeout_show, nvme_admin_timeout_store);
>
> Why not
>
>   DEVICE_ATTR(admin_timeout, S_IRUGO | S_IWUSR, nvme_admin_timeout_show
>   nvme_admin_timeout_store);
>
> ?

No valid reason, I must have copy-pasted it from the old patchset sent
by David Jeffery.

I will fix it, thanks.

Maurizio


