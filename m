From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 14 Aug 2019 10:08:21 -0700
Subject: [PATCH] nvme-cli/fabrics: Add tos param to connect cmd
In-Reply-To: <1565777981-18755-2-git-send-email-israelr@mellanox.com>
References: <1565777981-18755-1-git-send-email-israelr@mellanox.com>
 <1565777981-18755-2-git-send-email-israelr@mellanox.com>
Message-ID: <33ddd40f-14a8-9506-01dc-65a049f8bb5f@grimberg.me>


> Added 'tos' to 'connect' command so users can specify the type of service.
> 
> usage examples:
> nvme connect --tos=0 --transport=rdma --traddr=10.0.1.1 --nqn=test-nvme
> nvme connect -T 0 -t rdma -a 10.0.1.1 -n test_nvme

Still don't see how this is handled if the kernel does not support
tos yet.
