Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E59E77188
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Dec 2024 17:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gyBWBhTF5e5xMrkLYU8VnQmWPhXZiZLfpFaa0AqGdig=; b=TvVU0uWr4PiF6GrqSy3B0YDvhL
	HRU54V2s3HhI3GQc44PcXdvHtnbS2+7hUys4oI3xKKEMO4snVOZwBNzIcCfhPEYSZmZEAedg9KHBF
	je0SvGhnkoSx/U3vVtfRRN63x4mUAb0a4i+e/Au2woMWfWfVasrJv3V1tn1LvngoNnjbYWckXfUcz
	2mzzjl+DQkMvSGXGLQKDInD7w5zgq1TPfkpWryOhF7bWqNNJ/XNizVS1nNJx2B6iYXs+ST8wDsITW
	M/18aALokJCEEXhHGbmwU7wgP20gAvtELmmsurD3SYWqNQ3/1dGZH5Bqji6N5QdRyr+2OHftXHXl6
	qeuhrphA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNxfR-0000000HIpM-0PSS;
	Wed, 18 Dec 2024 17:17:01 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNxfN-0000000HIn6-1faP
	for linux-nvme@lists.infradead.org;
	Wed, 18 Dec 2024 17:17:00 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-215464b0432so6018495ad.0
        for <linux-nvme@lists.infradead.org>; Wed, 18 Dec 2024 09:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1734542216; x=1735147016; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyBWBhTF5e5xMrkLYU8VnQmWPhXZiZLfpFaa0AqGdig=;
        b=El3i5xhuFM8m/CxIuEDKLxd3WfIFEdq5zU4Q2HFF3h9kCm0FOZZy0X0ShPXBctggAh
         3o0jFp3YfI5UG5A94o6wubWjT2TjwS55KOB0BWGI19bj5yrNjAK74coQfeoZLjeaGUYn
         0/cC+rxx5iuxuajmDG9ZnPZXi9+cAxZ9vhcekVT3v2Vy1DG3EmAjB4pUqeATETQuQQ1S
         P/eowNSgZLvG3aUgWxXUHQEG83VSI9XoeJNroubJLdEowMgq3zLvtnALLkn/t5AZw7+4
         iAFw3r607AX+C0e2JQwKI8u2LItcd7XpEW0t8SBxInWkQVSb1dlVs3wPyIoN9FVLgOpv
         fnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734542216; x=1735147016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyBWBhTF5e5xMrkLYU8VnQmWPhXZiZLfpFaa0AqGdig=;
        b=p58T1yxJ7ZBm3eRIBxO0UTaopkrAw2qd/E44iThUD0PkIlnK1AkV3XOmqB3fGzv8Cg
         fvKkfHI3ZQIreuQ2TS8X+QhzAhhgxUEfq2s1NnzvtlRy0z3DeVmvngwS4KqDq3pP3QKJ
         9RFWpAuzt4/adIiiGxZsJpPc3UVwsKgwLSHMryVd4CrlNtnA80f8h4e/sC0TurruvsWo
         8qitIcP0Nzqp/xGY7fMYvqKAMT0hW1/ybTSGiurSugv+b4T/kE+qvqwNshA+Xqq77Czc
         4ixNnCaiaLVTanPMEr/HEIMUm5nD9iGEzd/MFEguQ8fCdj3uULF9KtbA8x7vidX8N+Kk
         TN8g==
X-Forwarded-Encrypted: i=1; AJvYcCXFm+V+CiSkJyVGFx79kKkwL/Nk0DwUF9+RuQVN4EepqC8b2QDB6bLMiPYHWJpeQGI1qiw14pdDsHAa@lists.infradead.org
X-Gm-Message-State: AOJu0YyMjgCvTAJWn5v/C42qid1IuuFPxHbZcXhl0LDko33LwIaUZoEe
	3aZZDFnEIIf3WE0UUpkez/jlbzIrczbPvzaCvD07BvOQpCysyWNoiqQfz2mgWtTR5B6+7B7o2Nq
	3WYOifmiJzmTBGX+5DSxEf8lRk/M5TyNa2Eh1Pw==
X-Gm-Gg: ASbGncs2JDOebjP7it8ZQIPB/MBicCvKfws47IW8Q+iq8AZ1+NGXn9D5v1bKuPxZZHc
	IJDmughQB6Bq6lx/Zo9M1QV6Axm1FiFFS0t6ttw==
X-Google-Smtp-Source: AGHT+IFneFLmXgRimVYtMh3hLfmZoKETQWQ82IXEOjGeKr80uXUSPOg6pwr1giTQ5XNK+Dm+Q4Io6i2Rau6Jb+VYoEg=
X-Received: by 2002:a17:90a:c88f:b0:2ee:d9f2:2acd with SMTP id
 98e67ed59e1d1-2f2e9392abemr1981930a91.6.1734542215646; Wed, 18 Dec 2024
 09:16:55 -0800 (PST)
MIME-Version: 1.0
References: <20241218160458.9587-2-leocstone@gmail.com>
In-Reply-To: <20241218160458.9587-2-leocstone@gmail.com>
From: Caleb Sander <csander@purestorage.com>
Date: Wed, 18 Dec 2024 09:16:43 -0800
Message-ID: <CADUfDZrV-_um_NzMiun==8JcDT0SEJ7qm4xt_gOmumuzRZUv9A@mail.gmail.com>
Subject: Re: [PATCH v2] nvmet: Don't overflow subsysnqn
To: Leo Stone <leocstone@gmail.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	syzbot+ff4aab278fa7e27e0f9e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241218_091657_469452_749C3436 
X-CRM114-Status: GOOD (  19.75  )
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

On Wed, Dec 18, 2024 at 8:07=E2=80=AFAM Leo Stone <leocstone@gmail.com> wro=
te:
>
> nvmet_root_discovery_nqn_store treats the subsysnqn string like a fixed
> size buffer, even though it is dynamically allocated to the size of the
> string.
>
> Create a new string with kstrdup instead of using the old buffer.
>
> Reported-by: syzbot+ff4aab278fa7e27e0f9e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dff4aab278fa7e27e0f9e
> Fixes: 95409e277d83 ("nvmet: implement unique discovery NQN")
> Signed-off-by: Leo Stone <leocstone@gmail.com>
> ---
> v2: Allocate memory outside the lock and handle errors.
> v1: https://lore.kernel.org/all/20241218005909.89092-2-leocstone@gmail.co=
m/
> ---
>  drivers/nvme/target/configfs.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configf=
s.c
> index eeee9e9b854c..3c9c98250cce 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -2254,12 +2254,17 @@ static ssize_t nvmet_root_discovery_nqn_store(str=
uct config_item *item,
>                 const char *page, size_t count)
>  {
>         struct list_head *entry;
> +       char *new_nqn;
>         size_t len;
>
>         len =3D strcspn(page, "\n");
>         if (!len || len > NVMF_NQN_FIELD_LEN - 1)
>                 return -EINVAL;
>
> +       new_nqn =3D kstrdup(page, GFP_KERNEL);

Looks like this is now keeping the trailing \n in the string, when
previously it was excluded. Use kstrndup() instead?

> +       if (!new_nqn)
> +               return -ENOMEM;
> +
>         down_write(&nvmet_config_sem);
>         list_for_each(entry, &nvmet_subsystems_group.cg_children) {
>                 struct config_item *item =3D
> @@ -2268,11 +2273,12 @@ static ssize_t nvmet_root_discovery_nqn_store(str=
uct config_item *item,
>                 if (!strncmp(config_item_name(item), page, len)) {
>                         pr_err("duplicate NQN %s\n", config_item_name(ite=
m));
>                         up_write(&nvmet_config_sem);
> +                       kfree(new_nqn);
>                         return -EINVAL;
>                 }
>         }
> -       memset(nvmet_disc_subsys->subsysnqn, 0, NVMF_NQN_FIELD_LEN);
> -       memcpy(nvmet_disc_subsys->subsysnqn, page, len);
> +       kfree(nvmet_disc_subsys->subsysnqn);
> +       nvmet_disc_subsys->subsysnqn =3D new_nqn;
>         up_write(&nvmet_config_sem);

The kfree() could also be moved after the up_write(), but it's
probably less of a concern than the potentially blocking kstrdup().

>
>         return len;
> --
> 2.43.0
>
>

