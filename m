From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 11 Jun 2018 11:27:13 +0200
Subject: [PATCH v3] nvme: trace: add disk name to tracepoints
In-Reply-To: <201806111759.lf41atZ3%fengguang.wu@intel.com>
References: <20180611090356.9174-1-jthumshirn@suse.de>
 <201806111759.lf41atZ3%fengguang.wu@intel.com>
Message-ID: <20180611092713.6ceqbsgiaqi7jxmr@linux-x5ow.site>

On Mon, Jun 11, 2018@05:22:15PM +0800, kbuild test robot wrote:
> Hi Johannes,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on block/for-next]
> [also build test ERROR on next-20180608]
> [cannot apply to v4.17]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Johannes-Thumshirn/nvme-trace-add-disk-name-to-tracepoints/20180611-170613
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
> config: x86_64-randconfig-x015-201823 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/nvme/host/fc.c: In function 'nvme_fc_queue_rq':
> >> drivers/nvme/host/fc.c:2291:23: error: incompatible type for argument 1 of 'nvme_setup_cmd'
>      ret = nvme_setup_cmd(ctrl->ctrl, ns, rq, sqe);
>                           ^~~~
>    In file included from drivers/nvme/host/fc.c:24:0:
>    drivers/nvme/host/nvme.h:425:14: note: expected 'struct nvme_ctrl *' but argument is of type 'struct nvme_ctrl'
>     blk_status_t nvme_setup_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>                  ^~~~~~~~~~~~~~
>    drivers/nvme/host/fc.c: In function 'nvme_fc_complete_rq':
> >> drivers/nvme/host/fc.c:2372:19: error: incompatible type for argument 1 of 'nvme_complete_rq'
>      nvme_complete_rq(ctrl->ctrl, rq);
>                       ^~~~
>    In file included from drivers/nvme/host/fc.c:24:0:
>    drivers/nvme/host/nvme.h:390:6: note: expected 'struct nvme_ctrl *' but argument is of type 'struct nvme_ctrl'
>     void nvme_complete_rq(struct nvme_ctrl *ctrl, struct request *req);
>          ^~~~~~~~~~~~~~~~

Args, will be sending a v4 later today...
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
