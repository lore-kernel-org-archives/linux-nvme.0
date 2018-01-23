From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 23 Jan 2018 11:56:39 +0100
Subject: [PATCH v5 0/2] add tracepoints for nvme command submission and
 completion
Message-ID: <20180123105641.24930-1-jthumshirn@suse.de>

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
    kworker/u8:0-5     [003] ....     2.998792: nvme_setup_admin_cmd:  cmdid=14, flags=0x0, meta=0x0, cmd=(nvme_admin_create_cq cqid=1, qsize=1023, cq_flags=0x3, irq_vector=0)
          <idle>-0     [003] d.h.     2.998866: nvme_complete_rq: cmdid=14, qid=0, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     2.998872: nvme_setup_admin_cmd:  cmdid=14, flags=0x0, meta=0x0, cmd=(nvme_admin_create_sq sqid=1, qsize=1023, sq_flags=0x1, cqid=1)
          <idle>-0     [003] d.h.     2.999050: nvme_complete_rq: cmdid=14, qid=0, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     2.999059: nvme_setup_admin_cmd:  cmdid=14, flags=0x0, meta=0x0, cmd=(nvme_admin_create_cq cqid=2, qsize=1023, cq_flags=0x3, irq_vector=1)
          <idle>-0     [003] d.h.     2.999102: nvme_complete_rq: cmdid=14, qid=0, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     2.999105: nvme_setup_admin_cmd:  cmdid=14, flags=0x0, meta=0x0, cmd=(nvme_admin_create_sq sqid=2, qsize=1023, sq_flags=0x1, cqid=2)
          <idle>-0     [003] d.h.     2.999218: nvme_complete_rq: cmdid=14, qid=0, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     2.999266: nvme_setup_admin_cmd:  cmdid=14, flags=0x0, meta=0x0, cmd=(nvme_admin_create_cq cqid=3, qsize=1023, cq_flags=0x3, irq_vector=2)
          <idle>-0     [003] d.h.     2.999305: nvme_complete_rq: cmdid=14, qid=0, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     2.999308: nvme_setup_admin_cmd:  cmdid=14, flags=0x0, meta=0x0, cmd=(nvme_admin_create_sq sqid=3, qsize=1023, sq_flags=0x1, cqid=3)
          <idle>-0     [003] d.h.     2.999427: nvme_complete_rq: cmdid=14, qid=0, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     2.999472: nvme_setup_admin_cmd:  cmdid=14, flags=0x0, meta=0x0, cmd=(nvme_admin_create_cq cqid=4, qsize=1023, cq_flags=0x3, irq_vector=3)
          <idle>-0     [003] d.h.     2.999504: nvme_complete_rq: cmdid=14, qid=0, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     2.999507: nvme_setup_admin_cmd:  cmdid=14, flags=0x0, meta=0x0, cmd=(nvme_admin_create_sq sqid=4, qsize=1023, sq_flags=0x1, cqid=4)
          <idle>-0     [003] d.h.     2.999626: nvme_complete_rq: cmdid=14, qid=0, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     3.000677: nvme_setup_admin_cmd:  cmdid=14, flags=0x0, meta=0x0, cmd=(nvme_admin_identify cns=0, ctrlid=1)
          <idle>-0     [003] d.h.     3.000746: nvme_complete_rq: cmdid=14, qid=0, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] .N..     3.000802: nvme_setup_admin_cmd:  cmdid=14, flags=0x0, meta=0x0, cmd=(nvme_admin_identify cns=0, ctrlid=0)
          <idle>-0     [003] d.h.     3.000843: nvme_complete_rq: cmdid=14, qid=0, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     3.000979: nvme_setup_admin_cmd:  cmdid=14, flags=0x0, meta=0x0, cmd=(nvme_admin_identify cns=0, ctrlid=0)
          <idle>-0     [003] d.h.     3.001020: nvme_complete_rq: cmdid=14, qid=0, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     3.001064: nvme_setup_nvm_cmd: nsid=1, cmdid=830, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=0, len=7, ctrl=0x0, dsmgmt=0, reftag=0)
          <idle>-0     [003] d.h.     3.001218: nvme_complete_rq: cmdid=830, qid=1, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     3.001245: nvme_setup_nvm_cmd: nsid=1, cmdid=830, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=24, len=7, ctrl=0x0, dsmgmt=0, reftag=0)
          <idle>-0     [003] d.h.     3.001302: nvme_complete_rq: cmdid=830, qid=1, res=0, retries=0, flags=0x0, status=0
              dd-205   [001] ....     3.500869: nvme_setup_nvm_cmd: nsid=1, cmdid=988, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=0, len=2559, ctrl=0x0, dsmgmt=0, reftag=0)
              dd-205   [001] ....     3.501764: nvme_setup_nvm_cmd: nsid=1, cmdid=989, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=2560, len=1535, ctrl=0x0, dsmgmt=0, reftag=0)
          <idle>-0     [001] d.h.     3.502925: nvme_complete_rq: cmdid=988, qid=1, res=0, retries=0, flags=0x0, status=0
          <idle>-0     [001] d.h.     3.503256: nvme_complete_rq: cmdid=989, qid=1, res=0, retries=0, flags=0x0, status=0
              dd-205   [001] ....     3.503929: nvme_setup_nvm_cmd: nsid=1, cmdid=989, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=4096, len=2047, ctrl=0x0, dsmgmt=0, reftag=0)
              dd-205   [001] ....     3.504240: nvme_setup_nvm_cmd: nsid=1, cmdid=990, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=6144, len=2047, ctrl=0x0, dsmgmt=0, reftag=0)
          <idle>-0     [001] d.h.     3.505266: nvme_complete_rq: cmdid=989, qid=1, res=0, retries=0, flags=0x0, status=0
              dd-205   [001] ....     3.505711: nvme_setup_nvm_cmd: nsid=1, cmdid=989, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=8192, len=2047, ctrl=0x0, dsmgmt=0, reftag=0)
          <idle>-0     [001] d.h.     3.505850: nvme_complete_rq: cmdid=990, qid=1, res=0, retries=0, flags=0x0, status=0
              dd-205   [001] ....     3.506202: nvme_setup_nvm_cmd: nsid=1, cmdid=990, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=10240, len=2047, ctrl=0x0, dsmgmt=0, reftag=0)
          <idle>-0     [001] d.H.     3.507158: nvme_complete_rq: cmdid=989, qid=1, res=0, retries=0, flags=0x0, status=0
              dd-205   [001] d.h.     3.507650: nvme_complete_rq: cmdid=990, qid=1, res=0, retries=0, flags=0x0, status=0
              dd-206   [000] ....     3.515159: nvme_setup_nvm_cmd: nsid=1, cmdid=853, flags=0x0, meta=0x0, cmd=(nvme_cmd_write slba=0, len=2559, ctrl=0x0, dsmgmt=0, reftag=0)
              dd-206   [000] ....     3.515626: nvme_setup_nvm_cmd: nsid=1, cmdid=854, flags=0x0, meta=0x0, cmd=(nvme_cmd_write slba=2560, len=2559, ctrl=0x0, dsmgmt=0, reftag=0)
              dd-206   [000] ....     3.516093: nvme_setup_nvm_cmd: nsid=1, cmdid=855, flags=0x0, meta=0x0, cmd=(nvme_cmd_write slba=5120, len=2559, ctrl=0x0, dsmgmt=0, reftag=0)
              dd-206   [000] ....     3.516529: nvme_setup_nvm_cmd: nsid=1, cmdid=856, flags=0x0, meta=0x0, cmd=(nvme_cmd_write slba=7680, len=2559, ctrl=0x0, dsmgmt=0, reftag=0)
          <idle>-0     [000] d.h.     3.516865: nvme_complete_rq: cmdid=853, qid=1, res=0, retries=0, flags=0x0, status=0
          <idle>-0     [000] d.h.     3.517744: nvme_complete_rq: cmdid=854, qid=1, res=0, retries=0, flags=0x0, status=0
          <idle>-0     [000] d.h.     3.518581: nvme_complete_rq: cmdid=856, qid=1, res=0, retries=0, flags=0x0, status=0
          <idle>-0     [000] d.h.     3.519480: nvme_complete_rq: cmdid=855, qid=1, res=0, retries=0, flags=0x0, status=0

Johannes Thumshirn (2):
  nvme: add tracepoint for nvme_setup_cmd
  nvme: add tracepoint for nvme_complete_rq

 drivers/nvme/host/Makefile |   4 ++
 drivers/nvme/host/core.c   |   9 +++
 drivers/nvme/host/trace.c  | 131 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/trace.h  | 165 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 309 insertions(+)
 create mode 100644 drivers/nvme/host/trace.c
 create mode 100644 drivers/nvme/host/trace.h

-- 
2.12.3
