From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 16 Jun 2016 22:55:54 +0300
Subject: target crash / host hang with nvme-all.3 branch of nvme-fabrics
In-Reply-To: <017001d1c7e7$95057270$bf105750$@opengridcomputing.com>
References: <00d801d1c7de$e17fc7d0$a47f5770$@opengridcomputing.com>
 <20160616145724.GA32635@infradead.org>
 <017001d1c7e7$95057270$bf105750$@opengridcomputing.com>
Message-ID: <5763044A.9090206@grimberg.me>


>> On Thu, Jun 16, 2016@09:53:45AM -0500, Steve Wise wrote:
>>> [11436.603807] nvmet: ctrl 1 keep-alive timer (15 seconds) expired!
>>> [11436.609866] BUG: unable to handle kernel NULL pointer dereference at
>>> 0000000000000050
>>> [11436.617764] IP: [<ffffffffa09c6dff>] nvmet_rdma_delete_ctrl+0x6f/0x100
>>
>> Can you check using gdb where in the code this is?
>
>
> nvmet_rdma_delete_ctrl():
> /root/nvmef/nvme-fabrics/drivers/nvme/target/rdma.c:1302
>                          &nvmet_rdma_queue_list, queue_list) {
>                  if (queue->nvme_sq.ctrl->cntlid == ctrl->cntlid)
>       df6:       48 8b 40 38             mov    0x38(%rax),%rax
>       dfa:       41 0f b7 4d 50          movzwl 0x50(%r13),%ecx
>       dff:       66 39 48 50             cmp    %cx,0x50(%rax)      <===========
> here
>       e03:       75 cd                   jne    dd2 <nvmet_rdma_delete_ctrl+0x42>

Umm, I think this might be happening because we get to delete_ctrl when
one of our queues has a NULL ctrl. This means that either:
1. we never got a chance to initialize it, or
2. we already freed it.

(1) doesn't seem possible as we have a very short window (that we're
better off eliminating) between when we start the keep-alive timer (in
alloc_ctrl) and the time we assign the sq->ctrl (install_queue).

(2) doesn't seem likely either to me at least as from what I followed,
delete_ctrl should be mutual exclusive with other deletions, moreover,
I didn't see an indication in the logs that any other deletions are
happening.

Steve, is this something that started happening recently? does the
4.6-rc3 tag suffer from the same phenomenon?
