From: lkp@intel.com (kbuild test robot)
Date: Tue, 20 Dec 2016 12:11:51 +0800
Subject: [PATCH v3 4/5] nvme: Implement resume_from_suspend and SED
 Allocation code.
In-Reply-To: <1482176149-2257-5-git-send-email-scott.bauer@intel.com>
Message-ID: <201612201248.mAeNJArh%fengguang.wu@intel.com>

Hi Scott,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.9 next-20161219]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Scott-Bauer/include-Add-definitions-for-sed/20161220-110214
config: x86_64-randconfig-i0-201651 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   drivers/nvme/host/core.c: In function 'nvme_sec_submit':
>> drivers/nvme/host/core.c:770:9: warning: missing braces around initializer [-Wmissing-braces]
     struct nvme_command cmd = { 0 };
            ^
   drivers/nvme/host/core.c:770:9: warning: (near initialization for 'cmd.<anonymous>') [-Wmissing-braces]
   Cyclomatic Complexity 5 include/linux/compiler.h:__read_once_size
   Cyclomatic Complexity 5 include/linux/compiler.h:__write_once_size
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:__set_bit
   Cyclomatic Complexity 2 arch/x86/include/asm/bitops.h:test_and_set_bit
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:constant_test_bit
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:variable_test_bit
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:fls64
   Cyclomatic Complexity 1 include/uapi/linux/byteorder/little_endian.h:__le64_to_cpup
   Cyclomatic Complexity 1 include/uapi/linux/byteorder/little_endian.h:__le16_to_cpup
   Cyclomatic Complexity 1 include/linux/log2.h:__ilog2_u64
   Cyclomatic Complexity 1 include/linux/list.h:INIT_LIST_HEAD
   Cyclomatic Complexity 1 include/linux/list.h:__list_del
   Cyclomatic Complexity 1 include/linux/list.h:list_empty
   Cyclomatic Complexity 1 arch/x86/include/asm/current.h:get_current
   Cyclomatic Complexity 2 arch/x86/include/asm/page_64.h:__phys_addr_nodebug
   Cyclomatic Complexity 1 include/asm-generic/getorder.h:__get_order
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic.h:atomic_read
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic.h:atomic_set
   Cyclomatic Complexity 2 arch/x86/include/asm/atomic.h:atomic_sub_and_test
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic.h:atomic_add_return
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic.h:atomic_cmpxchg
   Cyclomatic Complexity 5 arch/x86/include/asm/atomic.h:__atomic_add_unless
   Cyclomatic Complexity 1 include/linux/atomic.h:atomic_add_unless
   Cyclomatic Complexity 1 include/linux/err.h:PTR_ERR
   Cyclomatic Complexity 1 include/linux/thread_info.h:check_object_size
   Cyclomatic Complexity 1 include/linux/spinlock.h:spinlock_check
   Cyclomatic Complexity 1 include/linux/spinlock.h:spin_lock
   Cyclomatic Complexity 1 include/linux/spinlock.h:spin_lock_irq
   Cyclomatic Complexity 1 include/linux/spinlock.h:spin_unlock
   Cyclomatic Complexity 1 include/linux/spinlock.h:spin_unlock_irq
   Cyclomatic Complexity 1 include/linux/jiffies.h:_msecs_to_jiffies
   Cyclomatic Complexity 5 include/linux/jiffies.h:msecs_to_jiffies
   Cyclomatic Complexity 1 include/linux/workqueue.h:to_delayed_work
   Cyclomatic Complexity 1 include/linux/signal.h:sigismember
   Cyclomatic Complexity 1 include/linux/sched.h:task_thread_info
   Cyclomatic Complexity 1 include/linux/slab.h:__kmalloc_node
   Cyclomatic Complexity 68 include/linux/slab.h:kmalloc_large
   Cyclomatic Complexity 5 include/linux/slab.h:kmalloc
   Cyclomatic Complexity 1 include/linux/slab.h:kmalloc_node
   Cyclomatic Complexity 1 include/linux/slab.h:kzalloc
   Cyclomatic Complexity 1 include/linux/slab.h:kzalloc_node
   Cyclomatic Complexity 1 include/linux/kref.h:kref_init
   Cyclomatic Complexity 1 include/linux/kref.h:kref_get_unless_zero
   Cyclomatic Complexity 1 include/linux/device.h:dev_to_node
   Cyclomatic Complexity 1 include/linux/device.h:dev_get_drvdata
   Cyclomatic Complexity 1 include/linux/fs.h:iminor
   Cyclomatic Complexity 1 include/linux/genhd.h:get_capacity
   Cyclomatic Complexity 1 include/linux/genhd.h:set_capacity
   Cyclomatic Complexity 1 include/linux/kasan-checks.h:kasan_check_read
   Cyclomatic Complexity 1 include/linux/kasan-checks.h:kasan_check_write
   Cyclomatic Complexity 11 arch/x86/include/asm/uaccess.h:copy_from_user
   Cyclomatic Complexity 11 arch/x86/include/asm/uaccess.h:copy_to_user
   Cyclomatic Complexity 1 include/linux/blk_types.h:op_is_write
   Cyclomatic Complexity 1 include/linux/blkdev.h:queue_flag_set_unlocked
   Cyclomatic Complexity 1 include/linux/blkdev.h:blk_rq_pos
   Cyclomatic Complexity 1 include/linux/blkdev.h:blk_rq_bytes
   Cyclomatic Complexity 1 include/linux/blkdev.h:blk_integrity_rq
   Cyclomatic Complexity 1 include/linux/blkdev.h:blk_queue_max_integrity_segments
   Cyclomatic Complexity 1 include/linux/blk-mq.h:blk_mq_rq_to_pdu
   Cyclomatic Complexity 1 include/linux/module.h:try_module_get
   Cyclomatic Complexity 1 include/linux/module.h:module_put
   Cyclomatic Complexity 1 include/linux/unaligned/access_ok.h:put_unaligned_le64
   Cyclomatic Complexity 1 drivers/nvme/host/nvme.h:nvme_req
   Cyclomatic Complexity 1 drivers/nvme/host/nvme.h:nvme_block_nr
   Cyclomatic Complexity 1 drivers/nvme/host/nvme.h:nvme_nvm_register
   Cyclomatic Complexity 1 drivers/nvme/host/nvme.h:nvme_nvm_unregister
   Cyclomatic Complexity 1 drivers/nvme/host/nvme.h:nvme_nvm_register_sysfs
   Cyclomatic Complexity 1 drivers/nvme/host/nvme.h:nvme_nvm_unregister_sysfs
   Cyclomatic Complexity 1 drivers/nvme/host/nvme.h:nvme_nvm_ns_supported
   Cyclomatic Complexity 1 drivers/nvme/host/nvme.h:nvme_get_ns_from_dev
   Cyclomatic Complexity 1 drivers/nvme/host/core.c:nvme_getgeo
   Cyclomatic Complexity 7 drivers/nvme/host/core.c:nvme_pr_type
   Cyclomatic Complexity 1 drivers/nvme/host/core.c:nvme_sysfs_show_address
   Cyclomatic Complexity 1 drivers/nvme/host/core.c:ns_cmp
   Cyclomatic Complexity 2 drivers/nvme/host/core.c:nvme_async_event_work
   Cyclomatic Complexity 2 include/linux/thread_info.h:test_ti_thread_flag
   Cyclomatic Complexity 1 include/linux/sched.h:test_tsk_thread_flag
   Cyclomatic Complexity 3 include/linux/blkdev.h:blk_get_integrity
   Cyclomatic Complexity 3 drivers/nvme/host/core.c:nvme_sysfs_reset
   Cyclomatic Complexity 21 drivers/nvme/host/core.c:nvme_dev_attrs_are_visible
   Cyclomatic Complexity 9 include/linux/blkdev.h:queue_logical_block_size
   Cyclomatic Complexity 7 drivers/nvme/host/core.c:nvme_dev_open
   Cyclomatic Complexity 3 drivers/nvme/host/nvme.h:nvme_reset_subsystem
   Cyclomatic Complexity 3 include/linux/nvme.h:nvme_is_write
   Cyclomatic Complexity 2 include/linux/err.h:IS_ERR
   Cyclomatic Complexity 1 include/linux/sched.h:signal_pending
   Cyclomatic Complexity 1 include/linux/sched.h:__fatal_signal_pending
   Cyclomatic Complexity 3 include/linux/sched.h:fatal_signal_pending
   Cyclomatic Complexity 1 drivers/nvme/host/core.c:nvme_setup_flush
   Cyclomatic Complexity 3 drivers/nvme/host/core.c:nvme_setup_discard
   Cyclomatic Complexity 13 drivers/nvme/host/core.c:nvme_setup_rw
   Cyclomatic Complexity 4 arch/x86/include/asm/uaccess.h:copy_user_overflow
   Cyclomatic Complexity 1 include/linux/workqueue.h:queue_delayed_work
   Cyclomatic Complexity 1 include/linux/workqueue.h:schedule_delayed_work
   Cyclomatic Complexity 3 drivers/nvme/host/core.c:nvme_keep_alive_end_io
   Cyclomatic Complexity 12 drivers/nvme/host/core.c:nvme_wait_ready
   Cyclomatic Complexity 7 drivers/nvme/host/core.c:nvme_set_queue_limits

vim +770 drivers/nvme/host/core.c

   754			timeout = msecs_to_jiffies(cmd.timeout_ms);
   755	
   756		status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
   757				(void __user *)(uintptr_t)cmd.addr, cmd.data_len,
   758				&cmd.result, timeout);
   759		if (status >= 0) {
   760			if (put_user(cmd.result, &ucmd->result))
   761				return -EFAULT;
   762		}
   763	
   764		return status;
   765	}
   766	
   767	static int nvme_sec_submit(struct nvme_ctrl *ctrl, u16 spsp, u8 secp,
   768				   void *buffer, size_t len, u8 opcode)
   769	{
 > 770		struct nvme_command cmd = { 0 };
   771		struct nvme_ns *ns = NULL;
   772	
   773		mutex_lock(&ctrl->namespaces_mutex);
   774		if (!list_empty(&ctrl->namespaces))
   775			ns = list_first_entry(&ctrl->namespaces, struct nvme_ns, list);
   776	
   777		mutex_unlock(&ctrl->namespaces_mutex);
   778		if (!ns)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 20893 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20161220/b2ab85ac/attachment-0001.gz>
