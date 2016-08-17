From: lkp@intel.com (kbuild test robot)
Date: Wed, 17 Aug 2016 16:13:19 +0800
Subject: [PATCH 08/15] nvme: Pass attribute group to device_add_disk
In-Reply-To: <1471418115-3654-9-git-send-email-famz@redhat.com>
Message-ID: <201608171629.gksireZM%fengguang.wu@intel.com>

Hi Fam,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.8-rc2 next-20160817]
[cannot apply to linux/master]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Fam-Zheng/Fix-issue-with-KOBJ_ADD-uevent-versus-disk-attributes/20160817-152900
config: powerpc-allmodconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All warnings (new ones prefixed by >>):

   drivers/nvme/host/core.c: In function 'nvme_alloc_ns':
>> drivers/nvme/host/core.c:1689:42: warning: passing argument 3 of 'device_add_disk' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     device_add_disk(ctrl->device, ns->disk, &nvme_ns_attr_group);
                                             ^
   In file included from include/linux/blkdev.h:9:0,
                    from drivers/nvme/host/core.c:15:
   include/linux/genhd.h:416:12: note: expected 'struct attribute_group *' but argument is of type 'const struct attribute_group *'
    extern int device_add_disk(struct device *parent, struct gendisk *disk,
               ^

vim +1689 drivers/nvme/host/core.c

  1673		disk->private_data = ns;
  1674		disk->queue = ns->queue;
  1675		disk->flags = GENHD_FL_EXT_DEVT;
  1676		sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance, ns->instance);
  1677	
  1678		if (nvme_revalidate_disk(ns->disk))
  1679			goto out_free_disk;
  1680	
  1681		mutex_lock(&ctrl->namespaces_mutex);
  1682		list_add_tail(&ns->list, &ctrl->namespaces);
  1683		mutex_unlock(&ctrl->namespaces_mutex);
  1684	
  1685		kref_get(&ctrl->kref);
  1686		if (ns->type == NVME_NS_LIGHTNVM)
  1687			return;
  1688	
> 1689		device_add_disk(ctrl->device, ns->disk, &nvme_ns_attr_group);
  1690		return;
  1691	 out_free_disk:
  1692		kfree(disk);
  1693	 out_free_queue:
  1694		blk_cleanup_queue(ns->queue);
  1695	 out_release_instance:
  1696		ida_simple_remove(&ctrl->ns_ida, ns->instance);
  1697	 out_free_ns:

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 49909 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20160817/75a7e7e4/attachment-0001.obj>
