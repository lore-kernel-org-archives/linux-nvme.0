From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 23 Jan 2018 15:30:01 +0100
Subject: [PATCH v6 0/2] add tracepoints for nvme command submission and
 completion
Message-ID: <20180123143003.28299-1-jthumshirn@suse.de>

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
    kworker/u8:0-5     [003] ....     9.158541: nvme_setup_admin_cmd:  cmdid=14, flags=0x0, meta=0x0, cmd=(nvme_admin_create_cq cqid=1, qsize=1023, cq_flags=0x3, irq_vector=0)
          <idle>-0     [003] d.h.     9.158705: nvme_complete_rq: cmdid=14, qid=0, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     9.158712: nvme_setup_admin_cmd:  cmdid=14, flags=0x0, meta=0x0, cmd=(nvme_admin_create_sq sqid=1, qsize=1023, sq_flags=0x1, cqid=1)
          <idle>-0     [003] d.h.     9.159214: nvme_complete_rq: cmdid=14, qid=0, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     9.159236: nvme_setup_admin_cmd:  cmdid=14, flags=0x0, meta=0x0, cmd=(nvme_admin_create_cq cqid=2, qsize=1023, cq_flags=0x3, irq_vector=1)
          <idle>-0     [003] d.h.     9.159288: nvme_complete_rq: cmdid=14, qid=0, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     9.159293: nvme_setup_admin_cmd:  cmdid=14, flags=0x0, meta=0x0, cmd=(nvme_admin_create_sq sqid=2, qsize=1023, sq_flags=0x1, cqid=2)
          <idle>-0     [003] d.h.     9.159479: nvme_complete_rq: cmdid=14, qid=0, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     9.159525: nvme_setup_admin_cmd:  cmdid=14, flags=0x0, meta=0x0, cmd=(nvme_admin_create_cq cqid=3, qsize=1023, cq_flags=0x3, irq_vector=2)
          <idle>-0     [003] d.h.     9.159565: nvme_complete_rq: cmdid=14, qid=0, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     9.159569: nvme_setup_admin_cmd:  cmdid=14, flags=0x0, meta=0x0, cmd=(nvme_admin_create_sq sqid=3, qsize=1023, sq_flags=0x1, cqid=3)
          <idle>-0     [003] d.h.     9.159726: nvme_complete_rq: cmdid=14, qid=0, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     9.159769: nvme_setup_admin_cmd:  cmdid=14, flags=0x0, meta=0x0, cmd=(nvme_admin_create_cq cqid=4, qsize=1023, cq_flags=0x3, irq_vector=3)
          <idle>-0     [003] d.h.     9.159795: nvme_complete_rq: cmdid=14, qid=0, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     9.159799: nvme_setup_admin_cmd:  cmdid=14, flags=0x0, meta=0x0, cmd=(nvme_admin_create_sq sqid=4, qsize=1023, sq_flags=0x1, cqid=4)
          <idle>-0     [003] d.h.     9.159957: nvme_complete_rq: cmdid=14, qid=0, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     9.160971: nvme_setup_admin_cmd:  cmdid=14, flags=0x0, meta=0x0, cmd=(nvme_admin_identify cns=0, ctrlid=1)
          <idle>-0     [003] d.h.     9.161059: nvme_complete_rq: cmdid=14, qid=0, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     9.161101: nvme_setup_admin_cmd:  cmdid=14, flags=0x0, meta=0x0, cmd=(nvme_admin_identify cns=0, ctrlid=0)
          <idle>-0     [003] d.h.     9.161160: nvme_complete_rq: cmdid=14, qid=0, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     9.161305: nvme_setup_admin_cmd:  cmdid=14, flags=0x0, meta=0x0, cmd=(nvme_admin_identify cns=0, ctrlid=0)
          <idle>-0     [003] d.h.     9.161344: nvme_complete_rq: cmdid=14, qid=0, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     9.161390: nvme_setup_nvm_cmd: qid=1, nsid=1, cmdid=718, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=0, len=7, ctrl=0x0, dsmgmt=0, reftag=0)
          <idle>-0     [003] d.h.     9.161578: nvme_complete_rq: cmdid=718, qid=1, res=0, retries=0, flags=0x0, status=0
    kworker/u8:0-5     [003] ....     9.161608: nvme_setup_nvm_cmd: qid=1, nsid=1, cmdid=718, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=24, len=7, ctrl=0x0, dsmgmt=0, reftag=0)
          <idle>-0     [003] d.h.     9.161681: nvme_complete_rq: cmdid=718, qid=1, res=0, retries=0, flags=0x0, status=0
              dd-205   [001] ....     9.662909: nvme_setup_nvm_cmd: qid=1, nsid=1, cmdid=1011, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=0, len=2559, ctrl=0x0, dsmgmt=0, reftag=0)
              dd-205   [001] ....     9.662967: nvme_setup_nvm_cmd: qid=1, nsid=1, cmdid=1012, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=2560, len=1535, ctrl=0x0, dsmgmt=0, reftag=0)
          <idle>-0     [001] d.h.     9.664413: nvme_complete_rq: cmdid=1011, qid=1, res=0, retries=0, flags=0x0, status=0
          <idle>-0     [001] d.h.     9.664835: nvme_complete_rq: cmdid=1012, qid=1, res=0, retries=0, flags=0x0, status=0
              dd-205   [001] ....     9.666396: nvme_setup_nvm_cmd: qid=1, nsid=1, cmdid=1012, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=4096, len=2047, ctrl=0x0, dsmgmt=0, reftag=0)
              dd-205   [001] ....     9.667914: nvme_setup_nvm_cmd: qid=1, nsid=1, cmdid=1013, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=6144, len=2047, ctrl=0x0, dsmgmt=0, reftag=0)
          <idle>-0     [001] d.h.     9.676720: nvme_complete_rq: cmdid=1012, qid=1, res=0, retries=0, flags=0x0, status=0
              dd-205   [001] d.h.     9.676905: nvme_complete_rq: cmdid=1013, qid=1, res=0, retries=0, flags=0x0, status=0
              dd-205   [001] ....     9.677552: nvme_setup_nvm_cmd: qid=1, nsid=1, cmdid=1013, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=8192, len=2047, ctrl=0x0, dsmgmt=0, reftag=0)
              dd-205   [001] ....     9.678201: nvme_setup_nvm_cmd: qid=1, nsid=1, cmdid=1014, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=10240, len=2047, ctrl=0x0, dsmgmt=0, reftag=0)
          <idle>-0     [001] d.h.     9.678699: nvme_complete_rq: cmdid=1013, qid=1, res=0, retries=0, flags=0x0, status=0
              dd-205   [001] d.h.     9.679330: nvme_complete_rq: cmdid=1014, qid=1, res=0, retries=0, flags=0x0, status=0
              dd-206   [002] ....     9.687920: nvme_setup_nvm_cmd: qid=1, nsid=1, cmdid=366, flags=0x0, meta=0x0, cmd=(nvme_cmd_write slba=0, len=2559, ctrl=0x0, dsmgmt=0, reftag=0)
              dd-206   [002] ....     9.688396: nvme_setup_nvm_cmd: qid=1, nsid=1, cmdid=367, flags=0x0, meta=0x0, cmd=(nvme_cmd_write slba=2560, len=2559, ctrl=0x0, dsmgmt=0, reftag=0)
              dd-206   [002] ....     9.689290: nvme_setup_nvm_cmd: qid=1, nsid=1, cmdid=368, flags=0x0, meta=0x0, cmd=(nvme_cmd_write slba=5120, len=2559, ctrl=0x0, dsmgmt=0, reftag=0)
              dd-206   [002] ....     9.689759: nvme_setup_nvm_cmd: qid=1, nsid=1, cmdid=369, flags=0x0, meta=0x0, cmd=(nvme_cmd_write slba=7680, len=2559, ctrl=0x0, dsmgmt=0, reftag=0)
          <idle>-0     [002] d.h.     9.690222: nvme_complete_rq: cmdid=366, qid=1, res=0, retries=0, flags=0x0, status=0
          <idle>-0     [002] d.h.     9.691086: nvme_complete_rq: cmdid=367, qid=1, res=0, retries=0, flags=0x0, status=0
          <idle>-0     [002] d.h.     9.691935: nvme_complete_rq: cmdid=368, qid=1, res=0, retries=0, flags=0x0, status=0
          <idle>-0     [002] d.h.     9.692852: nvme_complete_rq: cmdid=369, qid=1, res=0, retries=0, flags=0x0, status=0


Johannes Thumshirn (2):
  nvme: add tracepoint for nvme_setup_cmd
  nvme: add tracepoint for nvme_complete_rq

 drivers/nvme/host/Makefile |   4 ++
 drivers/nvme/host/core.c   |   9 +++
 drivers/nvme/host/trace.c  | 131 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/trace.h  | 167 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 311 insertions(+)
 create mode 100644 drivers/nvme/host/trace.c
 create mode 100644 drivers/nvme/host/trace.h

-- 
2.12.3
