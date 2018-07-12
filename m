From: byi@connect.ust.hk (Bairen YI)
Date: Thu, 12 Jul 2018 05:54:08 +0000
Subject: NVMe over Fabrics I/O Error with RDMA/RXE
In-Reply-To: <dba9b7e6-d0d6-d213-1490-c746109e99c3@grimberg.me>
References: <4F63AE27-CBFD-4429-8BF9-ADEE946A9DB7@connect.ust.hk>
 <2f4ac5ac-9aa9-8f21-75cf-8419101a482f@grimberg.me>
 <741366E4-190D-4136-87F7-03CEF1CC8185@connect.ust.hk>
 <dba9b7e6-d0d6-d213-1490-c746109e99c3@grimberg.me>
Message-ID: <0964B9ED-4547-4512-A57D-9956804022E9@connect.ust.hk>

Hi Sagi,

Thanks! It works with kernel version 4.17.3-1.

$ uname -v
#1 SMP Debian 4.17.3-1 (2018-07-02)

Best,
Bairen

> On 11 Jul 2018,@18:37, Sagi Grimberg <sagi@grimberg.me> wrote:
> 
> 
>> The exact kernel version is 4.15.0-23.25 as in
>> https://packages.ubuntu.com/bionic/linux-image-4.15.0-23-generic
>> I tried again with the latest Debian unstable (kernel version 4.16.5) and the symptoms remain the same.
> 
> Looking at linux-stable, looks like the suspected missing commit [1]
> entered in tag v4.16.17, so I'm not sure it exists in your tested
> kernel, Not sure where I can access the source to verify.
> 
> [1]
>>> Possible suspect might be:
>>> --
>>> commit 2da36d44a9d54a2c6e1f8da1f7ccc26b0bc6cfec
>>> Author: Jianchao Wang <jianchao.w.wang at oracle.com>
>>> Date:   Thu Apr 26 11:52:39 2018 +0800
>>> 
>>>    IB/rxe: add RXE_START_MASK for rxe_opcode IB_OPCODE_RC_SEND_ONLY_INV
>>> 
>>>    w/o RXE_START_MASK, the last_psn of IB_OPCODE_RC_SEND_ONLY_INV
>>>    will not be updated in update_wqe_psn, and the corresponding
>>>    wqe will not be acked in rxe_completer due to its last_psn is
>>>    zero. Finally, the other wqe will also not be able to be acked,
>>>    because the wqe of IB_OPCODE_RC_SEND_ONLY_INV with last_psn 0
>>>    is still there. This causes large amount of io timeout when
>>>    nvmeof is over rxe.
>>> 
>>>    Add RXE_START_MASK for IB_OPCODE_RC_SEND_ONLY_INV to fix this.
>>> 
>>>    Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
>>>    Reviewed-by: Zhu Yanjun <yanjun.zhu at oracle.com>
>>>    Signed-off-by: Doug Ledford <dledford at redhat.com>
>>> --
