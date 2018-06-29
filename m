From: keith.busch@intel.com (Keith Busch)
Date: Fri, 29 Jun 2018 16:49:59 -0600
Subject: [PATCHv4 0/4] nvme trace updates
Message-ID: <20180629225003.16567-1-keith.busch@intel.com>

This patch series is based on/inspired patches from Johannes Thumshirn
that improves the nvme trace events.

The first one from Sagi is saving the nvme_ctrl in the driver request data
so we can reference it in other places, both for this series and future
developments.

The others simplifying and add to the nvme traces so we can see uniquely
identify what controller the trace event is showing, pair up completions
to their submissions, and filter events for specific hardware.

For good measure, I offer the following awk script (called nvme-iosnoop,
inspired by Brendan Gregg's iosnoop) to help parse the trace output. This
will pair up the submission and completion trace events and tell us
interesting things about nvme disk activity.

Example output:

# cat /sys/kernel/debug/tracing/trace | awk -f ~/bin/nvme-iosnoop.awk
COMM         PID    TYPE  DEV      SLBA         NLB       LATms
kworker/62:1 2550   write nvme0n1  0            8         0.051
kworker/62:1 2550   write nvme0n1  8            8         0.027
kworker/62:1 2550   write nvme0n1  16           8         0.013
kworker/62:1 2550   write nvme0n1  24           8         0.014
kworker/62:1 2550   write nvme0n1  32           8         0.013
kworker/62:1 2550   write nvme0n1  40           8         0.014
kworker/62:1 2550   write nvme0n1  48           8         0.014
kworker/63:1 2549   write nvme0n1  56           8         0.035
systemd-udev 1595   read  nvme0n1  0            8         0.087
systemd-udev 1595   read  nvme0n1  8            8         0.056
systemd-udev 4066   read  nvme0n1  781422592    8         0.060
systemd-udev 4066   read  nvme0n1  781422752    8         0.009
dd           4213   read  nvme1n1  0            8         0.070
dd           4213   read  nvme1n1  8            8         0.010
dd           4213   read  nvme1n1  16           8         0.012
dd           4213   read  nvme1n1  24           8         0.009
dd           4213   read  nvme1n1  32           8         0.011
dd           4213   read  nvme1n1  40           8         0.010
systemd-udev 4066   read  nvme0n1  64           56        0.034
systemd-udev 4066   read  nvme0n1  256          16        0.011
systemd-udev 4066   read  nvme0n1  128          128       0.057
systemd-udev 4066   read  nvme0n1  16           8         0.106
systemd-udev 4066   read  nvme0n1  32           24        0.132
systemd-udev 4066   read  nvme0n1  272          240       0.047
systemd-udev 4066   read  nvme0n1  512          256       0.051
systemd-udev 4066   read  nvme0n1  768          256       0.049

---
#!/usr/bin/awk

BEGIN {
	printf "%-12.12s %-6s %-5s %-8s %-12s %-6s %8s\n", \
		"COMM", "PID", "TYPE", "DEV", "SLBA", "NLB", "LATms"
}
{
	if ($1 != "#") {
		dev = $7; sub("disk=", "", dev); sub(",", "", dev)
		time = $4; sub(":", "", time)
		qid = $8; sub("qid=", "", qid); sub(",", "", qid)
		cid = $9; sub("cid=", "", cid); sub(",", "", cid)
	}

	if ($1 != "#" && $0 ~ /nvme_setup_cmd/) {
		comm = pid = $1
		sub(/-[0-9][0-9]*/, "", comm)
		sub(/.*-/, "", pid)
		slba = $14; sub("slba=", "", slba); sub(",", "", slba)
		len = $15; sub("len=", "", len); sub(",", "", len)

		starts[dev, qid, cid] = time
		slbas[dev, qid, cid] = slba
		lens[dev, qid, cid] = len + 1
		pids[dev, qid, cid] = pid
		comms[dev, qid, cid] = comm

		if ($0 ~ /nvme_cmd_read/) {
			dir[dev, qid, cid] = "read"
		}
		if ($0 ~ /nvme_cmd_write/) {
			dir[dev, qid, cid] = "write"
		}
		next
	}

	if ($1 != "#" && $0 ~ /nvme_complete_rq/) {
		if (starts[dev, qid, cid] > 0) {
			latency = sprintf("%.3f", 1000 * (time - starts[dev, qid, cid]))
			printf "%-12.12s %-6s %-5s %-8s %-12s %-6s %8s\n",
				comms[dev, qid, cid], pids[dev, qid, cid], dir[dev, qid, cid],
				dev, slbas[dev, qid, cid], lens[dev, qid, cid], latency

			delete comms[dev, qid, cid]
			delete pids[dev, qid, cid]
			delete dir[dev, qid, cid]
			delete slbas[dev, qid, cid]
			delete lens[dev, qid, cid]
			delete starts[dev, qid, cid]
		}
		next
	}
}
END{}
--

v3 -> v4:

  Fixed the parameter print order, nsid and cmdid

v2 -> v3:

  Removed unrelated code that leaked into the previous series

  Added helpers for setting the new qid and disk name fields

  Updated change logs

  Minor code formatting updates

  Added Reviewed-by for Sagi's patch

v1 -> v2:

  Dropped the blk-mq patch as there were pre-existing ways to get to the
  desired information without introducing a new API

  Changelog typo fixups

Keith Busch (3):
  nvme: use hw qid in trace events
  nvme: add controller name to trace events
  nvme: add disk name to trace events

Sagi Grimberg (1):
  nvme: cache struct nvme_ctrl reference to struct nvme_request

 drivers/nvme/host/core.c   |   5 +-
 drivers/nvme/host/fc.c     |   1 +
 drivers/nvme/host/nvme.h   |   1 +
 drivers/nvme/host/pci.c    |   2 +
 drivers/nvme/host/rdma.c   |   1 +
 drivers/nvme/host/trace.c  |  11 ++++
 drivers/nvme/host/trace.h  | 139 +++++++++++++++++++++++++--------------------
 drivers/nvme/target/loop.c |   1 +
 8 files changed, 94 insertions(+), 67 deletions(-)

-- 
2.14.3
