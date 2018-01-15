From: keith.busch@intel.com (Keith Busch)
Date: Sun, 14 Jan 2018 19:12:54 -0700
Subject: RDY bit clarification
In-Reply-To: <CADLzrv_83V8i_bSeUbKA2FDf0Gtm4NCEa7fP-=vxVDk9=qBs8A@mail.gmail.com>
References: <CADLzrv-QioecdwfNNfipio6iWBzsaDcHovOyAV4qGu8aLwv7Tg@mail.gmail.com>
 <20180115015753.GA13580@localhost.localdomain>
 <CADLzrv_83V8i_bSeUbKA2FDf0Gtm4NCEa7fP-=vxVDk9=qBs8A@mail.gmail.com>
Message-ID: <20180115021254.GF13580@localhost.localdomain>

On Mon, Jan 15, 2018@07:36:27AM +0530, muthu crazy wrote:
> My concern is Reading RDY bit will trigger a MemRD PCIe transcation
> which will add a delay for every command.
> So it will affect the overall performance.

Maybe I misunderstood what you're referring to. Are you looking at
nvmet_check_ctrl_status? The controller status is implemented in
software there and doesn't do MMIO to read it.
