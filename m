From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 7 Oct 2016 00:29:23 -0700
Subject: Problem with new uapi header in Linux kernel 4.4+
In-Reply-To: <20161006230947.GA3696@localhost.localdomain>
References: <37b9f516-a945-d41f-b21a-48728d7f9680@fu-berlin.de>
 <20161006230947.GA3696@localhost.localdomain>
Message-ID: <20161007072923.GA1936@infradead.org>

On Thu, Oct 06, 2016@07:09:48PM -0400, Keith Busch wrote:
> Yeah, we changed the uapi to only contain the what's necessary for the
> user-kernel interface. We don't want user space to depend on the kernel
> header for structure definitions when the kernel has no use for some them.
> 
> For the nvme-cli project, we define everything. I'm up for turning parts
> of this into a shared library that sedutil and others can use.

FYI, one issue is the the Linux nvme.h is GPLv2 only like much of the
kernel, making it hard to use for things like sedutils that use GPLv3+.
I'd be fine with relicing my contributions to it under GPLv2+, but I
don't sign up for contacting everyone that ever touched it and get
their permission..
