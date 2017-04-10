From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 10 Apr 2017 17:09:08 +0300
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <1948057100.362217696.1491824459274.JavaMail.zimbra@kalray.eu>
References: <08131a05-1f56-ef61-990a-7fff04eea095@gmail.com>
 <1848296658.37025722.1487782361271.JavaMail.zimbra@redhat.com>
 <1554c1d1-6bf4-9ca2-12d4-a0125d8c5715@gmail.com>
 <DE927C68B458BE418D582EC97927A92854655137@ORSMSX112.amr.corp.intel.com>
 <3eb5814f-14cb-2b94-adf8-335d4b2eb7e9@grimberg.me>
 <26912d0c-578f-26e9-490d-94fc95bdf259@mellanox.com>
 <DE927C68B458BE418D582EC97927A92855031724@ORSMSX113.amr.corp.intel.com>
 <809f87ab-b787-9d40-5840-07500d12e81a@mellanox.com>
 <1948057100.362217696.1491824459274.JavaMail.zimbra@kalray.eu>
Message-ID: <33e2cc35-f147-d4a4-9a42-8f1245e35842@mellanox.com>



On 4/10/2017 2:40 PM, Marta Rybczynska wrote:
>> On 3/17/2017 8:37 PM, Gruher, Joseph R wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Max Gurtovoy [mailto:maxg at mellanox.com]
>>>>
>>>> I think we need to add fence to the UMR wqe.
>>>>
>>>> diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
>>>> index ad8a263..c38c4fa 100644
>>>> --- a/drivers/infiniband/hw/mlx5/qp.c
>>>> +++ b/drivers/infiniband/hw/mlx5/qp.c
>>>> @@ -3737,8 +3737,7 @@ static void dump_wqe(struct mlx5_ib_qp *qp, int idx,
>>>> int size_16)
>>>>
>>>>   static u8 get_fence(u8 fence, struct ib_send_wr *wr)
>>>>   {
>>>> -       if (unlikely(wr->opcode == IB_WR_LOCAL_INV &&
>>>> -                    wr->send_flags & IB_SEND_FENCE))
>>>> +       if (wr->opcode == IB_WR_LOCAL_INV || wr->opcode == IB_WR_REG_MR)
>>>>                  return MLX5_FENCE_MODE_STRONG_ORDERING;
>>>>
>>>>          if (unlikely(fence)) {
>>>>
>>>>
>>>
>>> You mention these patches are only for testing.  How do we get to something
>>> which can be submitted to upstream?
>>
>> Yes, we need to be careful and not put the strong_fence if it's not a must.
>> I'll be out for the upcoming week, but I'll ask our mlx5 maintainers to
>> prepare a suitable patch and check some other applications performance
>> numbers.
>> Thanks for the testing, you can use this patch meanwhile till we push
>> the formal solution.
>>
>
> Hello Max,
> We're seeing the same issue in our setup and we're running this patch
> on our system for some time already. It seems to have fixed the issue.
> When there is a final patch available, we can test it too.
>
> Thanks,
> Marta
>

Hi Marta,
thanks for testing my patch. I'll send it early next week (holiday's in 
our country) so it will be available in 4.11 kernel hopefully.
if you can share on which NIC's you tested it and the perf numbers you 
get (with and without the patch), it will be great.

thanks,
Max.
