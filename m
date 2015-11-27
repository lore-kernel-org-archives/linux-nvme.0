From: ww.tao0320@gmail.com (Wenwei Tao)
Date: Fri, 27 Nov 2015 20:04:00 +0800
Subject: [PATCH v2 1/3] lightnvm: missing nvm_lock acquire
In-Reply-To: <565814E8.9020408@bjorling.me>
References: <1448597384-27976-1-git-send-email-ww.tao0320@gmail.com>
 <1448597384-27976-2-git-send-email-ww.tao0320@gmail.com>
 <565814E8.9020408@bjorling.me>
Message-ID: <CACygaLAW23EbxN2Sw33K3Zzyq1P=mM4ouUq6SSxV=_2A0HJJjg@mail.gmail.com>

Hi Matias
Previous version patch miss acquire lock before find supported manager
in nvm_init().
And find supported manager code is duplicated in nvm_init() and
nvm_create_target(), we may move it into a function to make the code
more clean.
And find supported manager may blocked while holding the lock, this is
not good.

2015-11-27 16:31 GMT+08:00 Matias Bj?rling <m at bjorling.me>:
> On 11/27/2015 05:09 AM, Wenwei Tao wrote:
>>
>> To avoid race conditions, traverse dev, media manager,
>> and targeet lists and also register, unregister entries
>> to/from them, should be always under the nvm_lock control.
>>
>> Signed-off-by: Wenwei Tao <ww.tao0320 at gmail.com>
>> ---
>>   drivers/lightnvm/core.c | 73
>> +++++++++++++++++++++++++------------------------
>>   1 file changed, 38 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
>> index 5178645..071a3e4 100644
>> --- a/drivers/lightnvm/core.c
>> +++ b/drivers/lightnvm/core.c
>> @@ -123,6 +123,24 @@ void nvm_unregister_mgr(struct nvmm_type *mt)
>>   }
>>   EXPORT_SYMBOL(nvm_unregister_mgr);
>>
>> +/* register with device with a supported manager */
>> +static int register_mgr(struct nvm_dev *dev)
>> +{
>> +       struct nvmm_type *mt;
>> +       int ret = 0;
>> +
>> +       list_for_each_entry(mt, &nvm_mgrs, list) {
>> +               ret = mt->register_mgr(dev);
>> +               if (ret > 0) {
>> +                       dev->mt = mt;
>> +                       break; /* successfully initialized */
>> +               }
>> +       }
>> +       if (!ret)
>> +               pr_info("nvm: no compatible nvm manager found.\n");
>> +       return ret;
>> +}
>> +
>>   static struct nvm_dev *nvm_find_nvm_dev(const char *name)
>>   {
>>         struct nvm_dev *dev;
>> @@ -221,7 +239,6 @@ static void nvm_free(struct nvm_dev *dev)
>>
>>   static int nvm_init(struct nvm_dev *dev)
>>   {
>> -       struct nvmm_type *mt;
>>         int ret = -EINVAL;
>>
>>         if (!dev->q || !dev->ops)
>> @@ -251,22 +268,13 @@ static int nvm_init(struct nvm_dev *dev)
>>                 pr_err("nvm: could not initialize core structures.\n");
>>                 goto err;
>>         }
>> -
>> -       /* register with device with a supported manager */
>> -       list_for_each_entry(mt, &nvm_mgrs, list) {
>> -               ret = mt->register_mgr(dev);
>> -               if (ret < 0)
>> -                       goto err; /* initialization failed */
>> -               if (ret > 0) {
>> -                       dev->mt = mt;
>> -                       break; /* successfully initialized */
>> -               }
>> -       }
>> -
>> -       if (!ret) {
>> -               pr_info("nvm: no compatible manager found.\n");
>> +       down_write(&nvm_lock);
>> +       ret = register_mgr(dev);
>> +       up_write(&nvm_lock);
>> +       if (ret < 0)
>> +               goto err;
>> +       if (!ret)
>>                 return 0;
>> -       }
>>
>>         pr_info("nvm: registered %s [%u/%u/%u/%u/%u/%u]\n",
>>                         dev->name, dev->sec_per_pg, dev->nr_planes,
>> @@ -335,18 +343,18 @@ EXPORT_SYMBOL(nvm_register);
>>
>>   void nvm_unregister(char *disk_name)
>>   {
>> +       down_write(&nvm_lock);
>>         struct nvm_dev *dev = nvm_find_nvm_dev(disk_name);
>>
>>         if (!dev) {
>>                 pr_err("nvm: could not find device %s to unregister\n",
>>
>> disk_name);
>> +               up_write(&nvm_lock);
>>                 return;
>>         }
>>
>> -       down_write(&nvm_lock);
>>         list_del(&dev->devices);
>>         up_write(&nvm_lock);
>> -
>>         nvm_exit(dev);
>>         kfree(dev);
>>   }
>> @@ -361,38 +369,30 @@ static int nvm_create_target(struct nvm_dev *dev,
>>   {
>>         struct nvm_ioctl_create_simple *s = &create->conf.s;
>>         struct request_queue *tqueue;
>> -       struct nvmm_type *mt;
>>         struct gendisk *tdisk;
>>         struct nvm_tgt_type *tt;
>>         struct nvm_target *t;
>>         void *targetdata;
>>         int ret = 0;
>>
>> +       down_write(&nvm_lock);
>>         if (!dev->mt) {
>> -               /* register with device with a supported NVM manager */
>> -               list_for_each_entry(mt, &nvm_mgrs, list) {
>> -                       ret = mt->register_mgr(dev);
>> -                       if (ret < 0)
>> -                               return ret; /* initialization failed */
>> -                       if (ret > 0) {
>> -                               dev->mt = mt;
>> -                               break; /* successfully initialized */
>> -                       }
>> -               }
>> -
>> -               if (!ret) {
>> -                       pr_info("nvm: no compatible nvm manager
>> found.\n");
>> -                       return -ENODEV;
>> +               ret = register_mgr(dev);
>> +               if (!ret)
>> +                       ret = -ENODEV;
>> +               if (ret < 0) {
>> +                       up_write(&nvm_lock);
>> +                       return ret;
>>                 }
>>         }
>>
>>         tt = nvm_find_target_type(create->tgttype);
>>         if (!tt) {
>>                 pr_err("nvm: target type %s not found\n",
>> create->tgttype);
>> +               up_write(&nvm_lock);
>>                 return -EINVAL;
>>         }
>>
>> -       down_write(&nvm_lock);
>>         list_for_each_entry(t, &dev->online_targets, list) {
>>                 if (!strcmp(create->tgtname, t->disk->disk_name)) {
>>                         pr_err("nvm: target name already exists.\n");
>> @@ -475,8 +475,9 @@ static int __nvm_configure_create(struct
>> nvm_ioctl_create *create)
>>   {
>>         struct nvm_dev *dev;
>>         struct nvm_ioctl_create_simple *s;
>> -
>> +       down_write(&nvm_lock);
>>         dev = nvm_find_nvm_dev(create->dev);
>> +       up_write(&nvm_lock);
>>         if (!dev) {
>>                 pr_err("nvm: device not found\n");
>>                 return -EINVAL;
>> @@ -535,7 +536,9 @@ static int nvm_configure_show(const char *val)
>>                 return -EINVAL;
>>         }
>>
>> +       down_write(&nvm_lock);
>>         dev = nvm_find_nvm_dev(devname);
>> +       up_write(&nvm_lock);
>>         if (!dev) {
>>                 pr_err("nvm: device not found\n");
>>                 return -EINVAL;
>>
>
> Thanks Wei. I applied the previous version of the patch.
>
> You can see the patches I have queued for upstream in the for-next at
> https://github.com/OpenChannelSSD/linux/commits/for-next
