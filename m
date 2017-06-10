From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sat, 10 Jun 2017 18:40:19 +0300
Subject: [PATCH] nvme: use uuid_t in nvme_ns
In-Reply-To: <20170610130333.20601-1-jthumshirn@suse.de>
References: <20170610130333.20601-1-jthumshirn@suse.de>
Message-ID: <CAHp75VcWqRu3SqWjMG5WbKKmWmDeWNrHyfuoCX3zq_fc3dYgSw@mail.gmail.com>

On Sat, Jun 10, 2017@4:03 PM, Johannes Thumshirn <jthumshirn@suse.de> wrote:

> struct nvme_ns still uses u u8 uuid[16], change it to using uuid_t.

...and we can convert to use UUID API.

> -                       memcpy(ns->uuid, data + pos + sizeof(*cur), len);
> +                       memcpy(&ns->uuid, data + pos + sizeof(*cur), len);

uuid_copy()

> -       if (!memchr_inv(ns->uuid, 0, sizeof(ns->uuid))) {
> +       if (!memchr_inv(&ns->uuid, 0, sizeof(ns->uuid))) {

uuid_is_null()

> -               if (!memchr_inv(ns->uuid, 0, sizeof(ns->uuid)) ||
> +               if (!memchr_inv(&ns->uuid, 0, sizeof(ns->uuid)) ||

Ditto.

-- 
With Best Regards,
Andy Shevchenko
