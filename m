From: muthucrazy90@gmail.com (muthu crazy)
Date: Mon, 15 Jan 2018 07:36:27 +0530
Subject: RDY bit clarification
In-Reply-To: <20180115015753.GA13580@localhost.localdomain>
References: <CADLzrv-QioecdwfNNfipio6iWBzsaDcHovOyAV4qGu8aLwv7Tg@mail.gmail.com>
 <20180115015753.GA13580@localhost.localdomain>
Message-ID: <CADLzrv_83V8i_bSeUbKA2FDf0Gtm4NCEa7fP-=vxVDk9=qBs8A@mail.gmail.com>

My concern is Reading RDY bit will trigger a MemRD PCIe transcation
which will add a delay for every command.
So it will affect the overall performance.

On 15 January 2018@07:27, Keith Busch <keith.busch@intel.com> wrote:
> On Sun, Jan 14, 2018@09:26:23AM +0530, muthu crazy wrote:
>> Why does linux nvme target code is checking for NVME_CSTS_RDY == 1
>> before submitting any IO commands to device. Is there any chance RDY
>> can go down after the controller initialization. It make sense if we
>> check for CFS instead of RDY.
>>
>> Isn't causing performance drop?
>
> I don't think it's for situations where RDY goest down on it's own, but
> for checking if a badly behaving host sends a command before respecting
> the proper state transitions.
