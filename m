From: lkp@intel.com (kbuild test robot)
Date: Thu, 11 Jan 2018 05:36:01 +0800
Subject: [PATCH V2 1/2] nvme: split resetting state into reset_prepate
 and resetting
In-Reply-To: <1515463393-3004-2-git-send-email-jianchao.w.wang@oracle.com>
References: <1515463393-3004-2-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <201801110540.JVzMJA3Y%fengguang.wu@intel.com>

Hi Jianchao,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v4.15-rc7]
[cannot apply to block/for-next linus/master hch-configfs/for-next next-20180110]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jianchao-Wang/nvme-split-resetting-state-into-reset_prepate-and-resetting/20180111-050049
config: x86_64-randconfig-x018-201801 (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   In file included from arch/x86/include/asm/bug.h:82:0,
                    from include/linux/bug.h:5,
                    from include/linux/jump_label.h:187,
                    from arch/x86/include/asm/string_64.h:6,
                    from arch/x86/include/asm/string.h:5,
                    from include/linux/string.h:19,
                    from include/linux/scatterlist.h:5,
                    from drivers/nvme/target/loop.c:15:
   drivers/nvme/target/loop.c: In function 'nvme_loop_reset_ctrl_work':
>> drivers/nvme/target/loop.c:486:20: error: 'struct nvme_loop_ctrl' has no member named 'state'
      WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING);
                       ^
   include/asm-generic/bug.h:68:25: note: in definition of macro 'WARN_ON_ONCE'
     int __ret_warn_on = !!(condition);   \
                            ^~~~~~~~~

vim +486 drivers/nvme/target/loop.c

   473	
   474	static void nvme_loop_reset_ctrl_work(struct work_struct *work)
   475	{
   476		struct nvme_loop_ctrl *ctrl =
   477			container_of(work, struct nvme_loop_ctrl, ctrl.reset_work);
   478		bool changed;
   479		int ret;
   480	
   481		nvme_stop_ctrl(&ctrl->ctrl);
   482		nvme_loop_shutdown_ctrl(ctrl);
   483	
   484		changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING);
   485		if (!changed) {
 > 486			WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING);
   487			return;
   488		}
   489		ret = nvme_loop_configure_admin_queue(ctrl);
   490		if (ret)
   491			goto out_disable;
   492	
   493		ret = nvme_loop_init_io_queues(ctrl);
   494		if (ret)
   495			goto out_destroy_admin;
   496	
   497		ret = nvme_loop_connect_io_queues(ctrl);
   498		if (ret)
   499			goto out_destroy_io;
   500	
   501		blk_mq_update_nr_hw_queues(&ctrl->tag_set,
   502				ctrl->ctrl.queue_count - 1);
   503	
   504		changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
   505		WARN_ON_ONCE(!changed);
   506	
   507		nvme_start_ctrl(&ctrl->ctrl);
   508	
   509		return;
   510	
   511	out_destroy_io:
   512		nvme_loop_destroy_io_queues(ctrl);
   513	out_destroy_admin:
   514		nvme_loop_destroy_admin_queue(ctrl);
   515	out_disable:
   516		dev_warn(ctrl->ctrl.device, "Removing after reset failure\n");
   517		nvme_uninit_ctrl(&ctrl->ctrl);
   518		nvme_put_ctrl(&ctrl->ctrl);
   519	}
   520	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 32830 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180111/7fbba43c/attachment-0001.gz>
