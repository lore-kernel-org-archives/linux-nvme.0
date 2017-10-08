From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 7 Oct 2017 23:24:08 -0700
Subject: Missing interrupts in kernel 4.5.0-21.cavium.el7.aarch64
In-Reply-To: <CAGSHeY1uhgMT5oQBt8fxEzO1k=s9q9eBaFGm+oVt9a31_Ga9aA@mail.gmail.com>
References: <CAGSHeY1uhgMT5oQBt8fxEzO1k=s9q9eBaFGm+oVt9a31_Ga9aA@mail.gmail.com>
Message-ID: <20171008062407.GA20749@infradead.org>

On Fri, Oct 06, 2017@02:49:06PM -0700, Yogi Wannabe wrote:
> Are there any known issues that could be causing this weird behavior?

Probablt broken interrupt handling code in your patched non-mainline
code.
