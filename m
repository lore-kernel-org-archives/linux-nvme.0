From: james.smart@broadcom.com (James Smart)
Date: Fri, 1 Dec 2017 12:58:22 -0800
Subject: [PATCH v2] nvme-fc: don't require user to enter host_traddr
In-Reply-To: <mqdefoe4zjq.fsf@linux-x5ow.site>
References: <20171130151210.8168-1-jthumshirn@suse.de>
 <f9b1eb5d-df4d-08fe-90da-5548bc1b6039@broadcom.com>
 <mqdefoe4zjq.fsf@linux-x5ow.site>
Message-ID: <b917f4a2-3c6f-e1c7-3c0b-846a081d20e3@broadcom.com>

On 12/1/2017 12:34 AM, Johannes Thumshirn wrote:
> James Smart <james.smart at broadcom.com> writes:
>
>> On 11/30/2017 7:12 AM, Johannes Thumshirn wrote:
>>> One major usability difference between NVMf RDMA and FC is resolving
>>> the default host transport address in RDMA. This is perfectly doable
>>> in FC as well, as we already have all possible lport <-> rport
>>> combinations pre-populated so we can pick the first lport that has a
>>> connection to our desired rport per default or optionally use the user
>>> supplied lport if we have one.
>>>
>>> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
>>> Cc: James Smart <james.smart at broadcom.com>
>> This is unnecessary and can create weird configurations. It assumes
>> connections are manually created.
> a) connections can (and will) be maually created and for this the users
> have to know the topology or connection establishment will fail b) there
> is no need that the connections are manually created. Sagi did post an
> RFC systemd service which calls nvme connect-all and this is what should
> be done regardless if we're running on FC-NVME or NVMe over RDMA any new
> transport that may come in the future. What I want is a consistent user
> experience within NVMe, as I am the one that has to answer a
> documentation team's inquiries on how to configure NVMf, support QA in
> testing and fix end user bugs. The least thing I want ot do is tell them
> "well if you use rdma you have to use the nvme-connect.service, if you
> use FC you have to have some magic udev rules and auto-connect scripts,
> if you use $POSSIBLE_NEW_TRANSPORT you have to yada, yada".
>
> I don't really like that we have to manully connect either but this
> behaviour was first in NVMe so we should either stick to that or convert
> RDMA over to using some sort of udev magic as well (which wont work as
> far as I know, and it definitively won't work with TCP if and when it's
> there).
>

Sagi's RFC is certainly fine to use with FC-NVME as well. But the 
mechanism does require the admin to have apriori knowledge and populate 
the discovery.conf file with the discovery controller information. It 
also requires updates on any dynamic change. All of that is unnecessary 
with the FC-NVME auto-connect scripts. Note: there's nothing wrong with 
using both mechanisms simultaneously with FC-NVME.

I certainly understand the sentiment of not doing something N ways. But, 
in this case, the functionality is so useful and valuable, that 
constraining the solution to the least common denominator is a bad 
idea.? You are also ignoring the user-base coming from SCSI on FC (which 
is much larger than nvmf on RDMA) that have completely different 
expectations on how the system finds targets and connects to storage. 
They will be confused and have lots of questions about why SCSI is so 
automatic yet (even on the same machines/adapters/fabric) they now must 
have all kinds of upfront knowledge and make manual changes for NVME. I 
get bombarded on this and I know you will too. ? Although it's not nice 
to state transport-specific methods, I believe the message is still 
rather short and simple.

We seem to have gotten away from the desired patch into a completely 
different area.?? In truth, adding the patch isn't a big deal, but to me 
it doesn't provide any value over the existing scripts. You could say it 
adds yet another one off in FC-specific behavior that could complicate 
the documentation.

-- james
