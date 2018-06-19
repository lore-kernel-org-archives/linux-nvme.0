From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 19 Jun 2018 11:02:48 -0500
Subject: [PATCH v4 0/3] NVMF/RDMA 16K Inline Support
In-Reply-To: <20180619054056.GB23184@lst.de>
References: <cover.1528219321.git.swise@opengridcomputing.com>
 <4f16cd07-015e-d1cf-f8fd-069c460ee2a6@opengridcomputing.com>
 <3f3b2259-b41b-59bd-c7b6-b5102849aec4@opengridcomputing.com>
 <20180619054056.GB23184@lst.de>
Message-ID: <68434eaa-ab12-35a2-2625-55978b9a7cf8@opengridcomputing.com>



On 6/19/2018 12:40 AM, Christoph Hellwig wrote:
> On Mon, Jun 18, 2018@10:18:18AM -0500, Steve Wise wrote:
>>
>> On 6/18/2018 9:49 AM, Steve Wise wrote:
>>> Hey Christoph,? will you merge patches 2 and 3 for -next?? I think
>>> they're ready.?? I also have a nvmetcli patch I can send out for using
>>> param_inline_data_size.
>>>
>>>
>> Or I can rebase on 4.18-rc1 and resend...
> Yes, please do.  I'd also like to see at least an ACK from one or our
> RDMA low level experts.
>

Sure.

+doug and jason.

There is one merge issue: This series will require the max_send/recv_sge
commit, which is merged in rdma-next [1] just recently.? Perhaps you can
pull that from the linux-rdma repo if and when these 2 nvme patches are
pulled into your repo?? I think that will allow easy merging when the
block and rdma repos get merged into Linus' repo.

Steve.

[1] https://www.spinics.net/lists/linux-rdma/msg66118.html
