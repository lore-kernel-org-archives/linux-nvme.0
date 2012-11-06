From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 6 Nov 2012 11:15:09 -0500
Subject: [PATCH] NVMe: Add discard support for capable devices
In-Reply-To: <20121106161008.GA1736@linux.intel.com>
References: <1343933944-32726-1-git-send-email-keith.busch@intel.com>
 <20121106161008.GA1736@linux.intel.com>
Message-ID: <20121106161509.GU4244@linux.intel.com>

On Tue, Nov 06, 2012@11:10:08AM -0500, Matthew Wilcox wrote:
> Although ... now I'm looking at the failure path in
> nvme_submit_bio_queue(), isn't it the case that we'll leak cmdids if
> nvme_map_bio() fails?  And in this case?  So I think we also need:
> 
> + free_cmdid:
> +	free_cmdid(nvmeq, cmdid, NULL);
>   free_iod:	
> 
> And then change the 'goto free_iod' to 'goto free_cmdid'.

Never mind; just got to the patch where you fixed this :-)
