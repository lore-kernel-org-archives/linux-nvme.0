From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 13 Apr 2017 19:46:27 +0300
Subject: [PATCH v2 0/4] arbitrary sg lists support
In-Reply-To: <1492101079.5176.9.camel@sandisk.com>
References: <1492098977-5231-1-git-send-email-maxg@mellanox.com>
 <1492101079.5176.9.camel@sandisk.com>
Message-ID: <9a8bc957-dcc0-2e54-d631-9f05f96e0f18@mellanox.com>



On 4/13/2017 7:31 PM, Bart Van Assche wrote:
> On Thu, 2017-04-13@18:56 +0300, Max Gurtovoy wrote:
>> This patch adds an arbitrary sg list support to NVMEoF host for
>> capable devices (such as RDMA CX4/CX5 HCAs).
>> During the review we decided to add an helper function to ib_core
>> that will be used by ULPs in order to avoid code duplication.
>
> Hello Max,
>
> A question that is not related to the ULP drivers touched by this patch series:
> some time ago registration of sg-lists with gaps was disabled in the SRP
> initiator because arbitrary sg-lists triggered CQE dumps in combination with the
> mlx5 driver. Does this mean that this issue has been resolved? If so, what mlx5
> driver and/or firmware version are needed to reenable arbitrary sg-list support
> in the SRP initiator?
>

Hi Bart,
IsraelR and I couldn't repro this issue even once on our labs. I suggest 
we take it with Laurence and try to figure it out.
I can try installing the latest FW on CX4/5 cards in Laurence Lab and 
run the test suite again.

> Thanks,
>
> Bart.
>
