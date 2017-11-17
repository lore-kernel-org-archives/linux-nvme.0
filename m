From: maxg@mellanox.com (Max Gurtovoy)
Date: Fri, 17 Nov 2017 21:32:42 +0200
Subject: [PATCH v2 0/3] nvmet-rdma: SRQ per completion vector
In-Reply-To: <263c6c9d-0dd2-da4f-12a9-efefd361e592@grimberg.me>
References: <1510852885-25519-1-git-send-email-maxg@mellanox.com>
 <263c6c9d-0dd2-da4f-12a9-efefd361e592@grimberg.me>
Message-ID: <a8e2be0b-deb7-8cc1-92ce-fc5dea3e241a@mellanox.com>



On 11/16/2017 8:36 PM, Sagi Grimberg wrote:
> 
>> Since there is an active discussion regarding the CQ pool 
>> architecture, I decided to push
>> this feature (maybe it can be pushed before CQ pool).
>>
>> This is a new feature for NVMEoF RDMA target,
> 
> Any chance having this for the rest? isert, srpt, svcrdma?
> 

We can implement it for isert, but I think it's better to see how the CQ 
pool will be defined first.
It can bring a big benefit and improvement for ib_srpt (similar to 
NVMEoF target) but I'm not sure if I can commit for that one soon..

>> results:
>>
>> BS??? 1.read (target CPU)?? 2.read (target CPU)??? 3.read (target 
>> CPU)?? 4.read (target CPU)
>> ---? --------------------- --------------------- --------------------- 
>> ----------------------
>> 1k???? 5.88M (80%)??????????? 5.45M (72%)??????????? 6.77M 
>> (91%)????????? 2.2M (72%)
>>
>> 2k???? 3.56M (65%)??????????? 3.45M (59%)??????????? 3.72M 
>> (64%)????????? 2.12M (59%)
>>
>> 4k???? 1.8M (33%)???????????? 1.87M (32%)??????????? 1.88M 
>> (32%)????????? 1.59M (34%)
> 
> I'm blown by the fact that there is such a small difference for 4k
> reads, how many cpu-cores did you have on the target-system? single
> numa-node? Maybe if that is the case we can use less srqs than 
> per-completion-vector...

These results were taken without the performance improvments we sent few 
weeks ago and on different and weaker servers.
Are you suggesting another module param for srq_count per device ? I 
tried to avoid that.
