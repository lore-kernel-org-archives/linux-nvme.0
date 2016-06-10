From: swise@opengridcomputing.com (Steve Wise)
Date: Fri, 10 Jun 2016 15:15:39 -0500
Subject: nvme-fabrics: crash at nvme connect-all
In-Reply-To: <CAF1ivSb5GoBmX+5oi5d62GgJNmjzFACSx_oWdteSnmYKA2NKBQ@mail.gmail.com>
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
 <CAF1ivSb5GoBmX+5oi5d62GgJNmjzFACSx_oWdteSnmYKA2NKBQ@mail.gmail.com>
Message-ID: <024201d1c354$db2e0330$918a0990$@opengridcomputing.com>

> > I applied your patch and it does avoid the crash.  So the connect to the target
> > device via cxgb4 that I setup to fail in ib_alloc_mr(), correctly fails w/o
> > crashing.   After this connect failure, I tried to connect the same target
> > device but via another rdma path (mlx4 instead of cxgb4 which was setup to fail)
> > and got a different failure.  Not sure if this is a regression from your fix or
> > just another error path problem:
> >
> > BUG: unable to handle kernel paging request at ffff881027d00e00
> > IP: [<ffffffffa04c5a49>] nvmf_parse_options+0x369/0x4a0 [nvme_fabrics]
> 
> Could you find out which line of code this is?

>From objdump -S -l nvme-fabrics.ok, nvmf_parse_options starts at 6e0:

---
00000000000006e0 <nvmf_parse_options>:
nvmf_parse_options():
/usr/local/src/linux-2.6/drivers/nvme/host/fabrics.c:515
        { NVMF_OPT_ERR,                 NULL                    }
};

static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
                const char *buf)
{
     6e0:       55                      push   %rbp
----

So 0x6e0+0x369 = 0xa49 which is in an inline atomic_add_return(), I think:

---
atomic_add_return():
/usr/local/src/linux-2.6/./arch/x86/include/asm/atomic.h:156
 *
 * Atomically adds @i to @v and returns @i + @v
 */
static __always_inline int atomic_add_return(int i, atomic_t *v)
{
        return i + xadd(&v->counter, i);
     a3d:       48 8b 15 00 00 00 00    mov    0x0(%rip),%rdx        # a44 <nvmf_parse_options+0x364>
     a44:       b8 01 00 00 00          mov    $0x1,%eax
     a49:       f0 0f c1 02             lock xadd %eax,(%rdx)
     a4d:       83 c0 01                add    $0x1,%eax
kref_get():
/usr/local/src/linux-2.6/include/linux/kref.h:46
{
        /* If refcount was 0 before incrementing then we have a race
         * condition when this kref is freeing by some other thread right now.
         * In this case one should use kref_get_unless_zero()
         */
        WARN_ON_ONCE(atomic_inc_return(&kref->refcount) < 2);
     a50:       83 f8 01                cmp    $0x1,%eax
     a53:       7e 1e                   jle    a73 <nvmf_parse_options+0x393>
nvmf_parse_options():
/usr/local/src/linux-2.6/drivers/nvme/host/fabrics.c:689
---
