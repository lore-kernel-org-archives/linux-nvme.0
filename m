From: vickey.nitt@gmail.com (VIKASH KUMAR)
Date: Mon, 15 Jan 2018 11:16:12 +0530
Subject: Fabric Connect Fails with Chelsio from Windows Host
In-Reply-To: <c3a14be0-2cca-842e-7b04-1560bb8af605@grimberg.me>
References: <CADNRq_+3uBmOYTJ+R6RaiU5HUa81vrBMQ2Ug39qqvA1Eng+MKg@mail.gmail.com>
 <c3a14be0-2cca-842e-7b04-1560bb8af605@grimberg.me>
Message-ID: <CADNRq_LLwAhVDwntO+6V_RSD0ZiPD2n+Gi97X9NxuQSdw80wvA@mail.gmail.com>

Hi Sagi Grimverg,

Thanks for the reply. Yes I am able to print logs. And you are right
it's failing inside rdma_rw_ctx_init for _init_mr_wrs and returned
value is fffffff5.


Thanks and Regards,
Vikash Kumar

On Sun, Jan 14, 2018@4:20 PM, Sagi Grimberg <sagi@grimberg.me> wrote:
>> Hi all,
>>
>> I have written a Windows application to test NVMe over RDMA with
>> Chelsio RNICs in host and target.
>> When I issue the fabric connect command from host, target fails in
>> nvmet_rdma_map_sgl_keyed( ) with Status code 0x6 (Internal error). And
>> RDMA connect command working fine.
>>
>> I have tried the same application with Mellanox RNICs, and connect is
>> working fine. Also I have tired with the linux host and linux target,
>> fabric connect command working fine.
>>
>> Has anybody tested the linux NVMe over RDMA stack with Chelsio RNIC?
>
>
> I think Steve Wise have.
>
> As I see it, this probably related to the rdma_rw_ctx that involves MRs.
> Are you able to add some logging prints to your system?
