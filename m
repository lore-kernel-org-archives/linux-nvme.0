From: snitzer@redhat.com (Mike Snitzer)
Date: Mon, 12 Oct 2015 19:06:33 -0400
Subject: [PATCH 5/5] block: Inline blk_integrity in struct gendisk
In-Reply-To: <1444683912-7140-6-git-send-email-martin.petersen@oracle.com>
References: <B58D82457FDA0744A320A2FC5AC253B93CBE5758@fmsmsx104.amr.corp.intel.com>
 <1444683912-7140-1-git-send-email-martin.petersen@oracle.com>
 <1444683912-7140-6-git-send-email-martin.petersen@oracle.com>
Message-ID: <20151012230632.GA9918@redhat.com>

On Mon, Oct 12 2015 at  5:05pm -0400,
Martin K. Petersen <martin.petersen@oracle.com> wrote:

> Up until now the_integrity profile has been dynamically allocated and
> attached to struct gendisk after the disk has been made active.
> 
> This causes problems because NVMe devices need to register the profile
> prior to the partition table being read due to a mandatory metadata
> buffer requirement. In addition, DM goes through hoops to deal with
> preallocating, but not initializing integrity profiles.
> 
> Since the integrity profile is small (4 bytes + a pointer), Christoph
> suggested moving it to struct gendisk proper. This requires several
> changes:
> 
>  - Moving the blk_integrity definition to genhd.h.
> 
>  - Inlining blk_integrity in struct gendisk.
> 
>  - Removing the dynamic allocation code.
> 
>  - Adding helper functions which allow gendisk to set up and tear down
>    the integrity sysfs dir when a disk is added/deleted.
> 
>  - Adding a blk_integrity_revalidate() callback for updating the stable
>    pages bdi setting.
> 
>  - The calls that depend on whether a device has an integrity profile or
>    not now key off of the bi->profile pointer.
> 
>  - Simplifying the integrity support routines in DM (Mike Snitzer).
> 
> Signed-off-by: Martin K. Petersen <martin.petersen at oracle.com>
> Reported-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
> Cc: Mike Snitzer <snitzer at redhat.com>
> Cc: Dan Williams <dan.j.williams at intel.com>

Thanks Martin.

Please replace the Cc: Mike Snitzer <snitzer at redhat.com> above with
Signed-off-by: Mike Snitzer <snitzer at redhat.com>
