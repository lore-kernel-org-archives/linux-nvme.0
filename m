From: jalee@purestorage.com (Jaesoo Lee)
Date: Mon, 3 Jun 2019 16:45:06 -0700
Subject: [PATCH] nvme: Fix u32 overflow in the number of namespace list
 calculation
In-Reply-To: <1619965f-3d7b-0a17-08ef-807d17ff1f6d@grimberg.me>
References: <1559601877-13614-1-git-send-email-jalee@purestorage.com>
 <CAJX3CthjFcMHK--n4TPjjJ6LCTx-FbnS2tBLx0kmuBMtW04xow@mail.gmail.com>
 <CAL1RGDUUMRWeLA6OtfAvUYuHVRO5Lc0A9xiWs6fc4iFfiGiHDw@mail.gmail.com>
 <1619965f-3d7b-0a17-08ef-807d17ff1f6d@grimberg.me>
Message-ID: <CAJX3CtgAhoJWWL5tYWG7oAaKaPizd0vhRuhf1BnRJyUgY3OOeA@mail.gmail.com>

Thanks for pointing that out; I was totally unaware of that.

I just pushed a revision, but using DIV_ROUND_UP_ULL() instead of
DIV64_U64_ROUND_UP(), because I found DIV_ROUND_UP_ULL() is more
popular.

Please let me know we prefer DIV64_U64_ROUND_UP().

On Mon, Jun 3, 2019@4:14 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> >> -       unsigned i, j, nsid, prev = 0, num_lists = DIV_ROUND_UP(nn, 1024);
> >> +       unsigned i, j, nsid, prev = 0, num_lists = DIV_ROUND_UP((u64)nn, 1024);
> >
> > This needs to be DIV64_U64_ROUND_UP(nn, 1024) to avoid issues on 32-bit kernels.
>
> Agreed.
