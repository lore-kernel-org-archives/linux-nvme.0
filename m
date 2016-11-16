From: ckulkarnilinux@gmail.com (Chaitanya Kulkarni)
Date: Tue, 15 Nov 2016 22:50:34 -0800
Subject: [PATCHSET] Add support for write zeroes operation in Block layer and
 NVMe Driver.
Message-ID: <1479279039-25818-1-git-send-email-chaitanya.kulkarni@hgst.com>

1. Block layer implementation details :-
    a. Introducing __blkdev_issue_zeroout variant of exiting code.
    b. Introducing new request operation flag REQ_OP_WRITE_ZEROES to represent
       write zeroes operation.
    c. Mechanism to issue bios without payload with the help of
       __blkdev_issue_write_zeroes block library function. In block layer 
       blkdev_issue_zeroout/__blkdev_issue_zeroout APIs are exported to execute 
       write zeroes operation. Based on the device support these 
       functions will :-
       1. Try to execute optimized Write Zeroes (REQ_OP_WRITE_ZEROES).
       2. If REQ_OP_WRITE_ZEROES is not supported, it will try to write zeroes
          using write same (REQ_OP_WRITE_SAME) operation.
       3. In case write zeroes and write same are not supported zeroes are
          written using regular write (REQ_OP_WRITE) operation.

2. NVMe over Fabric Driver implementation details :-
       1. NVMe write zeroes command definitions for host and target.
       2. NVMe write zeroes command implementation for host and target.
