From: ckulkarnilinux@gmail.com (chaitany kulkarni)
Date: Thu, 17 Nov 2016 14:28:12 -0800
Subject: [PATCH 2/5] block: add support for REQ_OP_WRITE_ZEROES
In-Reply-To: <yq1h976akkd.fsf@sermon.lab.mkp.net>
References: <1479279039-25818-1-git-send-email-chaitanya.kulkarni@hgst.com>
 <1479279039-25818-3-git-send-email-chaitanya.kulkarni@hgst.com>
 <20161116175906.GA10050@localhost.localdomain>
 <yq1h976akkd.fsf@sermon.lab.mkp.net>
Message-ID: <CAK0tqi=rMd9EqXLzAVXp0RnTGpv3USLcu95=vwhZPbK-qZos5A@mail.gmail.com>

Incorporated the comments and sent new patch.

On Wed, Nov 16, 2016 at 6:48 PM, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>>>>>> "Keith" == Keith Busch <keith.busch at intel.com> writes:
>
> Keith> Your maximum bi_size exceeds the 2-bytes an NVMe Write Zeroes
> Keith> command provides for the block count. Instead of having a simple
> Keith> queue flag for write zeroes support, have it take a max sectors
> Keith> value instead.
>
> Yes, please. Make it a queue limit and make sure it is properly stacked.
>
> The rest looks sensible to me. I'll wire up the SCSI pieces.
>
> --
> Martin K. Petersen      Oracle Linux Engineering
