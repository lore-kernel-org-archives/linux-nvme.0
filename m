From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 7 Jun 2016 15:08:15 -0500
Subject: NVMe over Fabrics support for nvme-cli
In-Reply-To: <1465312767-10070-1-git-send-email-hch@lst.de>
References: <1465312767-10070-1-git-send-email-hch@lst.de>
Message-ID: <022b01d1c0f8$53c13b50$fb43b1f0$@opengridcomputing.com>

> 
> Hi Keith,
> 
> the series below adds support for the discovery, connect, connect-all and
> disconnect commands to nvme-cli, which are useful to support the NVMe over
> Fabrics host code.  Most of the work is from Ming with various bits and
> pieces from me.  I also did the final rebase to the latest master tree.

Hey Christoph, looks like the man page needs to be updated.

Also, connect-all doesn't seem to work for me.  Am I doing something wrong?

[root at stevo1 nvme-cli]# nvme discover -t rdma -a 10.0.1.14 -s 4420
Discovery Log Number of Records 7, Generation counter 51
=====Discovery Log Entry 0======
trtype:  1
adrfam:  0
nqntype: 2
treq:    0
portid:  1
trsvcid: 4420
subnqn:  test-ram0
traddr:  10.0.1.14
rdma_prtype: 0
rdma_qptype: 0
rdma_cms:    0
rdma_pkey: 0x0000
=====Discovery Log Entry 1======
trtype:  1
adrfam:  0
nqntype: 2
treq:    0
portid:  1
trsvcid: 4420
subnqn:  test-ram1
traddr:  10.0.1.14
rdma_prtype: 0
rdma_qptype: 0
rdma_cms:    0
rdma_pkey: 0x0000
=====Discovery Log Entry 2======
trtype:  1
adrfam:  0
nqntype: 2
treq:    0
portid:  1
trsvcid: 4420
subnqn:  test-ram2
traddr:  10.0.1.14
rdma_prtype: 0
rdma_qptype: 0
rdma_cms:    0
rdma_pkey: 0x0000
=====Discovery Log Entry 3======
trtype:  1
adrfam:  0
nqntype: 2
treq:    0
portid:  1
trsvcid: 4420
subnqn:  test-ram3
traddr:  10.0.1.14
rdma_prtype: 0
rdma_qptype: 0
rdma_cms:    0
rdma_pkey: 0x0000
=====Discovery Log Entry 4======
trtype:  1
adrfam:  0
nqntype: 2
treq:    0
portid:  1
trsvcid: 4420
subnqn:  test-hynix0
traddr:  10.0.1.14
rdma_prtype: 0
rdma_qptype: 0
rdma_cms:    0
rdma_pkey: 0x0000
=====Discovery Log Entry 5======
trtype:  1
adrfam:  0
nqntype: 2
treq:    0
portid:  1
trsvcid: 4420
subnqn:  test-nullb0
traddr:  10.0.1.14
rdma_prtype: 0
rdma_qptype: 0
rdma_cms:    0
rdma_pkey: 0x0000
=====Discovery Log Entry 6======
trtype:  1
adrfam:  0
nqntype: 2
treq:    0
portid:  1
trsvcid: 4420
subnqn:  test-nullb1
traddr:  10.0.1.14
rdma_prtype: 0
rdma_qptype: 0
rdma_cms:    0
rdma_pkey: 0x0000
[root at stevo1 nvme-cli]# nvme connect-all -t rdma -a 10.0.1.14
skipping unsupported adrfam
skipping unsupported adrfam
skipping unsupported adrfam
skipping unsupported adrfam
skipping unsupported adrfam
skipping unsupported adrfam
skipping unsupported adrfam
