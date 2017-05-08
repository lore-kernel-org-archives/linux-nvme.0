From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 8 May 2017 09:25:05 +0200
Subject: [PATCH] lightnvm: remove unused rq parameter of
 nvme_nvm_rqtocmd() to kill warning
In-Reply-To: <5bc0bd5f-4eb5-5975-4700-071b78047917@fb.com>
References: <1494166484-11363-1-git-send-email-geert@linux-m68k.org>
 <5bc0bd5f-4eb5-5975-4700-071b78047917@fb.com>
Message-ID: <CAMuHMdWANws_wSzhSFiKzw4f36NmTBa+O6ZEVCz9Oq8wMcdhjQ@mail.gmail.com>

Hi Jens,

On Mon, May 8, 2017@3:53 AM, Jens Axboe <axboe@fb.com> wrote:
> On 05/07/2017 08:14 AM, Geert Uytterhoeven wrote:
>> With gcc 4.1.2:
>
> Wow, that's ancient.

But it helps to find things like this, and improve the code ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
