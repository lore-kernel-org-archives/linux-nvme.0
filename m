From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 27 Jul 2015 09:31:23 -0700
Subject: SGL support of driver
In-Reply-To: <CAB7xdimg82dhfMY5mVAfZZ5=Ub-Dz5N+x1gQ5QWg7qPwb5fsXA@mail.gmail.com>
References: <CAB7xdimg82dhfMY5mVAfZZ5=Ub-Dz5N+x1gQ5QWg7qPwb5fsXA@mail.gmail.com>
Message-ID: <20150727163123.GA5034@infradead.org>

On Mon, Jul 27, 2015@09:22:51AM -0700, sheng qiu wrote:
> Hi,
> 
> may i ask if exiting kernel driver support SGL DMA setups?

It doesn't.  There have been patches but they weren't in shape to be
included yet.
