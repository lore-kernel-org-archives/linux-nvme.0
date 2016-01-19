From: luto@amacapital.net (Andy Lutomirski)
Date: Tue, 19 Jan 2016 11:37:40 -0800
Subject: Anyone working on nvme power management?
In-Reply-To: <20160119144422.GB2948@linux.intel.com>
References: <CALCETrUDmjXDYzHrhpS=0UokebFys4rWhot5Ti1dxa=KX_9+9g@mail.gmail.com>
 <20160119144422.GB2948@linux.intel.com>
Message-ID: <CALCETrUHMrAbG5s8utgvrGUgn0E5mn80iWyNUef4+h1v8eY8yg@mail.gmail.com>

On Tue, Jan 19, 2016@6:44 AM, Matthew Wilcox <willy@linux.intel.com> wrote:
> On Mon, Jan 18, 2016@03:23:31PM -0800, Andy Lutomirski wrote:
>> Also, the host memory buffer feature seems related, although I can't
>> find anything in the spec saying what its purpose is.  Is it related
>> to the power management features?  Does it give faster low-power
>> exits?
>
> The host memory buffer exists because some bright spark working on a
> drive noticed that it's significantly quicker & higher bandwidth to store
> various data in host DRAM than it is to store them on the drive's flash.
> So as long as they can twist our arms into allocating host DRAM for
> them and tolerate the fact that the contents of the host memory buffer
> go away at power-loss, they're going to store all kinds of things there
> that they don't want to keep in the drive's own DRAM.
>
> So yes, the HMB may well be used by the drive to store the (hopefully
> encrypted) contents of its own DRAM during low-power states where it
> wants to power down its DRAM, but it may also be used during regular
> operation for other things.

This scares me a bit.

Suppose I own an nvme device, I enable HMB, and the power fails.
Suppose further that it's a reasonable quality part with power-fail
caps.  How much do we believe that the power-fail code won't try to
access the HMB?

Also, all of the slow-but-operational power states seem semi-useless.
They don't tell us how slow they are except in the "I am slower than
this other state" sense.

Maybe I'll try to implement some basic control over the autonomous
transition policy in the driver.  That's a lot less work than getting
D3 transitions to work without blowing up the driver state or taking
forever to wake back up and restore all the queues.

--Andy
