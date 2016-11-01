From: mlin@kernel.org (Ming Lin)
Date: Tue, 1 Nov 2016 16:27:51 -0700
Subject: Failure with 8K Write operations
In-Reply-To: <CAF1ivSZVgK_xwWtN+co0xE_rjfg2U9sM-ucaTq8QcsG2iBy5+A@mail.gmail.com>
References: <BY2PR08MB181580B3E2779DAF024CAD7DC0FF0@BY2PR08MB1815.namprd08.prod.outlook.com>
 <a8e92a9f-f3e6-6bc3-b49b-368f3302517d@grimberg.me>
 <BY2PR08MB1815C4CAC2FC683A05DFD443C0FE0@BY2PR08MB1815.namprd08.prod.outlook.com>
 <1473810683.2781.72.camel@linux.intel.com>
 <SN1PR08MB1822F0F69AE0A389A74CD6F1C0F10@SN1PR08MB1822.namprd08.prod.outlook.com>
 <1473871944.2781.90.camel@linux.intel.com>
 <BY2PR08MB1815B488DAC435C9EA684457C0F00@BY2PR08MB1815.namprd08.prod.outlook.com>
 <CAF1ivSZVgK_xwWtN+co0xE_rjfg2U9sM-ucaTq8QcsG2iBy5+A@mail.gmail.com>
Message-ID: <CAF1ivSZsK9TnF+XOrNyNrqTX0YF01KMAsgwc0iDW3WVsQFK4MQ@mail.gmail.com>

On Tue, Nov 1, 2016@4:07 PM, Ming Lin <mlin@kernel.org> wrote:
> On Thu, Sep 15, 2016 at 6:36 AM, Narayan Ayalasomayajula
> <narayan.ayalasomayajula@kazan-networks.com> wrote:
>> Hi Jay,
>>
>> Thanks for pointing out that I was not running the latest version of the kernel. I updated to 4.8rc6 and my FIO test that had previously failed with the Linux NVMeF target (using null_blk device as the target) is now completing successfully. I am still seeing the same NAK (Remote Access Error) failure when I use our target instead. I will debug this further but updating to 4.8rc6 did improve things.
>
> Hi Narayan,
>
> I also saw similar error with 8k write when I use my own target implementation.
> Did you fix it already?

Hi Narayan,

With Sagi's great help off-line, I just fixed it.
In my code, when I post RDMA_READ, I didn't set rdma_wr.next to NULL.

Shame on myself ... example code as below

int rw_ctx_post(NvmetRdmaRsp *rsp)
{
    rsp->rdma_wr.next = NULL;
    return ibv_post_send(cm_id->qp, &rsp->rdma_wr, &bad_wr);
}

Possibly you may don't have this kind of stupid bug ...
