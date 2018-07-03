From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 3 Jul 2018 09:09:54 -0500
Subject: [PATCH] Support inline_data_size port parameter
In-Reply-To: <d2032770-ad1c-04cf-8795-94fd587f1c9c@grimberg.me>
References: <20180702152948.9D0362B88F@smtp.opengridcomputing.com>
 <d2032770-ad1c-04cf-8795-94fd587f1c9c@grimberg.me>
Message-ID: <384c6782-1726-6427-c67b-0bcf5b8683f2@opengridcomputing.com>



On 7/3/2018 4:04 AM, Sagi Grimberg wrote:
>
>> @@ -493,6 +497,9 @@ class UIReferralNode(UINode):
>> ????????? 'trtype': ('string', 'Transport Type (e.g. rdma or loop or
>> fc)'),
>> ????????? 'portid': ('number', 'Port identifier'),
>> ????? }
>> +??? ui_desc_param = {
>> +??????? 'inline_data_size': ('string', 'Port inline data size in
>> bytes'),
>> +??? }
>
> Umm, should a referral node have this?
>

I didn't know what a referral node is. :)? I'll remove it.

> Also, would this work with kernels that don't have it yet?

Yea, it doesn't work.? I'll fix that.?? How should it deal with that?


---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
