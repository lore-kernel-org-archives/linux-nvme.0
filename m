From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 28 May 2019 02:53:41 +0900
Subject: [RFC PATCH V4 0/5] nvme-trace: Add support for fabrics command
Message-ID: <20190527175346.29972-1-minwoo.im.dev@gmail.com>

Hi all,

Here's a fourth patchset to support fabrics command tracing.  The first
patch updated host/trace module to a outside of it to provide common
interfaces for host and target both.  The second one adds support for
tracing fabrics command from host-side.  The third is a trivial clean-up
for providing a helper function to figure out given command structure is
for fabrics or not.

The fourth and fifth are the major change points of this patchset.  4th
patch adds request tracing from the target-side.  5th updated, of
course, completion of given request.

Tihs series has been reviewed by V3, but I didn't like the additional
argument frmo the caller side like NVME_TRACE_[HOST|TARGET].  V4
introduces it without additional argument, but it has an work-around not
to make them have additional arguments in caller level.

Please review.
Thanks,

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
  nvme: Make trace common for host and target both
  nvme-trace: Support tracing fabrics commands from host-side
  nvme: Introduce nvme_is_fabrics to check fabrics cmd
  nvme-trace: Add tracing for req_init in target
  nvme-trace: Add tracing for req_comp in target

 MAINTAINERS                       |   2 +
 drivers/nvme/Makefile             |   3 +
 drivers/nvme/host/Makefile        |   1 -
 drivers/nvme/host/core.c          |   3 +-
 drivers/nvme/host/fabrics.c       |   2 +-
 drivers/nvme/host/pci.c           |   2 +-
 drivers/nvme/target/core.c        |   8 +-
 drivers/nvme/target/fabrics-cmd.c |   2 +-
 drivers/nvme/target/fc.c          |   2 +-
 drivers/nvme/target/nvmet.h       |   9 ++
 drivers/nvme/{host => }/trace.c   |  75 +++++++++++++++
 drivers/nvme/{host => }/trace.h   | 154 +++++++++++++++++++++++++-----
 include/linux/nvme.h              |   7 +-
 13 files changed, 237 insertions(+), 33 deletions(-)
 rename drivers/nvme/{host => }/trace.c (65%)
 rename drivers/nvme/{host => }/trace.h (57%)

-- 
2.21.0
