From: gtiwari@redhat.com (Gopal Tiwari)
Date: Thu, 16 May 2019 02:06:15 -0400 (EDT)
Subject: nvme driver failed for test with kernel-v5.1-rc6
Message-ID: <1726253006.18456087.1557986775197.JavaMail.zimbra@redhat.com>

Kernel log : 

[  176.003453] run blktests nvme/013 at 2019-04-26 08:41:44
[  176.025656] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  176.033981] nvmet: creating controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:a5118b24-f118-4388-8bca-2d22043fe1d4.
[  176.034167] nvme nvme1: ANA group 1: optimized.
[  176.034182] nvme nvme1: creating 12 I/O queues.
[  176.037674] nvme nvme1: new ctrl: "blktests-subsystem-1"
[  177.240516] print_req_error: I/O error, dev nvme1n1, sector 0 flags 801
[  177.260984] XFS (nvme1n1): Mounting V5 Filesystem
[  177.317619] XFS (nvme1n1): Ending clean mount
[  207.406893] print_req_error: I/O error, dev nvme1n1, sector 1048656 flags 21801
[  207.415072] XFS (nvme1n1): metadata I/O error in "xlog_iodone" at daddr 0x100050 len 64 error 5
[  207.424793] XFS (nvme1n1): xfs_do_force_shutdown(0x2) called from line 1271 of file fs/xfs/xfs_log.c. Return address = 0000000040c83e2a
[  207.424795] XFS (nvme1n1): Log I/O Error Detected. Shutting down filesystem
[  207.432571] XFS (nvme1n1): Please unmount the filesystem and rectify the problem(s)
[  207.447558] print_req_error: I/O error, dev nvme1n1, sector 1048720 flags 21801
[  207.455724] print_req_error: I/O error, dev nvme1n1, sector 1048784 flags 21801
[  207.463882] print_req_error: I/O error, dev nvme1n1, sector 1048848 flags 21801
[  207.472039] print_req_error: I/O error, dev nvme1n1, sector 1048912 flags 21801
[  207.480196] print_req_error: I/O error, dev nvme1n1, sector 1048976 flags 21801
[  207.488351] print_req_error: I/O error, dev nvme1n1, sector 1049040 flags 21801
[  207.496509] print_req_error: I/O error, dev nvme1n1, sector 1049104 flags 21801
[  207.504679] XFS (nvme1n1): metadata I/O error in "xlog_iodone" at daddr 0x100090 len 64 error 5
[  207.514397] XFS (nvme1n1): metadata I/O error in "xlog_iodone" at daddr 0x1000d0 len 64 error 5
[  207.524112] XFS (nvme1n1): metadata I/O error in "xlog_iodone" at daddr 0x100110 len 64 error 5
[  207.533826] XFS (nvme1n1): metadata I/O error in "xlog_iodone" at daddr 0x100150 len 64 error 5
[  207.543542] XFS (nvme1n1): metadata I/O error in "xlog_iodone" at daddr 0x100190 len 64 error 5
[  207.553256] XFS (nvme1n1): metadata I/O error in "xlog_iodone" at daddr 0x1001d0 len 64 error 5
[  207.562972] XFS (nvme1n1): metadata I/O error in "xlog_iodone" at daddr 0x100210 len 64 error 5
[  207.667548] XFS (nvme1n1): Unmounting Filesystem
[  207.668002] print_req_error: I/O error, dev nvme1n1, sector 0 flags 801
[  207.677339] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  208.618984] run blktests nvme/015 at 2019-04-26 08:42:17
[  208.657123] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  208.664806] nvmet: creating controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:a5118b24-f118-4388-8bca-2d22043fe1d4.
[  208.664975] nvme nvme1: ANA group 1: optimized.
[  208.664991] nvme nvme1: creating 12 I/O queues.
[  208.668610] nvme nvme1: new ctrl: "blktests-subsystem-1"
[  217.455327] nvme nvme1: using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!
[  217.488016] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
[  217.492958] Dev nvme1n1: unable to read RDB block 0
[  217.498413]  nvme1n1: unable to read partition table
[  217.498419] nvme1n1: partition table beyond EOD, truncated
