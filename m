From: keith.busch@intel.com (Keith Busch)
Date: Fri, 23 Sep 2016 10:45:12 -0400
Subject: nvme-cli: add endianess annotations
In-Reply-To: <1474600989-16657-1-git-send-email-hch@lst.de>
References: <1474600989-16657-1-git-send-email-hch@lst.de>
Message-ID: <20160923144511.GA19352@keith>

On Thu, Sep 22, 2016@08:22:51PM -0700, Christoph Hellwig wrote:
> The intent of this series is to provide static type checking for the
> little endian NVMe data structures using the sparse tool, similar to
> the kernel.
> 
> To make my life easier I first converted nvme-cli to use a copy of
> the kernel nvme.h header that defines the NVMe data structures.  The
> next set of patches fixes various issues found by sparse as-is, followed
> by adding support for checking the __le{16,32,64} annotations and using
> the kernel cpu_to_le*/le*_to_cpu helpers, as well as fixing up various
> missing endianess conversion uncovered by sparse.
> 
> To use sparse make sure both sparse and the cgcc wrapper are installed
> and build nvme-cli using:
> 
>     make CC=cgcc
> 
> At least with my version of sparse there are a few warnings left that
> aren't really nvme-clis faults during the build, and sparse will finally
> crash after compiling nvme.c because it misparses the command line and
> tries to interpret argconfig.o as a source file.  I'll plan to look into
> that on the sparse side and hope to be able to provide a fix for that
> issue to the sparse maintainers.

Thanks for all the fixes. I ran some sanity tests successfully, and have
applied all the patches to master.
