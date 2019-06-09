From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Sun,  9 Jun 2019 23:16:59 +0900
Subject: [PATCH v3 0/3] nvme: enable to inject errors into admin commands
Message-ID: <1560089822-11462-1-git-send-email-akinobu.mita@gmail.com>

Currenlty fault injection support for nvme only enables to inject errors
into the commands submitted to I/O queues.

This enables to inject errors into the commands submitted to the admin
queue.
    
It is useful to test error handling in the controller initialization.

	# echo 100 > /sys/kernel/debug/nvme0/fault_inject/probability
	# echo 1 > /sys/kernel/debug/nvme0/fault_inject/times
	# echo 10 > /sys/kernel/debug/nvme0/fault_inject/space
	# nvme reset /dev/nvme0
	# dmesg
	...
	nvme nvme0: Could not set queue count (16385)
	nvme nvme0: IO queues not created

* v3
- add Reviewed-by tags
- WARN_ONCE() if no namespace is tied to the request
- remove thermal zone series dependency

* v2
- rename the argument 'name' to 'dev_name'
- add Reviewed-by tags
- add documentation for nvme fault injection

Akinobu Mita (3):
  nvme: prepare for fault injection into admin commands
  nvme: enable to inject errors into admin commands
  Documentation: nvme: add an example for nvme fault injection

 .../fault-injection/nvme-fault-injection.txt       | 56 ++++++++++++++++++++++
 drivers/nvme/host/core.c                           |  7 ++-
 drivers/nvme/host/fault_inject.c                   | 41 ++++++++--------
 drivers/nvme/host/nvme.h                           | 36 ++++++++------
 4 files changed, 104 insertions(+), 36 deletions(-)

Cc: Thomas Tai <thomas.tai at oracle.com>
Cc: Keith Busch <kbusch at kernel.org>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Minwoo Im <minwoo.im.dev at gmail.com>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
-- 
2.7.4
