From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 11 Jun 2018 15:07:28 +0000
Subject: [PATCH] nvme-cli: fix compilation error
In-Reply-To: <20180611145729.GA712@localhost.localdomain>
References: <20180611020341.2647-1-chaitanya.kulkarni@wdc.com>,
 <20180611145729.GA712@localhost.localdomain>
Message-ID: <92F18EC3-1D5B-4D52-A01B-96ECCA90DE91@wdc.com>

Okay, let me resend. 

> On Jun 11, 2018,@7:54 AM, Keith Busch <keith.busch@linux.intel.com> wrote:
> 
>> On Sun, Jun 10, 2018@10:03:41PM -0400, Chaitanya Kulkarni wrote:
>> [root at q nvme-cli]# make
>> NVME_VERSION = 1.5.182.g80f2
>> cc -D_GNU_SOURCE -D__CHECK_ENDIAN__ -O2 -g -Wall -Werror -std=gnu99 -DLIBUUID -DNVME_VERSION='"1.5.182.g80f2"' -c nvme-print.c
>> nvme-print.c: In function ?show_self_test_log?:
>> nvme-print.c:1282:4: error: format ?%lx? expects argument of type ?long unsigned int?, but argument 2 has type ?__le64? [-Werror=format=]
>>    le64_to_cpu(self_test->result[i].power_on_hours));
>>    ^
> 
> The way we've been fixing this is to cast the return of le64_to_cpu to
> uint64_t. That should work for 64 and 32 bit.
