From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 24 Jun 2018 19:01:53 +0300
Subject: [PATCH 1/1] nvme-fabrics: use default value for nr_io_queues
 setting
In-Reply-To: <1529855352-29356-1-git-send-email-maxg@mellanox.com>
References: <1529855352-29356-1-git-send-email-maxg@mellanox.com>
Message-ID: <cd5e47cd-1f87-026e-42e7-7849f09b0e43@grimberg.me>


> We set default value for nr_io_queues to be num_online_cpus(). No need
> to call num_online_cpus() again since we can use the default value we
> set earlier.

We should not override user arguments. plus num_online_cpus can change
from X to 1 and back to X...
