From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 28 Jul 2019 02:55:08 +0900
Subject: [PATCH 4/5] lnvm: introduce chunk-log command for chunk info
In-Reply-To: <CAOA7RkOe_pOvuSJZVhYkm8c=pC6bOu1g4Y0cN7wARrcMqoCEVA@mail.gmail.com>
References: <20190723183601.29370-1-minwoo.im.dev@gmail.com>
 <20190723183601.29370-5-minwoo.im.dev@gmail.com>
 <a40ea502-e293-e07c-9f7b-e5f9cc118adf@lightnvm.io>
 <20190725152926.GF3018@minwoo-desktop>
 <CAOA7RkOe_pOvuSJZVhYkm8c=pC6bOu1g4Y0cN7wARrcMqoCEVA@mail.gmail.com>
Message-ID: <20190727175508.GA23704@minwoo-desktop>

On 19-07-27 17:25:24, Matias Bj?rling wrote:
> Hi Minwoo,
> 
> Something like this would do:
> 
> Total chunks in namespace: %d
> ...
> SLBA: 0xee40000  WP: 0x12345678  CNLB: 0x12345 WLI: XXX   State: FREE
>       Type: SEQWRITE_REQ   Attrs: 0x00
> ...

Hi Matias,

Okay with that.  But I'm not sure what the "Attrs:" means here.  I'll
prepare the next version series with that format of print without Attrs
first.

Thanks,
