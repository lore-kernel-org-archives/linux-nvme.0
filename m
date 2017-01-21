From: matias@cnexlabs.com (=?UTF-8?Q?Matias_Bj=c3=b8rling?=)
Date: Sat, 21 Jan 2017 15:57:33 +0100
Subject: [bug report] lightnvm: add ioctls for vector I/Os
In-Reply-To: <20170121045645.GF15269@mwanda>
References: <20170121045645.GF15269@mwanda>
Message-ID: <3e41f316-1d7b-3685-d22e-96ac28ac48cb@cnexlabs.com>

On 01/21/2017 05:56 AM, Dan Carpenter wrote:
> Hello Matias Bj?rling,
> 
> The patch 3c6ff84da779: "lightnvm: add ioctls for vector I/Os" from
> Nov 16, 2016, leads to the following static checker warning:
> 
> 	drivers/nvme/host/lightnvm.c:695 nvme_nvm_submit_user_cmd()
> 	error: uninitialized symbol 'metadata_dma'.
> 
> 	drivers/nvme/host/lightnvm.c:704 nvme_nvm_submit_user_cmd()
> 	error: uninitialized symbol 'ppa_dma'.
> 
> drivers/nvme/host/lightnvm.c
>    627          if (ppa_buf && ppa_len) {
>                     ^^^^^^^^^^^^^^^^^^
> Here we assume that we can have a non-NULL buf and a zero len or the
> reverse where len is non-zero but ppa_buf is NULL.
> 
>    628                  ppa_list = dma_pool_alloc(dev->dma_pool, GFP_KERNEL, &ppa_dma);
>                                                                               ^^^^^^^
>    629                  if (!ppa_list) {
>    630                          ret = -ENOMEM;
>    631                          goto err_rq;
>    632                  }
>    633                  if (copy_from_user(ppa_list, (void __user *)ppa_buf,
>    634                                                  sizeof(u64) * (ppa_len + 1))) {
>    635                          ret = -EFAULT;
>    636                          goto err_ppa;
>    637                  }
>    638                  vcmd->ph_rw.spba = cpu_to_le64(ppa_dma);
>    639          } else {
>    640                  vcmd->ph_rw.spba = cpu_to_le64((uintptr_t)ppa_buf);
>    641          }
>    642  
>    643          if (ubuf && bufflen) {
>    644                  ret = blk_rq_map_user(q, rq, NULL, ubuf, bufflen, GFP_KERNEL);
>    645                  if (ret)
>    646                          goto err_ppa;
>    647                  bio = rq->bio;
>    648  
>    649                  if (meta_buf && meta_len) {
>                             ^^^^^^^^^^^^^^^^^^^^
> Same assumptions, that the one doesn't imply the other.
> 
>    650                          metadata = dma_pool_alloc(dev->dma_pool, GFP_KERNEL,
>    651                                                                  &metadata_dma);
>                                                                         ^^^^^^^^^^^^^
>    652                          if (!metadata) {
>    653                                  ret = -ENOMEM;
>    654                                  goto err_map;
>    655                          }
>    656  
>    657                          if (write) {
>    658                                  if (copy_from_user(metadata,
>    659                                                  (void __user *)meta_buf,
>    660                                                  meta_len)) {
>    661                                          ret = -EFAULT;
>    662                                          goto err_meta;
>    663                                  }
>    664                          }
>    665                          vcmd->ph_rw.metadata = cpu_to_le64(metadata_dma);
>    666                  }
>    667  
>    668                  if (!disk)
>    669                          goto submit;
>    670  
>    671                  bio->bi_bdev = bdget_disk(disk, 0);
>    672                  if (!bio->bi_bdev) {
>    673                          ret = -ENODEV;
>    674                          goto err_meta;
>    675                  }
>    676          }
>    677  
>    678  submit:
>    679          blk_execute_rq_nowait(q, NULL, rq, 0, nvme_nvm_end_user_vio);
>    680  
>    681          wait_for_completion_io(&wait);
>    682  
>    683          ret = nvme_error_status(rq->errors);
>    684          if (result)
>    685                  *result = rq->errors & 0x7ff;
>    686          if (status)
>    687                  *status = le64_to_cpu(nvme_req(rq)->result.u64);
>    688  
>    689          if (metadata && !ret && !write) {
>    690                  if (copy_to_user(meta_buf, (void *)metadata, meta_len))
>    691                          ret = -EFAULT;
>    692          }
>    693  err_meta:
>    694          if (meta_len)
>    695                  dma_pool_free(dev->dma_pool, metadata, metadata_dma);
>                                                                ^^^^^^^^^^^^
> 
> But here we assume that just testing meta_len is sufficient, that len
> implies buf is non-NULL.  Could we clean these up so they're consistent
> with each other?
> 
>    696  err_map:
>    697          if (bio) {
>    698                  if (disk && bio->bi_bdev)
>    699                          bdput(bio->bi_bdev);
>    700                  blk_rq_unmap_user(bio);
>    701          }
>    702  err_ppa:
>    703          if (ppa_len)
>    704                  dma_pool_free(dev->dma_pool, ppa_list, ppa_dma);
>                                                                ^^^^^^^
> Same.
> 
>    705  err_rq:
>    706          blk_mq_free_request(rq);
>    707  err_cmd:
>    708          return ret;
>    709  }
> 
> 
> regards,
> dan carpenter
> 

Hi Dan,

Good catch, will fix it. Thanks!

-Matias
