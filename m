From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Mon, 17 Jul 2017 13:34:04 +0300
Subject: [bug report] nvme-pci: implement host memory buffer support
Message-ID: <20170717103404.z6krbj6bq34jyqtd@mwanda>

Hello Christoph Hellwig,

The patch 87ad72a59a38: "nvme-pci: implement host memory buffer
support" from May 12, 2017, leads to the following static checker
warning:

	drivers/nvme/host/pci.c:1624 nvme_alloc_host_mem()
	warn: should we be adding 'chunk_size' of the min_t value?

drivers/nvme/host/pci.c
  1602  static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
  1603  {
  1604          struct nvme_host_mem_buf_desc *descs;
  1605          u32 chunk_size, max_entries;
  1606          int i = 0;
  1607          void **bufs;
  1608          u64 size = 0, tmp;
  1609  
  1610          /* start big and work our way down */
  1611          chunk_size = min(preferred, (u64)PAGE_SIZE << MAX_ORDER);
  1612  retry:
  1613          tmp = (preferred + chunk_size - 1);
  1614          do_div(tmp, chunk_size);
  1615          max_entries = tmp;
  1616          descs = kcalloc(max_entries, sizeof(*descs), GFP_KERNEL);
  1617          if (!descs)
  1618                  goto out;
  1619  
  1620          bufs = kcalloc(max_entries, sizeof(*bufs), GFP_KERNEL);
  1621          if (!bufs)
  1622                  goto out_free_descs;
  1623  
  1624          for (size = 0; size < preferred; size += chunk_size) {
                                                 ^^^^^^^^^^^^^^^^^^
The static checker is saying that maybe we should be doing
"size += len;" here.  On the last iteration through the loop, then len
can be less than chunk_size.

  1625                  u32 len = min_t(u64, chunk_size, preferred - size);
  1626                  dma_addr_t dma_addr;
  1627  
  1628                  bufs[i] = dma_alloc_attrs(dev->dev, len, &dma_addr, GFP_KERNEL,
  1629                                  DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_NO_WARN);
  1630                  if (!bufs[i])
  1631                          break;
  1632  
  1633                  descs[i].addr = cpu_to_le64(dma_addr);
  1634                  descs[i].size = cpu_to_le32(len / dev->ctrl.page_size);
  1635                  i++;
  1636          }
  1637  
  1638          if (!size || (min && size < min)) {
  1639                  dev_warn(dev->ctrl.device,
  1640                          "failed to allocate host memory buffer.\n");
  1641                  goto out_free_bufs;
  1642          }
  1643  
  1644          dev_info(dev->ctrl.device,
  1645                  "allocated %lld MiB host memory buffer.\n",
  1646                  size >> ilog2(SZ_1M));
  1647          dev->nr_host_mem_descs = i;
  1648          dev->host_mem_size = size;
                ^^^^^^^^^^^^^^^^^^^^^^^^^
Which means that we would be recording a slightly larger than actual
size in ->host_mem_size.  I don't know the code well enough to say if
this matters.

  1649          dev->host_mem_descs = descs;
  1650          dev->host_mem_desc_bufs = bufs;
  1651          return 0;
  1652  
  1653  out_free_bufs:
  1654          while (--i >= 0) {
  1655                  size_t size = le32_to_cpu(descs[i].size) * dev->ctrl.page_size;
  1656  
  1657                  dma_free_coherent(dev->dev, size, bufs[i],
  1658                                  le64_to_cpu(descs[i].addr));
  1659          }
  1660  
  1661          kfree(bufs);
  1662  out_free_descs:
  1663          kfree(descs);
  1664  out:
  1665          /* try a smaller chunk size if we failed early */
  1666          if (chunk_size >= PAGE_SIZE * 2 && (i == 0 || size < min)) {
  1667                  chunk_size /= 2;
  1668                  goto retry;
  1669          }
  1670          dev->host_mem_descs = NULL;
  1671          return -ENOMEM;
  1672  }

regards,
dan carpenter
