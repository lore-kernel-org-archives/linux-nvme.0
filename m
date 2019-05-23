From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 23 May 2019 08:54:20 -0700
Subject: Using host fabrics drivers with a target with limited queues
In-Reply-To: <20190516160338.GA21777@infradead.org>
References: <1CBC7E3F-7BE5-47DD-8A98-178BBEC8FB8F@intel.com>
 <20190516160338.GA21777@infradead.org>
Message-ID: <662f0b39-64d0-29dd-9741-a558494e5598@grimberg.me>


> Adding the nvme-tcp maintainer for increased visibility..
> 
> On Tue, May 14, 2019@09:32:34PM +0000, Harris, James R wrote:
>> Hi,
>>
>> I?ve been running some tests with the Linux nvme driver against the SPDK nvme fabrics target.  Some of the tests cap the number of queues returned by NVME_FEAT_NUM_QUEUES and result in a 100% reproducible NULL pointer dereference.  See stack trace below.  The exact same call stack happens on rdma as well (just swap nvme_tcp_create/setup_ctrl with nvme_rdma_create/setup_ctrl).
>>
>> nvme_tcp_alloc_io_queues and nvme_rdma_alloc_io_queues seem to be the culprits.  The ctrl->io_queues[] array gets set up assuming that all of the desired io queues will be available.  If nvme_set_queue_count() reduces nr_io_queues, the maps still get set up with the bigger values even though we have fewer I/O queues.
>>
>> Note that reducing the max number of queues in the kernel nvme fabrics target from 128 to a much smaller number results in the exact same issue.
>>
>> It seems like the ctrl->io_queues array needs to be setup after we know how many IO queues can be created.  But it's not clear to me exactly how it should handle the case where nr_write_queues or nr_poll_queues > 0.
>>
>> (The ctrl->io_queues[HCTX_TYPE_READ] assignment also seems incorrect when nr_write_queues > 0.  We've already incremented nr_io_queues at this point, so I think this results in too many io queues getting allocated and possibly some incorrect queue_offsets in the map_queues functions.  But I may not be understanding this part of the code correctly.)
>>
>> Any advice would be appreciated on fixing this issue.  I'd also be happy to test any patches if someone with a better understanding of this part of the code would like to throw something together.

Hi James, thanks for reporting.

Just got back from a vacation, let me prepare a patch for this one.
