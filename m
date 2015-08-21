From: keith.busch@intel.com (Busch, Keith)
Date: Fri, 21 Aug 2015 23:47:31 +0000
Subject: [PATCH 5/5] block: Inline blk_integrity in struct gendisk
In-Reply-To: <1440103314-31610-6-git-send-email-martin.petersen@oracle.com>
References: <20150721120102.GB1654@infradead.org>
 <1440103314-31610-1-git-send-email-martin.petersen@oracle.com>
 <1440103314-31610-6-git-send-email-martin.petersen@oracle.com>
Message-ID: <B58D82457FDA0744A320A2FC5AC253B93CBE5758@fmsmsx104.amr.corp.intel.com>

On Thu, Aug 20 2015, Martin K. Petersen wrote:
> -static struct gendisk * dm_table_get_integrity_disk(struct dm_table *t,
> -						    bool match_all)
> +static struct gendisk * dm_table_get_integrity_disk(struct dm_table *t)
>  {
>  	struct list_head *devices = dm_table_get_devices(t);
>  	struct dm_dev_internal *dd = NULL;
> @@ -1030,11 +1026,7 @@ static struct gendisk * dm_table_get_integrity_disk(struct dm_table *t,
> 
>  	list_for_each_entry(dd, devices, list) {
>  		template_disk = dd->dm_dev->bdev->bd_disk;
> -		if (!blk_get_integrity(template_disk))
> -			goto no_integrity;


The blk_get_integrity check is necessary to prevent a kernel crash. Without it,
this function will return a template disk without integrity and later attempt to
register a NULL disk->integrity.

Otherwise, looks good! I will post the nvme driver patch removing the two pass
disk revalidation since that's no longer necessary with this good stuff.


> -		if (!match_all && !blk_integrity_is_initialized(template_disk))
> -			continue; /* skip uninitialized profiles */
> -		else if (prev_disk &&
> +		if (prev_disk &&
>  			 blk_integrity_compare(prev_disk, template_disk) < 0)
>  			goto no_integrity;
>  		prev_disk = template_disk;
