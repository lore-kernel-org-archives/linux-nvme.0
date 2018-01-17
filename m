From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 17 Jan 2018 11:53:34 +0100
Subject: [PATCH v3 0/2] add tracepoints for nvme command submission and
 completion
Message-ID: <20180117105336.8666-1-jthumshirn@suse.de>

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
              dd-205   [002] ....     7.128368: nvme_setup_cmd: nsid=1, command_id=568, flags=0x0, metadata=0x0, cmd=(nvme_cmd_read slba=0, length=31, control=0x0, dsmgmt=0, reftag=0)
          <idle>-0     [002] d.h.     7.129098: nvme_complete_rq: command_id=568, result=0, retries=0, flags=0x0, status=0
              dd-205   [002] ....     7.129150: nvme_setup_cmd: nsid=1, command_id=568, flags=0x0, metadata=0x0, cmd=(nvme_cmd_read slba=32, length=63, control=0x0, dsmgmt=0, reftag=0)
              dd-205   [002] ....     7.129189: nvme_setup_cmd: nsid=1, command_id=569, flags=0x0, metadata=0x0, cmd=(nvme_cmd_read slba=96, length=127, control=0x0, dsmgmt=0, reftag=0)
          <idle>-0     [002] d.h.     7.129318: nvme_complete_rq: command_id=568, result=0, retries=0, flags=0x0, status=0
              dd-205   [002] d.h.     7.129355: nvme_complete_rq: command_id=569, result=0, retries=0, flags=0x0, status=0
              dd-206   [003] ....     7.137389: nvme_setup_cmd: nsid=1, command_id=22, flags=0x0, metadata=0x0, cmd=(nvme_cmd_write slba=0, length=2559, control=0x0, dsmgmt=0, reftag=0)
              dd-206   [003] ....     7.137888: nvme_setup_cmd: nsid=1, command_id=23, flags=0x0, metadata=0x0, cmd=(nvme_cmd_write slba=2560, length=2559, control=0x0, dsmgmt=0, reftag=0)
              dd-206   [003] ....     7.138365: nvme_setup_cmd: nsid=1, command_id=24, flags=0x0, metadata=0x0, cmd=(nvme_cmd_write slba=5120, length=2559, control=0x0, dsmgmt=0, reftag=0)
              dd-206   [003] d.h.     7.138634: nvme_complete_rq: command_id=22, result=0, retries=0, flags=0x0, status=0
              dd-206   [003] ....     7.139014: nvme_setup_cmd: nsid=1, command_id=25, flags=0x0, metadata=0x0, cmd=(nvme_cmd_write slba=7680, length=2559, control=0x0, dsmgmt=0, reftag=0)
          <idle>-0     [003] d.h.     7.139658: nvme_complete_rq: command_id=23, result=0, retries=0, flags=0x0, status=0
          <idle>-0     [003] d.h.     7.140650: nvme_complete_rq: command_id=24, result=0, retries=0, flags=0x0, status=0
          <idle>-0     [003] d.h.     7.141670: nvme_complete_rq: command_id=25, result=0, retries=0, flags=0x0, status=0

Johannes Thumshirn (2):
  nvme: add tracepoint for nvme_setup_cmd
  nvme: add tracepoint for nvme_complete_rq

 drivers/nvme/host/Makefile |   5 ++-
 drivers/nvme/host/core.c   |   6 +++
 drivers/nvme/host/trace.c  |  82 ++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/trace.h  | 103 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 195 insertions(+), 1 deletion(-)
 create mode 100644 drivers/nvme/host/trace.c
 create mode 100644 drivers/nvme/host/trace.h

-- 
2.12.3
