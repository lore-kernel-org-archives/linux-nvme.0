From: mlin@kernel.org (Ming Lin)
Date: Fri, 10 Jun 2016 13:00:20 -0700
Subject: nvme-fabrics: crash at nvme connect-all
In-Reply-To: <023d01d1c34c$b9249bd0$2b6dd370$@opengridcomputing.com>
References: <53708289.31891804.1465463883806.JavaMail.zimbra@kalray.eu>
 <20160609132459.GA5105@infradead.org>
 <1290178000.33062227.1465486654766.JavaMail.zimbra@kalray.eu>
 <04d301d1c28d$183af7b0$48b0e710$@opengridcomputing.com>
 <CAF1ivSb2fvjEzCxWXnrxv_i74SRm2qxWZ-RiKpEaGOx-Dk3f1A@mail.gmail.com>
 <04e301d1c292$d6c34430$8449cc90$@opengridcomputing.com>
 <CAF1ivSYBtsuvm-UO6osPAVT-krpF7iXqWy_8LheyWDDoAdWL1A@mail.gmail.com>
 <055801d1c29f$e164c000$a42e4000$@opengridcomputing.com>
 <01c601d1c32a$59576ec0$0c064c40$@opengridcomputing.com>
 <020b01d1c334$45077f50$cf167df0$@opengridcomputing.com>
 <CAF1ivSb82yM94jande+kfomG3hx6PwbUAzTb3VPNygd05uVbXg@mail.gmail.com>
 <023d01d1c34c$b9249bd0$2b6dd370$@opengridcomputing.com>
Message-ID: <CAF1ivSb5GoBmX+5oi5d62GgJNmjzFACSx_oWdteSnmYKA2NKBQ@mail.gmail.com>

On Fri, Jun 10, 2016 at 12:17 PM, Steve Wise
<swise@opengridcomputing.com> wrote:
>> I can reproduce this and below patch fixed it.
>> [PATCH] nvme-rdma: correctly stop keep alive on error path
>> http://lists.infradead.org/pipermail/linux-nvme/2016-June/004931.html
>>
>> Could you also give it a try and see if it helps for the crash you saw?
>
>
> I applied your patch and it does avoid the crash.  So the connect to the target
> device via cxgb4 that I setup to fail in ib_alloc_mr(), correctly fails w/o
> crashing.   After this connect failure, I tried to connect the same target
> device but via another rdma path (mlx4 instead of cxgb4 which was setup to fail)
> and got a different failure.  Not sure if this is a regression from your fix or
> just another error path problem:
>
> BUG: unable to handle kernel paging request at ffff881027d00e00
> IP: [<ffffffffa04c5a49>] nvmf_parse_options+0x369/0x4a0 [nvme_fabrics]

Could you find out which line of code this is?
