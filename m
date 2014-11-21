From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 21 Nov 2014 08:50:00 -0500
Subject: [PATCH] NVMe: Reduce divide operations
In-Reply-To: <546E6784.6000609@micron.com>
References: <546E6784.6000609@micron.com>
Message-ID: <20141121135000.GQ11522@wil.cx>

On Thu, Nov 20, 2014@02:13:24PM -0800, Sam Bradshaw wrote:
> There are several expensive divide operations in the submit and 
> completion paths that can be converted to less expensive arithmetic 
> and logical operations.  Profiling shows significant drops in time 
> spent in nvme_alloc_iod() under common workloads as a result of this 
> change.

OK ... but I think you've taken this a bit far.

>  static int nvme_npages(unsigned size, struct nvme_dev *dev)
>  {
> -	unsigned nprps = DIV_ROUND_UP(size + dev->page_size, dev->page_size);
> -	return DIV_ROUND_UP(8 * nprps, dev->page_size - 8);
> +	unsigned page_size = (1 << dev->page_shift);
> +	unsigned nprps = (size >> dev->page_shift) + 1;
> +
> +	if (size & (page_size - 1))
> +		nprps++;
> +	if ((nprps << 3) < (page_size - 8))
> +		return 1;
> +	return DIV_ROUND_UP(nprps << 3, page_size - 8);
>  }

I don't think there's a compiler in the world that doesn't optimise
'x * 8' into 'x << 3' if the latter is cheaper.

Also, I think your nprps is now slightly larger than it used to be.
Shouldn't it look like this?

	unsigned nprps = size >> dev->page_shift;
	if (size & (page_size - 1))
		nprps++;

Let's imagine we're sending a misaligned 16k I/O.  We need 5 PRP entries,
but the first one goes in the command, so we need to allocate enough
space for 4 entries.  16k / 4k is 4, but your code says to add 1.

We can actually do slightly better than the original code in the case
where we're sending a 2MB I/O.  The code in the driver today thinks we
need a second page, but the last entry on the PRP page will be a PRP
Entry, not a PRP List Entry.  So I think this is the right calculation:

 static int nvme_npages(unsigned size, struct nvme_dev *dev)
 {
-	unsigned nprps = DIV_ROUND_UP(size + dev->page_size, dev->page_size);
-	return DIV_ROUND_UP(8 * nprps, dev->page_size - 8);
+	unsigned page_size = (1 << dev->page_shift);
+	unsigned nprps = size >> dev->page_shift;
+
+	if (size & (page_size - 1))
+		nprps++;
+	if ((nprps * 8) <= page_size)
+		return 1;
+	return DIV_ROUND_UP(nprps * 8, page_size - 8);
 }

(it still overestimates for I/Os on 2MB boundaries that are larger than
2MB, but I'm OK with that.  If somebody wants to come up with a neater
calculation, feel free).

We could further optimise it by knowing that we need 0 pages if the I/O
is <= 8k in size:

+	unsigned nprps,	page_size = (1 << dev->page_shift);
+
+	if (size <= page_size * 2)
+		return 0;
+	nprps = size >> dev->page_shift;
+	if (size & (page_size - 1))
...

but I'm not sure that it's worth saving those 8 bytes.
