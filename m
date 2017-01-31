From: lkp@intel.com (kbuild test robot)
Date: Wed, 1 Feb 2017 02:21:31 +0800
Subject: [PATCH 1/1] MicroSemi Switchtec management interface driver
In-Reply-To: <1485882204-26947-2-git-send-email-logang@deltatee.com>
Message-ID: <201702010207.GxRatpeu%fengguang.wu@intel.com>

Hi Logan,

[auto build test ERROR on pci/next]
[also build test ERROR on v4.10-rc6 next-20170130]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Logan-Gunthorpe/MicroSemi-Switchtec-management-interface-driver/20170201-011235
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   drivers/pci/switch/switchtec.c: In function 'stdev_is_alive':
>> drivers/pci/switch/switchtec.c:120:14: warning: return makes integer from pointer without a cast [-Wint-conversion]
     return stdev->mmio;
            ~~~~~^~~~~~
   drivers/pci/switch/switchtec.c: In function 'switchtec_init_msi_isr':
>> drivers/pci/switch/switchtec.c:1075:7: error: implicit declaration of function 'pci_enable_msi_range' [-Werror=implicit-function-declaration]
     rc = pci_enable_msi_range(pdev, 1, 4);
          ^~~~~~~~~~~~~~~~~~~~
   drivers/pci/switch/switchtec.c: In function 'switchtec_dev_ioctl':
>> drivers/pci/switch/switchtec.c:758:3: warning: 'nr_idxs' may be used uninitialized in this function [-Wmaybe-uninitialized]
      for (ctl.index = 0; ctl.index < nr_idxs; ctl.index++) {
      ^~~
   drivers/pci/switch/switchtec.c:741:6: note: 'nr_idxs' was declared here
     int nr_idxs;
         ^~~~~~~
   drivers/pci/switch/switchtec.c: In function 'switchtec_pci_probe':
>> drivers/pci/switch/switchtec.c:1174:50: warning: 'partition' may be used uninitialized in this function [-Wmaybe-uninitialized]
     stdev->mmio_part_cfg = &stdev->mmio_part_cfg_all[partition];
                                                     ^
   drivers/pci/switch/switchtec.c:1153:6: note: 'partition' was declared here
     int partition;
         ^~~~~~~~~
   cc1: some warnings being treated as errors

vim +/pci_enable_msi_range +1075 drivers/pci/switch/switchtec.c

  1069	static int switchtec_init_msi_isr(struct switchtec_dev *stdev)
  1070	{
  1071		int rc;
  1072		struct pci_dev *pdev = stdev->pdev;
  1073	
  1074		/* Try to set up msi irq */
> 1075		rc = pci_enable_msi_range(pdev, 1, 4);
  1076		if (rc < 0)
  1077			return rc;
  1078	
  1079		stdev->event_irq = ioread32(&stdev->mmio_part_cfg->vep_vector_number);
  1080		if (stdev->event_irq < 0 || stdev->event_irq >= 4) {
  1081			rc = -EFAULT;
  1082			goto err_msi_request;
  1083		}
  1084	
  1085		stdev->event_irq = pdev->irq + stdev->event_irq;
  1086		dev_dbg(&stdev->dev, "Using msi interrupts: event_irq=%d\n",
  1087			stdev->event_irq);
  1088	
  1089		return 0;
  1090	
  1091	err_msi_request:
  1092		pci_disable_msi(pdev);
  1093		return rc;
  1094	}
  1095	
  1096	static int switchtec_init_isr(struct switchtec_dev *stdev)
  1097	{
  1098		int rc;
  1099	
  1100		rc = switchtec_init_msix_isr(stdev);
  1101		if (rc)
  1102			rc = switchtec_init_msi_isr(stdev);
  1103	
  1104		if (rc)
  1105			return rc;
  1106	
  1107		rc = devm_request_irq(&stdev->pdev->dev, stdev->event_irq,
  1108				      switchtec_event_isr, 0, KBUILD_MODNAME, stdev);
  1109	
  1110		return rc;
  1111	}
  1112	
  1113	static void switchtec_deinit_isr(struct switchtec_dev *stdev)
  1114	{
  1115		devm_free_irq(&stdev->pdev->dev, stdev->event_irq, stdev);
  1116		pci_disable_msix(stdev->pdev);
  1117		pci_disable_msi(stdev->pdev);
  1118	}
  1119	
  1120	static void init_pff(struct switchtec_dev *stdev)
  1121	{
  1122		int i;
  1123		u32 reg;
  1124		struct part_cfg_regs *pcfg = stdev->mmio_part_cfg;
  1125	
  1126		for (i = 0; i < SWITCHTEC_MAX_PFF_CSR; i++) {
  1127			reg = ioread16(&stdev->mmio_pff_csr[i].vendor_id);
  1128			if (reg != MICROSEMI_VENDOR_ID)
  1129				break;
  1130		}
  1131	
  1132		stdev->pff_csr_count = i;
  1133	
  1134		reg = ioread32(&pcfg->usp_pff_inst_id);
  1135		if (reg < SWITCHTEC_MAX_PFF_CSR)
  1136			stdev->pff_local[reg] = 1;
  1137	
  1138		reg = ioread32(&pcfg->vep_pff_inst_id);
  1139		if (reg < SWITCHTEC_MAX_PFF_CSR)
  1140			stdev->pff_local[reg] = 1;
  1141	
  1142		for (i = 0; i < ARRAY_SIZE(pcfg->dsp_pff_inst_id); i++) {
  1143			reg = ioread32(&pcfg->dsp_pff_inst_id[i]);
  1144			if (reg < SWITCHTEC_MAX_PFF_CSR)
  1145				stdev->pff_local[reg] = 1;
  1146		}
  1147	}
  1148	
  1149	static int switchtec_init_pci(struct switchtec_dev *stdev,
  1150				      struct pci_dev *pdev)
  1151	{
  1152		int rc;
  1153		int partition;
  1154	
  1155		rc = pcim_enable_device(pdev);
  1156		if (rc)
  1157			return rc;
  1158	
  1159		rc = pcim_iomap_regions(pdev, 0x1, KBUILD_MODNAME);
  1160		if (rc)
  1161			return rc;
  1162	
  1163		pci_set_master(pdev);
  1164	
  1165		stdev->mmio = pcim_iomap_table(pdev)[0];
  1166		stdev->mmio_mrpc = stdev->mmio + SWITCHTEC_GAS_MRPC_OFFSET;
  1167		stdev->mmio_sw_event = stdev->mmio + SWITCHTEC_GAS_SW_EVENT_OFFSET;
  1168		stdev->mmio_sys_info = stdev->mmio + SWITCHTEC_GAS_SYS_INFO_OFFSET;
  1169		stdev->mmio_flash_info = stdev->mmio + SWITCHTEC_GAS_FLASH_INFO_OFFSET;
  1170		stdev->mmio_ntb = stdev->mmio + SWITCHTEC_GAS_NTB_OFFSET;
  1171		stdev->partition = ioread8(&stdev->mmio_ntb->partition_id);
  1172		stdev->partition_count = ioread8(&stdev->mmio_ntb->partition_count);
  1173		stdev->mmio_part_cfg_all = stdev->mmio + SWITCHTEC_GAS_PART_CFG_OFFSET;
> 1174		stdev->mmio_part_cfg = &stdev->mmio_part_cfg_all[partition];
  1175		stdev->mmio_pff_csr = stdev->mmio + SWITCHTEC_GAS_PFF_CSR_OFFSET;
  1176	
  1177		init_pff(stdev);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 57993 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170201/1791c455/attachment-0001.gz>
