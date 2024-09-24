Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D9CCF9C6B
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2024 10:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ozn2n1eKsmR5x1M7gDYWIaW4Y4gKNPTdP82ocaDK8F8=; b=zel0heduHBLH5GPDejiu8DzLng
	h8Mz7rNdVIGkrW8Hm7YK035KVQwQGQfXLgWn3JzFLT88pDKLehwR/AlDcvqgbdnLZqR1VEQWgW2hq
	XceoNMurHJEJxXicsP90U/FSu4z8wlKKlZRJeIxaJ5JRS2DL9RB+u8rYURMiXFODqrqAkoc39jqX8
	lwXx03RIBMEJAyC8sktcX3ETNMv0bAjN8y6ZG6l1kZfhLBS3dpuaszqeyp76IEgU7XejmdPgiLgBx
	lW8BX7kEttNXSGYObmSoZ46zu6UfAGlr6ntdwiKQAHkSO+iMvbIXO0SxfkZzfscQWits0VD6HhBQ4
	GbNApDjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1st32w-0000000230D-3Z6T;
	Tue, 24 Sep 2024 10:45:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1st21o-00000001qSm-3QS4
	for linux-nvme@lists.infradead.org;
	Tue, 24 Sep 2024 09:40:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727170815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ozn2n1eKsmR5x1M7gDYWIaW4Y4gKNPTdP82ocaDK8F8=;
	b=A4ZcSaFa6GT4bPlYBr86iti2e8XzbuJKzKIUxComjsBhz0x/ipDiBxVhcqrcmycULVGUzu
	jHm0EkIAbLNmrBzL2tthpbb+ByRk6oHzGhgm4e2TZnlVBK3kYrEIhjiMPTJKxxWtDduvIY
	zOw2L2EuIJi/a/dCL7Y93XYOdXsAgW4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527--4iAjH5UNUuqH15v_PwHhw-1; Tue, 24 Sep 2024 05:40:14 -0400
X-MC-Unique: -4iAjH5UNUuqH15v_PwHhw-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2058ba8562fso99423245ad.3
        for <linux-nvme@lists.infradead.org>; Tue, 24 Sep 2024 02:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727170812; x=1727775612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozn2n1eKsmR5x1M7gDYWIaW4Y4gKNPTdP82ocaDK8F8=;
        b=ciQb1KYy3pxGMeiXtj6GPVIhgG2nZ4dO6CDgJuNJNI/BxsUdXyWVUfXpwyhQmC8Koa
         Tn6DDdXogquVPMNRM9dNaZt/6dPn8fbZRKz+msxx+7+/1ZjQLzhyFKUWcwFm5juGqRR5
         U3DdCxRVG8SgnIcY85kqOl4VA+O+nNL6ZkHJ3F/PKa7uS8eL2J3RTqpuJEigmd996wd9
         OT5bI9eYGNH/O7NMnOEwiITacysnR3xi6v4QXj52V9OMYB4o0OoR3R6tq9tpb0QJRJra
         8mGO5LUCFms9BYFJ+0go7JWjgh6qVGxg3yxyzUhQm53+sGM0J0YfjZdCkF82eNzNgZLq
         5h5g==
X-Gm-Message-State: AOJu0YwkTxZ1u1er3Uf4KyzyGfNnNg8SQiphItiCTvgDJsO1fTPJWk8+
	29p4SuDEb0oTRVT6V4OO3PR5d/z9WlpshJFuopkRyRs0F6QdgLKqKJu1a8SFoEFv29btTtKxIen
	O9Dq5egW7C7wFC8cppGJ+0us+Z4LK8H0FjuI/SPjOYkvj/HwXgATah9X+bBNsp7XF3SplOU7vNr
	c8Aqw8v3tNE8l6nWuOkSErPZ4U/CWfU7Nr/OMk0w7LOzY9f4SVns9n
X-Received: by 2002:a17:903:22c3:b0:203:a279:a144 with SMTP id d9443c01a7336-208d9807ce7mr237373175ad.25.1727170811888;
        Tue, 24 Sep 2024 02:40:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsym1T571kkHMEbg5Y1SS7v6Tdlm4NoFNXqzpqAX9p8DQxtPaz7q3af5xAfK320ea3qWy2YPCYIEezcanhb5k=
X-Received: by 2002:a17:903:22c3:b0:203:a279:a144 with SMTP id
 d9443c01a7336-208d9807ce7mr237373025ad.25.1727170811628; Tue, 24 Sep 2024
 02:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240924090134.1884012-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240924090134.1884012-1-shinichiro.kawasaki@wdc.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 24 Sep 2024 17:39:54 +0800
Message-ID: <CAHj4cs9=OLpvZ2rD-tkuxTMYKtP6sPNG8HxvMWNzKt4yOjsZaA@mail.gmail.com>
Subject: Re: [PATCH] nvme: null terminate nvme_tls_attrs
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>, 
	Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240924_024017_015916_AF513613 
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

On Tue, Sep 24, 2024 at 5:01=E2=80=AFPM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> Commit 1e48b34c9bc7 ("nvme: split off TLS sysfs attributes into a
> separate group") introduced the struct attribute array nvme_tls_attrs.
> However, the array was not null terminated and caused BUG KASAN global-
> out-of-bounds. To avoid the BUG, null terminate the array.
>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/linux-nvme/jhllwfxcedrcxcnbajwl4x2l2ujcqo=
wqcd4ps574zrafrqhjna@f4icvecutekm/
> Fixes: 1e48b34c9bc7 ("nvme: split off TLS sysfs attributes into a separat=
e group")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  drivers/nvme/host/sysfs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index eb345551d6fe..b68a9e5f1ea3 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -767,6 +767,7 @@ static struct attribute *nvme_tls_attrs[] =3D {
>         &dev_attr_tls_key.attr,
>         &dev_attr_tls_configured_key.attr,
>         &dev_attr_tls_keyring.attr,
> +       NULL,
>  };
>
>  static umode_t nvme_tls_attrs_are_visible(struct kobject *kobj,
> --
> 2.45.2
>

Verified the issue was fixed.

Tested-by: Yi Zhang <yi.zhang@redhat.com>


--
Best Regards,
  Yi Zhang


