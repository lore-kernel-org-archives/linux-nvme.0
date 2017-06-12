From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Mon, 12 Jun 2017 12:50:55 +0300
Subject: [PATCH v2] nvme: use uuid_t in nvme_ns
In-Reply-To: <20170612091240.18343-1-jthumshirn@suse.de>
References: <20170612091240.18343-1-jthumshirn@suse.de>
Message-ID: <CAHp75Ve+-+s3Fx4MnjXoXf3tjh_PkdnEKAKrXnmFWA_38_abnw@mail.gmail.com>

On Mon, Jun 12, 2017@12:12 PM, Johannes Thumshirn <jthumshirn@suse.de> wrote:
> struct nvme_ns still uses u u8 uuid[16], change it to using uuid_t and
> use the UUID API.

Thanks for an update.

See my further comments below.

>                         len = NVME_NIDT_UUID_LEN;
> -                       memcpy(ns->uuid, data + pos + sizeof(*cur), len);
> +                       uuid_copy(&ns->uuid, data + pos + sizeof(*cur));

So, this reveals two thins:
1) shall we define NVME_NIDT_UUID_LEN to be UUID_LEN or substitute it
completely with the latter?
2) Is the len variable used later in the function?

> -               if (!memchr_inv(ns->uuid, 0, sizeof(ns->uuid)) ||
> +               if (uuid_is_null(&ns->uuid) ||
>                     !memchr_inv(ns->nguid, 0, sizeof(ns->nguid)))

>         u8 nguid[16];
> -       u8 uuid[16];
> +       uuid_t uuid;

Do you plan to switch nguid to be guid_t / uuid_t ?

-- 
With Best Regards,
Andy Shevchenko
