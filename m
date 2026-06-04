Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B7CCD6E4A
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2026 13:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m/0wFdWCMrMzd1APZtnP1L5+ZxQxI7zZg+Hbdp7TWbc=; b=HLI3mS3Xmd2CI1FnPl5HNvdb6s
	3sXwxvUEzWRnBtbCFlhnnU1uThiZHNZCTgz+rf4xzCGOSjZH2aTiV5YJ1AgRJjZS2AD6caGICJkPr
	iJagRVogKCDFrcet70dUlZYs35iccrVEGJw5ARrQmkHsD4aGd5kmAQWsaNb9JdOTOjNK8vLe5Rib8
	jkeGDljEuZatOo0DeYjCTdK20A1+CNpfBIEHy+KJBlWJKmR7RHwYgLxCtDVQ4Wl/gJKvdSSfJqonU
	bDJiI0DqpCQPhmh7Ag9WUXkg2LpNjQpkVp/X04QFLfqSvSZRRy8clZED0hXhQpoyVNswOGKqqyV3R
	ilSsYcug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV8Ts-0000000Gpay-1f1n;
	Thu, 04 Jun 2026 13:51:32 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV8Tp-0000000GpaM-15Mo
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jun 2026 13:51:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=g8ETe5c0KP6lXy
	bCFJzSucraocnbd/cI84e4aYIPl0M=; h=in-reply-to:references:to:from:
	subject:cc:date; d=arkamax.eu; b=GMrtyGWMT/6pIgKKlLlSHFkmPhBzOdJ5cjb2r
	6UDefyP5dXGOOxlXAVmK/LkYdoPkvtYtjeaYo3P8dHbvkuWrXUeyJn/kap73MfjDFA+Zix
	/Z5U7l7+gol3BnX0FgSkbGEKcdNAoWtwG6PBjmMH5LkSdSM8KIaIGl257G4BJeDtsnH+7b
	R2TQYpzDnOvIEjKdatFwY8PexlxxLc5Cu+yF3s96VgDwixTl+9iq6gYoyw9gSz/bRKO51k
	axQZfVVgNA4CuCfonKPAaDmUkfo3WD2owEy5dJg7zpjgjFYTaNkMyGbcW2SQ5gSOUeEECX
	uHv6xhMcUI/lO4kWrDZHJkN/A==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 34e94241 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 15:51:24 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jun 2026 15:51:23 +0200
Message-Id: <DJ0BBDH22NJW.1V6PUKW4QG1EX@arkamax.eu>
Cc: <hch@lst.de>, <linux-nvme@lists.infradead.org>, <dwagner@suse.de>,
 <mlombard@arkamax.eu>
Subject: Re: [PATCH RFC] nvme: fix crash due to invalid cdev teardown
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Maurizio Lombardi" <mlombard@redhat.com>, <kbusch@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260604134308.192478-1-mlombard@redhat.com>
In-Reply-To: <20260604134308.192478-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260604_065129_939825_DD7C8B55 
X-CRM114-Status: GOOD (  18.99  )
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

I marked it as RFC because I am not sure if not creating
the cdevs is an acceptable solution.

Thoughts?

Maurizio

On Thu Jun 4, 2026 at 3:43 PM CEST, Maurizio Lombardi wrote:
> In the NVMe multipath code, if nvme_add_ns_head_cdev() fails during
> nvme_mpath_set_live(), the error is completely ignored. However, during
> teardown, nvme_remove_head() unconditionally calls nvme_cdev_del().
> This teardown asymmetry leads to a kernel panic if the character device
> was never successfully initialized, which might happen in very rare
> circumstances.
>
> BUG: kernel NULL pointer dereference, address: 00000000000000d0
>  device_del+0x39/0x3c0
>  cdev_device_del+0x15/0x50
>  nvme_cdev_del+0xe/0x20 [nvme_core]
>  nvme_mpath_shutdown_disk+0x38/0x60 [nvme_core]
>  nvme_ns_remove+0x177/0x1f0 [nvme_core]
>  nvme_remove_namespaces+0xdc/0x130 [nvme_core]
>  nvme_do_delete_ctrl+0x71/0xd0 [nvme_core]
>
> Regarding head namespaces, introduce the NVME_NSHEAD_CDEV_LIVE bit to
> track the successful creation of the head character device.
> nvme_remove_head() now checks this bit before attempting deletion.
> Enforcing rollback here is unsafe, as it triggers kobject_init panics
> on the embedded device struct during asynchronous ANA retries.
>
> Regarding non-head namespaces, enforce strict failure by capturing the
> return value of nvme_add_ns_cdev() and rolling back the namespace's
> creation. Because nvme_alloc_ns() completely frees the nvme_ns structure
> on error, rolling back is safe here.
>
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>  drivers/nvme/host/core.c      | 5 ++++-
>  drivers/nvme/host/multipath.c | 5 ++++-
>  drivers/nvme/host/nvme.h      | 1 +
>  3 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 72c50d5e938d..1e24232c0aac 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4213,13 +4213,16 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl,=
 struct nvme_ns_info *info)
>  		goto out_cleanup_ns_from_list;
> =20
>  	if (!nvme_ns_head_multipath(ns->head))
> -		nvme_add_ns_cdev(ns);
> +		if (nvme_add_ns_cdev(ns))
> +			goto out_del_disk;
> =20
>  	nvme_mpath_add_disk(ns, info->anagrpid);
>  	nvme_fault_inject_init(&ns->fault_inject, ns->disk->disk_name);
> =20
>  	return;
> =20
> + out_del_disk:
> +	del_gendisk(ns->disk);
>   out_cleanup_ns_from_list:
>  	nvme_put_ctrl(ctrl);
>  	mutex_lock(&ctrl->namespaces_lock);
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.=
c
> index 263161cb8ac0..a786eb18735a 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -628,6 +628,8 @@ static int nvme_add_ns_head_cdev(struct nvme_ns_head =
*head)
>  		return ret;
>  	ret =3D nvme_cdev_add(&head->cdev, &head->cdev_device,
>  			    &nvme_ns_head_chr_fops, THIS_MODULE);
> +	if (!ret)
> +		set_bit(NVME_NSHEAD_CDEV_LIVE, &head->flags);
>  	return ret;
>  }
> =20
> @@ -672,7 +674,8 @@ static void nvme_remove_head(struct nvme_ns_head *hea=
d)
>  		 */
>  		kblockd_schedule_work(&head->requeue_work);
> =20
> -		nvme_cdev_del(&head->cdev, &head->cdev_device);
> +		if (test_and_clear_bit(NVME_NSHEAD_CDEV_LIVE, &head->flags))
> +			nvme_cdev_del(&head->cdev, &head->cdev_device);
>  		synchronize_srcu(&head->srcu);
>  		del_gendisk(head->disk);
>  	}
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 9ccaed0b9dbf..e8833e56e9fd 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -567,6 +567,7 @@ struct nvme_ns_head {
>  	unsigned int		delayed_removal_secs;
>  #define NVME_NSHEAD_DISK_LIVE		0
>  #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
> +#define NVME_NSHEAD_CDEV_LIVE		2
>  	struct nvme_ns __rcu	*current_path[];
>  #endif
>  };


