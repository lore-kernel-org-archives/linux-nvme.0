From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 15 Aug 2019 11:41:17 +0300
Subject: [PATCH] nvme-cli/fabrics: Add tos param to connect cmd
In-Reply-To: <33ddd40f-14a8-9506-01dc-65a049f8bb5f@grimberg.me>
References: <1565777981-18755-1-git-send-email-israelr@mellanox.com>
 <1565777981-18755-2-git-send-email-israelr@mellanox.com>
 <33ddd40f-14a8-9506-01dc-65a049f8bb5f@grimberg.me>
Message-ID: <a447b0ba-31ea-6a12-2fb4-6cef0b95da96@mellanox.com>


On 8/14/2019 8:08 PM, Sagi Grimberg wrote:
>
>> Added 'tos' to 'connect' command so users can specify the type of 
>> service.
>>
>> usage examples:
>> nvme connect --tos=0 --transport=rdma --traddr=10.0.1.1 --nqn=test-nvme
>> nvme connect -T 0 -t rdma -a 10.0.1.1 -n test_nvme
>
> Still don't see how this is handled if the kernel does not support
> tos yet.

how any other feature we added to connect command will act with old 
kernel ? (e.g. queue_size/nr_queues)

it will fail to get token "token = match_token(p, opt_tokens, args);" 
and return? -EINVAL.

Israel checked that.
