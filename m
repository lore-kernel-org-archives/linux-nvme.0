From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Tue, 13 Feb 2018 10:21:44 +0800
Subject: [PATCH 3/3] nvme: Fail controller on timeouts during reset
In-Reply-To: <14a17a6a-c626-8cb2-78a8-aa79249efb90@grimberg.me>
References: <20180209174127.7224-1-keith.busch@intel.com>
 <20180209174127.7224-3-keith.busch@intel.com>
 <75313a79-29da-3ea1-dd5b-c3d0d8c9069d@oracle.com>
 <2f2b2f64-8ce4-89a7-20dd-5c29b3d4b4e7@grimberg.me>
 <c6b18ec6-a0f2-c744-c84c-3540122ddb49@oracle.com>
 <14a17a6a-c626-8cb2-78a8-aa79249efb90@grimberg.me>
Message-ID: <eab525b0-c986-5bec-88f0-998625a05b3c@oracle.com>

Hi Sagi

Sorry for bothering you.

On 02/13/2018 02:37 AM, Sagi Grimberg wrote:
> 
>> Hi Sagi
>>
>> On 02/11/2018 05:53 PM, Sagi Grimberg wrote:
>>> Actually, they are already in nvme-4.16-rc.
>>>
>>> I'd like to pick these up as well once they converge (even
>>> taking 1+3 would be a good start).
>>
>> Please don't refer to my test result here.
>> It is tested on my patchset, not the currently source code on your git tree.
> 
> OK, what I don't understand is what is your feedback on this patchset as
> I'd like to take it for 4.16-rc and I want a review for it

This bug was seen when I tested the patchset nvme-pci: fixes on nvme_timeout and nvme_dev_disable patchset.
Because it is also a issue for current source code, so I reported this and had some talking with Keith,
then Keith gave this solution (Really appreciate for this).
Then I ported this with the patchset nvme-pci: fixes on nvme_timeout and nvme_dev_disable patchset and the issue
I met was gone. So I posted a feedback here as you saw.

It is certainly fine to fix that issue.

Really sorry for bothering you.


Sincerely
Jianchao	
