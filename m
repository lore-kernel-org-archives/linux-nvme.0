From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 2 May 2017 19:14:33 +0300
Subject: [PATCH v2 0/4] arbitrary sg lists support
In-Reply-To: <1493664645.3041.184.camel@redhat.com>
References: <1492098977-5231-1-git-send-email-maxg@mellanox.com>
 <1492101079.5176.9.camel@sandisk.com>
 <c52b5ce7-5346-419d-26f2-0d4d45d20471@grimberg.me>
 <20170423103439.GC14088@mtr-leonro.local>
 <d697d360-99ca-c3ed-08e2-b89cc50a15b0@grimberg.me>
 <20170423121254.GD14088@mtr-leonro.local>
 <a3264968-2d9e-bda5-1f23-74da248cf4d5@grimberg.me>
 <9a9668fa-87a7-e730-27e2-8a2b3e7fbc36@mellanox.com>
 <8ed506ba-ae7b-af27-2d2a-9a434c22353c@grimberg.me>
 <1493664645.3041.184.camel@redhat.com>
Message-ID: <4a1c94b5-fe13-8b34-762f-e7465182ed27@mellanox.com>



On 5/1/2017 9:50 PM, Doug Ledford wrote:
> On Sun, 2017-04-23@17:35 +0300, Sagi Grimberg wrote:
>>>
>>> I actually answered here:
>>> https://www.spinics.net/lists/linux-rdma/msg46412.html
>>
>> Did anything progress with the debug?
>>
>>>
>>> Sagi,
>>> As you mentioned the IO path is different in SRP and iSER so IMO we
>>> should start with SRP debugging. NVMf is similar to iSER (and not
>>> SRP)
>>> and that's why I think we can apply this patchset.
>>
>> My concern is that this might be broken due to the fact that we don't
>> know what triggers this.
>>
>>>
>>> If you want to wait till we debug SRP issue it's fine, but I can't
>>> repro
>>> it in my lab so it can take longer.
>>
>> I'd prefer not to take a non-mandatory feature that is not guaranteed
>> to work.
>
> Indeed.  I've left this series on hold (actually, I've removed it from
> patchworks).  When we get this straightened, then please resubmit.
>

Sure, no problem.

Max.
