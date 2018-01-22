From: keith.busch@intel.com (Keith Busch)
Date: Mon, 22 Jan 2018 11:37:42 -0700
Subject: Hang when running LLVM+clang test suite
In-Reply-To: <26A085AA-98EB-4ACC-A0B2-0F30E7AAC33E@znu.io>
References: <7F6A25BD-AA87-4800-886F-1A256FFD8967@znu.io>
 <20180121025030.GK12043@localhost.localdomain>
 <21BE2F60-44C9-41E9-B64F-05C90008D44F@znu.io>
 <26A085AA-98EB-4ACC-A0B2-0F30E7AAC33E@znu.io>
Message-ID: <20180122183742.GP12043@localhost.localdomain>

On Sun, Jan 21, 2018@09:13:27AM -0500, David Zarzycki wrote:
> To my surprise, I think I?ve narrowed down the bug to the block multi-queue layer. Can you please confirm that the following test is reasonable?
> 
> 1) Create a file in /tmp (tmpfs with plenty of RAM and 2x the size needed by the test suite)
> 2) ?losetup? the file
> 3) 'cat /sys/block/loop0/queue/scheduler' ("[mq-deadline] none? in this case)
> 4) Create ext4 partition on /dev/loop0 and mount it
> 5) Run stress test in the loopback filesystem

The test looks fair to run. Does your error only happen if using
mq-deadline, or are there problems when using "none"?
