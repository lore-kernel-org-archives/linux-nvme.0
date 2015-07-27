From: keith.busch@intel.com (Keith Busch)
Date: Mon, 27 Jul 2015 16:50:25 +0000 (UTC)
Subject: SGL support of driver
In-Reply-To: <20150727163123.GA5034@infradead.org>
References: <CAB7xdimg82dhfMY5mVAfZZ5=Ub-Dz5N+x1gQ5QWg7qPwb5fsXA@mail.gmail.com>
 <20150727163123.GA5034@infradead.org>
Message-ID: <alpine.LNX.2.00.1507271636430.15930@localhost.lm.intel.com>

On Mon, 27 Jul 2015, Christoph Hellwig wrote:
> On Mon, Jul 27, 2015@09:22:51AM -0700, sheng qiu wrote:
>> Hi,
>>
>> may i ask if exiting kernel driver support SGL DMA setups?
>
> It doesn't.  There have been patches but they weren't in shape to be
> included yet.

We also need data that shows SGL is an improvement over PRP. H/w should
be able to process a PRP faster than an SGL in most cases.

SGL may be faster with a physically contiguous range across multiple
pages, or if a request payload can't be PRP mapped, requiring a bounce
buffer.

The Linux driver never recieves an IO vector that requires double
buffering though, and usually not physically contiguous. I'm not sure
there is a case to support SGL in the linux-nvme driver. Maybe if it's
tied to block integrity extensions with interleaved metadata formats,
but it'd be odd to find a device that implements SGL but not separate
metadata.
