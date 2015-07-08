From: dingxiang@huawei.com (dingxiang)
Date: Wed, 8 Jul 2015 16:49:01 +0800
Subject: Question about NVMe share I/O
In-Reply-To: <5595E46B.8030204@huawei.com>
References: <1433779695-15866-1-git-send-email-keith.busch@intel.com>
 <1433779695-15866-3-git-send-email-keith.busch@intel.com>
 <20150611104033.GA21107@infradead.org>
 <alpine.LNX.2.00.1506111410500.15930@localhost.lm.intel.com>
 <20150611152348.GB1292@infradead.org> <55935989.70809@huawei.com>
 <alpine.LNX.2.00.1507011612070.15930@localhost.lm.intel.com>
 <559531A9.5040704@huawei.com>
 <alpine.LNX.2.00.1507021428370.15930@localhost.lm.intel.com>
 <5595E46B.8030204@huawei.com>
Message-ID: <559CE3FD.7050205@huawei.com>

Hi Keith,
   There is a simple model can duplicate this issue,here is the diff,and these changes are based on 3.10 kernel driver:

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index ce79a59..9791459 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -80,6 +80,7 @@ struct nvme_queue {
        u16 sq_tail;
        u16 cq_head;
        u16 cq_phase;
+       u16 qid;
        unsigned long cmdid_data[];
 };

@@ -748,6 +749,8 @@ static irqreturn_t nvme_process_cq(struct nvme_queue *nvmeq)
                }

                ctx = free_cmdid(nvmeq, cqe.command_id, &fn);
+                if(!fn)
+                       printk("cmdid:%d sq_id:%d ,nvmeqid:%d\n",cqe.command_id,cqe.sq_id,nvmeq->qid);
                fn(nvmeq->dev, ctx, &cqe);
        }

@@ -1095,7 +1098,8 @@ static struct nvme_queue *nvme_create_queue(struct nvme_dev *dev, int qid,
        result = queue_request_irq(dev, nvmeq, "nvme");
        if (result < 0)
                goto release_sq;
-
+
+       nvmeq->qid = qid;
        return nvmeq;

  release_sq:
@@ -1703,13 +1707,14 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)

        q_depth = min_t(int, NVME_CAP_MQES(readq(&dev->bar->cap)) + 1,
                                                                NVME_Q_DEPTH);
-       for (i = 0; i < nr_io_queues; i++) {
+       for (i = 1; i < nr_io_queues; i++) {
                dev->queues[i + 1] = nvme_create_queue(dev, i + 1, q_depth, i);
                if (IS_ERR(dev->queues[i + 1]))
                        return PTR_ERR(dev->queues[i + 1]);
                dev->queue_count++;
        }

+       dev->queues[1]=dev->queues[2];
        for (; i < num_possible_cpus(); i++) {
                int target = i % rounddown_pow_of_two(dev->queue_count - 1);
                dev->queues[i + 1] = dev->queues[target + 1];

In some cases,we need to reserve first several queues, so we will not create queues from qid 1.
Here is the crash log,from the log, we can find the qid 7 in cqe is different from qid 8 in nvmeq,
and this will cause system crash.

[  150.618085] cmdid:0 sq_id:7 ,nvmeqid:8
[  150.621821] BUG: unable to handle kernel NULL pointer dereference at
  (null)
[  150.629628] IP: [<          (null)>]           (null)
[  150.634660] PGD 0
[  150.636668] Oops: 0010 [#1] SMP
[  150.639895] Modules linked in: nvme(OF+) nf_conntrack_netbios_ns nf_conntrack
_broadcast ipt_MASQUERADE ip6t_REJECT bnep xt_conntrack bluetooth rfkill ebtable
_nat ebtable_broute bridge stp llc ebtable_filter ebtables ip6table_nat nf_connt
rack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_security ip6table_
raw ip6table_filter ip6_tables iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_n
at_ipv4 nf_nat nf_conntrack iptable_mangle iptable_security iptable_raw mperf co
retemp kvm_intel kvm crc32_pclmul crc32c_intel ghash_clmulni_intel iTCO_wdt iTCO
_vendor_support microcode serio_raw tg3 pcspkr ptp mei_me ioatdma ses pps_core m
ei lpc_ich enclosure i2c_i801 mfd_core i2c_core shpchp wmi dca nfsd auth_rpcgss
nfs_acl lockd sunrpc isci libsas megaraid_sas scsi_transport_sas [last unloaded:
 nvme]
[  150.710416] CPU: 6 PID: 0 Comm: swapper/6 Tainted: GF          O 3.10.68+ #1
[  150.717420] Hardware name: Huawei Technologies Co., Ltd. RH2285H V2-24S/BC11S
RSF1, BIOS RMIBV399 12/15/2014
[  150.727098] task: ffff880c3cd88000 ti: ffff880c3cd82000 task.ti: ffff880c3cd8
2000
[  150.734531] RIP: 0010:[<0000000000000000>]  [<          (null)>]           (n
ull)
[  150.741978] RSP: 0018:ffff88184ee03e50  EFLAGS: 00010082
[  150.747253] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 000000000000083f

[  150.754342] RDX: ffff88184ee03e68 RSI: 0000000000000000 RDI: ffff8818337f9000

[  150.761431] RBP: ffff88184ee03ea0 R08: 0000000000000000 R09: 00000000000005d7

[  150.768521] R10: 0000000000000000 R11: ffff88184ee03b96 R12: 0000000000000001

[  150.775610] R13: 0000000000000001 R14: ffff881836518000 R15: 0000000000000010

[  150.782700] FS:  0000000000000000(0000) GS:ffff88184ee00000(0000) knlGS:00000
00000000000
[  150.790738] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  150.796446] CR2: 0000000000000000 CR3: 0000000001c0c000 CR4: 00000000001407e0

[  150.803536] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000

[  150.810625] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400

[  150.817714] Stack:
[  150.819711]  ffffffffa03da49c 0000000000000000 0000000000000000 0000000000000
000
[  150.827098]  0001000000070001 ffff881836518000 000000000000007b 0000000000000
07b
[  150.834485]  0000000000000000 ffffffff81c921b8 ffff88184ee03eb8 ffffffffa03da
5ae
[  150.841872] Call Trace:
[  150.844302]  <IRQ>
[  150.846214]  [<ffffffffa03da49c>] ? nvme_process_cq+0x9c/0x190 [nvme]
[  150.852812]  [<ffffffffa03da5ae>] nvme_irq+0x1e/0x30 [nvme]
[  150.858354]  [<ffffffff810e8fde>] handle_irq_event_percpu+0x3e/0x1e0
[  150.864668]  [<ffffffff810e91b6>] handle_irq_event+0x36/0x60
[  150.870293]  [<ffffffff810ebb4f>] handle_edge_irq+0x6f/0x120
[  150.875919]  [<ffffffff810133df>] handle_irq+0xbf/0x150
[  150.881114]  [<ffffffff8163d06a>] ? atomic_notifier_call_chain+0x1a/0x20
[  150.887773]  [<ffffffff8164331d>] do_IRQ+0x4d/0xc0
[  150.892535]  [<ffffffff8163922d>] common_interrupt+0x6d/0x6d
[  150.898157]  <EOI>
[  150.900068]  [<ffffffff814dead2>] ? cpuidle_enter_state+0x52/0xc0
[  150.906319]  [<ffffffff814dec09>] cpuidle_idle_call+0xc9/0x210
[  150.912117]  [<ffffffff8101a21e>] arch_cpu_idle+0xe/0x30
[  150.917395]  [<ffffffff810aa455>] cpu_startup_entry+0xe5/0x280
[  150.923193]  [<ffffffff81628276>] start_secondary+0x253/0x255
[  150.928901] Code:  Bad RIP value.
[  150.932215] RIP  [<          (null)>]           (null)
[  150.937328]  RSP <ffff88184ee03e50>
[  150.940792] CR2: 0000000000000000
[  150.944085] ---[ end trace 302912b189a4225c ]---
[  150.996202] Kernel panic - not syncing: Fatal exception in interrupt
[  152.061661] Shutting down cpus with NMI





> On 2015/7/2 22:42, Keith Busch wrote:
>> On Thu, 2 Jul 2015, Yijing Wang wrote:
>>> Most of the time, the Host and NVMe work fine, we could read/write the same
>>> nvme by different Host, but if we do test which insmod and rmmod nvme
>>> driver(we reworked) in both hosts, a system crash would happen, Host A,
>>> because submit queue id in completion is 2.
>>
>> Could you share the source to your "reworked" driver?
>>
>>
> 
> It has a lot changes, I diff the new reworked driver and the default nvme driver in linux 3.10
> 
> The main changes focus on following:
> 
> 1?Private DMA alloc functions, we use it to alloc dma resource, and its address is global across the hosts,
>    so when NVMe controller try to transmit DMA packets, the PCIe interconnect fabric could route the dma to
>    correct host by its dma address;
> 
> 2?Private MSI-X enable functions, because default msix setup the local msi-x address, so we need to update it
>    to global dma address, which just add a global address offset.
> 
> 3?Use non-used NVMe bar4 as the communication way to map host nvme admin queue to manager OS, so we could pass
>    the host admin command to manager OS, and manager OS is responsible for delivering the admin command to physical
>    nvme controller;
> 
> 4?Request nvme IO queues from manger OS which return the free IO queue id, then host would request to create the allocated IO queues.
> 
> 
> 
> [yijing at localhost linux-3.10-new]$ diff drivers/block/nvme-host.c drivers/block/nvme-core.c
> 44d43
> < #include <linux/msi.h>
> 61d59
> < static dma_addr_t plx_dma_addr_offset = 0;
> 63,64d60
> < static void nvme_post_admin_cmd(struct nvme_dev *dev,
> < 		struct nvme_command *c);
> 90,163d85
> < static void * nvme_dma_alloc_coherent(struct device *dev,
> < 		size_t size, dma_addr_t *dma_handle, gfp_t gfp)
> < {
> < 	void *mem;
> <
> < 	mem = dma_alloc_coherent(dev, size, dma_handle, gfp);
> < 	/* Add dma address offset for nvme device in the host side */
> < 	*dma_handle += plx_dma_addr_offset;
> < 	return mem;
> < }
> <
> < static void nvme_dma_free_coherent(struct device *dev,
> < 		size_t size, void *vaddr, dma_addr_t bus)
> < {
> < 	dma_free_coherent(dev, size, vaddr, bus - plx_dma_addr_offset);
> < }
> <
> < static int nvme_dma_map_sg(struct device *dev, struct scatterlist *sg,
> < 		int nents, enum dma_data_direction dir)
> < {
> < 	int result, i;
> < 	struct scatterlist *s;
> < 	
> < 	result = dma_map_sg(dev, sg, nents, dir);
> < 	for_each_sg(sg, s, nents, i)
> < 		s->dma_address += plx_dma_addr_offset;
> < 	
> < 	return result;
> < }
> <
> < static void nvme_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
> < 		int nents, enum dma_data_direction dir)
> < {
> < 	int i;
> < 	struct scatterlist *s;
> < 	
> < 	for_each_sg(sg, s, nents, i)
> < 		s->dma_address -= plx_dma_addr_offset;
> <
> < 	dma_unmap_sg(dev, sg, nents, dir);
> < }
> <
> < /* NVMe private MSI interfaces */
> < static int nvme_enable_msix(struct nvme_dev *dev, int nvec)
> < {
> < 	int ret;
> < 	void __iomem *base;
> < 	struct msi_desc *entry;
> <
> < 	ret = pci_enable_msix(dev->pci_dev, dev->entry, nvec);
> < 	if (!ret) {
> < 		list_for_each_entry(entry, &dev->pci_dev->msi_list, list) {
> < 			base = entry->mask_base +
> < 				entry->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE;
> <
> < 			entry->msg.address_lo += plx_dma_addr_offset & 0xffffffff;
> < 			entry->msg.address_hi += plx_dma_addr_offset >> 32;
> <
> < 			mask_msix_entry(dev->pci_dev, entry->msi_attrib.entry_nr,
> < 					entry->mask_base + entry->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE
> < 					+ PCI_MSIX_ENTRY_VECTOR_CTRL, 1);
> < 			/* Flush the updated MSI address */
> < 			writel(entry->msg.address_lo, base + PCI_MSIX_ENTRY_LOWER_ADDR);
> < 			writel(entry->msg.address_hi, base + PCI_MSIX_ENTRY_UPPER_ADDR);
> <
> < 			mask_msix_entry(dev->pci_dev, entry->msi_attrib.entry_nr,
> < 					entry->mask_base + entry->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE
> < 					+ PCI_MSIX_ENTRY_VECTOR_CTRL, 0);
> < 		}	
> < 	}
> <
> < 	return ret;
> < }
> <
> 289d210
> < 	pr_info("%s: nvmeq %p, free cmdid %d\n", __func__, nvmeq, cmdid);
> 308c229
> < 	return dev->queues[get_cpu()];
> ---
>> 	return dev->queues[get_cpu() + 1];
> 398c319
> < 		nvme_dma_unmap_sg(&dev->pci_dev->dev, iod->sg, iod->nents,
> ---
>> 		dma_unmap_sg(&dev->pci_dev->dev, iod->sg, iod->nents,
> 630c551
> < 	if (nvme_dma_map_sg(nvmeq->q_dmadev, iod->sg, iod->nents, dma_dir) == 0)
> ---
>> 	if (dma_map_sg(nvmeq->q_dmadev, iod->sg, iod->nents, dma_dir) == 0)
> 699d619
> < 	pr_info("%s: nvmeq %p, alloc cmdid %d\n", __func__, nvmeq, cmdid);
> 734d653
> < 	pr_info("%s: nvmeq %p, alloc cmdid %d\n", __func__, nvmeq, cmdid);
> 832,837d750
> < 		if (!fn) {
> < 			pr_err("%s: nvmeq %p, result %d, sq_head %d,"
> < 					"sq_id %d, command id %d, status %d\n",
> < 					__func__, nvmeq, cqe.result, cqe.sq_head,
> < 					cqe.sq_id, cqe.command_id, cqe.status);
> < 		}
> 915d827
> < 	pr_info("%s: nvmeq %p, alloc cmdid %d\n", __func__, nvmeq, cmdid);
> 941c853
> < 	u32 val;
> ---
>> 	int status;
> 948,950c860,862
> < 	nvme_post_admin_cmd(dev, &c);
> < 	writel(NVME_DATA_VALID, dev->bar4);
> < 	pci_read_config_dword(dev->pci_dev, 0x100, &val);
> ---
>> 	status = nvme_submit_admin_cmd(dev, &c, NULL);
>> 	if (status)
>> 		return -EIO;
> 956a869
>> 	int status;
> 959d871
> < 	u32 val;
> 968,972c880,883
> < 	pr_debug("%s: cq qid %d, prp1 0x%llx, vector %d\n",
> < 			__func__, qid, nvmeq->cq_dma_addr, nvmeq->cq_vector);
> < 	nvme_post_admin_cmd(dev, &c);
> < 	writel(NVME_DATA_VALID, dev->bar4);
> < 	pci_read_config_dword(dev->pci_dev, 0x100, &val);
> ---
>>
>> 	status = nvme_submit_admin_cmd(dev, &c, NULL);
>> 	if (status)
>> 		return -EIO;
> 978a890
>> 	int status;
> 981d892
> < 	u32 val;
> 991,995c902,904
> < 	pr_debug("%s: sq qid %d, prp1 0x%llx\n",
> < 			__func__, qid, nvmeq->sq_dma_addr);
> < 	nvme_post_admin_cmd(dev, &c);
> < 	writel(NVME_DATA_VALID, dev->bar4);
> < 	pci_read_config_dword(dev->pci_dev, 0x100, &val);
> ---
>> 	status = nvme_submit_admin_cmd(dev, &c, NULL);
>> 	if (status)
>> 		return -EIO;
> 1009,1083d917
> < static void nvme_post_admin_cmd(struct nvme_dev *dev,
> < 		struct nvme_command *c)
> < {
> < 	int i;
> < 	u32 *addr = (u32 *)c;
> <
> < 	/* nvme admin command is always 64 bytes */
> < 	for (i = 0; i < 16; i++) {
> < 		writel(*addr, dev->bar4 + 8 + i * 4);
> < 		addr++;
> < 	}
> < 	/* Tag it's a nvme admin command */
> < 	writel(NVME_ADMIN_CMD, dev->bar4 + 4);
> < }
> <
> < static int nvme_recv_data_back(struct nvme_dev *dev,
> < 		void *mem, size_t size)
> < {
> < 	u32 *addr = (u32 *)mem;
> < 	int count = 30, i;
> < 	u32 val;
> <
> < 	while (count--) {
> < 		if (readl(dev->bar4 + NVME_RETURN_OFFSET) ==
> < 				NVME_RETURN_READY) {
> < 			writel(0x0, dev->bar4 + NVME_RETURN_OFFSET);
> <
> < 			val = readl(dev->bar4 + NVME_RETURN_OFFSET + 4);
> < 			writel(0x0, dev->bar4 + NVME_RETURN_OFFSET + 4);
> < 			if (val) {
> < 				/* admin process fail */
> < 				dev_warn(&dev->pci_dev->dev,
> < 						"admin command fail\n");
> < 				return val;
> < 			}
> <
> < 			for (i = 0; i < size; i += 4) {
> < 				*addr = readl(dev->bar4 + NVME_RETURN_OFFSET + 8 + i);
> < 				addr++;
> < 			}
> < 			break;
> < 		}
> < 		msleep(10);
> < 	}
> < 	
> < 	if (!count) {
> < 		dev_warn(&dev->pci_dev->dev,
> < 				"recv admin command data back timeout\n");
> < 		return -1;
> < 	}
> <
> < 	return 0;
> < }
> <
> < int nvme_identify_plx(struct nvme_dev *dev, unsigned nsid, unsigned cns,
> < 							void *mem)
> < {
> < 	struct nvme_command c;
> < 	int val;
> <
> < 	memset(&c, 0, sizeof(c));
> < 	c.identify.opcode = nvme_admin_identify;
> < 	c.identify.nsid = cpu_to_le32(nsid);
> < 	/* prp1 is not necessary, it will be replaced
> < 	 * with MCPU dma address in PLX MGR
> < 	 */
> < 	c.identify.prp1 = cpu_to_le64(0x12345678);
> < 	c.identify.cns = cpu_to_le32(cns);
> < 	
> < 	nvme_post_admin_cmd(dev, &c);
> < 	writel(NVME_DATA_VALID, dev->bar4);
> < 	pci_read_config_dword(dev->pci_dev, 0x100, &val);
> < 	return nvme_recv_data_back(dev, mem, 4096);
> < }
> <
> 1112,1133d945
> < int nvme_get_features_plx(struct nvme_dev *dev, unsigned fid, unsigned nsid,
> < 					void *mem, u32 *result)
> < {
> < 	struct nvme_command c;
> < 	int val;
> <
> < 	memset(&c, 0, sizeof(c));
> < 	c.features.opcode = nvme_admin_get_features;
> < 	c.features.nsid = cpu_to_le32(nsid);
> < 	/* prp1 is not necessary, it will be replaced
> < 	 * with MCPU dma address in PLX MGR, so
> < 	 * 0x12345678 is meaningless here.
> < 	 */
> < 	c.features.prp1 = cpu_to_le64(0x12345678);
> < 	c.features.fid = cpu_to_le32(fid);
> < 	nvme_post_admin_cmd(dev, &c);
> < 	writel(NVME_DATA_VALID, dev->bar4);
> < 	pci_read_config_dword(dev->pci_dev, 0x100, &val);
> <
> < 	return nvme_recv_data_back(dev, mem, 4096);
> < }
> <
> 1138d949
> < 	u32 val;
> 1146,1150c957
> < 	nvme_post_admin_cmd(dev, &c);
> < 	writel(NVME_DATA_VALID, dev->bar4);
> < 	pci_read_config_dword(dev->pci_dev, 0x100, &val);
> <
> < 	return nvme_recv_data_back(dev, result, 4);
> ---
>> 	return nvme_submit_admin_cmd(dev, &c, result);
> 1184c991
> < 	nvme_dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
> ---
>> 	dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
> 1186c993
> < 	nvme_dma_free_coherent(nvmeq->q_dmadev, SQ_SIZE(nvmeq->q_depth),
> ---
>> 	dma_free_coherent(nvmeq->q_dmadev, SQ_SIZE(nvmeq->q_depth),
> 1194c1001
> < 	int vector = dev->entry[nvmeq->cq_vector - dev->first + 1].vector;
> ---
>> 	int vector = dev->entry[nvmeq->cq_vector].vector;
> 1207,1209c1014,1018
> < 	/* Hosts don't have admin queue,the IO queues' index are from 0 */
> < 	adapter_delete_sq(dev, qid + dev->first);
> < 	adapter_delete_cq(dev, qid + dev->first);
> ---
>> 	/* Don't tell the adapter to delete the admin queue */
>> 	if (qid) {
>> 		adapter_delete_sq(dev, qid);
>> 		adapter_delete_cq(dev, qid);
>> 	}
> 1224c1033
> < 	nvmeq->cqes = nvme_dma_alloc_coherent(dmadev, CQ_SIZE(depth),
> ---
>> 	nvmeq->cqes = dma_alloc_coherent(dmadev, CQ_SIZE(depth),
> 1230c1039
> < 	nvmeq->sq_cmds = nvme_dma_alloc_coherent(dmadev, SQ_SIZE(depth),
> ---
>> 	nvmeq->sq_cmds = dma_alloc_coherent(dmadev, SQ_SIZE(depth),
> 1250c1059
> < 	nvme_dma_free_coherent(dmadev, CQ_SIZE(depth), (void *)nvmeq->cqes,
> ---
>> 	dma_free_coherent(dmadev, CQ_SIZE(depth), (void *)nvmeq->cqes,
> 1265,1266c1074,1075
> < 	return request_irq(dev->entry[nvmeq->cq_vector - dev->first + 1].vector,
> < 			nvme_irq, IRQF_DISABLED | IRQF_SHARED, name, nvmeq);
> ---
>> 	return request_irq(dev->entry[nvmeq->cq_vector].vector, nvme_irq,
>> 				IRQF_DISABLED | IRQF_SHARED, name, nvmeq);
> 1297c1106
> < 	nvme_dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
> ---
>> 	dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
> 1299c1108
> < 	nvme_dma_free_coherent(nvmeq->q_dmadev, SQ_SIZE(nvmeq->q_depth),
> ---
>> 	dma_free_coherent(nvmeq->q_dmadev, SQ_SIZE(nvmeq->q_depth),
> 1305d1113
> < #if 0
> 1346c1154,1200
> < #endif
> ---
>>
>> static int nvme_configure_admin_queue(struct nvme_dev *dev)
>> {
>> 	int result;
>> 	u32 aqa;
>> 	u64 cap = readq(&dev->bar->cap);
>> 	struct nvme_queue *nvmeq;
>>
>> 	dev->dbs = ((void __iomem *)dev->bar) + 4096;
>> 	dev->db_stride = NVME_CAP_STRIDE(cap);
>>
>> 	result = nvme_disable_ctrl(dev, cap);
>> 	if (result < 0)
>> 		return result;
>>
>> 	nvmeq = nvme_alloc_queue(dev, 0, 64, 0);
>> 	if (!nvmeq)
>> 		return -ENOMEM;
>>
>> 	aqa = nvmeq->q_depth - 1;
>> 	aqa |= aqa << 16;
>>
>> 	dev->ctrl_config = NVME_CC_ENABLE | NVME_CC_CSS_NVM;
>> 	dev->ctrl_config |= (PAGE_SHIFT - 12) << NVME_CC_MPS_SHIFT;
>> 	dev->ctrl_config |= NVME_CC_ARB_RR | NVME_CC_SHN_NONE;
>> 	dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
>>
>> 	writel(aqa, &dev->bar->aqa);
>> 	writeq(nvmeq->sq_dma_addr, &dev->bar->asq);
>> 	writeq(nvmeq->cq_dma_addr, &dev->bar->acq);
>> 	writel(dev->ctrl_config, &dev->bar->cc);
>>
>> 	result = nvme_enable_ctrl(dev, cap);
>> 	if (result)
>> 		goto free_q;
>>
>> 	result = queue_request_irq(dev, nvmeq, "nvme admin");
>> 	if (result)
>> 		goto free_q;
>>
>> 	dev->queues[0] = nvmeq;
>> 	return result;
>>
>>  free_q:
>> 	nvme_free_queue_mem(nvmeq);
>> 	return result;
>> }
> 1388c1242
> < 	nents = nvme_dma_map_sg(&dev->pci_dev->dev, sg, count,
> ---
>> 	nents = dma_map_sg(&dev->pci_dev->dev, sg, count,
> 1410c1264
> < 	nvme_dma_unmap_sg(&dev->pci_dev->dev, iod->sg, iod->nents,
> ---
>> 	dma_unmap_sg(&dev->pci_dev->dev, iod->sg, iod->nents,
> 1470c1324
> < 		meta_mem = nvme_dma_alloc_coherent(&dev->pci_dev->dev, meta_len,
> ---
>> 		meta_mem = dma_alloc_coherent(&dev->pci_dev->dev, meta_len,
> 1522c1376
> < 		nvme_dma_free_coherent(&dev->pci_dev->dev, meta_len, meta_mem,
> ---
>> 		dma_free_coherent(&dev->pci_dev->dev, meta_len, meta_mem,
> 1771c1625
> < static int get_queue_info(struct nvme_dev *dev, int *start, int count)
> ---
>> static int set_queue_count(struct nvme_dev *dev, int count)
> 1773,1788c1627,1629
> < 	u32 result = 0, val;
> < 	int c = 10;
> <
> < 	writel(NVME_IOQ_INFO, dev->bar4 + 4);
> < 	writel(NVME_DATA_VALID, dev->bar4);
> < 	pci_read_config_dword(dev->pci_dev, 0x100, &val);
> <
> < 	while (c--) {
> < 		if (readl(dev->bar4 + NVME_RETURN_OFFSET) ==
> < 				NVME_RETURN_READY) {
> < 			result = readl(dev->bar4 + NVME_RETURN_OFFSET + 8);
> < 			writel(0x0, dev->bar4 + NVME_RETURN_OFFSET);
> < 			break;
> < 		}
> < 		msleep(10);
> < 	}
> ---
>> 	int status;
>> 	u32 result;
>> 	u32 q_count = (count - 1) | ((count - 1) << 16);
> 1790,1795c1631,1635
> < 	/*
> < 	 * MCPU would save the start IO queue number in high 16 bits
> < 	 * the IO queue number is saved in low 16 bits
> < 	 */
> < 	*start = result >> 16;
> < 	return (result & 0xffff);
> ---
>> 	status = nvme_set_features(dev, NVME_FEAT_NUM_QUEUES, q_count, 0,
>> 								&result);
>> 	if (status)
>> 		return -EIO;
>> 	return min(result & 0xffff, result >> 16) + 1;
> 1801,1802c1641
> < 	int result, first, cpu, i, nr_io_queues;
> < 	int db_bar_size, q_depth;
> ---
>> 	int result, cpu, i, nr_io_queues, db_bar_size, q_depth, q_count;
> 1805,1806c1644
> < 	/* "first" is the first io queue id allocated */
> < 	result = get_queue_info(dev, &first, nr_io_queues);
> ---
>> 	result = set_queue_count(dev, nr_io_queues);
> 1809,1810d1646
> < 	if (result == 0 || first == 0)
> < 		return -EPERM;
> 1813,1815c1649,1654
> < 	
> < 	dev->first = first;
> < 	db_bar_size = 4096 + ((first + nr_io_queues) << (dev->db_stride + 3));
> ---
>>
>> 	q_count = nr_io_queues;
>> 	/* Deregister the admin queue's interrupt */
>> 	free_irq(dev->entry[0].vector, dev->queues[0]);
>>
>> 	db_bar_size = 4096 + ((nr_io_queues + 1) << (dev->db_stride + 3));
> 1823,1827d1661
> < 	/*
> < 	 * Admin queue and first io queue share the MSI-X irq
> < 	 * in MCPU, so if io queue id is x, its related vector
> < 	 * should be x-1.
> < 	 */
> 1829c1663
> < 		dev->entry[i].entry = i + first - 1;
> ---
>> 		dev->entry[i].entry = i;
> 1831c1665
> < 		result = nvme_enable_msix(dev, nr_io_queues);
> ---
>> 		result = pci_enable_msix(pdev, dev->entry, nr_io_queues);
> 1842a1677,1697
>> 	if (nr_io_queues == 0) {
>> 		nr_io_queues = q_count;
>> 		for (;;) {
>> 			result = pci_enable_msi_block(pdev, nr_io_queues);
>> 			if (result == 0) {
>> 				for (i = 0; i < nr_io_queues; i++)
>> 					dev->entry[i].vector = i + pdev->irq;
>> 				break;
>> 			} else if (result > 0) {
>> 				nr_io_queues = result;
>> 				continue;
>> 			} else {
>> 				nr_io_queues = 1;
>> 				break;
>> 			}
>> 		}
>> 	}
>>
>> 	result = queue_request_irq(dev, dev->queues[0], "nvme admin");
>> 	/* XXX: handle failure here */
>>
> 1852,1855c1707,1709
> < 		dev->queues[i] = nvme_create_queue(dev, i + first, q_depth,
> < 				i + first -1);
> < 		if (IS_ERR(dev->queues[i]))
> < 			return PTR_ERR(dev->queues[i]);
> ---
>> 		dev->queues[i + 1] = nvme_create_queue(dev, i + 1, q_depth, i);
>> 		if (IS_ERR(dev->queues[i + 1]))
>> 			return PTR_ERR(dev->queues[i + 1]);
> 1860,1861c1714,1715
> < 		int target = i % rounddown_pow_of_two(dev->queue_count);
> < 		dev->queues[i] = dev->queues[target];
> ---
>> 		int target = i % rounddown_pow_of_two(dev->queue_count - 1);
>> 		dev->queues[i + 1] = dev->queues[target + 1];
> 1887a1742
>> 	dma_addr_t dma_addr;
> 1894c1749,1750
> < 	mem = kzalloc(8192, GFP_KERNEL);
> ---
>> 	mem = dma_alloc_coherent(&dev->pci_dev->dev, 8192, &dma_addr,
>> 								GFP_KERNEL);
> 1898c1754
> < 	res = nvme_identify_plx(dev, 0, 1, mem);
> ---
>> 	res = nvme_identify(dev, 0, 1, dma_addr);
> 1918c1774
> < 		res = nvme_identify_plx(dev, i, 0, mem);
> ---
>> 		res = nvme_identify(dev, i, 0, dma_addr);
> 1925,1926c1781,1782
> < 		res = nvme_get_features_plx(dev, NVME_FEAT_LBA_RANGE, i,
> < 							mem + 4096, NULL);
> ---
>> 		res = nvme_get_features(dev, NVME_FEAT_LBA_RANGE, i,
>> 							dma_addr + 4096, NULL);
> 1939c1795
> < 	kfree(mem);
> ---
>> 	dma_free_coherent(&dev->pci_dev->dev, 8192, mem, dma_addr);
> 2049,2074d1904
> < static void nvme_update_dma_addr_offset(struct nvme_dev *dev)
> < {
> < 	int val, count = 10;
> < 	u64	result = 0;
> <
> < 	if (plx_dma_addr_offset)
> < 		return;
> <
> < 	writel(NVME_DMA_ADDR_OFFSET, dev->bar4 + 4);
> < 	writel(NVME_DATA_VALID, dev->bar4);
> < 	pci_read_config_dword(dev->pci_dev, 0x100, &val);
> < 	while (count--) {
> < 		if (readl(dev->bar4 + NVME_RETURN_OFFSET) ==
> < 				NVME_RETURN_READY) {
> <
> < 			result = readq(dev->bar4 + NVME_RETURN_OFFSET + 8);
> < 			writel(0x0, dev->bar4 + NVME_RETURN_OFFSET);
> < 			break;
> < 		}
> < 		msleep(10);
> < 	}
> <
> < 	dev_info(&dev->pci_dev->dev, "PLX dma addr offset: 0x%llx\n", result);
> < 	plx_dma_addr_offset = result;
> < }
> <
> 2098,2112c1928
> < 	struct pci_dev *tmp_dev = NULL;
> < 	u64 cap;
> < 	int flag = 0;	
> <
> < 	pdev->nvme = 1;
> < 	for_each_pci_dev(tmp_dev){
> < 		if(tmp_dev->device == 0x1009){
> < 			flag = 1;
> < 			break;
> < 		}
> < 	}
> < 	if(flag)
> < 		return 0;
> < 	if(pdev->bus->self->device != 0x9797)
> < 		return 0;	
> ---
>>
> 2120c1936
> < 	dev->queues = kcalloc(num_possible_cpus(), sizeof(void *),
> ---
>> 	dev->queues = kcalloc(num_possible_cpus() + 1, sizeof(void *),
> 2146a1963,1964
>> 	dev->entry[0].vector = pdev->irq;
>>
> 2157,2159c1975,1976
> < 	dev->bar4 = ioremap(pci_resource_start(pdev, 4), 16 *1024);
> < 	if (!dev->bar4) {
> < 		result = -ENOMEM;
> ---
>> 	result = nvme_configure_admin_queue(dev);
>> 	if (result)
> 2161,2167c1978
> < 	}
> <
> < 	nvme_update_dma_addr_offset(dev);
> <
> < 	cap = readq(&dev->bar->cap);
> < 	dev->dbs = ((void __iomem *)dev->bar) + 4096;
> < 	dev->db_stride = NVME_CAP_STRIDE(cap);
> ---
>> 	dev->queue_count++;
> 2199d2009
> < 	iounmap(dev->bar4);
> [yijing at localhost linux-3.10-new]$
> 
> 
