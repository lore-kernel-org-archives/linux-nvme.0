From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 7 Nov 2018 16:19:06 -0800
Subject: [RFC PATCH] nvme of: don't flush scan work inside reset context
In-Reply-To: <dbfed2f9-4ad3-40ce-7c6d-0feae2b4128f@broadcom.com>
References: <20181105115734.15515-1-ming.lei@redhat.com>
 <782deffe-eb72-3550-2d69-980604609fd5@broadcom.com>
 <20181106011822.GB20193@ming.t460p>
 <dbfed2f9-4ad3-40ce-7c6d-0feae2b4128f@broadcom.com>
Message-ID: <1590d7a5-8fe7-c775-6656-36e117b8a8db@grimberg.me>


>>> transports are
>>> several of the flush cases require an io to complete to finish 
>>> flushing -
>>> not just scan_work.?? nvme_mpath_stop() syncs with ctrl->ana_work, 
>>> which may
>>> be waiting for an ana log to complete.? fw_act_queues() may be in the 
>>> midst
>>> of polling the CSTS bit register or doing a fw_slot log read, or a
>>> stop_ctrl() routine for the transport may be in the middle of a 
>>> start_ctrl
>>> call.
>> These commands won't be retried since REQ_FAILFAST_DRIVER is set for any
>> request allocated via nvme_alloc_request().
>>
>> So the above flush cases you mentioned should be easier to handle than 
>> IO from
>> scan context. However, looks the patch we discussed before by moving
>> nvme_stop_ctrl() after nvme_rdma_shutdown_ctrl() is still needed for
>> avoiding hang on flush in these commands.
> 
> Agree - nvme_stop_ctrl() has to move so the transport routines that 
> stop/return the io can run.? Leaving it in the same place with an 
> argument won't be enough.

nvme_stop_ctrl() cannot move to after queue termination, it has to
barrier before moving forward. The things that must flush before
are async_event_work that does not go via the normal request path
that is quiesced and ->stop_ctrl() at least for the rdma case make
sure that no error recovery is concurrent with the reset/delete flow.

Perhaps we can move scan_work flush into nvme_remove_namespaces()
instead? I guess it makes sense that when we remove namespaces we don't
want a scan to run concurrently?
