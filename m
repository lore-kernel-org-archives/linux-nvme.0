From: jmoyer@redhat.com (Jeff Moyer)
Date: Fri, 13 May 2016 13:33:10 -0400
Subject: [RFC 1/2] block: allow other bd i_node flags when DAX is disabled
In-Reply-To: <CAA9_cmeaa6qGKeDfRXWm-BkNtw0hJrbc9kqsLfOEJ2ZE-Mubgw@mail.gmail.com>
 (Dan Williams's message of "Fri, 13 May 2016 06:25:22 -0700")
References: <1463074986-3070-1-git-send-email-jonathan.derrick@intel.com>
 <1463074986-3070-2-git-send-email-jonathan.derrick@intel.com>
 <CAA9_cmeaa6qGKeDfRXWm-BkNtw0hJrbc9kqsLfOEJ2ZE-Mubgw@mail.gmail.com>
Message-ID: <x49d1op982x.fsf@segfault.boston.devel.redhat.com>

Dan Williams <dan.j.williams at intel.com> writes:

> On Thu, May 12, 2016 at 10:43 AM, Jon Derrick
> <jonathan.derrick@intel.com> wrote:
>> When DAX is not compiled into the kernel or the device does not support
>> direct-access, the block device file's inode flags are fully cleared.
>> This patch changes it to only clear the S_DAX flag when DAX is disabled.
>>
>> This reverts to i_flags behavior prior to
>> bbab37ddc20bae4709bca8745c128c4f46fe63c5
>>
>> Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
>> ---
>>  fs/block_dev.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>> index 20a2c02..d4fa725 100644
>> --- a/fs/block_dev.c
>> +++ b/fs/block_dev.c
>> @@ -1208,7 +1208,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
>>                 if (IS_ENABLED(CONFIG_BLK_DEV_DAX) && disk->fops->direct_access)
>>                         bdev->bd_inode->i_flags = S_DAX;
>>                 else
>> -                       bdev->bd_inode->i_flags = 0;
>> +                       bdev->bd_inode->i_flags &= ~S_DAX;
>
> Setting S_DAX is atomic, but the above change makes it a non-atomic
> read-modify-write.  Do we need exclusion / locking in this path?

First, I don't see how you'd ever get a read-modify-write here, as S_DAX
surely won't ever be set if direct_access isn't supported.  Second,
there is existing code that already does this very thing.  See further
down in __blkdev_get:

                        if (!ret) {
                                bd_set_size(bdev,(loff_t)get_capacity(disk)<<9);
                                if (!blkdev_dax_capable(bdev))
                                        bdev->bd_inode->i_flags &= ~S_DAX;
                        }

What relies on S_DAX being set or cleared atomically?

Cheers,
Jeff
