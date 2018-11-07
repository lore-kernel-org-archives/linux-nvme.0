From: james.smart@broadcom.com (James Smart)
Date: Wed, 7 Nov 2018 11:27:21 -0800
Subject: [RFC PATCH] nvme of: don't flush scan work inside reset context
In-Reply-To: <5f193243-a0a7-8f9f-7d7b-7f3f87a7fdae@grimberg.me>
References: <20181105115734.15515-1-ming.lei@redhat.com>
 <97aae455-fa74-b1aa-21f6-80c03732a573@grimberg.me>
 <20181107035107.GA6920@ming.t460p>
 <f1167108-0e3f-0b64-d9c3-399f4dec73d3@grimberg.me>
 <20181107083412.GA8878@ming.t460p>
 <5f193243-a0a7-8f9f-7d7b-7f3f87a7fdae@grimberg.me>
Message-ID: <ecd83dd4-2647-84ac-d2c7-06d11a7d51c2@broadcom.com>

On 11/7/2018 10:38 AM, Sagi Grimberg wrote:
>
>> https://bugzilla.redhat.com/show_bug.cgi?id=1622487
>> https://bugzilla.redhat.com/show_bug.cgi?id=1628100
>>
>> Especially you may find some details in the following comment:
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=1628100#c7
>
> I don't have permissions to see the tickets.

they show the issue occuring on both RDMA IB and FC.

the test cases are manually inducing a reset vial the reset_controller 
attribute while there is load on the controller. The reset_work threads 
are hung waiting on flush(scan_work) and the scan_work thread is in 
ns_validate waiting on the io load to go to zero - which it can't, as 
the normal io is requeued within blk-mq due to the BLK_RESOURCE returns.

FC is more susceptible as it's error handling resolves the error by 
resetting the controller, rather than an abbreviated reset like rdma does.

-- james
