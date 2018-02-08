From: thomas.tai@oracle.com (Thomas Tai)
Date: Thu, 8 Feb 2018 11:19:03 -0500
Subject: [PATCH v3 2/2] Documentation: nvme: Documentation for nvme fault
 injection
In-Reply-To: <2c1534d4-c2c8-3e38-59bb-170c7c3d205a@grimberg.me>
References: <1517526659-3450-1-git-send-email-thomas.tai@oracle.com>
 <1517526659-3450-3-git-send-email-thomas.tai@oracle.com>
 <75fba2c9-3fb6-0cf8-fcf4-7738bd7c6147@grimberg.me>
 <600bfddd-448c-bedd-ba6c-a3e925137ee8@oracle.com>
 <cf7ed6dd-05b2-32fe-451a-e32f0ac810fa@grimberg.me>
 <483b49dc-a89c-cba7-3f63-9a29420e4b6c@oracle.com>
 <2c1534d4-c2c8-3e38-59bb-170c7c3d205a@grimberg.me>
Message-ID: <af2a15b1-8887-77ec-98b7-abc9b630b47c@oracle.com>

[ ... ]
>>> It's going to 4.17 (we have time), so I'd prefer to get it right once
>>> instead of having another fixup on top. Would it be possible to re-spin
>>> with the minor fix?
>>
>> Sure. Do you mean I should resend the patch set which include the 
>> fault injection maintainer in the email?
> 
> No, just fix the documentation to say not only NVME_SC_INVALID_OPCODE 
> can be injected (the entry in fault-injection.txt)

Oh yes. Sorry I missed that. will update the doc. Thank you.
