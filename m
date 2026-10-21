Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89A9606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 01:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hUMBVbmh;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WXtxaO3I
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zv4v9mywYl+AK1vWFeNrf6/w5gOM9zmsMP2K5/SuJaM=; b=hUMBVbmh2IklDLY5txJvRDhEYb
	qB4A7ZL+mT/IdXld5LigiQkItmPRXA8uBgqcfMZyg2dIjViU6J0Zonlw2IDU2ZTsJZRjBKRhBikIm
	6E3vJevJ0N3GVfeZfK4Bf1kB1A5A2DKnWeRlbbD77fhLR6WrA18avtCTxkdb5p81J5gC9FuoT/DFu
	teTX5sAahqEQ1ECNmiCdywj2v9NiJbhhyJRZck/UJtLbbEQ0Md3W5mnRSqx0UYg8nGuYNNt6ioi7E
	7YSW3yv6zvFRppDgSZ2fOGe3oTil1o5/AsPRPy9/yBU9kAs2QAGlZfi28I0yLKKDBKisJfR+EB+qG
	QjBwCX5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJKhr-0000000AsQo-2r01;
	Wed, 21 Oct 2026 01:01:27 +0000
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJKho-0000000AsQJ-3mXd
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 01:01:26 +0000
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-4ab8cb2a6e4so152314b6e.0
        for <linux-nvme@lists.infradead.org>; Tue, 20 Oct 2026 18:01:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792544483; cv=none;
        d=google.com; s=arc-20260327;
        b=q5YY2PcpKw81bNcCGY+m2dUgfPRSLM0bvKMzKMh79dtfW0AebxluEEsg+2MHD/o69a
         gosBFPUCCRPgoCKLheR3oBjNzj3nhK4Xul6qLKU5isHFg4EdaP4PxS5460pjFN43elmG
         7HjgVN5Ti/XR3376iXqJMW3jVfAW1rxKQZd5Ic1fHb/PlARpeTQp/18SM+HFRVAQfGNf
         y4vYPaCJE2Ro5HXuGRNojr/KpSBLQF2Qw5jSRtJW42wvaZW6s4fOEp1vT/sNWUxVdb4M
         ogB3f1xCFApZFqlQFx7xT9VTePZsa4WFMkuGJFIfP7ucK2mSAeeLJXdzJ+bv/dGt/6Gg
         oT+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zv4v9mywYl+AK1vWFeNrf6/w5gOM9zmsMP2K5/SuJaM=;
        fh=3U6QzZUgGasp5UVhA3r1nGWFirAxUpnn+DEYEpwA+ug=;
        b=AUtjPQZWq4qd4mildMeECFBK5vOoFVL2JOxTBMbFFQ80DSdbUut9Ar0rnoeT8jZUtc
         AltAuNbB0U7ltU/wKa7S9/4b/mX5lxH6fEwCdHfslfN9JdkaDhbQ2qIFY+mBge1R+CCo
         Mj7XlIka0HBKNe9BbhCN8J4npxDH9vaZvDiAko/rAEyZny8D70/LmYbw2VlrjN56gMeL
         43h3d5oxs+OGXimRss6mD66dI35kvyG3wUdULs/IqUyyrvbJnqtCvNVgqoR/jQOzt4eI
         cEt9EpiunU+uFIKDsWVEvB7XOTg1w7UR2/+yY3kcaebbDaTlNuoQU/pMZAw4V2Yo6iLE
         3m5A==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792544483; x=1793149283; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zv4v9mywYl+AK1vWFeNrf6/w5gOM9zmsMP2K5/SuJaM=;
        b=WXtxaO3IgkFgOmEZLD1o2ADlX88TRUYkorAvhYmCZROw0TpxLKFszqr8xsLgFYWwkn
         7jonjR72EjJ9vhZLBa1UcNDDXbr+erUpEr/VPde+VezsqVdo9JbeqFvysoRl0bCd6abn
         T6awc5S4qwJOvuvjkOSroUtjuIrXQdBgtwaVdVu4onL+ohv97qKVAe2/KcYfQyWjIkoB
         Udk+G2vOjzmuUXNSs8fkrpyXVbE9zN//P0WHotQla9AiwC0SAMZDVxmDBbibhsv0C1N+
         7DiPBj/+H+VW7lcRL0aRK5Vp2OoA9mo5bKABsPy/eyIjD/9Jgp7/hDRU5YMU9f/NTh8h
         8o4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792544483; x=1793149283;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zv4v9mywYl+AK1vWFeNrf6/w5gOM9zmsMP2K5/SuJaM=;
        b=GFIoS77qy42cO3M/i6pA1c/EChi87K6ONb9ceoReuWVKfnR1UEESDr25PgfnaYkXvy
         ynO2MEuxKeXkdgWkIe/u+RHMFNqR7X+7iIv+CGqAel9WB6xkv05GMv7PHmMl34kD36XQ
         +a6OtoYp+WzQL/bRceCs2HIY+1zyhtfCjQ8hu+mwNCWwyqsULjYF04dcAk94ckaZM9Es
         XwEejEc2+hOcrIVOwMPxNtzHjs2Q6Vclw+f4Gh4uqH8xSIGmyP/h2zm1ePHiQiEjG/42
         0DazfZbP6Nj+tmpKyeB5ABFipgIl07XGmh19ZiIm68oPuS/WsQqgxwOo+cqw+hjrI+Yz
         rZ0Q==
X-Forwarded-Encrypted: i=1; AKwUvBwMP5beV3IRi6z5sokpSO7NCuvQFteeFNC/WQJIpe2NTXVtFLC0Ny5WWlL+JQyUprgPBO3ne3c5AryE@lists.infradead.org
X-Gm-Message-State: AFq9FYK42ipo0WoEhR0OHRWlhXy67bQu7ov693xkOgwy7zbR48gOd24f
	1H4qbW8++/js5NnF9Okwwf1k61lCEKlTvfPJ0YKjYk76inL5awLeFSMTHFr1uLLRK+fRv1c398N
	l4jBlMMbuPtCQGbEZ9qmy8kfLFNVZd5Q=
X-Gm-Gg: AYBFou1B+8gB0sNd2GZkXqdSJVslGjmcZKEdkULl0FS+yht8a5cUTJb2etIZVIzy/sp
	iJLwZNd1X6FesO/Jnb7iDCaVd0FjxFx7WfeiX5EIWhFE9WG8xMBEhY/Jf9ooUruMZOgoT3j7FV/
	ybI5X+3Ero0JUGeIitSecR772E9xP1QF5X3Mq07ogmLRce9JG+IeAJmp5h+ECkgbtN3mQiZy3pj
	lxq7gMzM8hC+1nItTHM+0fDFoSG1aUqOleZZpJrrtY0k62RGNL4Os6jeqmm9f5dYX4cTiJt1uUc
	ipDaDmOUNhls4zx++FKoGC0oH5Ifa+RRW1lY+GZIuVWlIrWsApnIzL3COKJ3kiYByGD/AFxIYEb
	AyA+3NVH5QOmhTJAWbQX+1PVbAl26cuO3748DCMYm9DFZ6VQGDjYu1yhiCwi0xoHjQ04K
X-Received: by 2002:a05:6808:2507:b0:54f:ee4e:51ed with SMTP id
 5614622812f47-553557b3c63mr401658b6e.19.1792544482984; Tue, 20 Oct 2026
 18:01:22 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261002152821.410591-1-yupeng0921@gmail.com>
In-Reply-To: <20261002152821.410591-1-yupeng0921@gmail.com>
From: peng yu <yupeng0921@gmail.com>
Date: Tue, 20 Oct 2026 18:01:12 -0700
X-Gm-Features: AclHuK_n6qsIakhZRQK5TQcKEGD7lzYcbicyH70R9FV2PExAFzVNyl2NSTa2zSY
Message-ID: <CAG3TDc1Ydhjx1GD7-ZCqmzYbZv5+DM0O7wPnzKLWJ1ycK9C2sQ@mail.gmail.com>
Subject: Re: [PATCH v8] nvmet: add cgroup_id to charge namespace I/O to a cgroup
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	Maurizio Lombardi <mlombard@arkamax.eu>, cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_180125_006405_C50DAE40 
X-CRM114-Status: GOOD (  38.71  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tejun, does this patch look good from the cgroup perspective?


On Fri, Oct 2, 2026 at 8:28=E2=80=AFAM Peng Yu <yupeng0921@gmail.com> wrote=
:
>
> nvmet issues namespace I/O from kernel threads, which are in the root
> cgroup, so io.max and the other io controller settings can't be applied
> per namespace. When namespaces on shared storage, e.g. LVM volumes on
> the same physical volumes, are exported to different users, nothing
> stops a noisy user from slowing down the others. Unlike loop, there is
> no userspace process whose cgroup could be used instead.
>
> Add a cgroup_id namespace attribute that takes a cgroup2 ID. While the
> namespace is enabled, nvmet holds the cgroup and charges each command's
> I/O to the cgroup's effective io css. Block device and file backed
> namespaces are supported, but not buffered_io: buffered writes are
> written back later by flusher threads that don't know the namespace's
> cgroup.
>
> Signed-off-by: Peng Yu <yupeng0921@gmail.com>
> Assisted-by: Claude:claude-fable-5 [Claude Code]
> Assisted-by: Claude:claude-opus-5-5 [Claude Code]
> ---
> Change since v7:
> * Write the commit message as prose (Tejun).
> * Add a Documentation/ABI/stable/configfs-nvmet entry for cgroup_id
>   (Tejun).
> * Associate the read/write, flush and zone append bios through
>   nvmet_blkcg_begin()/end() and drop nvmet_blkcg_set_bio(), so each
>   bio is associated only once (Tejun).
> * v7 1/2 was applied to cgroup/for-7.4 as d5632ae01502 ("cgroup: Track
>   the effective css in each cgroup"). This patch doesn't depend on it.
>
> v7 (with test steps): https://lore.kernel.org/all/20260929232411.101087-1=
-yupeng0921@gmail.com/
>
>  Documentation/ABI/stable/configfs-nvmet | 15 +++++++
>  drivers/nvme/target/configfs.c          | 47 +++++++++++++++++++++
>  drivers/nvme/target/core.c              | 54 +++++++++++++++++++++++++
>  drivers/nvme/target/io-cmd-bdev.c       | 22 +++++++++-
>  drivers/nvme/target/io-cmd-file.c       | 21 +++++++++-
>  drivers/nvme/target/nvmet.h             | 42 +++++++++++++++++++
>  drivers/nvme/target/zns.c               |  7 ++++
>  7 files changed, 205 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/ABI/stable/configfs-nvmet b/Documentation/ABI/=
stable/configfs-nvmet
> index 36b587404ee7..bdcb705aa8c9 100644
> --- a/Documentation/ABI/stable/configfs-nvmet
> +++ b/Documentation/ABI/stable/configfs-nvmet
> @@ -314,6 +314,21 @@ Description:
>                 attr_subsys_vendor_id: Shows or sets the PCI subsystem
>                 vendor ID. Displayed in "0x%x" format.
>
> +What:          /config/nvmet/subsystems/NAME/namespaces/NSID/cgroup_id
> +Date:          October 2026
> +KernelVersion: 7.4
> +Contact:       Peng Yu <yupeng0921@gmail.com>
> +Description:
> +               Shows or sets the cgroup2 ID of the cgroup to charge this
> +               namespace's I/O to. Writing 0 clears it. The I/O is
> +               charged to the cgroup's effective io css: the cgroup
> +               itself or its nearest ancestor with the io controller
> +               enabled. The namespace must be disabled before
> +               modification. Enabling the namespace fails if the cgroup
> +               can't be found or if buffered_io is set.
> +
> +               Only available when CONFIG_BLK_CGROUP is enabled.
> +
>  What:          /config/nvmet/hosts/HOSTNQN/dhchap_key
>  What:          /config/nvmet/hosts/HOSTNQN/dhchap_ctrl_key
>  What:          /config/nvmet/hosts/HOSTNQN/dhchap_hash
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configf=
s.c
> index 6286e38436dd..cef832303d72 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -561,6 +561,50 @@ static ssize_t nvmet_ns_device_path_store(struct con=
fig_item *item,
>
>  CONFIGFS_ATTR(nvmet_ns_, device_path);
>
> +#ifdef CONFIG_BLK_CGROUP
> +static ssize_t nvmet_ns_cgroup_id_show(struct config_item *item, char *p=
age)
> +{
> +       struct nvmet_ns *ns =3D to_nvmet_ns(item);
> +       struct nvmet_subsys *subsys =3D ns->subsys;
> +       ssize_t ret;
> +
> +       mutex_lock(&subsys->lock);
> +       ret =3D snprintf(page, PAGE_SIZE, "%llu\n", ns->cgroup_id);
> +       mutex_unlock(&subsys->lock);
> +       return ret;
> +}
> +
> +static ssize_t nvmet_ns_cgroup_id_store(struct config_item *item,
> +               const char *page, size_t count)
> +{
> +       struct nvmet_ns *ns =3D to_nvmet_ns(item);
> +       struct nvmet_subsys *subsys =3D ns->subsys;
> +       u64 cgroup_id;
> +       int ret;
> +
> +       ret =3D kstrtou64(page, 0, &cgroup_id);
> +       if (ret)
> +               return ret;
> +
> +       mutex_lock(&subsys->lock);
> +
> +       if (ns->enabled) {
> +               ret =3D -EBUSY;
> +               goto out_unlock;
> +       }
> +
> +       /* Writing 0 clears the association. */
> +       ns->cgroup_id =3D cgroup_id;
> +       ret =3D count;
> +
> +out_unlock:
> +       mutex_unlock(&subsys->lock);
> +       return ret;
> +}
> +
> +CONFIGFS_ATTR(nvmet_ns_, cgroup_id);
> +#endif /* CONFIG_BLK_CGROUP */
> +
>  #ifdef CONFIG_PCI_P2PDMA
>  static ssize_t nvmet_ns_p2pmem_show(struct config_item *item, char *page=
)
>  {
> @@ -833,6 +877,9 @@ static struct configfs_attribute *nvmet_ns_attrs[] =
=3D {
>         &nvmet_ns_attr_buffered_io,
>         &nvmet_ns_attr_revalidate_size,
>         &nvmet_ns_attr_resv_enable,
> +#ifdef CONFIG_BLK_CGROUP
> +       &nvmet_ns_attr_cgroup_id,
> +#endif
>  #ifdef CONFIG_PCI_P2PDMA
>         &nvmet_ns_attr_p2pmem,
>  #endif
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 43871a8f56ca..6d9d55eb11eb 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -4,6 +4,7 @@
>   * Copyright (c) 2015-2016 HGST, a Western Digital Company.
>   */
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +#include <linux/cgroup.h>
>  #include <linux/hex.h>
>  #include <linux/module.h>
>  #include <linux/random.h>
> @@ -474,8 +475,57 @@ void nvmet_put_namespace(struct nvmet_ns *ns)
>         percpu_ref_put(&ns->ref);
>  }
>
> +#ifdef CONFIG_BLK_CGROUP
> +static int nvmet_blkcg_ns_enable(struct nvmet_ns *ns)
> +{
> +       struct cgroup *cgrp;
> +
> +       if (!ns->cgroup_id)
> +               return 0;
> +
> +       /*
> +        * Buffered writes will be handled by a separate thread,
> +        * these IOs have no namespace/cgroup information at that time,
> +        * so we don't support buffered io.
> +        */
> +       if (ns->buffered_io) {
> +               pr_err("cgroup_id is not supported with buffered_io: %s\n=
",
> +                      ns->device_path);
> +               return -EINVAL;
> +       }
> +
> +       cgrp =3D cgroup_get_from_id(ns->cgroup_id);
> +       if (IS_ERR(cgrp)) {
> +               pr_err("failed to resolve cgroup id %llu: %ld\n",
> +                      ns->cgroup_id, PTR_ERR(cgrp));
> +               return PTR_ERR(cgrp);
> +       }
> +
> +       ns->cgrp =3D cgrp;
> +       return 0;
> +}
> +
> +static void nvmet_blkcg_ns_disable(struct nvmet_ns *ns)
> +{
> +       if (ns->cgrp) {
> +               cgroup_put(ns->cgrp);
> +               ns->cgrp =3D NULL;
> +       }
> +}
> +#else
> +static inline int nvmet_blkcg_ns_enable(struct nvmet_ns *ns)
> +{
> +       return 0;
> +}
> +
> +static inline void nvmet_blkcg_ns_disable(struct nvmet_ns *ns)
> +{
> +}
> +#endif /* CONFIG_BLK_CGROUP */
> +
>  static void nvmet_ns_dev_disable(struct nvmet_ns *ns)
>  {
> +       nvmet_blkcg_ns_disable(ns);
>         nvmet_bdev_ns_disable(ns);
>         nvmet_file_ns_disable(ns);
>  }
> @@ -602,6 +652,10 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
>         if (ret)
>                 goto out_unlock;
>
> +       ret =3D nvmet_blkcg_ns_enable(ns);
> +       if (ret)
> +               goto out_dev_disable;
> +
>         ret =3D nvmet_p2pmem_ns_enable(ns);
>         if (ret)
>                 goto out_dev_disable;
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-c=
md-bdev.c
> index f2d9e8901df4..615a403d2e06 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -262,6 +262,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *r=
eq)
>         struct sg_mapping_iter prot_miter;
>         unsigned int iter_flags;
>         unsigned int total_len =3D nvmet_rw_data_len(req) + req->metadata=
_len;
> +       bool associated;
>
>         if (!nvmet_check_transfer_len(req, total_len))
>                 return;
> @@ -289,6 +290,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *r=
eq)
>
>         sector =3D nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
>
> +       associated =3D nvmet_blkcg_begin(req->ns);
>         if (nvmet_use_inline_bvec(req)) {
>                 bio =3D &req->b.inline_bio;
>                 bio_init(bio, req->ns->bdev, req->inline_bvec,
> @@ -315,6 +317,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *r=
eq)
>                                 rc =3D nvmet_bdev_alloc_bip(req, bio,
>                                                           &prot_miter);
>                                 if (unlikely(rc)) {
> +                                       nvmet_blkcg_end(associated);
>                                         bio_io_error(bio);
>                                         return;
>                                 }
> @@ -331,6 +334,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *r=
eq)
>                 sector +=3D sg->length >> 9;
>                 sg_cnt--;
>         }
> +       nvmet_blkcg_end(associated);
>
>         if (req->metadata_len) {
>                 rc =3D nvmet_bdev_alloc_bip(req, bio, &prot_miter);
> @@ -347,6 +351,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *r=
eq)
>  static void nvmet_bdev_execute_flush(struct nvmet_req *req)
>  {
>         struct bio *bio =3D &req->b.inline_bio;
> +       bool associated;
>
>         if (!bdev_write_cache(req->ns->bdev)) {
>                 nvmet_req_complete(req, NVME_SC_SUCCESS);
> @@ -356,8 +361,10 @@ static void nvmet_bdev_execute_flush(struct nvmet_re=
q *req)
>         if (!nvmet_check_transfer_len(req, 0))
>                 return;
>
> +       associated =3D nvmet_blkcg_begin(req->ns);
>         bio_init(bio, req->ns->bdev, req->inline_bvec,
>                  ARRAY_SIZE(req->inline_bvec), REQ_OP_WRITE | REQ_PREFLUS=
H);
> +       nvmet_blkcg_end(associated);
>         bio->bi_private =3D req;
>         bio->bi_end_io =3D nvmet_bio_done;
>
> @@ -366,10 +373,16 @@ static void nvmet_bdev_execute_flush(struct nvmet_r=
eq *req)
>
>  u16 nvmet_bdev_flush(struct nvmet_req *req)
>  {
> +       bool associated;
> +       int ret;
> +
>         if (!bdev_write_cache(req->ns->bdev))
>                 return 0;
>
> -       if (blkdev_issue_flush(req->ns->bdev))
> +       associated =3D nvmet_blkcg_begin(req->ns);
> +       ret =3D blkdev_issue_flush(req->ns->bdev);
> +       nvmet_blkcg_end(associated);
> +       if (ret)
>                 return NVME_SC_INTERNAL | NVME_STATUS_DNR;
>         return 0;
>  }
> @@ -380,9 +393,11 @@ static void nvmet_bdev_execute_discard(struct nvmet_=
req *req)
>         struct nvme_dsm_range range;
>         struct bio *bio =3D NULL;
>         sector_t nr_sects;
> +       bool associated;
>         int i;
>         u16 status =3D NVME_SC_SUCCESS;
>
> +       associated =3D nvmet_blkcg_begin(ns);
>         for (i =3D 0; i <=3D le32_to_cpu(req->cmd->dsm.nr); i++) {
>                 status =3D nvmet_copy_from_sgl(req, i * sizeof(range), &r=
ange,
>                                 sizeof(range));
> @@ -394,6 +409,7 @@ static void nvmet_bdev_execute_discard(struct nvmet_r=
eq *req)
>                                 nvmet_lba_to_sect(ns, range.slba), nr_sec=
ts,
>                                 GFP_KERNEL, &bio);
>         }
> +       nvmet_blkcg_end(associated);
>
>         if (bio) {
>                 bio->bi_private =3D req;
> @@ -431,6 +447,7 @@ static void nvmet_bdev_execute_write_zeroes(struct nv=
met_req *req)
>         struct bio *bio =3D NULL;
>         sector_t sector;
>         sector_t nr_sector;
> +       bool associated;
>         int ret;
>
>         if (!nvmet_check_transfer_len(req, 0))
> @@ -440,8 +457,11 @@ static void nvmet_bdev_execute_write_zeroes(struct n=
vmet_req *req)
>         nr_sector =3D (((sector_t)le16_to_cpu(write_zeroes->length) + 1) =
<<
>                 (req->ns->blksize_shift - 9));
>
> +       associated =3D nvmet_blkcg_begin(req->ns);
>         ret =3D __blkdev_issue_zeroout(req->ns->bdev, sector, nr_sector,
>                         GFP_KERNEL, &bio, 0);
> +       nvmet_blkcg_end(associated);
> +
>         if (bio) {
>                 bio->bi_private =3D req;
>                 bio->bi_end_io =3D nvmet_bio_done;
> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-c=
md-file.c
> index 0b22d183f927..570e65259ad8 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -79,6 +79,8 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req =
*req, loff_t pos,
>         struct kiocb *iocb =3D &req->f.iocb;
>         ssize_t (*call_iter)(struct kiocb *iocb, struct iov_iter *iter);
>         struct iov_iter iter;
> +       bool associated;
> +       ssize_t ret;
>         int rw;
>
>         if (req->cmd->rw.opcode =3D=3D nvme_cmd_write) {
> @@ -97,7 +99,10 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req=
 *req, loff_t pos,
>         iocb->ki_filp =3D req->ns->file;
>         iocb->ki_flags =3D ki_flags | iocb->ki_filp->f_iocb_flags;
>
> -       return call_iter(iocb, &iter);
> +       associated =3D nvmet_blkcg_begin(req->ns);
> +       ret =3D call_iter(iocb, &iter);
> +       nvmet_blkcg_end(associated);
> +       return ret;
>  }
>
>  static void nvmet_file_io_done(struct kiocb *iocb, long ret)
> @@ -251,7 +256,13 @@ static void nvmet_file_execute_rw(struct nvmet_req *=
req)
>
>  u16 nvmet_file_flush(struct nvmet_req *req)
>  {
> -       return errno_to_nvme_status(req, vfs_fsync(req->ns->file, 1));
> +       bool associated;
> +       int ret;
> +
> +       associated =3D nvmet_blkcg_begin(req->ns);
> +       ret =3D vfs_fsync(req->ns->file, 1);
> +       nvmet_blkcg_end(associated);
> +       return errno_to_nvme_status(req, ret);
>  }
>
>  static void nvmet_file_flush_work(struct work_struct *w)
> @@ -274,10 +285,12 @@ static void nvmet_file_execute_discard(struct nvmet=
_req *req)
>         int mode =3D FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
>         struct nvme_dsm_range range;
>         loff_t offset, len;
> +       bool associated;
>         u16 status =3D 0;
>         int ret;
>         int i;
>
> +       associated =3D nvmet_blkcg_begin(req->ns);
>         for (i =3D 0; i <=3D le32_to_cpu(req->cmd->dsm.nr); i++) {
>                 status =3D nvmet_copy_from_sgl(req, i * sizeof(range), &r=
ange,
>                                         sizeof(range));
> @@ -300,6 +313,7 @@ static void nvmet_file_execute_discard(struct nvmet_r=
eq *req)
>                         break;
>                 }
>         }
> +       nvmet_blkcg_end(associated);
>
>         nvmet_req_complete(req, status);
>  }
> @@ -336,6 +350,7 @@ static void nvmet_file_write_zeroes_work(struct work_=
struct *w)
>         int mode =3D FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE;
>         loff_t offset;
>         loff_t len;
> +       bool associated;
>         int ret;
>
>         offset =3D le64_to_cpu(write_zeroes->slba) << req->ns->blksize_sh=
ift;
> @@ -347,7 +362,9 @@ static void nvmet_file_write_zeroes_work(struct work_=
struct *w)
>                 return;
>         }
>
> +       associated =3D nvmet_blkcg_begin(req->ns);
>         ret =3D vfs_fallocate(req->ns->file, mode, offset, len);
> +       nvmet_blkcg_end(associated);
>         nvmet_req_complete(req, ret < 0 ? errno_to_nvme_status(req, ret) =
: 0);
>  }
>
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index dbda55895f4f..db46f8fd583d 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -21,6 +21,8 @@
>  #include <linux/radix-tree.h>
>  #include <linux/t10-pi.h>
>  #include <linux/kfifo.h>
> +#include <linux/kthread.h>
> +#include <linux/cgroup.h>
>
>  #define NVMET_DEFAULT_VS               NVME_VS(2, 1, 0)
>
> @@ -115,6 +117,16 @@ struct nvmet_ns {
>         struct nvmet_subsys     *subsys;
>         const char              *device_path;
>
> +#ifdef CONFIG_BLK_CGROUP
> +       u64                     cgroup_id;
> +       /*
> +        * Resolved from ->cgroup_id when the namespace is enabled and
> +        * released when it is disabled, so it has the same lifetime and
> +        * visibility rules as ->bdev and ->file.
> +        */
> +       struct cgroup           *cgrp;
> +#endif
> +
>         struct config_group     device_group;
>         struct config_group     group;
>
> @@ -732,6 +744,36 @@ void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_=
req *req);
>  void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);
>  void nvmet_bdev_execute_zone_append(struct nvmet_req *req);
>
> +#ifdef CONFIG_BLK_CGROUP
> +static inline bool nvmet_blkcg_begin(struct nvmet_ns *ns)
> +{
> +       struct cgroup_subsys_state *css;
> +
> +       if (!ns->cgrp || !in_task() || !(current->flags & PF_KTHREAD))
> +               return false;
> +
> +       css =3D cgroup_get_e_css(ns->cgrp, &io_cgrp_subsys);
> +       kthread_associate_blkcg(css);
> +       css_put(css);
> +       return true;
> +}
> +
> +static inline void nvmet_blkcg_end(bool associated)
> +{
> +       if (associated)
> +               kthread_associate_blkcg(NULL);
> +}
> +#else
> +static inline bool nvmet_blkcg_begin(struct nvmet_ns *ns)
> +{
> +       return false;
> +}
> +
> +static inline void nvmet_blkcg_end(bool associated)
> +{
> +}
> +#endif /* CONFIG_BLK_CGROUP */
> +
>  static inline u32 nvmet_rw_data_len(struct nvmet_req *req)
>  {
>         return ((u32)le16_to_cpu(req->cmd->rw.length) + 1) <<
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
> index 23a17c02abee..c6cc4730285b 100644
> --- a/drivers/nvme/target/zns.c
> +++ b/drivers/nvme/target/zns.c
> @@ -480,8 +480,11 @@ static void nvmet_bdev_zmgmt_send_work(struct work_s=
truct *w)
>         struct block_device *bdev =3D req->ns->bdev;
>         sector_t zone_sectors =3D bdev_zone_sectors(bdev);
>         u16 status =3D NVME_SC_SUCCESS;
> +       bool associated;
>         int ret;
>
> +       associated =3D nvmet_blkcg_begin(req->ns);
> +
>         if (op =3D=3D REQ_OP_LAST) {
>                 req->error_loc =3D offsetof(struct nvme_zone_mgmt_send_cm=
d, zsa);
>                 status =3D NVME_SC_ZONE_INVALID_TRANSITION | NVME_STATUS_=
DNR;
> @@ -511,6 +514,7 @@ static void nvmet_bdev_zmgmt_send_work(struct work_st=
ruct *w)
>                 status =3D blkdev_zone_mgmt_errno_to_nvme_status(ret);
>
>  out:
> +       nvmet_blkcg_end(associated);
>         nvmet_req_complete(req, status);
>  }
>
> @@ -542,6 +546,7 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req =
*req)
>         struct scatterlist *sg;
>         u32 data_len =3D nvmet_rw_data_len(req);
>         struct bio *bio;
> +       bool associated;
>         int sg_cnt;
>
>         /* Request is completed on len mismatch in nvmet_check_transfer_l=
en() */
> @@ -572,6 +577,7 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req =
*req)
>                 goto out;
>         }
>
> +       associated =3D nvmet_blkcg_begin(req->ns);
>         if (nvmet_use_inline_bvec(req)) {
>                 bio =3D &req->z.inline_bio;
>                 bio_init(bio, req->ns->bdev, req->inline_bvec,
> @@ -579,6 +585,7 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req =
*req)
>         } else {
>                 bio =3D bio_alloc(req->ns->bdev, req->sg_cnt, opf, GFP_KE=
RNEL);
>         }
> +       nvmet_blkcg_end(associated);
>
>         bio->bi_end_io =3D nvmet_bdev_zone_append_bio_done;
>         bio->bi_iter.bi_sector =3D sect;
>
> base-commit: 2ee54f01f07c0307deaf90ca8691a4643ae0357b
> --
> 2.53.0
>

