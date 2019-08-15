From: james.smart@broadcom.com (James Smart)
Date: Thu, 15 Aug 2019 08:18:29 -0700
Subject: [PATCH] nvme-cli/fabrics: Add tos param to connect cmd
In-Reply-To: <a447b0ba-31ea-6a12-2fb4-6cef0b95da96@mellanox.com>
References: <1565777981-18755-1-git-send-email-israelr@mellanox.com>
 <1565777981-18755-2-git-send-email-israelr@mellanox.com>
 <33ddd40f-14a8-9506-01dc-65a049f8bb5f@grimberg.me>
 <a447b0ba-31ea-6a12-2fb4-6cef0b95da96@mellanox.com>
Message-ID: <d44bfcb2-08c8-d621-6d9f-17c3da9c40d2@broadcom.com>

On 8/15/2019 1:41 AM, Max Gurtovoy wrote:
>
> On 8/14/2019 8:08 PM, Sagi Grimberg wrote:
>>
>>> Added 'tos' to 'connect' command so users can specify the type of 
>>> service.
>>>
>>> usage examples:
>>> nvme connect --tos=0 --transport=rdma --traddr=10.0.1.1 --nqn=test-nvme
>>> nvme connect -T 0 -t rdma -a 10.0.1.1 -n test_nvme
>>
>> Still don't see how this is handled if the kernel does not support
>> tos yet.
>
> how any other feature we added to connect command will act with old 
> kernel ? (e.g. queue_size/nr_queues)
>
> it will fail to get token "token = match_token(p, opt_tokens, args);" 
> and return? -EINVAL.
>
> Israel checked that.

I think what Sagi's getting at is: it would be really nice to not fail 
the whole connect request if an argument can't be parsed. E.g. a newer 
cli, used on an older kernel, should be functional with or without the 
tos argument.

If so- as I doubt the cli knows what was invalid or which argument was 
invalid and it would be really odd (especially over time) to back out 
arguments and try again - we need to update the kernel to warn that an 
argument was not parsed and was ignored, but attempt to use what it does 
recognize and not return failure to the cli.? Sagi ?

-- james
