From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 24 Apr 2019 09:31:23 -0700
Subject: [PATCH 1/2] nvme: pci: Return -EINVAL if given nr_queue larger
 than nr_cpu
In-Reply-To: <20190411155239.1094-2-minwoo.im.dev@gmail.com>
References: <20190411155239.1094-1-minwoo.im.dev@gmail.com>
 <20190411155239.1094-2-minwoo.im.dev@gmail.com>
Message-ID: <f01517db-74ba-477f-49fe-88aaf0b8ab89@grimberg.me>


> "write_queues" and "poll_queues" can be configured by module parameters
> with callback queue_count_set().
> 
> This function shall return a error if given number of queue is larger
> than nr_possible_cpus due to blk-mq.

Why?
