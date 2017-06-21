From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 21 Jun 2017 13:38:46 +0300
Subject: [Suspected-Phishing]Re: RDMA_Connect issue on Windows
In-Reply-To: <0d322454-a853-8625-9fcd-87883df59e99@mellanox.com>
References: <CADLzrv_yFWA2nvt=_SbEUVTuE_MScRrwj-yaFKorvPZ_6pw9bA@mail.gmail.com>
 <73ba33ed-765a-07c3-7ce7-d93503364dae@grimberg.me>
 <983226b0-9efa-7c3e-10ff-7a22b84a9160@mellanox.com>
 <CADLzrv9-qH=7JtMRy7+8_80fxbheU_8cNApa90723sRei5xkAg@mail.gmail.com>
 <0d322454-a853-8625-9fcd-87883df59e99@mellanox.com>
Message-ID: <fe7dd8af-4781-343a-e28c-a157a382766b@mellanox.com>



On 6/21/2017 1:33 PM, Max Gurtovoy wrote:
>
>
> On 6/21/2017 3:56 AM, muthu crazy wrote:
>> Thanks for the reply,
>>
>> I was trying to see the packets in Wireshark(2.2.6) during
>> rdma_connect but I was getting only ARP packets. Do I need to add any
>> plugin for Wireshark? Or any protocol preference has to be added in
>> settings?
>>
>> -Muthu
>
>
> please use this link:

  https://www.wireshark.org/download.html

>
> and download the latest development release.
> make sure your listener port is 4420.
>
> -Max.
>
>>
>> On 20 June 2017@12:50, Max Gurtovoy <maxg@mellanox.com> wrote:
>>> I would also try to parse it with Wireshark and compare all the needed
>>> fields and sizes.
>>> We are adding more and more nvmf command parsing to the disector but
>>> you're
>>> in earliar stage of RDMA connection establisment.
>>>
>>>
>>> On 6/20/2017 9:34 AM, Sagi Grimberg wrote:
>>>>
>>>> CC'ing Robert who has experience with Windows <-> Linux
>>>> interop...
>>>>
>>>> On 19/06/17 20:58, muthu crazy wrote:
>>>>>
>>>>> Dear All,
>>>>>
>>>>> I am trying to make a fabrics setup using Chelsio RNIC where Windows
>>>>> is the Client PC, and Linux is the target PC. From Windows Client
>>>>> driver, I am invoking NDKConnect API(It will internally call
>>>>> RMDA_Connect) and passing below structures as a parameter to it.
>>>>>
>>>>> struct RDMA_CONN_PARAM
>>>>> {
>>>>> RDMA_CM_REQUEST private_data;
>>>>> private_data_len = sizeof(RDMA_CM_REQUEST)
>>>>> responder_resources = 0x20
>>>>> initiator_depth = 0
>>>>> flow_control=1
>>>>> retry_count=7
>>>>> RNR_Retry_count = 7
>>>>> SRQ = 0
>>>>> QP_num = 0x400
>>>>> }
>>>>>
>>>>> struct RDMA_CM_REQUEST
>>>>> {
>>>>> Recfmt = 0
>>>>> Qid = 0
>>>>> Hrqsize = 0x20
>>>>> Hsqsize = 0x20
>>>>> Reserved[8:31] = 0;
>>>>> }
>>>>>
>>>>> but on target side, I could see some junk value along with my actual
>>>>> data received.(Linux Kernel:4.9.8)
>>>>>
>>>>> like below:
>>>>>
>>>>> 0xFFFFFFE0, 0xFFFFFFB0, 0x23, 0x6, 0x0, 0xFFFFFFE0, 0xFFFFFFFF
>>>>> 0x20,0x20,0x0,0x1,0x7,0x7,0x0,0x0,0x0,0x4
>>>>>
>>>>> Has anybody observed this before? Please help me out.
>>>>>
>>>>>
>>>>> Thanks,
>>>>> --Muthu
>>>>>
>>>>> _______________________________________________
>>>>> Linux-nvme mailing list
>>>>> Linux-nvme at lists.infradead.org
>>>>>
>>>>> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-nvme&data=02%7C01%7Cmaxg%40mellanox.com%7C2abc52e374854c98a13508d4b7a684e2%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636335373205704262&sdata=ET93l30HHFfZYSdGJ2xCTLVOObYIG%2Bq%2BS%2Ffv2y5Of74%3D&reserved=0
>>>>>
>>>>>
>>>>>
>>>>
>>>> _______________________________________________
>>>> Linux-nvme mailing list
>>>> Linux-nvme at lists.infradead.org
>>>>
>>>> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-nvme&data=02%7C01%7Cmaxg%40mellanox.com%7C2abc52e374854c98a13508d4b7a684e2%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636335373205714275&sdata=C2YQOHf93VyDCyeYfHUboIl81mZcmR%2BDM2V58xmLFEI%3D&reserved=0
>>>>
>>>>
>>>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-nvme&data=02%7C01%7Cmaxg%40mellanox.com%7C486b3843d17e4cda382908d4b8910951%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C636336380464261069&sdata=SFYoJ9bBCOxCL9ovN2Pu5FxOfes%2Bd65PB0NMCKRV588%3D&reserved=0
>
