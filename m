Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EBBEED60A
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 14:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FYwbxEfzgjP484q7GbXtyYhGMfu3fb71XeJefeAuTQU=; b=twG6rMGnqugICdFb8iKHWeCfVp
	bHIp+z8uUdl6dw5lO3LahXiOs+qOB2bGOHBBs1Um92F3rK0Pd+sg7hOZe0qw6xiMoXY3iIfIhIcJm
	cEhA30tmnM/atMjT6HXazUdnvimlyYwRSdu23JHbNKqu95VTA7GT3YQOi85MZUQTYDHFVPdQX4Br3
	oreQd0wMn8Y3BdVIoAOoigY0CGsecl2earPjmKvkNQCbXFYvVV+i/aqPJARd+iKmVxTjiTVkyEYCu
	3dPIKsOG+9Gs9Zg43kggWqyj42qoajhVqhXVmb9pdVZJLFCqs56/NzyE9MlVlZ1nGYwqtsfFYfGW4
	hK0dxkmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sokuN-0000000DNB0-1Wjw;
	Thu, 12 Sep 2024 14:34:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sokrm-0000000DMRt-3b1u
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 14:32:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726151532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FYwbxEfzgjP484q7GbXtyYhGMfu3fb71XeJefeAuTQU=;
	b=OftcWMxF5XI8yVKKRGarKcoQ926N//jbIyoVHQNKWALZUiDnj2Y7uZ2ujuKD0JKE0xldWq
	OounHpXt+4WqHXFbVu/uDrLY0E2R4iHHRfpbLlvc94diawCnXaiWtZmUoplUt8Zy3RXGoX
	20raZ/JOgiXrbx64IBN6Igyeh0hHUEw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-HECC94mTMG2KCq3aWk8irg-1; Thu, 12 Sep 2024 10:30:39 -0400
X-MC-Unique: HECC94mTMG2KCq3aWk8irg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2f75c8181c0so11054951fa.0
        for <linux-nvme@lists.infradead.org>; Thu, 12 Sep 2024 07:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726151437; x=1726756237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYwbxEfzgjP484q7GbXtyYhGMfu3fb71XeJefeAuTQU=;
        b=GvU66G3nd2ikmmT6RQYK/vY5QE+8CAdHrP6dQKsG037V7NuuZxlfoBvfWnihyMcRLs
         ELpsrc7RFjlttq4rUfiaA/U/iyBvKg2cw3fJy+0ZdeRVEdOeBub1d6dN3vfzb3kAw1bH
         xoyiYjnl4hQxKOhxNl9xZaFIBqdD+HFT8ilFm6KPODEKCtFoO9CenryLrY9cH//fpNM8
         hOjG0SZoew9V160X5G9x3gbZl51lg8QMdkY/aT6a8wHCehwEc3ZJi/VH2wzVx32p4A9f
         pijCID+5mfu670JGmMRbz2ZZA19rDazYt4/ZKwdt5zSrElMoL7K5OQJPleLdO0FcP10B
         lsAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb9tJnvr6qGKB/bbX+sjoBXWpLQhZYpHO8IVUTJJnWB5w2dS3I2WEEV4Pri/BizPUVnssqcvvQyouV@lists.infradead.org
X-Gm-Message-State: AOJu0Yz6XXEA9NW+1knQM/os6FAbzl58CUgQy4tSHuv6haBnNEzpDp2h
	+B7FAy7pn3jfL0CIBK/OeZ9sYp6K8uJlNX4kjbSphEZAH+jCVcTJb3geuYIoclgooVr2pzed8y8
	Ef0h/tkGr38k9slGb+x2rSo7Dly0JDwfI75D7yV2mNbDfa8rM5PaMHnODezhgxfaM1s9IMQ6KwG
	B4JDBNEjP0TeqaEWcSSoTqenSv5UVNT/PCPq3819c=
X-Received: by 2002:a2e:b889:0:b0:2f7:8d3f:11fc with SMTP id 38308e7fff4ca-2f78d3f12efmr10488951fa.31.1726151436932;
        Thu, 12 Sep 2024 07:30:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbg6QnIMTU4ODqKcSnlXW0968zPimhFSBfAuTm7uncIIqVoFMKCU+SvrhTex8/e0gr3QExhr8Cf7ntxBLUD8Q=
X-Received: by 2002:a2e:b889:0:b0:2f7:8d3f:11fc with SMTP id
 38308e7fff4ca-2f78d3f12efmr10488301fa.31.1726151435583; Thu, 12 Sep 2024
 07:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
 <20240822202805.6379-4-stuart.w.hayes@gmail.com> <83f39f2d-7237-4880-83e3-1c3afc62087d@siemens.com>
 <448875be-59e1-48a5-8a3c-cc45fff196ca@gmail.com>
In-Reply-To: <448875be-59e1-48a5-8a3c-cc45fff196ca@gmail.com>
From: David Jeffery <djeffery@redhat.com>
Date: Thu, 12 Sep 2024 10:30:23 -0400
Message-ID: <CA+-xHTEMM09PXgWyKX4h48diUxxGnSSrDowh5Gt=Y+EVhHL-_Q@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] driver core: shut down devices asynchronously
To: stuart hayes <stuart.w.hayes@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Martin Belanger <Martin.Belanger@dell.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_073214_979263_D200F3FE 
X-CRM114-Status: GOOD (  20.72  )
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

On Tue, Sep 10, 2024 at 8:14=E2=80=AFPM stuart hayes <stuart.w.hayes@gmail.=
com> wrote:
>
...
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index b69b82da8837..52d64b419c01 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4832,6 +4832,13 @@ static void shutdown_one_device_async(void *data, =
async_cookie_t cookie)
>   {
>         struct device *dev =3D data;
>
> +       /*
> +        * Sanity check to prevent shutdown hang in case a parent or supp=
lier
> +        * is in devices_kset list in the wrong order
> +        */
> +       if (dev->p->shutdown_after > cookie)
> +               dev->p->shutdown_after =3D cookie - 1;
> +
>         async_synchronize_cookie_domain(dev->p->shutdown_after + 1, &sd_d=
omain);
>
>         shutdown_one_device(dev);

While the race window is really small, there is a potential race with
this fixup. It's possible for the shutdown operation to write a new
value to shutdown_after in the time between the if check and
shutdown_after being re-read and used in the
async_synchronize_cookie_domain call. Such a race would allow a too
high value to be used.

Instead, could do something like:

--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4833,8 +4833,12 @@ static void shutdown_one_device(struct device *dev)
 static void shutdown_one_device_async(void *data, async_cookie_t cookie)
 {
        struct device *dev =3D data;
+       async_cookie_t wait =3D dev->p->shutdown_after + 1;

-       async_synchronize_cookie_domain(dev->p->shutdown_after + 1, &sd_dom=
ain);
+       if (wait > cookie)
+               wait =3D cookie;
+
+       async_synchronize_cookie_domain(wait, &sd_domain);

        shutdown_one_device(dev);
 }

This reads the shutdown_after value once and avoids the race window
where its value being changed on another CPU could still cause a
potential deadlock.


