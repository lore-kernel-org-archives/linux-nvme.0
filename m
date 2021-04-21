Return-Path: <SRS0=D0Wy=JS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C6CC433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Apr 2021 17:03:16 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D40B261450
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Apr 2021 17:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40B261450
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wwJir/O/KIaFtBFWajSL5ekuDbkBgZR3z2cpDZWrmqI=; b=qtilR2wWeu+C9A1Vp6vuXtFy5
	68paFeezlkIXkUb20cAnaqsAi9Kkwplifg30zDZWiEopq8bRfTcex/ZnaIJwAHZlHXgaJMCJoDg5i
	5U+x141OaGP+Ueh7a+PW9lkxaQUB/ogxYCndUBKtLvRvw6gHeF1UXq0KtJC9BsZErjrBPRSmF0aD9
	JwarTFkGuY34TnFW5BfO0+CNb9yRsZgy4Z1f6lhE1Jg3p2n7BjZHVyxpbE+6YoR1KRtc+lIYxGSCq
	4UNsq1Z1OG5woekZuriwUcvWU/BCF99LUbpimi83x5ZmeWj4zA/04lGu+TUCOqEOfsD7yUyFmI3nS
	a2P9Sv+Pg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZGFQ-00EoEV-SM; Wed, 21 Apr 2021 17:02:45 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZGFN-00EoEG-FA
 for linux-nvme@desiato.infradead.org; Wed, 21 Apr 2021 17:02:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
 :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=diEjeCun4rfkyxqdNgRnt+M1O8CPoe0UGA5gaTgE24o=; b=cE6BnYmR/NiLkO2dVNQ0ohl121
 /jWbXlHBhsmd1z4wVX6deJW5nAYE16wRwb2Q73Hf1GtQgDI2pFoyjtS/OxWZebpeUP4uldYf2btZe
 CoIOfSZiQnctpZZZaGhNFTsAOsknQQQkSz8+jU7ZUf+/pidKhom7GvaPwKnScB2TEogmsdOMvvHpR
 LmZ+iZE9W1u7PwbekoABaqLb9IBXsAepiIGOyMSfw7GF6DAh6gLVnvs7sI9NzXC5NEZP3o6Q49YNh
 4DzJPRCG5WqyBy1O4h5wuYEsk4mkOsnPsMP9r19MciUPxiRBbnws/ux82JxlwjAaUDs6P1/DY35k2
 gcPcP5Nw==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZGFK-00D30J-5Z
 for linux-nvme@lists.infradead.org; Wed, 21 Apr 2021 17:02:40 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C75FD6144A;
 Wed, 21 Apr 2021 17:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619024556;
 bh=Ae08hcpqrX4Rtj79y91e3aFY2rswfwahyRERom+xQcE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PnzpKvuAG0gQePl63GD/m9eLLhsWteqVGSsKn8ekAYPND3HnmJlX5cEIOxYnsXdVt
 9+2HkQ1ef7M9y9w7vs0/6SqUGX1U1q+DsPI5W7tRwk9NOWPAZ/VtR5l0zufpPHm8+P
 Echzi+axoy4RDLUATUpskvzN061PM6Dz88ruPCgU2yadVA/HelraG52FkLyOMjML3O
 KldOe8httfY0plsAH0JxrySdLnNsDf5VCUlBPhT1QND7eT4ROU+78mmYkCNZ0iL0Rp
 IHHoRO+hB7hgBESGbgxbViax8+PYupdqcSqAajpWIATkJsjceWBlAJQlUT+zTi3ac/
 Ba8LCviafUtzA==
Date: Thu, 22 Apr 2021 02:02:29 +0900
From: Keith Busch <kbusch@kernel.org>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Subject: Re: [PATCH V3 1/1] nvme: introduce generic per-namespace chardev
Message-ID: <20210421170229.GA22598@redsun51.ssa.fujisawa.hgst.com>
References: <20210421074504.57750-1-minwoo.im.dev@gmail.com>
 <20210421074504.57750-2-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210421074504.57750-2-minwoo.im.dev@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210421_100238_332679_C0467227 
X-CRM114-Status: GOOD (  33.28  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Apr 21, 2021 at 04:45:04PM +0900, Minwoo Im wrote:
> Userspace has not been allowed to I/O to device that's failed to
> be initialized.  This patch introduces generic per-namespace character
> device to allow userspace to I/O regardless the block device is there or
> not.
> =

> The chardev naming convention will similar to the existing blkdev naming,
> using a ng prefix instead of nvme, i.e.
> =

> 	- /dev/ngXnY
> =

> It also supports multipath which means it will not expose chardev for the
> hidden namespace blkdevs (e.g., nvmeXcYnZ).  If /dev/ngXnY is created for
> a ns_head, then I/O request will be routed to a specific controller
> selected by the iopolicy of the subsystem.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
> [hch: rebased on top of the ioctl cleanups, split the ns_head and ns
>  implementations]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c      | 87 +++++++++++++++++++++++++++++++++++
>  drivers/nvme/host/ioctl.c     | 41 ++++++++++++++---
>  drivers/nvme/host/multipath.c | 51 ++++++++++++++++++--
>  drivers/nvme/host/nvme.h      | 13 ++++++
>  4 files changed, 182 insertions(+), 10 deletions(-)
> =

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index b905f91f14eb..2f45e8fcdd7c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -89,6 +89,10 @@ static dev_t nvme_ctrl_base_chr_devt;
>  static struct class *nvme_class;
>  static struct class *nvme_subsys_class;
>  =

> +static DEFINE_IDA(nvme_ns_chr_minor_ida);
> +static dev_t nvme_ns_chr_devt;
> +static struct class *nvme_ns_chr_class;
> +
>  static void nvme_put_subsystem(struct nvme_subsystem *subsys);
>  static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>  					   unsigned nsid);
> @@ -3429,6 +3433,66 @@ static int __nvme_check_ids(struct nvme_subsystem =
*subsys,
>  	return 0;
>  }
>  =

> +void nvme_cdev_del(struct cdev *cdev, struct device *cdev_device)
> +{
> +	cdev_device_del(cdev, cdev_device);
> +	ida_simple_remove(&nvme_ns_chr_minor_ida, MINOR(cdev_device->devt));
> +}
> +
> +int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
> +		const struct file_operations *fops, struct module *owner)
> +{
> +	int minor, ret;
> +
> +	minor =3D ida_simple_get(&nvme_ns_chr_minor_ida, 0, 0, GFP_KERNEL);
> +	if (minor < 0)
> +		return minor;
> +	cdev_device->devt =3D MKDEV(MAJOR(nvme_ns_chr_devt), minor);
> +	cdev_device->class =3D nvme_ns_chr_class;
> +	device_initialize(cdev_device);
> +	cdev_init(cdev, fops);
> +	cdev->owner =3D owner;
> +	ret =3D cdev_device_add(cdev, cdev_device);
> +	if (ret)
> +		ida_simple_remove(&nvme_ns_chr_minor_ida, minor);
> +	return ret;
> +}
> +
> +static int nvme_ns_chr_open(struct inode *inode, struct file *file)
> +{
> +	return nvme_ns_open(container_of(inode->i_cdev, struct nvme_ns, cdev));
> +}
> +
> +static int nvme_ns_chr_release(struct inode *inode, struct file *file)
> +{
> +	nvme_ns_release(container_of(inode->i_cdev, struct nvme_ns, cdev));
> +	return 0;
> +}
> +
> +static const struct file_operations nvme_ns_chr_fops =3D {
> +	.owner		=3D THIS_MODULE,
> +	.open		=3D nvme_ns_chr_open,
> +	.release	=3D nvme_ns_chr_release,
> +	.unlocked_ioctl	=3D nvme_ns_chr_ioctl,
> +	.compat_ioctl	=3D compat_ptr_ioctl,
> +};
> +
> +static int nvme_add_ns_cdev(struct nvme_ns *ns)
> +{
> +	int ret;
> +
> +	ns->cdev_device.parent =3D ns->ctrl->device;
> +	ret =3D dev_set_name(&ns->cdev_device, "ng%dn%d",
> +			   ns->ctrl->instance, ns->head->instance);
> +	if (ret)
> +		return ret;
> +	ret =3D nvme_cdev_add(&ns->cdev, &ns->cdev_device, &nvme_ns_chr_fops,
> +			    ns->ctrl->ops->module);
> +	if (ret)
> +		kfree_const(ns->cdev_device.kobj.name);
> +	return ret;
> +}
> +
>  static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>  		unsigned nsid, struct nvme_ns_ids *ids)
>  {
> @@ -3630,6 +3694,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, u=
nsigned nsid,
>  	nvme_get_ctrl(ctrl);
>  =

>  	device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups);
> +	if (!nvme_ns_head_multipath(ns->head))
> +		nvme_add_ns_cdev(ns);
>  =

>  	nvme_mpath_add_disk(ns, id);
>  	nvme_fault_inject_init(&ns->fault_inject, ns->disk->disk_name);
> @@ -3674,6 +3740,8 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>  	synchronize_srcu(&ns->head->srcu); /* wait for concurrent submissions */
>  =

>  	if (ns->disk->flags & GENHD_FL_UP) {
> +		if (!nvme_ns_head_multipath(ns->head))
> +			nvme_cdev_del(&ns->cdev, &ns->cdev_device);
>  		del_gendisk(ns->disk);
>  		blk_cleanup_queue(ns->queue);
>  		if (blk_get_integrity(ns->disk))
> @@ -4464,8 +4532,24 @@ static int __init nvme_core_init(void)
>  		result =3D PTR_ERR(nvme_subsys_class);
>  		goto destroy_class;
>  	}
> +
> +	result =3D alloc_chrdev_region(&nvme_ns_chr_devt, 0, NVME_MINORS,
> +				     "nvme-generic");
> +	if (result < 0)
> +		goto destroy_subsys_class;
> +
> +	nvme_ns_chr_class =3D class_create(THIS_MODULE, "nvme-generic");
> +	if (IS_ERR(nvme_ns_chr_class)) {
> +		result =3D PTR_ERR(nvme_ns_chr_class);
> +		goto unregister_generic_ns;
> +	}
> +
>  	return 0;
>  =

> +unregister_generic_ns:
> +	unregister_chrdev_region(nvme_ns_chr_devt, NVME_MINORS);
> +destroy_subsys_class:
> +	class_destroy(nvme_subsys_class);
>  destroy_class:
>  	class_destroy(nvme_class);
>  unregister_chrdev:
> @@ -4482,12 +4566,15 @@ static int __init nvme_core_init(void)
>  =

>  static void __exit nvme_core_exit(void)
>  {
> +	class_destroy(nvme_ns_chr_class);
>  	class_destroy(nvme_subsys_class);
>  	class_destroy(nvme_class);
> +	unregister_chrdev_region(nvme_ns_chr_devt, NVME_MINORS);
>  	unregister_chrdev_region(nvme_ctrl_base_chr_devt, NVME_MINORS);
>  	destroy_workqueue(nvme_delete_wq);
>  	destroy_workqueue(nvme_reset_wq);
>  	destroy_workqueue(nvme_wq);
> +	ida_destroy(&nvme_ns_chr_minor_ida);
>  	ida_destroy(&nvme_instance_ida);
>  }
>  =

> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 8e05d65c9e93..8f27c2f16f24 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -346,15 +346,27 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsign=
ed int cmd,
>  	}
>  }
>  =

> +static int __nvme_ioctl(struct nvme_ns *ns, unsigned int cmd, void __use=
r *arg)
> +{
> +       if (is_ctrl_ioctl(cmd))
> +               return nvme_ctrl_ioctl(ns->ctrl, cmd, arg);
> +       return nvme_ns_ioctl(ns, cmd, arg);
> +}
> +
>  int nvme_ioctl(struct block_device *bdev, fmode_t mode,
>  		unsigned int cmd, unsigned long arg)
>  {
>  	struct nvme_ns *ns =3D bdev->bd_disk->private_data;
> -	void __user *argp =3D (void __user *)arg;
>  =

> -	if (is_ctrl_ioctl(cmd))
> -		return nvme_ctrl_ioctl(ns->ctrl, cmd, argp);
> -	return nvme_ns_ioctl(ns, cmd, argp);
> +	return __nvme_ioctl(ns, cmd, (void __user *)arg);
> +}
> +
> +long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned lon=
g arg)
> +{
> +	struct nvme_ns *ns =3D
> +		container_of(file_inode(file)->i_cdev, struct nvme_ns, cdev);
> +
> +	return __nvme_ioctl(ns, cmd, (void __user *)arg);
>  }
>  =

>  #ifdef CONFIG_NVME_MULTIPATH
> @@ -384,14 +396,29 @@ static int nvme_ns_head_ns_ioctl(struct nvme_ns_hea=
d *head,
>  	return ret;
>  }
>  =

> +static int __nvme_ns_head_ioctl(struct nvme_ns_head *head, unsigned int =
cmd,
> +               void __user *arg)
> +{
> +       if (is_ctrl_ioctl(cmd))
> +               return nvme_ns_head_ctrl_ioctl(head, cmd, arg);
> +       return nvme_ns_head_ns_ioctl(head, cmd, arg);
> +}
> +
>  int nvme_ns_head_ioctl(struct block_device *bdev, fmode_t mode,
>  		unsigned int cmd, unsigned long arg)
>  {
>  	struct nvme_ns_head *head =3D bdev->bd_disk->private_data;
>  =

> -	if (is_ctrl_ioctl(cmd))
> -		return nvme_ns_head_ctrl_ioctl(head, cmd, (void __user *)arg);
> -	return nvme_ns_head_ns_ioctl(head, cmd, (void __user *)arg);
> +	return __nvme_ns_head_ioctl(head, cmd, (void __user *)arg);
> +}
> +
> +long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
> +		unsigned long arg)
> +{
> +	struct cdev *cdev =3D file_inode(file)->i_cdev;
> +	struct nvme_ns_head *head =3D container_of(cdev, struct nvme_ns_head, c=
dev);
> +
> +	return __nvme_ns_head_ioctl(head, cmd, (void __user *)arg);
>  }
>  #endif /* CONFIG_NVME_MULTIPATH */
>  =

> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 68918ea1d3d0..0d0de3433f37 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -357,6 +357,48 @@ const struct block_device_operations nvme_ns_head_op=
s =3D {
>  	.pr_ops		=3D &nvme_pr_ops,
>  };
>  =

> +static inline struct nvme_ns_head *cdev_to_ns_head(struct cdev *cdev)
> +{
> +	return container_of(cdev, struct nvme_ns_head, cdev);
> +}
> +
> +static int nvme_ns_head_chr_open(struct inode *inode, struct file *file)
> +{
> +	if (!nvme_tryget_ns_head(cdev_to_ns_head(inode->i_cdev)))
> +		return -ENXIO;
> +	return 0;
> +}
> +
> +static int nvme_ns_head_chr_release(struct inode *inode, struct file *fi=
le)
> +{
> +	nvme_put_ns_head(cdev_to_ns_head(inode->i_cdev));
> +	return 0;
> +}
> +
> +static const struct file_operations nvme_ns_head_chr_fops =3D {
> +	.owner		=3D THIS_MODULE,
> +	.open		=3D nvme_ns_head_chr_open,
> +	.release	=3D nvme_ns_head_chr_release,
> +	.unlocked_ioctl	=3D nvme_ns_head_chr_ioctl,
> +	.compat_ioctl	=3D compat_ptr_ioctl,
> +};
> +
> +static int nvme_add_ns_head_cdev(struct nvme_ns_head *head)
> +{
> +	int ret;
> +
> +	head->cdev_device.parent =3D &head->subsys->dev;
> +	ret =3D dev_set_name(&head->cdev_device, "ng%dn%d",
> +			   head->subsys->instance, head->instance);
> +	if (ret)
> +		return ret;
> +	ret =3D nvme_cdev_add(&head->cdev, &head->cdev_device,
> +			    &nvme_ns_head_chr_fops, THIS_MODULE);
> +	if (ret)
> +		kfree_const(head->cdev_device.kobj.name);
> +	return ret;
> +}
> +
>  static void nvme_requeue_work(struct work_struct *work)
>  {
>  	struct nvme_ns_head *head =3D
> @@ -435,9 +477,11 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
>  	if (!head->disk)
>  		return;
>  =

> -	if (!test_and_set_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
> +	if (!test_and_set_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
>  		device_add_disk(&head->subsys->dev, head->disk,
>  				nvme_ns_id_attr_groups);
> +		nvme_add_ns_head_cdev(head);
> +	}
>  =

>  	mutex_lock(&head->lock);
>  	if (nvme_path_is_optimized(ns)) {
> @@ -714,8 +758,10 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *hea=
d)
>  {
>  	if (!head->disk)
>  		return;
> -	if (head->disk->flags & GENHD_FL_UP)
> +	if (head->disk->flags & GENHD_FL_UP) {
> +		nvme_cdev_del(&head->cdev, &head->cdev_device);
>  		del_gendisk(head->disk);
> +	}
>  	blk_set_queue_dying(head->disk->queue);
>  	/* make sure all pending bios are cleaned up */
>  	kblockd_schedule_work(&head->requeue_work);
> @@ -785,4 +831,3 @@ void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
>  	kfree(ctrl->ana_log_buf);
>  	ctrl->ana_log_buf =3D NULL;
>  }
> -
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 49276186d5bd..773dde5b231d 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -412,6 +412,10 @@ struct nvme_ns_head {
>  	bool			shared;
>  	int			instance;
>  	struct nvme_effects_log *effects;
> +
> +	struct cdev		cdev;
> +	struct device		cdev_device;
> +
>  	struct gendisk		*disk;
>  #ifdef CONFIG_NVME_MULTIPATH
>  	struct bio_list		requeue_list;
> @@ -464,6 +468,9 @@ struct nvme_ns {
>  #define NVME_NS_ANA_PENDING	2
>  #define NVME_NS_FORCE_RO	3
>  =

> +	struct cdev		cdev;
> +	struct device		cdev_device;
> +
>  	struct nvme_fault_inject fault_inject;
>  =

>  };
> @@ -658,10 +665,16 @@ void nvme_put_ns_from_disk(struct nvme_ns_head *hea=
d, int idx);
>  bool nvme_tryget_ns_head(struct nvme_ns_head *head);
>  void nvme_put_ns_head(struct nvme_ns_head *head);
>  struct nvme_ctrl *nvme_find_get_live_ctrl(struct nvme_subsystem *subsys);
> +int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
> +		const struct file_operations *fops, struct module *owner);
> +void nvme_cdev_del(struct cdev *cdev, struct device *cdev_device);
>  int nvme_ioctl(struct block_device *bdev, fmode_t mode,
>  		unsigned int cmd, unsigned long arg);
> +long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned lon=
g arg);
>  int nvme_ns_head_ioctl(struct block_device *bdev, fmode_t mode,
>  		unsigned int cmd, unsigned long arg);
> +long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
> +		unsigned long arg);
>  long nvme_dev_ioctl(struct file *file, unsigned int cmd,
>  		unsigned long arg);
>  int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo);
> -- =

> 2.27.0
> =


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
