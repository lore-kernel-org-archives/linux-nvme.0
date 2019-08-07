From: israelr@mellanox.com (Israel Rukshin)
Date: Wed, 7 Aug 2019 08:02:54 +0000
Subject: [PATCH 1/2] nvme-fabrics: Add type of service (TOS) configuration
In-Reply-To: <04c776f4-a04a-8256-c659-daa11fe78a29@grimberg.me>
References: <1564912530-15404-1-git-send-email-israelr@mellanox.com>
 <04c776f4-a04a-8256-c659-daa11fe78a29@grimberg.me>
Message-ID: <806d9809-2c24-fcf9-e4c0-e07eaac88d13@mellanox.com>

On 8/5/2019 6:10 PM, Sagi Grimberg wrote:
>
>> TOS is user-defined and needs to be configured via nvme-cli.
>> It must be set before initiating any traffic and once set the TOS
>> cannot be changed.
>
> Can you please have tcp support it too in the patch set (and test
> that it works)?
>
> Its simply setsockopt with SO_PRIORITY.

Hi Sagi,

I implemented your suggestion but it doesn't work for me.

The kernel_setsockopt() succeed and I see that 
queue->sock->sk->sk_priority was changed to the correct value,

but I don't see that the priority was changed on Wireshark.

Do I miss anything?

Here is my change:

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 606b13d..c0efb2a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1301,6 +1301,19 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl 
*nctrl,
 ???? ??? goto err_sock;
 ???? }

+??? /* Set socket priority */
+??? if (nctrl->opts->tos >= 0) {
+??? ??? opt = nctrl->opts->tos;
+??? ??? ret = kernel_setsockopt(queue->sock, SOL_SOCKET, SO_PRIORITY,
+??? ??? ??? ??? (char *)&opt, sizeof(opt));
+??? ??? if (ret) {
+??? ??? ??? dev_err(nctrl->device,
+??? ??? ??? ??? "failed to set SO_PRIORITY sock opt %d\n", ret);
+??? ??? ??? goto err_sock;
+??? ??? }
+??? }
+
 ???? queue->sock->sk->sk_allocation = GFP_ATOMIC;
 ???? if (!qid)
 ???? ??? n = 0;
-- 


Regards,

Israel
