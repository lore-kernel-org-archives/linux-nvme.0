Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6099BC3DA7F
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Aug 2024 13:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=grXQBNc2ZQuB1b4U7s3K18X+RUL2WmwxrrMrHGVy8h0=; b=vL8T2iee18UP40JJjKsdexnYr5
	gkVY6VZYKOoWii8geyXbITlgVTcSHGWlwf5OLN9msN+0MDR8TIHOFK0rmzV2oOnyspcCXw2vcmGOp
	9NZ8rpqqdzGUzQBoMgyoQbOtSkh6TSa4DhLOX2MBq92ASgntIjw0xbEgPrLzQ4Zh77GN+EfbzaAB7
	97314mYahnqV3pqzDcd/Pimt2o6XAf866N0hprnYzTkQ6qVVMm9tzBv1ZBO/mv9d9xKWqCuy3Xbuq
	2sHWD5U/7i1NvfO4cTomM7UoTunHgKZLyupaBJFnJUMF0CsCTvxYiLYwkEdJyG2nE0uc5APtN102L
	XajC2AeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sabbr-0000000DM95-0Be8;
	Sun, 04 Aug 2024 13:49:19 +0000
Received: from mgamail.intel.com ([198.175.65.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sabbm-0000000DM7Z-2cW3;
	Sun, 04 Aug 2024 13:49:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722779354; x=1754315354;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZEvV73YBlKrPcu6njYHmN/07ygxyiQcHWg7qogNJQPk=;
  b=Px9sEjFlX7A5XvQBWcMFCJAImfEr9wF/2Z+jTgm5mA5aPTmKp3UxeFsx
   CyIUFIIa+rX6ai2jpa4SUJLPogtiRVTb3zPTYE1ULwgQMyVjio5+7f5aZ
   YW3NIyD8hQ7+r6rX/Q0YnELpfzZHidyqypxlqpTF/oMYO6bfViDxefAl1
   1NvbulQRjdlM0vIo3d+nfHO4R+01T+9ccBNc2ENbluE4TSmf891oDM9B3
   DBVxZm+APt6zAlmarEfuHtWg8lZlQaI2+9mbYiihnkG0um4EDR9zE1M7H
   C+8RgshfEAz/g9KkAgZA2f3unNrEYdlvk4HNOjqLkMCt/QY54WGtXF6nw
   A==;
X-CSE-ConnectionGUID: DImGVkprS7ya+A2OYHik1Q==
X-CSE-MsgGUID: rz6kkRSfSPi6IWIiF1xE/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="32117728"
X-IronPort-AV: E=Sophos;i="6.09,262,1716274800"; 
   d="scan'208";a="32117728"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 06:49:08 -0700
X-CSE-ConnectionGUID: qtAM2HN1T0GeKA0Lann3AQ==
X-CSE-MsgGUID: 9yukeT7/QKeGvvlkzvmkfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,262,1716274800"; 
   d="scan'208";a="56657427"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 04 Aug 2024 06:49:02 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sabbX-0001Sg-1X;
	Sun, 04 Aug 2024 13:48:59 +0000
Date: Sun, 4 Aug 2024 21:48:10 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Joern Engel <joern@lazybastard.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Wolfram Sang <wsa-dev@sang-engineering.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/6] nvme: assign of_node to nvme device
Message-ID: <202408042134.wVQ7VdU6-lkp@intel.com>
References: <20240804114108.1893-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804114108.1893-3-ansuelsmth@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240804_064914_746524_61A210C9 
X-CRM114-Status: GOOD (  16.03  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.11-rc1 next-20240802]
[cannot apply to mtd/mtd/next mtd/mtd/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/dt-bindings-nvme-Document-nvme-card-compatible/20240804-194357
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240804114108.1893-3-ansuelsmth%40gmail.com
patch subject: [PATCH 2/6] nvme: assign of_node to nvme device
config: i386-buildonly-randconfig-002-20240804 (https://download.01.org/0day-ci/archive/20240804/202408042134.wVQ7VdU6-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240804/202408042134.wVQ7VdU6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408042134.wVQ7VdU6-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/nvme/host/core.c: In function 'nvme_uninit_ctrl':
>> drivers/nvme/host/core.c:4654:9: error: implicit declaration of function 'of_node_put'; did you mean 'bpf_token_put'? [-Werror=implicit-function-declaration]
    4654 |         of_node_put(ctrl->device->of_node);
         |         ^~~~~~~~~~~
         |         bpf_token_put
   drivers/nvme/host/core.c: In function 'nvme_init_ctrl':
>> drivers/nvme/host/core.c:4775:33: error: implicit declaration of function 'of_get_compatible_child' [-Werror=implicit-function-declaration]
    4775 |         ctrl->device->of_node = of_get_compatible_child(ctrl->dev->of_node,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/nvme/host/core.c:4775:31: warning: assignment to 'struct device_node *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    4775 |         ctrl->device->of_node = of_get_compatible_child(ctrl->dev->of_node,
         |                               ^
   cc1: some warnings being treated as errors


vim +4654 drivers/nvme/host/core.c

  4648	
  4649	void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
  4650	{
  4651		nvme_hwmon_exit(ctrl);
  4652		nvme_fault_inject_fini(&ctrl->fault_inject);
  4653		dev_pm_qos_hide_latency_tolerance(ctrl->device);
> 4654		of_node_put(ctrl->device->of_node);
  4655		cdev_device_del(&ctrl->cdev, ctrl->device);
  4656		nvme_put_ctrl(ctrl);
  4657	}
  4658	EXPORT_SYMBOL_GPL(nvme_uninit_ctrl);
  4659	
  4660	static void nvme_free_cels(struct nvme_ctrl *ctrl)
  4661	{
  4662		struct nvme_effects_log	*cel;
  4663		unsigned long i;
  4664	
  4665		xa_for_each(&ctrl->cels, i, cel) {
  4666			xa_erase(&ctrl->cels, i);
  4667			kfree(cel);
  4668		}
  4669	
  4670		xa_destroy(&ctrl->cels);
  4671	}
  4672	
  4673	static void nvme_free_ctrl(struct device *dev)
  4674	{
  4675		struct nvme_ctrl *ctrl =
  4676			container_of(dev, struct nvme_ctrl, ctrl_device);
  4677		struct nvme_subsystem *subsys = ctrl->subsys;
  4678	
  4679		if (!subsys || ctrl->instance != subsys->instance)
  4680			ida_free(&nvme_instance_ida, ctrl->instance);
  4681		key_put(ctrl->tls_key);
  4682		nvme_free_cels(ctrl);
  4683		nvme_mpath_uninit(ctrl);
  4684		cleanup_srcu_struct(&ctrl->srcu);
  4685		nvme_auth_stop(ctrl);
  4686		nvme_auth_free(ctrl);
  4687		__free_page(ctrl->discard_page);
  4688		free_opal_dev(ctrl->opal_dev);
  4689	
  4690		if (subsys) {
  4691			mutex_lock(&nvme_subsystems_lock);
  4692			list_del(&ctrl->subsys_entry);
  4693			sysfs_remove_link(&subsys->dev.kobj, dev_name(ctrl->device));
  4694			mutex_unlock(&nvme_subsystems_lock);
  4695		}
  4696	
  4697		ctrl->ops->free_ctrl(ctrl);
  4698	
  4699		if (subsys)
  4700			nvme_put_subsystem(subsys);
  4701	}
  4702	
  4703	/*
  4704	 * Initialize a NVMe controller structures.  This needs to be called during
  4705	 * earliest initialization so that we have the initialized structured around
  4706	 * during probing.
  4707	 *
  4708	 * On success, the caller must use the nvme_put_ctrl() to release this when
  4709	 * needed, which also invokes the ops->free_ctrl() callback.
  4710	 */
  4711	int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
  4712			const struct nvme_ctrl_ops *ops, unsigned long quirks)
  4713	{
  4714		int ret;
  4715	
  4716		WRITE_ONCE(ctrl->state, NVME_CTRL_NEW);
  4717		ctrl->passthru_err_log_enabled = false;
  4718		clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
  4719		spin_lock_init(&ctrl->lock);
  4720		mutex_init(&ctrl->namespaces_lock);
  4721	
  4722		ret = init_srcu_struct(&ctrl->srcu);
  4723		if (ret)
  4724			return ret;
  4725	
  4726		mutex_init(&ctrl->scan_lock);
  4727		INIT_LIST_HEAD(&ctrl->namespaces);
  4728		xa_init(&ctrl->cels);
  4729		ctrl->dev = dev;
  4730		ctrl->ops = ops;
  4731		ctrl->quirks = quirks;
  4732		ctrl->numa_node = NUMA_NO_NODE;
  4733		INIT_WORK(&ctrl->scan_work, nvme_scan_work);
  4734		INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
  4735		INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
  4736		INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
  4737		init_waitqueue_head(&ctrl->state_wq);
  4738	
  4739		INIT_DELAYED_WORK(&ctrl->ka_work, nvme_keep_alive_work);
  4740		INIT_DELAYED_WORK(&ctrl->failfast_work, nvme_failfast_work);
  4741		memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
  4742		ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
  4743		ctrl->ka_last_check_time = jiffies;
  4744	
  4745		BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
  4746				PAGE_SIZE);
  4747		ctrl->discard_page = alloc_page(GFP_KERNEL);
  4748		if (!ctrl->discard_page) {
  4749			ret = -ENOMEM;
  4750			goto out;
  4751		}
  4752	
  4753		ret = ida_alloc(&nvme_instance_ida, GFP_KERNEL);
  4754		if (ret < 0)
  4755			goto out;
  4756		ctrl->instance = ret;
  4757	
  4758		ret = nvme_auth_init_ctrl(ctrl);
  4759		if (ret)
  4760			goto out_release_instance;
  4761	
  4762		nvme_mpath_init_ctrl(ctrl);
  4763	
  4764		device_initialize(&ctrl->ctrl_device);
  4765		ctrl->device = &ctrl->ctrl_device;
  4766		ctrl->device->devt = MKDEV(MAJOR(nvme_ctrl_base_chr_devt),
  4767				ctrl->instance);
  4768		ctrl->device->class = &nvme_class;
  4769		ctrl->device->parent = ctrl->dev;
  4770		if (ops->dev_attr_groups)
  4771			ctrl->device->groups = ops->dev_attr_groups;
  4772		else
  4773			ctrl->device->groups = nvme_dev_attr_groups;
  4774		ctrl->device->release = nvme_free_ctrl;
> 4775		ctrl->device->of_node = of_get_compatible_child(ctrl->dev->of_node,
  4776								"nvme-card");
  4777		dev_set_drvdata(ctrl->device, ctrl);
  4778	
  4779		return ret;
  4780	
  4781	out_release_instance:
  4782		ida_free(&nvme_instance_ida, ctrl->instance);
  4783	out:
  4784		if (ctrl->discard_page)
  4785			__free_page(ctrl->discard_page);
  4786		cleanup_srcu_struct(&ctrl->srcu);
  4787		return ret;
  4788	}
  4789	EXPORT_SYMBOL_GPL(nvme_init_ctrl);
  4790	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

