From: keith.busch@intel.com (Keith Busch)
Date: Mon, 17 Jul 2017 19:34:53 -0400
Subject: [bug report] nvme-pci: implement host memory buffer support
In-Reply-To: <20170717103404.z6krbj6bq34jyqtd@mwanda>
References: <20170717103404.z6krbj6bq34jyqtd@mwanda>
Message-ID: <20170717233453.GC1496@localhost.localdomain>

On Mon, Jul 17, 2017@01:34:04PM +0300, Dan Carpenter wrote:
> Hello Christoph Hellwig,
> 
> The patch 87ad72a59a38: "nvme-pci: implement host memory buffer
> support" from May 12, 2017, leads to the following static checker
> warning:
> 
> 	drivers/nvme/host/pci.c:1624 nvme_alloc_host_mem()
> 	warn: should we be adding 'chunk_size' of the min_t value?
> 
> drivers/nvme/host/pci.c
>   1602  static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
>   1603  {
>   1604          struct nvme_host_mem_buf_desc *descs;
>   1605          u32 chunk_size, max_entries;
>   1606          int i = 0;
>   1607          void **bufs;
>   1608          u64 size = 0, tmp;
>   1609  
>   1610          /* start big and work our way down */
>   1611          chunk_size = min(preferred, (u64)PAGE_SIZE << MAX_ORDER);
>   1612  retry:
>   1613          tmp = (preferred + chunk_size - 1);
>   1614          do_div(tmp, chunk_size);
>   1615          max_entries = tmp;
>   1616          descs = kcalloc(max_entries, sizeof(*descs), GFP_KERNEL);
>   1617          if (!descs)
>   1618                  goto out;
>   1619  
>   1620          bufs = kcalloc(max_entries, sizeof(*bufs), GFP_KERNEL);
>   1621          if (!bufs)
>   1622                  goto out_free_descs;
>   1623  
>   1624          for (size = 0; size < preferred; size += chunk_size) {
>                                                  ^^^^^^^^^^^^^^^^^^
> The static checker is saying that maybe we should be doing
> "size += len;" here.  On the last iteration through the loop, then len
> can be less than chunk_size.
> 
>   1625                  u32 len = min_t(u64, chunk_size, preferred - size);
>   1626                  dma_addr_t dma_addr;
>   1627  
>   1628                  bufs[i] = dma_alloc_attrs(dev->dev, len, &dma_addr, GFP_KERNEL,
>   1629                                  DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_NO_WARN);
>   1630                  if (!bufs[i])
>   1631                          break;
>   1632  
>   1633                  descs[i].addr = cpu_to_le64(dma_addr);
>   1634                  descs[i].size = cpu_to_le32(len / dev->ctrl.page_size);
>   1635                  i++;
>   1636          }
>   1637  
>   1638          if (!size || (min && size < min)) {
>   1639                  dev_warn(dev->ctrl.device,
>   1640                          "failed to allocate host memory buffer.\n");
>   1641                  goto out_free_bufs;
>   1642          }
>   1643  
>   1644          dev_info(dev->ctrl.device,
>   1645                  "allocated %lld MiB host memory buffer.\n",
>   1646                  size >> ilog2(SZ_1M));
>   1647          dev->nr_host_mem_descs = i;
>   1648          dev->host_mem_size = size;
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^
> Which means that we would be recording a slightly larger than actual
> size in ->host_mem_size.  I don't know the code well enough to say if
> this matters.

Thanks for the report. It looks like the driver could be telling the
device it has more memory reserved for it than reality. There is no HMB
descriptor for that memory, so we're safe from corrupting anything, but I
think a device may choose to return an error if the total HSIZE and list
entries' BSIZE don't add up. I'll send a patch to correct this.
