From: hch@lst.de (Christoph Hellwig)
Date: Tue, 18 Aug 2015 07:51:38 +0200
Subject: [PATCH 1/2] nvme: remove spurious use of *_to_cpup helpers
In-Reply-To: <20150817201237.GC9645@linux.intel.com>
References: <1439838580-29647-1-git-send-email-hch@lst.de>
 <1439838580-29647-2-git-send-email-hch@lst.de>
 <20150817201237.GC9645@linux.intel.com>
Message-ID: <20150818055138.GA20959@lst.de>

On Mon, Aug 17, 2015@04:12:37PM -0400, Matthew Wilcox wrote:
> On Mon, Aug 17, 2015@09:09:39PM +0200, Christoph Hellwig wrote:
> > Switch to the normal endianess helpers that take an integer instead of
> > the pointer to it.
> 
> Why?  Some CPUs have a 'load-reversed-endian' instruction, which can be
> used in the _to_cpup() cases, but not in the _to_cpu() cases.

They can and will be used in both cases.

Powerpc examples listings below, as you can see they produce identical code.

------------------ le32_to_cpu ------------------
test.o:     file format elf32-powerpc


Disassembly of section .text:

00000000 <foor>:
};

int foor(struct foo *foo)
{
	return le32_to_cpu(foo->foo);
}
   0:	7c 60 1c 2c 	lwbrx   r3,0,r3
   4:	4e 80 00 20 	blr

------------------ le32_to_cpup ------------------
test.o:     file format elf32-powerpc


Disassembly of section .text:

00000000 <foor>:
};

int foor(struct foo *foo)
{
	return le32_to_cpup(&foo->foo);
}
   0:	7c 60 1c 2c 	lwbrx   r3,0,r3
   4:	4e 80 00 20 	blr
