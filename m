From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 19 Jan 2018 15:18:17 +0100
Subject: [PATCH v4 0/2] add tracepoints for nvme command submission and
 completion
Message-ID: <20180119141819.11938-1-jthumshirn@suse.de>

Add tracepoints for nvme command submission and completion. The tracepoints
are modeled after SCSI's trace_scsi_dispatch_cmd_start() and
trace_scsi_dispatch_cmd_done() tracepoints and fulfil a similar purpose,
namely a fast way to check which command is going to be queued into the HW or
Fabric driver and which command is completed again.

Here's an example output using the qemu emulated pci nvme:

# tracer: nop
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
    kworker/u8:0-5     [003] ....     3.927513: nvme_setup_cmd: nsid=0, cmdid=3, flags=0x0, meta=0x0, cmd=(nvme_admin_create_cq cqid=1, qsize=1023, cq_flags=0x3, irq_vector=0)
          <idle>-0     [003] d.h.     3.927553: nvme_complete_rq: cmdid=3, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     3.927559: nvme_setup_cmd: nsid=0, cmdid=3, flags=0x0, meta=0x0, cmd=(nvme_admin_create_sq sqid=1, qsize=1023, sq_flags=0x1, cqid=1)
          <idle>-0     [003] d.h.     3.927732: nvme_complete_rq: cmdid=3, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     3.927741: nvme_setup_cmd: nsid=0, cmdid=3, flags=0x0, meta=0x0, cmd=(nvme_admin_create_cq cqid=2, qsize=1023, cq_flags=0x3, irq_vector=1)
          <idle>-0     [003] d.h.     3.927775: nvme_complete_rq: cmdid=3, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     3.927778: nvme_setup_cmd: nsid=0, cmdid=3, flags=0x0, meta=0x0, cmd=(nvme_admin_create_sq sqid=2, qsize=1023, sq_flags=0x1, cqid=2)
          <idle>-0     [003] d.h.     3.927915: nvme_complete_rq: cmdid=3, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     3.927960: nvme_setup_cmd: nsid=0, cmdid=3, flags=0x0, meta=0x0, cmd=(nvme_admin_create_cq cqid=3, qsize=1023, cq_flags=0x3, irq_vector=2)
          <idle>-0     [003] d.h.     3.928006: nvme_complete_rq: cmdid=3, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     3.928009: nvme_setup_cmd: nsid=0, cmdid=3, flags=0x0, meta=0x0, cmd=(nvme_admin_create_sq sqid=3, qsize=1023, sq_flags=0x1, cqid=3)
          <idle>-0     [003] d.h.     3.928141: nvme_complete_rq: cmdid=3, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     3.928183: nvme_setup_cmd: nsid=0, cmdid=3, flags=0x0, meta=0x0, cmd=(nvme_admin_create_cq cqid=4, qsize=1023, cq_flags=0x3, irq_vector=3)
          <idle>-0     [003] d.h.     3.928217: nvme_complete_rq: cmdid=3, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     3.928220: nvme_setup_cmd: nsid=0, cmdid=3, flags=0x0, meta=0x0, cmd=(nvme_admin_create_sq sqid=4, qsize=1023, sq_flags=0x1, cqid=4)
          <idle>-0     [003] d.h.     3.928336: nvme_complete_rq: cmdid=3, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     3.929405: nvme_setup_cmd: nsid=0, cmdid=3, flags=0x0, meta=0x0, cmd=(nvme_admin_identify cns=1, ctrlid=0)
          <idle>-0     [003] d.h.     3.929492: nvme_complete_rq: cmdid=3, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     3.929547: nvme_setup_cmd: nsid=1, cmdid=3, flags=0x0, meta=0x0, cmd=(nvme_admin_identify cns=0, ctrlid=0)
          <idle>-0     [003] d.h.     3.929592: nvme_complete_rq: cmdid=3, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     3.929750: nvme_setup_cmd: nsid=1, cmdid=3, flags=0x0, meta=0x0, cmd=(nvme_admin_identify cns=0, ctrlid=0)
          <idle>-0     [003] d.h.     3.929792: nvme_complete_rq: cmdid=3, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     3.929860: nvme_setup_cmd: nsid=1, cmdid=622, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=0, len=7, ctrl=0x0, dsmgmt=0, reftag=0)
          <idle>-0     [003] d.h.     3.930002: nvme_complete_rq: cmdid=622, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     3.930033: nvme_setup_cmd: nsid=1, cmdid=622, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=24, len=7, ctrl=0x0, dsmgmt=0, reftag=0)
          <idle>-0     [003] d.h.     3.930104: nvme_complete_rq: cmdid=622, res=0, retries=0, flags=0x0, status=0
              dd-205   [002] .N..     4.430448: nvme_setup_cmd: nsid=1, cmdid=626, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=0, len=2559, ctrl=0x0, dsmgmt=0, reftag=0)
              dd-205   [002] .N..     4.430490: nvme_setup_cmd: nsid=1, cmdid=627, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=2560, len=1535, ctrl=0x0, dsmgmt=0, reftag=0)
          <idle>-0     [002] d.h.     4.431423: nvme_complete_rq: cmdid=626, res=0, retries=0, flags=0x0, status=0
          <idle>-0     [002] d.h.     4.431771: nvme_complete_rq: cmdid=627, res=0, retries=0, flags=0x0, status=0
              dd-205   [002] ....     4.432657: nvme_setup_cmd: nsid=1, cmdid=627, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=4096, len=2047, ctrl=0x0, dsmgmt=0, reftag=0)
              dd-205   [002] ....     4.433779: nvme_setup_cmd: nsid=1, cmdid=628, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=6144, len=2047, ctrl=0x0, dsmgmt=0, reftag=0)
          <idle>-0     [002] d.h.     4.434007: nvme_complete_rq: cmdid=627, res=0, retries=0, flags=0x0, status=0
              dd-205   [002] ....     4.434372: nvme_setup_cmd: nsid=1, cmdid=627, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=8192, len=2047, ctrl=0x0, dsmgmt=0, reftag=0)
          <idle>-0     [002] d.h.     4.434750: nvme_complete_rq: cmdid=628, res=0, retries=0, flags=0x0, status=0
              dd-205   [002] ....     4.435215: nvme_setup_cmd: nsid=1, cmdid=628, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=10240, len=2047, ctrl=0x0, dsmgmt=0, reftag=0)
          <idle>-0     [002] d.h.     4.435494: nvme_complete_rq: cmdid=627, res=0, retries=0, flags=0x0, status=0
          <idle>-0     [002] d.h.     4.436182: nvme_complete_rq: cmdid=628, res=0, retries=0, flags=0x0, status=0
              dd-206   [003] ....     4.442316: nvme_setup_cmd: nsid=1, cmdid=622, flags=0x0, meta=0x0, cmd=(nvme_cmd_write slba=0, len=2559, ctrl=0x0, dsmgmt=0, reftag=0)
              dd-206   [003] ....     4.442579: nvme_setup_cmd: nsid=1, cmdid=623, flags=0x0, meta=0x0, cmd=(nvme_cmd_write slba=2560, len=2559, ctrl=0x0, dsmgmt=0, reftag=0)
              dd-206   [003] ....     4.442823: nvme_setup_cmd: nsid=1, cmdid=624, flags=0x0, meta=0x0, cmd=(nvme_cmd_write slba=5120, len=2559, ctrl=0x0, dsmgmt=0, reftag=0)
              dd-206   [003] ....     4.443064: nvme_setup_cmd: nsid=1, cmdid=625, flags=0x0, meta=0x0, cmd=(nvme_cmd_write slba=7680, len=2559, ctrl=0x0, dsmgmt=0, reftag=0)
          <idle>-0     [003] d.h.     4.444250: nvme_complete_rq: cmdid=622, res=0, retries=0, flags=0x0, status=0
          <idle>-0     [003] d.h.     4.444912: nvme_complete_rq: cmdid=623, res=0, retries=0, flags=0x0, status=0
          <idle>-0     [003] d.h.     4.445615: nvme_complete_rq: cmdid=624, res=0, retries=0, flags=0x0, status=0
          <idle>-0     [003] d.h.     4.446504: nvme_complete_rq: cmdid=625, res=0, retries=0, flags=0x0, status=0


Note: I decided to keep the Reviewd-by's although I added the admin command decoding.


Johannes Thumshirn (2):
  nvme: add tracepoint for nvme_setup_cmd
  nvme: add tracepoint for nvme_complete_rq

 drivers/nvme/host/Makefile |   4 ++
 drivers/nvme/host/core.c   |   6 ++
 drivers/nvme/host/trace.c  | 161 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/trace.h  | 136 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 307 insertions(+)
 create mode 100644 drivers/nvme/host/trace.c
 create mode 100644 drivers/nvme/host/trace.h

-- 
2.12.3
