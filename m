From: sagi@grimberg.me (Sagi Grimberg)
Date: Sat, 22 Oct 2016 00:45:33 +0300
Subject: [PATCH RFC v2 2/3] rdma_cm: add rdma_consumer_reject() helper
 function
In-Reply-To: <CAG53R5Xyp+n7KYj6zZF6PFuXke3XtqaMgaGTRmgd_uGXTFNDtw@mail.gmail.com>
References: <cover.1477003235.git.swise@opengridcomputing.com>
 <cb135696be86c21c144ef35a4d6f7f71394a3627.1477003235.git.swise@opengridcomputing.com>
 <20161021121428.GB17028@lst.de>
 <005f01d22ba4$aeadeab0$0c09c010$@opengridcomputing.com>
 <CAG53R5Xyp+n7KYj6zZF6PFuXke3XtqaMgaGTRmgd_uGXTFNDtw@mail.gmail.com>
Message-ID: <a649dc62-3005-f6fd-7d00-d4ddd77c8816@grimberg.me>


>>> Yes.  Also I'd just inline the ib_consumer_reject and iw_consumer_reject
>>> helpers here.
>>>
>>> Aso wouldn't it be better named rdma_consumer_is_reject or similar
>>> given that we don't reject anything here, but check if the request
>>> has been rejected?
>>
>> How about rdma_rejected_by_consumer()?
>>
> How about rdma_reject_by_ulp()?
> We have ulp directory holding iser, srp etc.

I like consumer better.
