From: keith.busch@intel.com (Keith Busch)
Date: Sun, 14 Jan 2018 18:57:54 -0700
Subject: RDY bit clarification
In-Reply-To: <CADLzrv-QioecdwfNNfipio6iWBzsaDcHovOyAV4qGu8aLwv7Tg@mail.gmail.com>
References: <CADLzrv-QioecdwfNNfipio6iWBzsaDcHovOyAV4qGu8aLwv7Tg@mail.gmail.com>
Message-ID: <20180115015753.GA13580@localhost.localdomain>

On Sun, Jan 14, 2018@09:26:23AM +0530, muthu crazy wrote:
> Why does linux nvme target code is checking for NVME_CSTS_RDY == 1
> before submitting any IO commands to device. Is there any chance RDY
> can go down after the controller initialization. It make sense if we
> check for CFS instead of RDY.
> 
> Isn't causing performance drop?

I don't think it's for situations where RDY goest down on it's own, but
for checking if a badly behaving host sends a command before respecting
the proper state transitions.
