From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 23 Nov 2016 11:28:08 +0200
Subject: [PATCH v2 0/2] align to generic ib_event logging helper
In-Reply-To: <1479831796.18270.3.camel@linux.intel.com>
References: <1479825391-10389-1-git-send-email-maxg@mellanox.com>
 <1479831796.18270.3.camel@linux.intel.com>
Message-ID: <5c1f953f-ed5c-133d-d62d-688ff4f47303@mellanox.com>



On 11/22/2016 6:23 PM, J Freyensee wrote:
> On Tue, 2016-11-22@16:36 +0200, Max Gurtovoy wrote:
>> Changes since V1:
>>   - updated debug level to pr_debug
>>
>> Max Gurtovoy (2):
>>   nvmet-rdma: align to generic ib_event logging helper
>>   nvme-rdma: align to generic ib_event logging helper
>>
>>  drivers/nvme/host/rdma.c   |    4 +++-
>>  drivers/nvme/target/rdma.c |    4 +++-
>>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> Seems fine but I'm curious why the extra debugging is needed to the
> point it warrants a change to the Linux kernel?  Why does the default
> print case need to be moved such that there will be a debug message
> printed for each event instead of the unmatched default event?

The reason for this commit is to use generic ib_event_msg (that is used 
in iser/srp/isert etc...). I'll add a new version that will keep it 
inside the default case in the target side.

>
>>
>>
>> _______________________________________________
>> Linux-nvme mailing list
>> Linux-nvme at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-nvme
