From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 19 Jan 2016 09:44:22 -0500
Subject: Anyone working on nvme power management?
In-Reply-To: <CALCETrUDmjXDYzHrhpS=0UokebFys4rWhot5Ti1dxa=KX_9+9g@mail.gmail.com>
References: <CALCETrUDmjXDYzHrhpS=0UokebFys4rWhot5Ti1dxa=KX_9+9g@mail.gmail.com>
Message-ID: <20160119144422.GB2948@linux.intel.com>

On Mon, Jan 18, 2016@03:23:31PM -0800, Andy Lutomirski wrote:
> Also, the host memory buffer feature seems related, although I can't
> find anything in the spec saying what its purpose is.  Is it related
> to the power management features?  Does it give faster low-power
> exits?

The host memory buffer exists because some bright spark working on a
drive noticed that it's significantly quicker & higher bandwidth to store
various data in host DRAM than it is to store them on the drive's flash.
So as long as they can twist our arms into allocating host DRAM for
them and tolerate the fact that the contents of the host memory buffer
go away at power-loss, they're going to store all kinds of things there
that they don't want to keep in the drive's own DRAM.

So yes, the HMB may well be used by the drive to store the (hopefully
encrypted) contents of its own DRAM during low-power states where it
wants to power down its DRAM, but it may also be used during regular
operation for other things.
