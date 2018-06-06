From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 6 Jun 2018 12:27:02 +0300
Subject: Cannot Connect NVMeoF At Certain NR_IO_Queues Values
In-Reply-To: <DE927C68B458BE418D582EC97927A9287FF8E731@ORSMSX113.amr.corp.intel.com>
References: <DE927C68B458BE418D582EC97927A9287FF26F91@ORSMSX113.amr.corp.intel.com>
 <743c4b33-2bf8-7c76-95af-62043c2aaeeb@mellanox.com>
 <DE927C68B458BE418D582EC97927A9287FF27624@ORSMSX113.amr.corp.intel.com>
 <4b40ebf3-e01c-cf2b-38f5-07d7c5c6e304@mellanox.com>
 <DE927C68B458BE418D582EC97927A9287FF8E731@ORSMSX113.amr.corp.intel.com>
Message-ID: <8ec9ce8d-e967-edfa-7240-323bf7794f3a@mellanox.com>



On 6/6/2018 5:29 AM, Gruher, Joseph R wrote:
>> On 5/15/2018 2:09 AM, Gruher, Joseph R wrote:
>>>> IMO this issue was fixed in mlx5_core function mlx5_get_vector_affinity.
>>>> It was a long discussion regarding this fix and it will be fixed
>>>> again in 4.17. After the final fix, it should go to stable kernel as well.
>>>
>>> Thanks Max.  So current 4.17-rc5 has a fix now?  Or fix is not in yet?
>>
>> The latest fix is not there. SaeedM should push it this week.
>>
> 
> Hey Max, was just hoping to confirm if this fix made it in?  Do you know which kernel release would first include it?
> 

Hey,

Commit e3ca34880652250f524022ad89e516f8ba9a805b was pushed to 4.17.

-Max.
