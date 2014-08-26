From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 26 Aug 2014 08:32:42 -0400
Subject: [PATCH] block: Fix dev_t liftime allocations
In-Reply-To: <1408999975-9976-1-git-send-email-keith.busch@intel.com>
References: <1408999975-9976-1-git-send-email-keith.busch@intel.com>
Message-ID: <20140826123242.GC3285@linux.intel.com>

On Mon, Aug 25, 2014@02:52:55PM -0600, Keith Busch wrote:
> Since the partition's release may be invoked from call_rcu's soft-irq
> context, the ext_dev_idr's mutex had to be replaced with a spinlock so
> as not so sleep.

> @@ -420,9 +420,9 @@ int blk_alloc_devt(struct hd_struct *part, dev_t *devt)
>  	}
>  
>  	/* allocate ext devt */
> -	mutex_lock(&ext_devt_mutex);
> +	spin_lock(&ext_devt_lock);
>  	idx = idr_alloc(&ext_devt_idr, part, 0, NR_EXT_DEVT, GFP_KERNEL);
> -	mutex_unlock(&ext_devt_mutex);
> +	spin_unlock(&ext_devt_lock);

Can't use GFP_KERNEL if we're protected with a spinlock.  See the comment
in lib/idr.c about idr_preload:

+	idr_preload(GFP_KERNEL);
-	mutex_lock(&ext_devt_mutex);
+	spin_lock(&ext_devt_lock);
-	idx = idr_alloc(&ext_devt_idr, part, 0, NR_EXT_DEVT, GFP_KERNEL);
+	idx = idr_alloc(&ext_devt_idr, part, 0, NR_EXT_DEVT, GFP_NOWAIT);
-	mutex_unlock(&ext_devt_mutex);
+	spin_unlock(&ext_devt_lock);
