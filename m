From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 13 Aug 2019 09:43:56 -0700
Subject: [PATCH] nvme-cli/fabrics: Add tos param to connect cmd
In-Reply-To: <1565702251-17198-2-git-send-email-israelr@mellanox.com>
References: <1565702251-17198-1-git-send-email-israelr@mellanox.com>
 <1565702251-17198-2-git-send-email-israelr@mellanox.com>
Message-ID: <82499575-a1d7-35aa-1cae-32d1fdbc3ab0@grimberg.me>


> Added 'tos' to 'connect' command so users can specify the type of service.
> 
> usage examples:
> nvme connect --tos=0 --transport=rdma --traddr=10.0.1.1 --nqn=test-nvme
> nvme connect -T 0 -t rdma -a 10.0.1.1 -n test_nvme
> 

What if you run this with a kernel that doesn't support tos yet?
