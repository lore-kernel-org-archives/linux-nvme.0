From: m.misono760@gmail.com (Masanori Misono)
Date: Fri, 18 Jan 2019 14:32:54 +0900
Subject: [PATCH 1/1] nvme pci: fix the check of the cqe->command_id
In-Reply-To: <20190118051755.1818-1-m.misono760@gmail.com>
References: <20190118051755.1818-1-m.misono760@gmail.com>
Message-ID: <CAKRxd0sd8QCytWyqsgXQCgwe87zrq-UdbncMuQuTfYwbv1gjSw@mail.gmail.com>

This patch is something similar to
http://lists.infradead.org/pipermail/linux-nvme/2019-January/021892.html
and tries to protect against hardware failures.
I just found this problem using my own fault injection scheme.
In fc.c and rdma.c, the return value of the blk_mq_tag_to_rq() is checked.
