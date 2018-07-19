From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 19 Jul 2018 05:41:58 -0700
Subject: nvme-cli shows failed to map on Kernel 4.16.16
In-Reply-To: <20180718231211.GE32160@localhost.localdomain>
References: <CAGSHeY1JpRAXzbdYKpwVnB5Wug=6iyUZVUqLteQCgOOEqq5RoA@mail.gmail.com>
 <20180718231211.GE32160@localhost.localdomain>
Message-ID: <20180719124158.GA3147@infradead.org>

On Wed, Jul 18, 2018@05:12:11PM -0600, Keith Busch wrote:
> That is correct, you will not be able to use that command when
> CONFIG_IO_STRICT_DEVMEM=y. When that kernel config option is set, the
> kernel will not allow user space to mmap io memory if a driver also
> mapped it.

Yikes.  We really ought to have a way to scrape that information
without reading the bar..
