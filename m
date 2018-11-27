From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 26 Nov 2018 23:48:01 -0800
Subject: [PATCH v3 13/13] nvme-tcp: add NVMe over TCP host driver
In-Reply-To: <e4407485-843a-7968-c367-29d60baf8373@mellanox.com>
References: <20181122015615.15763-1-sagi@grimberg.me>
 <20181122015615.15763-14-sagi@grimberg.me> <20181122080224.GA26504@lst.de>
 <af432c70-1b3a-6c62-bb13-67bf7df1a43f@grimberg.me>
 <e4407485-843a-7968-c367-29d60baf8373@mellanox.com>
Message-ID: <43ad34a0-799d-5f78-a07f-e2c51f64a854@grimberg.me>


>>> This looks odd.? It's not really the timeout handlers job to
>>> call nvme_end_request here.
>>
>> Well.. if we are not yet LIVE, we will not trigger error
>> recovery, which means nothing will complete this command so
>> something needs to do it...
>>
>> I think that we need it for rdma too..
> 
> 
> yes we do. and we've patches in our pipe.
> 
> I'm thinking on a wider change in the error/recovery flows but might 
> send it "as is" meanwhile.

I have it too in the pipe. Do you want to send it out or should I?
