From: dan.j.williams@intel.com (Dan Williams)
Date: Fri, 13 May 2016 06:25:22 -0700
Subject: [RFC 1/2] block: allow other bd i_node flags when DAX is disabled
In-Reply-To: <1463074986-3070-2-git-send-email-jonathan.derrick@intel.com>
References: <1463074986-3070-1-git-send-email-jonathan.derrick@intel.com>
 <1463074986-3070-2-git-send-email-jonathan.derrick@intel.com>
Message-ID: <CAA9_cmeaa6qGKeDfRXWm-BkNtw0hJrbc9kqsLfOEJ2ZE-Mubgw@mail.gmail.com>

On Thu, May 12, 2016 at 10:43 AM, Jon Derrick
<jonathan.derrick@intel.com> wrote:
> When DAX is not compiled into the kernel or the device does not support
> direct-access, the block device file's inode flags are fully cleared.
> This patch changes it to only clear the S_DAX flag when DAX is disabled.
>
> This reverts to i_flags behavior prior to
> bbab37ddc20bae4709bca8745c128c4f46fe63c5
>
> Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
> ---
>  fs/block_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 20a2c02..d4fa725 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1208,7 +1208,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
>                 if (IS_ENABLED(CONFIG_BLK_DEV_DAX) && disk->fops->direct_access)
>                         bdev->bd_inode->i_flags = S_DAX;
>                 else
> -                       bdev->bd_inode->i_flags = 0;
> +                       bdev->bd_inode->i_flags &= ~S_DAX;

Setting S_DAX is atomic, but the above change makes it a non-atomic
read-modify-write.  Do we need exclusion / locking in this path?
