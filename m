From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 8 Aug 2019 12:31:38 -0700
Subject: [PATCH 1/2] nvme-fabrics: Add type of service (TOS) configuration
In-Reply-To: <bbab005d-a1c2-02a6-0716-fd74e5c8150f@mellanox.com>
References: <1564912530-15404-1-git-send-email-israelr@mellanox.com>
 <04c776f4-a04a-8256-c659-daa11fe78a29@grimberg.me>
 <806d9809-2c24-fcf9-e4c0-e07eaac88d13@mellanox.com>
 <e2a4fa0c-cba1-c044-768f-b9c249e5a5e5@grimberg.me>
 <bbab005d-a1c2-02a6-0716-fd74e5c8150f@mellanox.com>
Message-ID: <ff091196-93b9-f240-d44a-b0d79762acbe@grimberg.me>


>>> Hi Sagi,
>>>
>>> I implemented your suggestion but it doesn't work for me.
>>>
>>> The kernel_setsockopt() succeed and I see that
>>> queue->sock->sk->sk_priority was changed to the correct value,
>>>
>>> but I don't see that the priority was changed on Wireshark.
>>>
>>> Do I miss anything?
>>
>> Should work, can you instrument to see that the skb->priority does
>> get assigned correctly?
> 
> I did the following instead and it works! :)
> 
> +?????????????? ret = kernel_setsockopt(queue->sock, SOL_IP, IP_TOS,
> +?????????????????????????????? (char *)&opt, sizeof(opt));
> 
> It affects only the outgoing packets from the initiator side (unlike
> rdma-cm that affects both sides).
> 
> I added the same kernel_setsockopt() to the target at
> nvmet_tcp_add_port() and it works on both sides.
> 
> Do you think we need to add port configuration on the target side for
> nvmet tcp?

Absolutely not :)

We should check our received tos and set according to that.

Can you test something like:
--
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 76e43750b9e5..a2f7e1eec440 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1415,6 +1415,7 @@ static void nvmet_tcp_state_change(struct sock *sk)
  static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
  {
         struct socket *sock = queue->sock;
+       struct inet_sock *inet = inet_sk(sock->sk);
         struct linger sol = { .l_onoff = 1, .l_linger = 0 };
         int ret;

@@ -1448,6 +1449,15 @@ static int nvmet_tcp_set_queue_sock(struct 
nvmet_tcp_queue *queue)
         sock->sk->sk_write_space = nvmet_tcp_write_space;
         write_unlock_bh(&sock->sk->sk_callback_lock);

+       if (inet->rcv_tos > 0) {
+               int opt = inet->rcv_tos;
+
+               ret = kernel_setsockopt(sock, SOL_IP, IP_TOS,
+                               (char *)&opt, sizeof(opt));
+               if (ret)
+                       return ret;
+       }
+
         return 0;
  }
--
