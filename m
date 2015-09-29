From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 29 Sep 2015 11:20:54 +0800
Subject: [PATCH 0/3] blk-mq & nvme: introduce .map_changed
Message-ID: <1443496857-26887-1-git-send-email-tom.leiming@gmail.com>

This patchset introduces .map_changed callback into 'struct blk_mq_ops',
and use this callback to get NVMe notified about the mapping changed event,
then NVMe can update the irq affinity hint for its queues.

Also the 'cpumask' in 'struct blk_mq_tags' isn't needed any more, so remove
that and related kernel interface.

Thanks,
