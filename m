From: osandov@osandov.com (Omar Sandoval)
Date: Tue, 28 Aug 2018 16:22:47 -0700
Subject: [PATCH 0/6] blktests: new testcases for NVMeOF
In-Reply-To: <20180827225542.4329-1-chaitanya.kulkarni@wdc.com>
References: <20180827225542.4329-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180828232247.GA2024@vader>

On Mon, Aug 27, 2018@03:55:36PM -0700, Chaitanya Kulkarni wrote:
> Hi,
> 
> This adds new testcases for Dataset Management, write-zeroes and
> smart-log for block device and file backed namespace when NVMeOF
> target is configured with loop mode (nvme-loop.ko).
> 
> Please note that I'm leaving out "018" for Hannes's ANA realted testcase :-
> http://lists.infradead.org/pipermail/linux-nvme/2018-August/019553.html.
> 
> Regards,
> Chaitanya

Hi, Chaitanya, thanks for the tests. On v4.19-rc1, I'm getting:

nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  0.730s  ...  0.722s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  0.575s  ...  0.507s
nvme/021 (test NVMe write-zeroes command on NVMeOF block-device ns) [failed]
    runtime  0.657s  ...  0.647s
    --- tests/nvme/021.out      2018-08-28 15:36:47.586392748 -0700
    +++ /home/vmuser/linux/blktests/results/nodev/nvme/021.out.bad      2018-08-28 16:03:25.888026800 -0700
    @@ -1,6 +1,6 @@
     Running nvme/021
     91fdba0d-f87b-4c25-b80f-db7be1418b9e
     uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
    -NVME Write Zeroes Success
    +NVME IO command error:Unknown(400f)
     NQN:blktests-subsystem-1 disconnected 1 controller(s)
     Test complete
nvme/022 (test NVMe write-zeroes command on NVMeOF file-backed ns) [passed]
    runtime  0.539s  ...  0.519s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  0.794s  ...  0.744s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [failed]
    runtime  0.428s  ...  0.438s
    --- tests/nvme/024.out      2018-08-28 15:36:47.586392748 -0700
    +++ /home/vmuser/linux/blktests/results/nodev/nvme/024.out.bad      2018-08-28 16:03:28.028041782 -0700
    @@ -1,5 +1,8 @@
     Running nvme/024
    -91fdba0d-f87b-4c25-b80f-db7be1418b9e
    -uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
    +tests/nvme/rc: line 76: printf: write error: Invalid argument
    +cat: /sys/block/nvme1n1/uuid: No such file or directory
    +cat: /sys/block/nvme1n1/wwid: No such file or directory
    +NVMe Status:INVALID_NS(b)
    ...
    (Run 'diff -u tests/nvme/024.out /home/vmuser/linux/blktests/results/nodev/nvme/024.out.bad' to see the entire diff)
