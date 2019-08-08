From: israelr@mellanox.com (Israel Rukshin)
Date: Thu, 8 Aug 2019 16:12:35 +0000
Subject: [PATCH 1/2] nvme-fabrics: Add type of service (TOS) configuration
In-Reply-To: <e2a4fa0c-cba1-c044-768f-b9c249e5a5e5@grimberg.me>
References: <1564912530-15404-1-git-send-email-israelr@mellanox.com>
 <04c776f4-a04a-8256-c659-daa11fe78a29@grimberg.me>
 <806d9809-2c24-fcf9-e4c0-e07eaac88d13@mellanox.com>
 <e2a4fa0c-cba1-c044-768f-b9c249e5a5e5@grimberg.me>
Message-ID: <bbab005d-a1c2-02a6-0716-fd74e5c8150f@mellanox.com>

On 8/7/2019 11:53 PM, Sagi Grimberg wrote:
>
>> Hi Sagi,
>>
>> I implemented your suggestion but it doesn't work for me.
>>
>> The kernel_setsockopt() succeed and I see that
>> queue->sock->sk->sk_priority was changed to the correct value,
>>
>> but I don't see that the priority was changed on Wireshark.
>>
>> Do I miss anything?
>
> Should work, can you instrument to see that the skb->priority does
> get assigned correctly?

I did the following instead and it works! :)

+?????????????? ret = kernel_setsockopt(queue->sock, SOL_IP, IP_TOS,
+?????????????????????????????? (char *)&opt, sizeof(opt));

It affects only the outgoing packets from the initiator side (unlike 
rdma-cm that affects both sides).

I added the same kernel_setsockopt() to the target at 
nvmet_tcp_add_port() and it works on both sides.

Do you think we need to add port configuration on the target side for 
nvmet tcp?

Regards,

Israel
