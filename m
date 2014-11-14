From: keith.busch@intel.com (Keith Busch)
Date: Fri, 14 Nov 2014 22:59:13 +0000 (UTC)
Subject: [PATCH] NVMe: Add rw_page support
In-Reply-To: <54666BD8.9010901@kernel.dk>
References: <1415923538-18760-1-git-send-email-keith.busch@intel.com>
 <54655B01.9090206@kernel.dk> <20141114145858.GF11522@wil.cx>
 <54661AC5.7000605@kernel.dk> <20141114155223.GG11522@wil.cx>
 <54662E8B.9070409@kernel.dk>
 <alpine.LNX.2.00.1411141633180.4225@localhost.lm.intel.com>
 <54666BD8.9010901@kernel.dk>
Message-ID: <alpine.LNX.2.00.1411142251180.4225@localhost.lm.intel.com>

On Fri, 14 Nov 2014, Jens Axboe wrote:
> It's hard (impossible) to tell from just this, we'd need performance
> data to go with it, too. The number of events is a very vague hint, I
> would not put any value into that.

Oh good. After generating the report I couldn't figure out why I thought
it would have been useful in the first place!

> If you can describe your workload, I'd love to just run it and see what
> happens here!

Sure, I made this program up real quick, so there's probably something
better out there. It just allocates millions of pages in an array then
writes and reads a byte from each page to force page faults and swapping,
then does it all again a few more times.

This is the basic verion. I've another one that does this with lots of
threads accessing pages in random order.

It allocates 40GB worth of pages, so that might not be appropriate for
all machines.

swap.c:
---
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int main(int argc, char ** argv)
{
 	unsigned long i, j, num_pages;
 	unsigned char **mem;
 	volatile unsigned char k;

 	num_pages = (1024 * 1024 * 1024 * 40ULL) / getpagesize();
 	mem = (unsigned char **)calloc(num_pages, sizeof(*mem));
 	if (!mem)
 		return 1;

 	for (i = 0; i < num_pages; i++) {
 		mem[i] = malloc(getpagesize());
 		if (!mem[i])
 			return 1;
 	}

 	for (j = 0; j < 8; j++) {
 		for (i = 0; i < num_pages; i++)
 			mem[i][0] = i;
 		for (i = 0; i < num_pages; i++)
 			k = mem[i][0];
 	}
 	return 0;
}
--
