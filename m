From: rosattig@linux.vnet.ibm.com (Rodrigo Rosatti Galvao)
Date: Mon, 2 Apr 2018 10:47:10 -0300
Subject: [PATCH] nvmet: fix nvmet_execute_write_zeroes function
In-Reply-To: <CAK0tqikdyFoZGuRnh3_YXKtrY9NqEZVv5AysL+xGKpvGJ762fA@mail.gmail.com>
References: <1522444730-2060-1-git-send-email-rosattig@linux.vnet.ibm.com>
 <20180330212439.GA28945@localhost.localdomain>
 <93622938-f532-b8ac-2bca-fe40ed759e71@linux.vnet.ibm.com>
 <CAK0tqikdyFoZGuRnh3_YXKtrY9NqEZVv5AysL+xGKpvGJ762fA@mail.gmail.com>
Message-ID: <8a3d1471-571d-3352-1414-bf2051e2ebb9@linux.vnet.ibm.com>

One thing that I just forgot to explain previously, but I think its 
relevant:

1. The command is failing with 4k logical block size, but works with 512B

2. With the patch, the command is working for both 512B and 4K.


Here are some extra information I could get when executing the command 
with both block sizes:


[without the patch]


# nvme write-zeroes /dev/nvme0n1 -c 1 -s 0

#### 512 B ####

[ 3222.049211] __blkdev_issue_zeroout() - sector: 0 -- rrg
[ 3222.049375] __blkdev_issue_zeroout() - nr_sects: 9 -- rrg
[ 3222.049419] __blkdev_issue_zeroout() - bs_mask: 0 -- rrg
[ 3222.049575] __blkdev_issue_zeroout() - ((sector | nr_sects) & 
bs_mask): 0 -- rrg


#### 4K #### (FAILS)

[ 4110.654424] __blkdev_issue_zeroout() - sector: 0 -- rrg
[ 4110.654601] __blkdev_issue_zeroout() - nr_sects: 9 -- rrg
[ 4110.654645] __blkdev_issue_zeroout() - bs_mask: 7 -- rrg
[ 4110.654794] __blkdev_issue_zeroout() - ((sector | nr_sects) & 
bs_mask): 1 -- rrg



[with the patch]

nvme write-zeroes /dev/nvme0n1 -c 1 -s 0

#### 512 B #####

[root at ltc-garrison ~]# nvme write-zeroes /dev/nvme0n1 -c 1 -s 0

[? 426.028592] __blkdev_issue_zeroout() - sector: 0 -- rrg
[? 426.028779] __blkdev_issue_zeroout() - nr_sects: 8 -- rrg
[? 426.028946] __blkdev_issue_zeroout() - bs_mask: 0 -- rrg
[? 426.028986] __blkdev_issue_zeroout() - ((sector | nr_sects) & 
bs_mask): 0 -- rrg



#### 4K ####

[? 265.489219] __blkdev_issue_zeroout() - sector: 0 -- rrg
[? 265.489419] __blkdev_issue_zeroout() - nr_sects: 8 -- rrg
[? 265.489587] __blkdev_issue_zeroout() - bs_mask: 7 -- rrg
[? 265.489627] __blkdev_issue_zeroout() - ((sector | nr_sects) & 
bs_mask): 0 -- rrg


On 04/02/2018 05:03 AM, chaitany kulkarni wrote:
> Please give me a couple of days, I'll look into this.
>
> On Fri, Mar 30, 2018 at 2:48 PM, Rodrigo Rosatti Galv?o
> <rosattig@linux.vnet.ibm.com> wrote:
>>> Doesn't that mean your host is using this command wrong? The NLB is a
>>> 0's based value, we're supposed to +1 to get the correct block count.
>>
>> Keith, I tested passing different values to the c (number of blocks) and s
>> (64-bit LBA of first block to access) parameters, and it was failing. When I
>> removed the +1, the command worked fine.
>>
>> I used a simple script to validate this:
>>
>> for s in {0..20}
>>      do
>>              for c in {0..20}
>>              do
>>                      nvme write-zeroes /dev/nvme0 -n 10 -s $s -c $c
>>              done
>>      done
>>
>>
>> Is there some other way to test it?
>>
>> --
>> Rodrigo R. Galv?o
>> Intern - Linux Technology Center - IBM
>>
>>
>>
>> _______________________________________________
>> Linux-nvme mailing list
>> Linux-nvme at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-nvme

-- 
Rodrigo R. Galv?o
Intern - Linux Technology Center - IBM
