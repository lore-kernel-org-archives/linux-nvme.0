From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 8 May 2017 09:51:56 +0200
Subject: [PATCH] lightnvm: remove unused rq parameter of
 nvme_nvm_rqtocmd() to kill warning
In-Reply-To: <CAMuHMdWANws_wSzhSFiKzw4f36NmTBa+O6ZEVCz9Oq8wMcdhjQ@mail.gmail.com>
References: <1494166484-11363-1-git-send-email-geert@linux-m68k.org>
 <5bc0bd5f-4eb5-5975-4700-071b78047917@fb.com>
 <CAMuHMdWANws_wSzhSFiKzw4f36NmTBa+O6ZEVCz9Oq8wMcdhjQ@mail.gmail.com>
Message-ID: <CAK8P3a0Y0pHyXKrNDhrAmKhvDse686TRFYbEqBeT9X_KcG_MjQ@mail.gmail.com>

On Mon, May 8, 2017@9:25 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Jens,
>
> On Mon, May 8, 2017@3:53 AM, Jens Axboe <axboe@fb.com> wrote:
>> On 05/07/2017 08:14 AM, Geert Uytterhoeven wrote:
>>> With gcc 4.1.2:
>>
>> Wow, that's ancient.
>
> But it helps to find things like this, and improve the code ;-)

For reference, the warning shows up in gcc-4.2 and 4.3 as well, but
not in gcc-4.4 or
higher unless you disable all optimizations (e.g. gcc-7.1 -O0 warns).

      Arnd
