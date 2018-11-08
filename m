From: james.smart@broadcom.com (James Smart)
Date: Thu, 8 Nov 2018 09:49:04 -0800
Subject: [RFC PATCH] nvme of: don't flush scan work inside reset context
In-Reply-To: <1590d7a5-8fe7-c775-6656-36e117b8a8db@grimberg.me>
References: <20181105115734.15515-1-ming.lei@redhat.com>
 <782deffe-eb72-3550-2d69-980604609fd5@broadcom.com>
 <20181106011822.GB20193@ming.t460p>
 <dbfed2f9-4ad3-40ce-7c6d-0feae2b4128f@broadcom.com>
 <1590d7a5-8fe7-c775-6656-36e117b8a8db@grimberg.me>
Message-ID: <a29f61a9-584c-19f9-8854-3c86909e0e07@broadcom.com>



On 11/7/2018 4:19 PM, Sagi Grimberg wrote:
>
>>>> transports are
>>>> several of the flush cases require an io to complete to finish 
>>>> flushing -
>>>> not just scan_work.?? nvme_mpath_stop() syncs with ctrl->ana_work, 
>>>> which may
>>>> be waiting for an ana log to complete.? fw_act_queues() may be in 
>>>> the midst
>>>> of polling the CSTS bit register or doing a fw_slot log read, or a
>>>> stop_ctrl() routine for the transport may be in the middle of a 
>>>> start_ctrl
>>>> call.
>>> These commands won't be retried since REQ_FAILFAST_DRIVER is set for 
>>> any
>>> request allocated via nvme_alloc_request().
>>>
>>> So the above flush cases you mentioned should be easier to handle 
>>> than IO from
>>> scan context. However, looks the patch we discussed before by moving
>>> nvme_stop_ctrl() after nvme_rdma_shutdown_ctrl() is still needed for
>>> avoiding hang on flush in these commands.
>>
>> Agree - nvme_stop_ctrl() has to move so the transport routines that 
>> stop/return the io can run.? Leaving it in the same place with an 
>> argument won't be enough.
>
> nvme_stop_ctrl() cannot move to after queue termination, it has to
> barrier before moving forward. The things that must flush before
> are async_event_work that does not go via the normal request path
> that is quiesced and ->stop_ctrl() at least for the rdma case make
> sure that no error recovery is concurrent with the reset/delete flow.

Well - then I don't know how things are going to proceed. If you are in 
a scenario where the device is no longer responding for outstanding ios, 
the only way you will get the flushes waiting on internally generated 
ios to finish is for the transport to walk the queues and terminate the 
ios and mark the queues non-connected so that any retries fail 
outright.? And if it's normal io - same thing has to be true for 
scan_work, but we're additionally faced with they aren't terminated by 
the queue not connected - they sit on the blk-mq queue, or they fail 
back to the nvme multipather who may be holding them waiting for a path 
to come back.? The latter case is where this same nvme_stop_ctrl() hits 
the controller delete case if scan_work is outstanding at the time of 
the delete.

So minimally, we need to io aborted and the queues marked - like what is 
done in the err_work thread on rdma.

>
> Perhaps we can move scan_work flush into nvme_remove_namespaces()
> instead? I guess it makes sense that when we remove namespaces we don't
> want a scan to run concurrently?

well- that makes sense, but I assume there's also validity of the scan 
instance itself. If we leave scan_work blocked - waiting for normal io 
to finish thus it won't release until a new controller instance is 
connected or the device fails - and for the case where a new instance is 
connected:
a) do we have any issues of it using data gathered prior to blocking? 
(from the old controller) after it resumes (now on the new controller) ?
b) will the scan work kicked off by the init_ctrl() call on the 
reconnect cause it to be re-performed correctly a second time ?? (I 
assume so)


-- james
