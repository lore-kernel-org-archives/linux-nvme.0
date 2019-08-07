From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 7 Aug 2019 13:53:29 -0700
Subject: [PATCH 1/2] nvme-fabrics: Add type of service (TOS) configuration
In-Reply-To: <806d9809-2c24-fcf9-e4c0-e07eaac88d13@mellanox.com>
References: <1564912530-15404-1-git-send-email-israelr@mellanox.com>
 <04c776f4-a04a-8256-c659-daa11fe78a29@grimberg.me>
 <806d9809-2c24-fcf9-e4c0-e07eaac88d13@mellanox.com>
Message-ID: <e2a4fa0c-cba1-c044-768f-b9c249e5a5e5@grimberg.me>


> Hi Sagi,
> 
> I implemented your suggestion but it doesn't work for me.
> 
> The kernel_setsockopt() succeed and I see that
> queue->sock->sk->sk_priority was changed to the correct value,
> 
> but I don't see that the priority was changed on Wireshark.
> 
> Do I miss anything?

Should work, can you instrument to see that the skb->priority does
get assigned correctly?
