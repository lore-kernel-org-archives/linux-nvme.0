From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 11 Nov 2015 23:47:39 +0100
Subject: [PATCH v14 1/5] lightnvm: Support for Open-Channel SSDs
In-Reply-To: <CAMuHMdVfboMmbWcd_iCJ2KqAAmYjYUZ9_i4yFut6rRwQ75X+eQ@mail.gmail.com>
References: <1446058499-24150-1-git-send-email-m@bjorling.me>
 <1446058499-24150-2-git-send-email-m@bjorling.me>
 <CAMuHMdVfboMmbWcd_iCJ2KqAAmYjYUZ9_i4yFut6rRwQ75X+eQ@mail.gmail.com>
Message-ID: <CAMuHMdVpj+hxrTQ-DJ4GbfAFXHdaDU8xsGEnnoAKG1Frwv7g=g@mail.gmail.com>

On Wed, Nov 11, 2015 at 11:46 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, Oct 28, 2015@7:54 PM, Matias Bj?rling <m@bjorling.me> wrote:
>> +struct nvm_dev_ops {
>
> [...]
>
>> +       uint8_t                 max_phys_sect;
>> +};
>
>> --- /dev/null
>> +++ b/drivers/lightnvm/core.c
>
>> +int nvm_register(struct request_queue *q, char *disk_name,
>> +                                                       struct nvm_dev_ops *ops)
>> +{
>
> [...]
>
>> +       } else if (dev->ops->max_phys_sect > 256) {
>
> drivers/nfc/nfcmrvl/i2c.c:52: warning: comparison is always false due
> to limited range of data type

Oops, I copied the wrong warning. Obviously this was supposed to be
"drivers/lightnvm/core.c:322: warning: comparison is always false due
to limited range of data type"

> Indeed, max_phys_sect is "uint8_t", so its maximum value is 255.
>
>> +               pr_info("nvm: max sectors supported is 256.\n");
>
> Hence this message is not correct. What's the intended maximum value?
> 255 or 256?
>
>> +               return -EINVAL;
>> +       }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
