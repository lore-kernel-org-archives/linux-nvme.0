From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 14 Mar 2017 10:55:26 +0200
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <9a7e48b5-6e2d-75ed-bf12-8fd4543f2f76@grimberg.me>
References: <08131a05-1f56-ef61-990a-7fff04eea095@gmail.com>
 <de1a559a-bf24-0d73-5fc7-148d6cd4d4e0@grimberg.me>
 <1848296658.37025722.1487782361271.JavaMail.zimbra@redhat.com>
 <1554c1d1-6bf4-9ca2-12d4-a0125d8c5715@gmail.com>
 <DE927C68B458BE418D582EC97927A92854655137@ORSMSX112.amr.corp.intel.com>
 <3eb5814f-14cb-2b94-adf8-335d4b2eb7e9@grimberg.me>
 <26912d0c-578f-26e9-490d-94fc95bdf259@mellanox.com>
 <16c4bd86-fd63-f230-40bc-f52cb106e11b@grimberg.me>
 <fbd647dd-3a16-8155-107d-f98e8326cc63@mellanox.com>
 <AM4PR0501MB278621363209E177A738D75FCB220@AM4PR0501MB2786.eurprd05.prod.outlook.com>
 <9a7e48b5-6e2d-75ed-bf12-8fd4543f2f76@grimberg.me>
Message-ID: <7aa4b74e-ea28-7bc1-68b8-01a728588297@mellanox.com>



On 3/13/2017 11:43 AM, Sagi Grimberg wrote:
>
>> Patched  by patch of Max (block 4K):
>>
>> allways reg          Y                N
>> write              1902K            1923.3K
>> read               1315K            2009K
>>
>> Original  OFED code (block 4K)
>>
>> allways reg          Y                N
>> write              1947K           1982K
>> read               1273K
>> 1978K
>
> First, the write comparison is redundant because
> we send immediate data without memory registration.
>
> And, I'd compare against upstream code and not OFED.

I dont thing we'll get different results (my first tests were with nvmf 
upstream driver).

>
> So it seems that strong fencing does not effect performance
> from the ULP point of view, surprising...
> I'd suggest comparing on nvmf and srp as well.

I agree. We also want to run other application types with it in our 
performance lab.

>
> If this is the case, and it indeed resolves the issue, we
> should move forward with it as is.

Not as is, because it will have influence on ConnectX5 too (no need).
We'll need to update the patch before submission.
