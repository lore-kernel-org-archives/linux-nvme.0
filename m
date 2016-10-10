From: keith.busch@intel.com (Keith Busch)
Date: Mon, 10 Oct 2016 11:29:10 -0400
Subject: nvme_admin_passthru DMA failure
In-Reply-To: <CAEhN9jtpkEGOOo88hDADkhuL09OgGTUgSDsqsqxGOG7+XDfMCA@mail.gmail.com>
References: <CAEhN9jtotCMNBt9Oy7M_HDe_oqDHoMegf+trki+2255gyfoO0g@mail.gmail.com>
 <B58D82457FDA0744A320A2FC5AC253B93D75FBDE@fmsmsx104.amr.corp.intel.com>
 <CAEhN9jtpkEGOOo88hDADkhuL09OgGTUgSDsqsqxGOG7+XDfMCA@mail.gmail.com>
Message-ID: <20161010152910.GB8524@localhost.localdomain>

On Mon, Oct 10, 2016@08:58:36AM -0600, Patrick Sheridan wrote:
> Hi Keith,
> 
> It is a vendor specific command with opcode 0xC0 and is expected to
> copy data from the host to the drive.
> I think you hit the nail on the head:  nvme_is_write would indicate
> that it's a read.
> Out of curiosity, do you know why this worked in previous nvme drivers?

Before 4.1, the nvme driver mapped user pages and setup the prp
directly. It didn't care about the alignment.

Now we use blk_rq_map_user, and this uses a bounce buffer if your user
buffer is not aligned. If the data direction is wrong, the data will be
copied to/from the bounce buffer in the wrong direction.

I think you probably will want to adjust your vendor specific opcode.
The driver's ioctl doesn't have a data transfer field, so it always used
the opcode to determine which direction to DMA map a buffer. A C0 is a
command with no data transfer according to the spec. I know the spec
explicitly defines this direction only for defined commands rather
than vendor specific ones, but I don't think that was the intention
(potential for an ECN here).

If you have to stick with the current opcode, you should be able to
work-around the bounce buffer if you allocate your buffers on pages,
but that's conditional on your architecture not enforcing read/write
DMA direction.
