From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu,  6 Jun 2019 15:32:26 +0900
Subject: [RFC PATCH V6 0/3] nvme-trace: Add support for fabrics command
Message-ID: <20190606063229.17258-1-minwoo.im.dev@gmail.com>

Hi,

This is 6th series to introduce target-side tracing.  This series
continas codes duplicated with host-side tracing, but it can make us
avoid some disadvantages Christoph pointed out.

The target-side takes struct nvmet_req *req, so that those two entries
have a little bit different from host-side tracing entries.

The following logs are examples of this patch series when trying to
connect the loop targeted device:
            nvme-2401  [006] ....  1474.570779: nvmet_req_init: nvme0: qid=0, cmdid=0, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_fabrics_type_connect recfmt=0, qid=0, sqsize=31, cattr=0, kato=15000)
     kworker/6:2-1067  [006] ....  1474.570933: nvmet_req_complete: nvme1: qid=0, cmdid=0, res=0x1, status=0x0
            nvme-2401  [004] ....  1474.571216: nvmet_req_init: nvme1: qid=0, cmdid=6, nsid=4, flags=0x40, meta=0x0, cmd=(nvme_fabrics_type_property_get attrib=1, ofst=0x0)
     kworker/4:2-1235  [004] ....  1474.571336: nvmet_req_complete: nvme1: qid=0, cmdid=6, res=0x200f0003ff, status=0x0
            nvme-2401  [006] ....  1474.571440: nvmet_req_init: nvme1: qid=0, cmdid=22, nsid=0, flags=0x40, meta=0x0, cmd=(nvme_fabrics_type_property_set attrib=0, ofst=0x14, value=0x460001)
     kworker/6:2-1067  [006] ....  1474.571494: nvmet_req_complete: nvme1: qid=0, cmdid=22, res=0x0, status=0x0
            nvme-2401  [004] ....  1474.571668: nvmet_req_init: nvme1: qid=0, cmdid=7, nsid=4, flags=0x40, meta=0x0, cmd=(nvme_fabrics_type_property_get attrib=0, ofst=0x1c)
     kworker/4:2-1235  [004] ....  1474.571767: nvmet_req_complete: nvme1: qid=0, cmdid=7, res=0x1, status=0x0
            nvme-2401  [006] ....  1474.572078: nvmet_req_init: nvme1: qid=0, cmdid=23, nsid=4, flags=0x40, meta=0x0, cmd=(nvme_fabrics_type_property_get attrib=0, ofst=0x8)
     kworker/6:2-1067  [006] ....  1474.572098: nvmet_req_complete: nvme1: qid=0, cmdid=23, res=0x10300, status=0x0
            nvme-2401  [004] ....  1474.572268: nvmet_req_init: nvme1: qid=0, cmdid=8, nsid=4, flags=0x40, meta=0x0, cmd=(nvme_fabrics_type_property_get attrib=1, ofst=0x0)
     kworker/4:2-1235  [004] ....  1474.572287: nvmet_req_complete: nvme1: qid=0, cmdid=8, res=0x200f0003ff, status=0x0
            nvme-2401  [006] ....  1474.572436: nvmet_req_init: nvme1: qid=0, cmdid=24, nsid=0, flags=0x40, meta=0x0, cmd=(nvme_admin_identify cns=1, ctrlid=0)
     kworker/6:2-1067  [006] ....  1474.572462: nvmet_req_complete: nvme1: qid=0, cmdid=24, res=0x0, status=0x0
            nvme-2401  [004] ....  1474.572643: nvmet_req_init: nvme1: qid=0, cmdid=9, nsid=4294967295, flags=0x40, meta=0x0, cmd=(nvme_admin_get_log_page cdw10=05 00 ff 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)
     kworker/4:2-1235  [004] ....  1474.572664: nvmet_req_complete: nvme1: qid=0, cmdid=9, res=0x0, status=0x0
            nvme-2401  [006] ....  1474.573001: nvmet_req_init: nvme1: qid=0, cmdid=25, nsid=4294967295, flags=0x40, meta=0x0, cmd=(nvme_admin_get_log_page cdw10=0c 01 03 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)
     kworker/6:2-1067  [006] ....  1474.573028: nvmet_req_complete: nvme1: qid=0, cmdid=25, res=0x0, status=0x0
            nvme-2401  [004] ....  1474.573158: nvmet_req_init: nvme1: qid=0, cmdid=6, nsid=0, flags=0x40, meta=0x0, cmd=(nvme_admin_set_features cdw10=07 00 00 00 07 00 07 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)
     kworker/4:2-1235  [004] ....  1474.573179: nvmet_req_complete: nvme1: qid=0, cmdid=6, res=0x20007f007f, status=0x0
    kworker/0:1H-1057  [000] ....  1474.574905: nvmet_req_init: nvme0: qid=0, cmdid=0, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_fabrics_type_connect recfmt=0, qid=1, sqsize=127, cattr=0, kato=0)
     kworker/0:2-2118  [000] ....  1474.575025: nvmet_req_complete: nvme1: qid=1, cmdid=0, res=0x0, status=0x0
    kworker/1:1H-1867  [001] ....  1474.575236: nvmet_req_init: nvme0: qid=0, cmdid=0, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_fabrics_type_connect recfmt=0, qid=2, sqsize=127, cattr=0, kato=0)
     kworker/1:1-63    [001] ....  1474.575358: nvmet_req_complete: nvme1: qid=2, cmdid=0, res=0x0, status=0x0

Please review.
Thanks,

Changes to V5:
  - Provide trace code to the target-side instead of a common code
    shared between host and target to avoid disadvantages something bad
    for the performance like cache miss.  It has been suggested by
    Christoph.
  - Removed the third patch out of this series because that has nothing
    to do with this series.
  - Merged the last two commits into a single commit for the review.

Changes to V4:
  - Add Reviewed-by: tag from Sagi. (Thanks to Sagi)
  - Consider endianness for cqe->status when assigning the value in
    trace
  - Add more descriptions about the variable arguments in events.

Changes to V3:
  - Remove additional argument from the caller level.

Changes to V2:
  - Provide a common code for both host and target. (Chaitanya)
  - Add support for tracing requests in target-side (Chaitanya)
  - Make it simple in trace.h without branch out from nvme core module
    (Christoph)

Changes to V1:
  - fabrics commands should also be decoded, not just showing that it's
    a fabrics command. (Christoph)
  - do not make it within nvme admin commands (Chaitanya)

Minwoo Im (3):
  nvmet: introduce nvmet_req_to_ctrl to get ctrl instance
  nvme: trace: do not EXPORT_SYMBOL for a trace function
  nvmet: introduce target-side trace

 drivers/nvme/host/trace.c    |   1 -
 drivers/nvme/target/Makefile |   3 +
 drivers/nvme/target/core.c   |   8 ++
 drivers/nvme/target/nvmet.h  |   9 ++
 drivers/nvme/target/trace.c  | 179 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/trace.h  | 184 +++++++++++++++++++++++++++++++++++
 6 files changed, 383 insertions(+), 1 deletion(-)
 create mode 100644 drivers/nvme/target/trace.c
 create mode 100644 drivers/nvme/target/trace.h

-- 
2.21.0
