From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Wed, 12 Jun 2019 21:45:28 +0900
Subject: [PATCH V8 0/5] nvme-trace: Add support for fabrics command
Message-ID: <20190612124533.10299-1-minwoo.im.dev@gmail.com>

Hi Christoph, Hi Sagi.

It's been few days for this series to be reviewed.  Please consider it
for the nvme-5.3.

This series introduces not only fabrics commands tracing in nvme host
side, but also target side tracing features.

Changes to V7:
  - http://lists.infradead.org/pipermail/linux-nvme/2019-June/024818.html
  - Add Reviewed-by: tag from Christoph.
  - Drop the 3rd commit because command_id is not in __le16.
  - Drop the 5th commit, we just can print reserved fields out.
  - Few style changes suggested by Christoph.
  - Words changes in the comments pointed out by Christoph.

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
  - do not make it within nvme admin commands (Chaitanya)

Minwoo Im (5):
  nvme: trace: do not EXPORT_SYMBOL for a trace function
  nvme: trace: move opcode symbol print to nvme.h
  nvme: trace: support for fabrics commands in host-side
  nvme: trace: print result and status in hex format
  nvmet: introduce target-side trace

 drivers/nvme/host/trace.c    |  68 +++++++++++-
 drivers/nvme/host/trace.h    |  66 +++---------
 drivers/nvme/target/Makefile |   3 +
 drivers/nvme/target/core.c   |   8 ++
 drivers/nvme/target/trace.c  | 202 +++++++++++++++++++++++++++++++++++
 drivers/nvme/target/trace.h  | 141 ++++++++++++++++++++++++
 include/linux/nvme.h         |  59 ++++++++++
 7 files changed, 495 insertions(+), 52 deletions(-)
 create mode 100644 drivers/nvme/target/trace.c
 create mode 100644 drivers/nvme/target/trace.h

-- 
2.21.0
