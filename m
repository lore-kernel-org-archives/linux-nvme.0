From: sbradshaw@micron.com (Sam Bradshaw (sbradshaw))
Date: Fri, 21 Nov 2014 17:38:35 +0000
Subject: [PATCH] NVMe: Reduce divide operations
In-Reply-To: <20141121135000.GQ11522@wil.cx>
References: <546E6784.6000609@micron.com> <20141121135000.GQ11522@wil.cx>
Message-ID: <80B89753B40C5141A3E2D53FE7A2A8A9945CE63D@NTXBOIMBX02.micron.com>


> I don't think there's a compiler in the world that doesn't optimise 'x
> * 8' into 'x << 3' if the latter is cheaper.
> 
> Also, I think your nprps is now slightly larger than it used to be.
> Shouldn't it look like this?
> 
> 	unsigned nprps = size >> dev->page_shift;
> 	if (size & (page_size - 1))
> 		nprps++;
> 
> Let's imagine we're sending a misaligned 16k I/O.  We need 5 PRP
> entries, but the first one goes in the command, so we need to allocate
> enough space for 4 entries.  16k / 4k is 4, but your code says to add 1.
> 
> We can actually do slightly better than the original code in the case
> where we're sending a 2MB I/O.  The code in the driver today thinks we
> need a second page, but the last entry on the PRP page will be a PRP
> Entry, not a PRP List Entry.  So I think this is the right calculation:
> 
>  static int nvme_npages(unsigned size, struct nvme_dev *dev)  {
> -	unsigned nprps = DIV_ROUND_UP(size + dev->page_size, dev-
> >page_size);
> -	return DIV_ROUND_UP(8 * nprps, dev->page_size - 8);
> +	unsigned page_size = (1 << dev->page_shift);
> +	unsigned nprps = size >> dev->page_shift;
> +
> +	if (size & (page_size - 1))
> +		nprps++;
> +	if ((nprps * 8) <= page_size)
> +		return 1;
> +	return DIV_ROUND_UP(nprps * 8, page_size - 8);
>  }
> 
> (it still overestimates for I/Os on 2MB boundaries that are larger than
> 2MB, but I'm OK with that.  If somebody wants to come up with a neater
> calculation, feel free).

Seems reasonable to me.

> We could further optimise it by knowing that we need 0 pages if the I/O
> is <= 8k in size:
> 
> +	unsigned nprps,	page_size = (1 << dev->page_shift);
> +
> +	if (size <= page_size * 2)
> +		return 0;
> +	nprps = size >> dev->page_shift;
> +	if (size & (page_size - 1))
> ...
> 
> but I'm not sure that it's worth saving those 8 bytes.

Agreed.  I had originally thought of eliminating nvme_npages()
altogether in favor of a worst case padding for the iod but decided
to stick with the overall theme of saving bytes here and there.
