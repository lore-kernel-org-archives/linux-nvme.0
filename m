From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 30 Jan 2018 02:03:42 +0200
Subject: [PATCH 3/5] nvme-fc: use NVME_CTRL_CONNECTING state to mark init
 process
In-Reply-To: <83fbd86f-2733-8e86-f686-f88b93ff3f06@grimberg.me>
References: <1517147887-15645-1-git-send-email-maxg@mellanox.com>
 <1517147887-15645-4-git-send-email-maxg@mellanox.com>
 <83fbd86f-2733-8e86-f686-f88b93ff3f06@grimberg.me>
Message-ID: <5a292701-2222-f1d5-0c03-edc776be487d@mellanox.com>



On 1/29/2018 9:42 PM, Sagi Grimberg wrote:
> 
>> Align with RDMA and PCI transports.
>>
>> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> 
> Was this tested?

No, I don't have the FC HW to test it.
I hope someone from the FC guys can help us with this one.
This patch was sent as proposal in V1..
