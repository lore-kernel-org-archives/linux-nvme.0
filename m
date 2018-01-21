From: rosattig@linux.vnet.ibm.com (=?UTF-8?Q?Rodrigo_Rosatti_Galv=c3=a3o?=)
Date: Sun, 21 Jan 2018 07:50:48 -0200
Subject: Possible error in nvmet_execute_write_zeroes() function?
Message-ID: <3a9168fc-ccb3-2063-e2f0-ba7479537f34@linux.vnet.ibm.com>

Hi everyone,


Recently I was looking at a problem where the write-zeroes command is 
not working on INITIATOR. After getting some tips from some people, such 
as Keith Busch, Christoph Hellwig and Darrick Wong, I could debug this 
issue and find where exactly it was failing.

I will post my findings below, even though I'm not sure whether I'm 
correct or not about it.


When executing the command on INITIATOR, the __blkdev_issue_zeroout 
function was return -EINVAL exactly at this point:


 ??? ??? bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
 ??? ??? if ((sector | nr_sects) & bs_mask)
 ??? ??? ??? return -EINVAL;


## executing the command

[root at localhost ~]# nvme write-zeroes /dev/nvme0n1
NVME IO command error:INTERNAL(4006)


## some printks on __blkdev_issue_zeroout function [block/blk-lib.c]

[? 220.812506] __blkdev_issue_zeroout() - sector: 0 -- rrg
[? 220.812543] __blkdev_issue_zeroout() - nr_sects: 1 -- rrg
[? 220.812578] __blkdev_issue_zeroout() - bs_mask: 7 -- rrg
[? 220.812748] __blkdev_issue_zeroout() - ((sector | nr_sects) & 
bs_mask): 1 -- rrg



So, after debug for a while I could make it works after making one 
simple modification, which I do not know whether it's correct or not.
For some reason, the nr_sector variable was being incremented at the 
beginning of the nvmet_execute_write_zeroes function. Just by removing 
the "+1", the command worked:


## executing command

[root at localhost ~]# nvme write-zeroes /dev/nvme0n1
NVME Write Zeroes Success


## dmesg

[ 1636.770564] __blkdev_issue_zeroout() - sector: 0 -- rrg
[ 1636.770601] __blkdev_issue_zeroout() - nr_sects: 0 -- rrg
[ 1636.770636] __blkdev_issue_zeroout() - bs_mask: 7 -- rrg
[ 1636.770787] __blkdev_issue_zeroout() - ((sector | nr_sects) & 
bs_mask): 0 -- rrg



Basically the only modification I did was the following:

--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -171,7 +171,7 @@ static void nvmet_execute_write_zeroes(struct 
nvmet_req *req)
 ??????? sector = le64_to_cpu(write_zeroes->slba) <<
 ??????????????? (req->ns->blksize_shift - 9);
 ??????? nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length)) <<
-?????????????? (req->ns->blksize_shift - 9)) + 1;
+?????????????? (req->ns->blksize_shift - 9));

 ??????? if (__blkdev_issue_zeroout(req->ns->bdev, sector, nr_sector,
 ??????????????????????????????? GFP_KERNEL, &bio, 0))



The adapter where I tested it has a block size of 4K. But, I don't know 
if this info is relevant for this problem.



I'm quite unexperienced yet, so any help or thoughts here is very 
welcomed :-)


Thanks in advance!

-- 
Rodrigo R. Galv?o
Intern - Linux Technology Center - IBM
