From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 21 Oct 2016 06:32:52 -0700
Subject: [PATCH 0/6] Six NVMeOF-related patches
In-Reply-To: <dc3f4a94-72bd-469d-16ba-b1a6619f8609@sandisk.com>
References: <e96f7b21-9686-c24f-9c64-e6fb4b44fea0@sandisk.com>
 <1ae62d3e-8e23-6458-e822-7a11d3f9897f@grimberg.me>
 <dc3f4a94-72bd-469d-16ba-b1a6619f8609@sandisk.com>
Message-ID: <20161021133252.GB16449@infradead.org>

On Thu, Oct 20, 2016@10:38:39AM -0700, Bart Van Assche wrote:
> Sorry but that's something I wasn't aware of. In the MAINTAINERS file I
> found Keith and Jens as maintainers for the code under drivers/nvme/host/.
> Does this mean that a new entry should be added for
> drivers/nvme/host/fabrics.[ch]?

Maybe.  Or we should just add Sagi and me to the general NVMe antry
and replace the Fabrics git tree with a general NVMe one.

Keith, Jens - any preferences?
