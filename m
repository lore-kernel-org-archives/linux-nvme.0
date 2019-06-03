From: roland@purestorage.com (Roland Dreier)
Date: Mon, 3 Jun 2019 15:59:29 -0700
Subject: [PATCH] nvme: Fix u32 overflow in the number of namespace list
 calculation
In-Reply-To: <CAJX3CthjFcMHK--n4TPjjJ6LCTx-FbnS2tBLx0kmuBMtW04xow@mail.gmail.com>
References: <1559601877-13614-1-git-send-email-jalee@purestorage.com>
 <CAJX3CthjFcMHK--n4TPjjJ6LCTx-FbnS2tBLx0kmuBMtW04xow@mail.gmail.com>
Message-ID: <CAL1RGDUUMRWeLA6OtfAvUYuHVRO5Lc0A9xiWs6fc4iFfiGiHDw@mail.gmail.com>

> -       unsigned i, j, nsid, prev = 0, num_lists = DIV_ROUND_UP(nn, 1024);
> +       unsigned i, j, nsid, prev = 0, num_lists = DIV_ROUND_UP((u64)nn, 1024);

This needs to be DIV64_U64_ROUND_UP(nn, 1024) to avoid issues on 32-bit kernels.
