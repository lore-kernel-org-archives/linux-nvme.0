From: israelr@mellanox.com (Israel Rukshin)
Date: Wed, 14 Aug 2019 07:42:28 +0000
Subject: [PATCH] nvme-cli/fabrics: Add tos param to connect cmd
In-Reply-To: <82499575-a1d7-35aa-1cae-32d1fdbc3ab0@grimberg.me>
References: <1565702251-17198-1-git-send-email-israelr@mellanox.com>
 <1565702251-17198-2-git-send-email-israelr@mellanox.com>
 <82499575-a1d7-35aa-1cae-32d1fdbc3ab0@grimberg.me>
Message-ID: <b6fa103b-bac4-f0d7-5b43-8a8fff8227b5@mellanox.com>

On 8/13/2019 7:43 PM, Sagi Grimberg wrote:
>
>> Added 'tos' to 'connect' command so users can specify the type of 
>> service.
>>
>> usage examples:
>> nvme connect --tos=0 --transport=rdma --traddr=10.0.1.1 --nqn=test-nvme
>> nvme connect -T 0 -t rdma -a 10.0.1.1 -n test_nvme
>>
>
> What if you run this with a kernel that doesn't support tos yet?
You will get:
nvme_fabrics: unknown parameter or missing value 'tos=0' in ctrl 
creation request
