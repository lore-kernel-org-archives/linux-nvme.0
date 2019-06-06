From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Fri,  7 Jun 2019 04:45:05 +0900
Subject: [RFC PATCH V7 0/7] nvme-trace: Add support for fabrics command
Message-ID: <20190606194512.11020-1-minwoo.im.dev@gmail.com>

Hi,

This is 7th series to support for commands tracing in host and target-side
for not only admin and nvm commands, but also fabrics commands.

This series has been applied suggestion points from Christoph, and it
has added patches for host-side which has exactly the same things with
the target-side as we discussed.

This series has been tested with the target backed loop device, and the
target with RDMA.

Example (RDMA):
  1) target-side
 kworker/0:2-1844  [000] ....    65.451612: nvmet_req_init: nvmet_: qid=0, cmdid=0 cmd=(nvme_fabrics_type_connect, recfmt=0, qid=0, sqsize=31, cattr=0, kato=15000)
kworker/0:1H-1056  [000] ....    65.454270: nvmet_req_complete: nvmet1: qid=0, cmdid=0, res=0xffff888000000001, status=0x0
kworker/0:1H-1056  [000] ....    65.456356: nvmet_req_init: nvmet1: qid=0, cmdid=6 cmd=(nvme_fabrics_type_property_get, attrib=1, ofst=0x0)
kworker/0:1H-1056  [000] ....    65.456663: nvmet_req_complete: nvmet1: qid=0, cmdid=6, res=0x200f0003ff, status=0x0
kworker/0:1H-1056  [000] ....    65.459008: nvmet_req_init: nvmet1: qid=0, cmdid=7 cmd=(nvme_fabrics_type_property_set, attrib=0, ofst=0x14, value=0x460001)
kworker/0:1H-1056  [000] ....    65.459101: nvmet_req_complete: nvmet1: qid=0, cmdid=7, res=0xffff88807ac61420, status=0x0
kworker/0:1H-1056  [000] ....    65.461032: nvmet_req_init: nvmet1: qid=0, cmdid=8 cmd=(nvme_fabrics_type_property_get, attrib=0, ofst=0x1c)
kworker/0:1H-1056  [000] ....    65.461118: nvmet_req_complete: nvmet1: qid=0, cmdid=8, res=0x1, status=0x0
kworker/0:1H-1056  [000] ....    65.462977: nvmet_req_init: nvmet1: qid=0, cmdid=9 cmd=(nvme_fabrics_type_property_get, attrib=0, ofst=0x8)
kworker/0:1H-1056  [000] ....    65.463087: nvmet_req_complete: nvmet1: qid=0, cmdid=9, res=0x10300, status=0x0
kworker/0:1H-1056  [000] ....    65.465135: nvmet_req_init: nvmet1: qid=0, cmdid=6 cmd=(nvme_fabrics_type_property_get, attrib=1, ofst=0x0)
kworker/0:1H-1056  [000] ....    65.465234: nvmet_req_complete: nvmet1: qid=0, cmdid=6, res=0x200f0003ff, status=0x0
...
kworker/0:1H-1056  [000] ....    65.569340: nvmet_req_init: nvmet1: disk=/dev/nvme0n1, qid=6, cmdid=49, nsid=0x1, flags=0x40, meta=0x0 cmd=(nvme_cmd_read, slba=0, len=7, ctrl=0x0, dsmgmt=0, reftag=0)
      <idle>-0     [000] d.h.    65.570140: nvmet_req_complete: nvmet1: disk=/dev/nvme0n1, qid=6, cmdid=49, res=0xffff88807a3b8b90, status=0x0
kworker/0:1H-1056  [000] ....    65.573208: nvmet_req_init: nvmet1: disk=/dev/nvme0n1, qid=6, cmdid=50, nsid=0x1, flags=0x40, meta=0x0 cmd=(nvme_cmd_read, slba=8, len=7, ctrl=0x0, dsmgmt=0, reftag=0)
      <idle>-0     [000] d.H.    65.573790: nvmet_req_complete: nvmet1: disk=/dev/nvme0n1, qid=6, cmdid=50, res=0xffff88807a3b8ba0, status=0x0
kworker/0:1H-1056  [000] ....    65.585858: nvmet_req_init: nvmet1: disk=/dev/nvme0n1, qid=3, cmdid=1, nsid=0x1, flags=0x40, meta=0x0 cmd=(nvme_cmd_read, slba=1048448, len=7, ctrl=0x8000, dsmgmt=7, reftag=0)
      <idle>-0     [000] d.h.    65.586238: nvmet_req_complete: nvmet1: disk=/dev/nvme0n1, qid=3, cmdid=1, res=0xffff88807c9e95c0, status=0x0
kworker/0:1H-1056  [000] ....    65.587726: nvmet_req_init: nvmet1: disk=/dev/nvme0n1, qid=3, cmdid=2, nsid=0x1, flags=0x40, meta=0x0 cmd=(nvme_cmd_read, slba=1048560, len=7, ctrl=0x8000, dsmgmt=7, reftag=0)
      <idle>-0     [000] d.h.    65.587982: nvmet_req_complete: nvmet1: disk=/dev/nvme0n1, qid=3, cmdid=2, res=0xffff88807c9e95d0, status=0x0

  2) host-side
  nvme-2318  [007] ....    64.668667: nvme_setup_cmd: nvme0: qid=0, cmdid=0 cmd=(nvme_fabrics_type_connect recfmt=0, qid=0, sqsize=31, cattr=0, kato=15000)
<idle>-0     [007] ..s.    64.673720: nvme_complete_rq: nvme0: qid=0, cmdid=0, res=0xffff888000000001, retries=0, flags=0x0, status=0x0
  nvme-2318  [007] ....    64.673882: nvme_setup_cmd: nvme0: qid=0, cmdid=6 cmd=(nvme_fabrics_type_property_get attrib=1, ofst=0x0)
<idle>-0     [007] ..s.    64.676172: nvme_complete_rq: nvme0: qid=0, cmdid=6, res=0x200f0003ff, retries=0, flags=0x0, status=0x0
  nvme-2318  [007] ....    64.676306: nvme_setup_cmd: nvme0: qid=0, cmdid=7 cmd=(nvme_fabrics_type_property_set attrib=0, ofst=0x14, value=0x460001)
<idle>-0     [007] ..s.    64.678340: nvme_complete_rq: nvme0: qid=0, cmdid=7, res=0xffff88807ac61420, retries=0, flags=0x0, status=0x0
  nvme-2318  [007] ....    64.678363: nvme_setup_cmd: nvme0: qid=0, cmdid=8 cmd=(nvme_fabrics_type_property_get attrib=0, ofst=0x1c)
<idle>-0     [007] ..s.    64.680215: nvme_complete_rq: nvme0: qid=0, cmdid=8, res=0x1, retries=0, flags=0x0, status=0x0
  nvme-2318  [007] ....    64.680240: nvme_setup_cmd: nvme0: qid=0, cmdid=9 cmd=(nvme_fabrics_type_property_get attrib=0, ofst=0x8)
<idle>-0     [007] ..s.    64.682335: nvme_complete_rq: nvme0: qid=0, cmdid=9, res=0x10300, retries=0, flags=0x0, status=0x0
  nvme-2318  [007] ....    64.682474: nvme_setup_cmd: nvme0: qid=0, cmdid=6 cmd=(nvme_fabrics_type_property_get attrib=1, ofst=0x0)
<idle>-0     [007] ..s.    64.684448: nvme_complete_rq: nvme0: qid=0, cmdid=6, res=0x200f0003ff, retries=0, flags=0x0, status=0x0
...
worker/u18:2-1945  [005] ....    64.786215: nvme_setup_cmd: nvme0: disk=nvme0c0n1, qid=6, cmdid=49, nsid=0x1, flags=0x40, meta=0x0 cmd=(nvme_cmd_read slba=0, len=7, ctrl=0x0, dsmgmt=0, reftag=0)
      <idle>-0     [005] d.h.    64.790116: nvme_complete_rq: nvme0: disk=nvme0c0n1, qid=6, cmdid=49, res=0xffff88807a3b8b90, retries=0, flags=0x0, status=0x0
worker/u18:2-1945  [005] ....    64.790287: nvme_setup_cmd: nvme0: disk=nvme0c0n1, qid=6, cmdid=50, nsid=0x1, flags=0x40, meta=0x0 cmd=(nvme_cmd_read slba=8, len=7, ctrl=0x0, dsmgmt=0, reftag=0)
      <idle>-0     [005] d.h.    64.794233: nvme_complete_rq: nvme0: disk=nvme0c0n1, qid=6, cmdid=50, res=0xffff88807a3b8ba0, retries=0, flags=0x0, status=0x0
ystemd-udevd-2328  [002] ....    64.803350: nvme_setup_cmd: nvme0: disk=nvme0c0n1, qid=3, cmdid=1, nsid=0x1, flags=0x40, meta=0x0 cmd=(nvme_cmd_read slba=1048448, len=7, ctrl=0x8000, dsmgmt=7, reftag=0)
      <idle>-0     [000] ..s.    64.805254: nvme_complete_rq: nvme0: disk=nvme0c0n1, qid=3, cmdid=1, res=0xffff88807c9e95c0, retries=0, flags=0x0, status=0x0
ystemd-udevd-2328  [002] ....    64.805389: nvme_setup_cmd: nvme0: disk=nvme0c0n1, qid=3, cmdid=2, nsid=0x1, flags=0x0, meta=0x0 cmd=(nvme_cmd_read slba=1048560, len=7, ctrl=0x8000, dsmgmt=7, reftag=0)
      <idle>-0     [000] ..s.    64.807072: nvme_complete_rq: nvme0: disk=nvme0c0n1, qid=3, cmdid=2, res=0xffff88807c9e95d0, retries=0, flags=0x0, status=0x0

Please review.
Thanks,

Changes to V6:
  - Removed the first patch by a suggestion from Christoph.  The helper
    nvmet_req_to_ctrl() has been moved to the last commit which
    introduces the target-side tracing.
  - Symbolic print for the opcodes for admin, nvm, and fabrics have been
    moved to <linux/nvme.h> to be shared between host and target side.
    It's just a bunch of macros so that we don't share the actual code
    as suggested by Christoph.
  - Print "device_path" when I/O commands come in and out.  The uuid
    will make the trace line too long so that we just can know the
    backed device for the request.
  - From the 2nd patch to 6th patch, they have been added to this series
    to make sure the host-side trace supports the exactly same thing
    with the target-side introduced.

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
  - do not make it within nvme admin commands (Chaitany

Minwoo Im (7):
  nvme: trace: do not EXPORT_SYMBOL for a trace function
  nvme: trace: move opcode symbol print to nvme.h
  nvme: trace: put cid with le16_to_cpu()
  nvme: trace: support for fabrics commands in host-side
  nvme: trace: filter out unnecessary fields for fabrics
  nvme: trace: print result and status in hex format
  nvmet: introduce target-side trace

 drivers/nvme/host/trace.c    |  88 +++++++++++++-
 drivers/nvme/host/trace.h    |  86 ++++----------
 drivers/nvme/target/Makefile |   3 +
 drivers/nvme/target/core.c   |   8 ++
 drivers/nvme/target/trace.c  | 222 +++++++++++++++++++++++++++++++++++
 drivers/nvme/target/trace.h  | 140 ++++++++++++++++++++++
 include/linux/nvme.h         |  59 ++++++++++
 7 files changed, 545 insertions(+), 61 deletions(-)
 create mode 100644 drivers/nvme/target/trace.c
 create mode 100644 drivers/nvme/target/trace.h

--
2.21.0
