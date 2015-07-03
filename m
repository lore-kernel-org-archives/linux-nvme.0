From: wangyijing@huawei.com (Yijing Wang)
Date: Fri, 3 Jul 2015 09:24:59 +0800
Subject: Question about NVMe share I/O
In-Reply-To: <alpine.LNX.2.00.1507021428370.15930@localhost.lm.intel.com>
References: <1433779695-15866-1-git-send-email-keith.busch@intel.com>
 <1433779695-15866-3-git-send-email-keith.busch@intel.com>
 <20150611104033.GA21107@infradead.org>
 <alpine.LNX.2.00.1506111410500.15930@localhost.lm.intel.com>
 <20150611152348.GB1292@infradead.org> <55935989.70809@huawei.com>
 <alpine.LNX.2.00.1507011612070.15930@localhost.lm.intel.com>
 <559531A9.5040704@huawei.com>
 <alpine.LNX.2.00.1507021428370.15930@localhost.lm.intel.com>
Message-ID: <5595E46B.8030204@huawei.com>

On 2015/7/2 22:42, Keith Busch wrote:
> On Thu, 2 Jul 2015, Yijing Wang wrote:
>> Most of the time, the Host and NVMe work fine, we could read/write the same
>> nvme by different Host, but if we do test which insmod and rmmod nvme
>> driver(we reworked) in both hosts, a system crash would happen, Host A,
>> because submit queue id in completion is 2.
> 
> Could you share the source to your "reworked" driver?
> 
> 

It has a lot changes, I diff the new reworked driver and the default nvme driver in linux 3.10

The main changes focus on following:

1?Private DMA alloc functions, we use it to alloc dma resource, and its address is global across the hosts,
   so when NVMe controller try to transmit DMA packets, the PCIe interconnect fabric could route the dma to
   correct host by its dma address;

2?Private MSI-X enable functions, because default msix setup the local msi-x address, so we need to update it
   to global dma address, which just add a global address offset.

3?Use non-used NVMe bar4 as the communication way to map host nvme admin queue to manager OS, so we could pass
   the host admin command to manager OS, and manager OS is responsible for delivering the admin command to physical
   nvme controller;

4?Request nvme IO queues from manger OS which return the free IO queue id, then host would request to create the allocated IO queues.



[yijing at localhost linux-3.10-new]$ diff drivers/block/nvme-host.c drivers/block/nvme-core.c
44d43
< #include <linux/msi.h>
61d59
< static dma_addr_t plx_dma_addr_offset = 0;
63,64d60
< static void nvme_post_admin_cmd(struct nvme_dev *dev,
< 		struct nvme_command *c);
90,163d85
< static void * nvme_dma_alloc_coherent(struct device *dev,
< 		size_t size, dma_addr_t *dma_handle, gfp_t gfp)
< {
< 	void *mem;
<
< 	mem = dma_alloc_coherent(dev, size, dma_handle, gfp);
< 	/* Add dma address offset for nvme device in the host side */
< 	*dma_handle += plx_dma_addr_offset;
< 	return mem;
< }
<
< static void nvme_dma_free_coherent(struct device *dev,
< 		size_t size, void *vaddr, dma_addr_t bus)
< {
< 	dma_free_coherent(dev, size, vaddr, bus - plx_dma_addr_offset);
< }
<
< static int nvme_dma_map_sg(struct device *dev, struct scatterlist *sg,
< 		int nents, enum dma_data_direction dir)
< {
< 	int result, i;
< 	struct scatterlist *s;
< 	
< 	result = dma_map_sg(dev, sg, nents, dir);
< 	for_each_sg(sg, s, nents, i)
< 		s->dma_address += plx_dma_addr_offset;
< 	
< 	return result;
< }
<
< static void nvme_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
< 		int nents, enum dma_data_direction dir)
< {
< 	int i;
< 	struct scatterlist *s;
< 	
< 	for_each_sg(sg, s, nents, i)
< 		s->dma_address -= plx_dma_addr_offset;
<
< 	dma_unmap_sg(dev, sg, nents, dir);
< }
<
< /* NVMe private MSI interfaces */
< static int nvme_enable_msix(struct nvme_dev *dev, int nvec)
< {
< 	int ret;
< 	void __iomem *base;
< 	struct msi_desc *entry;
<
< 	ret = pci_enable_msix(dev->pci_dev, dev->entry, nvec);
< 	if (!ret) {
< 		list_for_each_entry(entry, &dev->pci_dev->msi_list, list) {
< 			base = entry->mask_base +
< 				entry->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE;
<
< 			entry->msg.address_lo += plx_dma_addr_offset & 0xffffffff;
< 			entry->msg.address_hi += plx_dma_addr_offset >> 32;
<
< 			mask_msix_entry(dev->pci_dev, entry->msi_attrib.entry_nr,
< 					entry->mask_base + entry->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE
< 					+ PCI_MSIX_ENTRY_VECTOR_CTRL, 1);
< 			/* Flush the updated MSI address */
< 			writel(entry->msg.address_lo, base + PCI_MSIX_ENTRY_LOWER_ADDR);
< 			writel(entry->msg.address_hi, base + PCI_MSIX_ENTRY_UPPER_ADDR);
<
< 			mask_msix_entry(dev->pci_dev, entry->msi_attrib.entry_nr,
< 					entry->mask_base + entry->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE
< 					+ PCI_MSIX_ENTRY_VECTOR_CTRL, 0);
< 		}	
< 	}
<
< 	return ret;
< }
<
289d210
< 	pr_info("%s: nvmeq %p, free cmdid %d\n", __func__, nvmeq, cmdid);
308c229
< 	return dev->queues[get_cpu()];
---
> 	return dev->queues[get_cpu() + 1];
398c319
< 		nvme_dma_unmap_sg(&dev->pci_dev->dev, iod->sg, iod->nents,
---
> 		dma_unmap_sg(&dev->pci_dev->dev, iod->sg, iod->nents,
630c551
< 	if (nvme_dma_map_sg(nvmeq->q_dmadev, iod->sg, iod->nents, dma_dir) == 0)
---
> 	if (dma_map_sg(nvmeq->q_dmadev, iod->sg, iod->nents, dma_dir) == 0)
699d619
< 	pr_info("%s: nvmeq %p, alloc cmdid %d\n", __func__, nvmeq, cmdid);
734d653
< 	pr_info("%s: nvmeq %p, alloc cmdid %d\n", __func__, nvmeq, cmdid);
832,837d750
< 		if (!fn) {
< 			pr_err("%s: nvmeq %p, result %d, sq_head %d,"
< 					"sq_id %d, command id %d, status %d\n",
< 					__func__, nvmeq, cqe.result, cqe.sq_head,
< 					cqe.sq_id, cqe.command_id, cqe.status);
< 		}
915d827
< 	pr_info("%s: nvmeq %p, alloc cmdid %d\n", __func__, nvmeq, cmdid);
941c853
< 	u32 val;
---
> 	int status;
948,950c860,862
< 	nvme_post_admin_cmd(dev, &c);
< 	writel(NVME_DATA_VALID, dev->bar4);
< 	pci_read_config_dword(dev->pci_dev, 0x100, &val);
---
> 	status = nvme_submit_admin_cmd(dev, &c, NULL);
> 	if (status)
> 		return -EIO;
956a869
> 	int status;
959d871
< 	u32 val;
968,972c880,883
< 	pr_debug("%s: cq qid %d, prp1 0x%llx, vector %d\n",
< 			__func__, qid, nvmeq->cq_dma_addr, nvmeq->cq_vector);
< 	nvme_post_admin_cmd(dev, &c);
< 	writel(NVME_DATA_VALID, dev->bar4);
< 	pci_read_config_dword(dev->pci_dev, 0x100, &val);
---
>
> 	status = nvme_submit_admin_cmd(dev, &c, NULL);
> 	if (status)
> 		return -EIO;
978a890
> 	int status;
981d892
< 	u32 val;
991,995c902,904
< 	pr_debug("%s: sq qid %d, prp1 0x%llx\n",
< 			__func__, qid, nvmeq->sq_dma_addr);
< 	nvme_post_admin_cmd(dev, &c);
< 	writel(NVME_DATA_VALID, dev->bar4);
< 	pci_read_config_dword(dev->pci_dev, 0x100, &val);
---
> 	status = nvme_submit_admin_cmd(dev, &c, NULL);
> 	if (status)
> 		return -EIO;
1009,1083d917
< static void nvme_post_admin_cmd(struct nvme_dev *dev,
< 		struct nvme_command *c)
< {
< 	int i;
< 	u32 *addr = (u32 *)c;
<
< 	/* nvme admin command is always 64 bytes */
< 	for (i = 0; i < 16; i++) {
< 		writel(*addr, dev->bar4 + 8 + i * 4);
< 		addr++;
< 	}
< 	/* Tag it's a nvme admin command */
< 	writel(NVME_ADMIN_CMD, dev->bar4 + 4);
< }
<
< static int nvme_recv_data_back(struct nvme_dev *dev,
< 		void *mem, size_t size)
< {
< 	u32 *addr = (u32 *)mem;
< 	int count = 30, i;
< 	u32 val;
<
< 	while (count--) {
< 		if (readl(dev->bar4 + NVME_RETURN_OFFSET) ==
< 				NVME_RETURN_READY) {
< 			writel(0x0, dev->bar4 + NVME_RETURN_OFFSET);
<
< 			val = readl(dev->bar4 + NVME_RETURN_OFFSET + 4);
< 			writel(0x0, dev->bar4 + NVME_RETURN_OFFSET + 4);
< 			if (val) {
< 				/* admin process fail */
< 				dev_warn(&dev->pci_dev->dev,
< 						"admin command fail\n");
< 				return val;
< 			}
<
< 			for (i = 0; i < size; i += 4) {
< 				*addr = readl(dev->bar4 + NVME_RETURN_OFFSET + 8 + i);
< 				addr++;
< 			}
< 			break;
< 		}
< 		msleep(10);
< 	}
< 	
< 	if (!count) {
< 		dev_warn(&dev->pci_dev->dev,
< 				"recv admin command data back timeout\n");
< 		return -1;
< 	}
<
< 	return 0;
< }
<
< int nvme_identify_plx(struct nvme_dev *dev, unsigned nsid, unsigned cns,
< 							void *mem)
< {
< 	struct nvme_command c;
< 	int val;
<
< 	memset(&c, 0, sizeof(c));
< 	c.identify.opcode = nvme_admin_identify;
< 	c.identify.nsid = cpu_to_le32(nsid);
< 	/* prp1 is not necessary, it will be replaced
< 	 * with MCPU dma address in PLX MGR
< 	 */
< 	c.identify.prp1 = cpu_to_le64(0x12345678);
< 	c.identify.cns = cpu_to_le32(cns);
< 	
< 	nvme_post_admin_cmd(dev, &c);
< 	writel(NVME_DATA_VALID, dev->bar4);
< 	pci_read_config_dword(dev->pci_dev, 0x100, &val);
< 	return nvme_recv_data_back(dev, mem, 4096);
< }
<
1112,1133d945
< int nvme_get_features_plx(struct nvme_dev *dev, unsigned fid, unsigned nsid,
< 					void *mem, u32 *result)
< {
< 	struct nvme_command c;
< 	int val;
<
< 	memset(&c, 0, sizeof(c));
< 	c.features.opcode = nvme_admin_get_features;
< 	c.features.nsid = cpu_to_le32(nsid);
< 	/* prp1 is not necessary, it will be replaced
< 	 * with MCPU dma address in PLX MGR, so
< 	 * 0x12345678 is meaningless here.
< 	 */
< 	c.features.prp1 = cpu_to_le64(0x12345678);
< 	c.features.fid = cpu_to_le32(fid);
< 	nvme_post_admin_cmd(dev, &c);
< 	writel(NVME_DATA_VALID, dev->bar4);
< 	pci_read_config_dword(dev->pci_dev, 0x100, &val);
<
< 	return nvme_recv_data_back(dev, mem, 4096);
< }
<
1138d949
< 	u32 val;
1146,1150c957
< 	nvme_post_admin_cmd(dev, &c);
< 	writel(NVME_DATA_VALID, dev->bar4);
< 	pci_read_config_dword(dev->pci_dev, 0x100, &val);
<
< 	return nvme_recv_data_back(dev, result, 4);
---
> 	return nvme_submit_admin_cmd(dev, &c, result);
1184c991
< 	nvme_dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
---
> 	dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
1186c993
< 	nvme_dma_free_coherent(nvmeq->q_dmadev, SQ_SIZE(nvmeq->q_depth),
---
> 	dma_free_coherent(nvmeq->q_dmadev, SQ_SIZE(nvmeq->q_depth),
1194c1001
< 	int vector = dev->entry[nvmeq->cq_vector - dev->first + 1].vector;
---
> 	int vector = dev->entry[nvmeq->cq_vector].vector;
1207,1209c1014,1018
< 	/* Hosts don't have admin queue,the IO queues' index are from 0 */
< 	adapter_delete_sq(dev, qid + dev->first);
< 	adapter_delete_cq(dev, qid + dev->first);
---
> 	/* Don't tell the adapter to delete the admin queue */
> 	if (qid) {
> 		adapter_delete_sq(dev, qid);
> 		adapter_delete_cq(dev, qid);
> 	}
1224c1033
< 	nvmeq->cqes = nvme_dma_alloc_coherent(dmadev, CQ_SIZE(depth),
---
> 	nvmeq->cqes = dma_alloc_coherent(dmadev, CQ_SIZE(depth),
1230c1039
< 	nvmeq->sq_cmds = nvme_dma_alloc_coherent(dmadev, SQ_SIZE(depth),
---
> 	nvmeq->sq_cmds = dma_alloc_coherent(dmadev, SQ_SIZE(depth),
1250c1059
< 	nvme_dma_free_coherent(dmadev, CQ_SIZE(depth), (void *)nvmeq->cqes,
---
> 	dma_free_coherent(dmadev, CQ_SIZE(depth), (void *)nvmeq->cqes,
1265,1266c1074,1075
< 	return request_irq(dev->entry[nvmeq->cq_vector - dev->first + 1].vector,
< 			nvme_irq, IRQF_DISABLED | IRQF_SHARED, name, nvmeq);
---
> 	return request_irq(dev->entry[nvmeq->cq_vector].vector, nvme_irq,
> 				IRQF_DISABLED | IRQF_SHARED, name, nvmeq);
1297c1106
< 	nvme_dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
---
> 	dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
1299c1108
< 	nvme_dma_free_coherent(nvmeq->q_dmadev, SQ_SIZE(nvmeq->q_depth),
---
> 	dma_free_coherent(nvmeq->q_dmadev, SQ_SIZE(nvmeq->q_depth),
1305d1113
< #if 0
1346c1154,1200
< #endif
---
>
> static int nvme_configure_admin_queue(struct nvme_dev *dev)
> {
> 	int result;
> 	u32 aqa;
> 	u64 cap = readq(&dev->bar->cap);
> 	struct nvme_queue *nvmeq;
>
> 	dev->dbs = ((void __iomem *)dev->bar) + 4096;
> 	dev->db_stride = NVME_CAP_STRIDE(cap);
>
> 	result = nvme_disable_ctrl(dev, cap);
> 	if (result < 0)
> 		return result;
>
> 	nvmeq = nvme_alloc_queue(dev, 0, 64, 0);
> 	if (!nvmeq)
> 		return -ENOMEM;
>
> 	aqa = nvmeq->q_depth - 1;
> 	aqa |= aqa << 16;
>
> 	dev->ctrl_config = NVME_CC_ENABLE | NVME_CC_CSS_NVM;
> 	dev->ctrl_config |= (PAGE_SHIFT - 12) << NVME_CC_MPS_SHIFT;
> 	dev->ctrl_config |= NVME_CC_ARB_RR | NVME_CC_SHN_NONE;
> 	dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
>
> 	writel(aqa, &dev->bar->aqa);
> 	writeq(nvmeq->sq_dma_addr, &dev->bar->asq);
> 	writeq(nvmeq->cq_dma_addr, &dev->bar->acq);
> 	writel(dev->ctrl_config, &dev->bar->cc);
>
> 	result = nvme_enable_ctrl(dev, cap);
> 	if (result)
> 		goto free_q;
>
> 	result = queue_request_irq(dev, nvmeq, "nvme admin");
> 	if (result)
> 		goto free_q;
>
> 	dev->queues[0] = nvmeq;
> 	return result;
>
>  free_q:
> 	nvme_free_queue_mem(nvmeq);
> 	return result;
> }
1388c1242
< 	nents = nvme_dma_map_sg(&dev->pci_dev->dev, sg, count,
---
> 	nents = dma_map_sg(&dev->pci_dev->dev, sg, count,
1410c1264
< 	nvme_dma_unmap_sg(&dev->pci_dev->dev, iod->sg, iod->nents,
---
> 	dma_unmap_sg(&dev->pci_dev->dev, iod->sg, iod->nents,
1470c1324
< 		meta_mem = nvme_dma_alloc_coherent(&dev->pci_dev->dev, meta_len,
---
> 		meta_mem = dma_alloc_coherent(&dev->pci_dev->dev, meta_len,
1522c1376
< 		nvme_dma_free_coherent(&dev->pci_dev->dev, meta_len, meta_mem,
---
> 		dma_free_coherent(&dev->pci_dev->dev, meta_len, meta_mem,
1771c1625
< static int get_queue_info(struct nvme_dev *dev, int *start, int count)
---
> static int set_queue_count(struct nvme_dev *dev, int count)
1773,1788c1627,1629
< 	u32 result = 0, val;
< 	int c = 10;
<
< 	writel(NVME_IOQ_INFO, dev->bar4 + 4);
< 	writel(NVME_DATA_VALID, dev->bar4);
< 	pci_read_config_dword(dev->pci_dev, 0x100, &val);
<
< 	while (c--) {
< 		if (readl(dev->bar4 + NVME_RETURN_OFFSET) ==
< 				NVME_RETURN_READY) {
< 			result = readl(dev->bar4 + NVME_RETURN_OFFSET + 8);
< 			writel(0x0, dev->bar4 + NVME_RETURN_OFFSET);
< 			break;
< 		}
< 		msleep(10);
< 	}
---
> 	int status;
> 	u32 result;
> 	u32 q_count = (count - 1) | ((count - 1) << 16);
1790,1795c1631,1635
< 	/*
< 	 * MCPU would save the start IO queue number in high 16 bits
< 	 * the IO queue number is saved in low 16 bits
< 	 */
< 	*start = result >> 16;
< 	return (result & 0xffff);
---
> 	status = nvme_set_features(dev, NVME_FEAT_NUM_QUEUES, q_count, 0,
> 								&result);
> 	if (status)
> 		return -EIO;
> 	return min(result & 0xffff, result >> 16) + 1;
1801,1802c1641
< 	int result, first, cpu, i, nr_io_queues;
< 	int db_bar_size, q_depth;
---
> 	int result, cpu, i, nr_io_queues, db_bar_size, q_depth, q_count;
1805,1806c1644
< 	/* "first" is the first io queue id allocated */
< 	result = get_queue_info(dev, &first, nr_io_queues);
---
> 	result = set_queue_count(dev, nr_io_queues);
1809,1810d1646
< 	if (result == 0 || first == 0)
< 		return -EPERM;
1813,1815c1649,1654
< 	
< 	dev->first = first;
< 	db_bar_size = 4096 + ((first + nr_io_queues) << (dev->db_stride + 3));
---
>
> 	q_count = nr_io_queues;
> 	/* Deregister the admin queue's interrupt */
> 	free_irq(dev->entry[0].vector, dev->queues[0]);
>
> 	db_bar_size = 4096 + ((nr_io_queues + 1) << (dev->db_stride + 3));
1823,1827d1661
< 	/*
< 	 * Admin queue and first io queue share the MSI-X irq
< 	 * in MCPU, so if io queue id is x, its related vector
< 	 * should be x-1.
< 	 */
1829c1663
< 		dev->entry[i].entry = i + first - 1;
---
> 		dev->entry[i].entry = i;
1831c1665
< 		result = nvme_enable_msix(dev, nr_io_queues);
---
> 		result = pci_enable_msix(pdev, dev->entry, nr_io_queues);
1842a1677,1697
> 	if (nr_io_queues == 0) {
> 		nr_io_queues = q_count;
> 		for (;;) {
> 			result = pci_enable_msi_block(pdev, nr_io_queues);
> 			if (result == 0) {
> 				for (i = 0; i < nr_io_queues; i++)
> 					dev->entry[i].vector = i + pdev->irq;
> 				break;
> 			} else if (result > 0) {
> 				nr_io_queues = result;
> 				continue;
> 			} else {
> 				nr_io_queues = 1;
> 				break;
> 			}
> 		}
> 	}
>
> 	result = queue_request_irq(dev, dev->queues[0], "nvme admin");
> 	/* XXX: handle failure here */
>
1852,1855c1707,1709
< 		dev->queues[i] = nvme_create_queue(dev, i + first, q_depth,
< 				i + first -1);
< 		if (IS_ERR(dev->queues[i]))
< 			return PTR_ERR(dev->queues[i]);
---
> 		dev->queues[i + 1] = nvme_create_queue(dev, i + 1, q_depth, i);
> 		if (IS_ERR(dev->queues[i + 1]))
> 			return PTR_ERR(dev->queues[i + 1]);
1860,1861c1714,1715
< 		int target = i % rounddown_pow_of_two(dev->queue_count);
< 		dev->queues[i] = dev->queues[target];
---
> 		int target = i % rounddown_pow_of_two(dev->queue_count - 1);
> 		dev->queues[i + 1] = dev->queues[target + 1];
1887a1742
> 	dma_addr_t dma_addr;
1894c1749,1750
< 	mem = kzalloc(8192, GFP_KERNEL);
---
> 	mem = dma_alloc_coherent(&dev->pci_dev->dev, 8192, &dma_addr,
> 								GFP_KERNEL);
1898c1754
< 	res = nvme_identify_plx(dev, 0, 1, mem);
---
> 	res = nvme_identify(dev, 0, 1, dma_addr);
1918c1774
< 		res = nvme_identify_plx(dev, i, 0, mem);
---
> 		res = nvme_identify(dev, i, 0, dma_addr);
1925,1926c1781,1782
< 		res = nvme_get_features_plx(dev, NVME_FEAT_LBA_RANGE, i,
< 							mem + 4096, NULL);
---
> 		res = nvme_get_features(dev, NVME_FEAT_LBA_RANGE, i,
> 							dma_addr + 4096, NULL);
1939c1795
< 	kfree(mem);
---
> 	dma_free_coherent(&dev->pci_dev->dev, 8192, mem, dma_addr);
2049,2074d1904
< static void nvme_update_dma_addr_offset(struct nvme_dev *dev)
< {
< 	int val, count = 10;
< 	u64	result = 0;
<
< 	if (plx_dma_addr_offset)
< 		return;
<
< 	writel(NVME_DMA_ADDR_OFFSET, dev->bar4 + 4);
< 	writel(NVME_DATA_VALID, dev->bar4);
< 	pci_read_config_dword(dev->pci_dev, 0x100, &val);
< 	while (count--) {
< 		if (readl(dev->bar4 + NVME_RETURN_OFFSET) ==
< 				NVME_RETURN_READY) {
<
< 			result = readq(dev->bar4 + NVME_RETURN_OFFSET + 8);
< 			writel(0x0, dev->bar4 + NVME_RETURN_OFFSET);
< 			break;
< 		}
< 		msleep(10);
< 	}
<
< 	dev_info(&dev->pci_dev->dev, "PLX dma addr offset: 0x%llx\n", result);
< 	plx_dma_addr_offset = result;
< }
<
2098,2112c1928
< 	struct pci_dev *tmp_dev = NULL;
< 	u64 cap;
< 	int flag = 0;	
<
< 	pdev->nvme = 1;
< 	for_each_pci_dev(tmp_dev){
< 		if(tmp_dev->device == 0x1009){
< 			flag = 1;
< 			break;
< 		}
< 	}
< 	if(flag)
< 		return 0;
< 	if(pdev->bus->self->device != 0x9797)
< 		return 0;	
---
>
2120c1936
< 	dev->queues = kcalloc(num_possible_cpus(), sizeof(void *),
---
> 	dev->queues = kcalloc(num_possible_cpus() + 1, sizeof(void *),
2146a1963,1964
> 	dev->entry[0].vector = pdev->irq;
>
2157,2159c1975,1976
< 	dev->bar4 = ioremap(pci_resource_start(pdev, 4), 16 *1024);
< 	if (!dev->bar4) {
< 		result = -ENOMEM;
---
> 	result = nvme_configure_admin_queue(dev);
> 	if (result)
2161,2167c1978
< 	}
<
< 	nvme_update_dma_addr_offset(dev);
<
< 	cap = readq(&dev->bar->cap);
< 	dev->dbs = ((void __iomem *)dev->bar) + 4096;
< 	dev->db_stride = NVME_CAP_STRIDE(cap);
---
> 	dev->queue_count++;
2199d2009
< 	iounmap(dev->bar4);
[yijing at localhost linux-3.10-new]$


-- 
Thanks!
Yijing
