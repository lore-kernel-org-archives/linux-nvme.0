Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9C3606A31C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 06:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BORGqzK4;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yN8eIivA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ggt4XEbzaHLvs1xJGaZAIsxFE3XBdGn1PW0gI0oUcwE=; b=BORGqzK4q4/0wU
	xy1Mb/qFILx2VLOMXQ8yWyfnHClBaVdAWO3WpdAvwmQYNc9zG/fU3l4h4l6L/rjZJEEvPMAut5j+f
	3d60NxnzT4fK/PIvGu5p8mROh1IiV8woqyXhtIXwsYHYftT6lceZuVsTqPWDeC9iQ6oGCVKzfcBIS
	3FDTlTcfQgGs38AQ07vxYaiiavBkRNiso4WzC2tmO5xHnyiH/wPYjmofsVPCyyFRuUoDm1VFCxMm/
	lj5r64yF3hcvE5vAOWZ7huSVr1diidh+rgaEXL1HjaCnn/Eo7LFHEwX4dP41MY86uK7y+aQd4bhAY
	107QiPkossmDcdUJOd9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSqHK-00000001Izt-2pCo;
	Mon, 16 Nov 2026 06:33:22 +0000
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSqHH-00000001Iyu-49cB
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 06:33:21 +0000
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-4ada9579947so2345346fac.1
        for <linux-nvme@lists.infradead.org>; Sun, 15 Nov 2026 22:33:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794810798; cv=none;
        d=google.com; s=arc-20260327;
        b=GgKnzW0PC1NcsJ9NxtZT8QezzFr1VYKVpGrLJ0TT53rfZdoLm8LorS71X2gDz0TA4u
         4SZ8ABWp6kR3I+ErJ8gFssBxpTVye6JQUdLYoDvqxtbluPN507c0tzwwgkZNwnAhCD1s
         yfYaNjD9hmZF1ekqaYVIMXhMXu0dWeharIoGO3qYMMbyL5Oct8I7gJo9TTk7gJvoKvYP
         m4+JCWHSlZaDN56qEbk1YbkSf6XvtcWCyu28hU1AFGPCmMiaowaxfxHEpVjeG5XvMglA
         lXlmDP1ASW2qDQKhZ6SCkiCw7IrwVffpY4+eRJaXC1Sa6uDzKe9k4H5FQEucyPs4n7Gp
         MJFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ggt4XEbzaHLvs1xJGaZAIsxFE3XBdGn1PW0gI0oUcwE=;
        fh=utzaJ9CUk3o330iT6e2Ns8t9KcaMHBb8VGKrNKcOh64=;
        b=fPUgFXm4Zic49iCvv2Z7qt0//fKZVdM/ZtNV+AOBs+5XGo47l/O82+Y6zLg1kO98FD
         gkzTcOloyKzbWxcpndKYAMWFIbwfvNpCVVNkez3GhnKNVnA9xFPssCZhC0XgNTiAyVRJ
         4PdZLzvL6Fk55DuLt2YddP3nlGa2749etoiLdNfn9fFo9n5HKjxED54vA+U/cbtCsYug
         6/gs30pKpNMOiMY0VLvMehIa5Oe2ZBkcVuk5UIqIFrTvSmbj4Sh3EPta32RWalZLYSoc
         pmevvq2j8FdBEztiMxJ0fVxgOGPwYYUPtyXm4HZwqFZA909zxyde1Wt76QVl/5Iv3A3u
         r8dg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794810798; x=1795415598; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ggt4XEbzaHLvs1xJGaZAIsxFE3XBdGn1PW0gI0oUcwE=;
        b=yN8eIivAbXTWaXZoqVpatJ2Lp7l1U2SLXqpywNlTMH3T4V3uB3of95AZGv6uRB794u
         wzr3JWzgLNFnuy210hI0vGwmWEQ4IywnmEMxWzdx4ncCHPY2s3WKyTNFKbCzlFW+A/JA
         3sw6l4Tk6qygQ7QWpm8oPM6J0g09wke2y3N7ARPKKdr8AWtcuAm/bj39T5HVzM+aNq5y
         n3brnleLvrZG16qCF1hPhlrgw3vhEBgRiEud03Io8nHA6eQZOCCSwK+4qAah8oPSvbCJ
         NIVIfHybGiO9217vTpTNSE7o7oz2Zg5Y5NRmbknf/TKiGk8VxgWjjvMJSW/kIlUdJnVC
         yifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794810798; x=1795415598;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ggt4XEbzaHLvs1xJGaZAIsxFE3XBdGn1PW0gI0oUcwE=;
        b=nQpeMU+JYEf9X0WhjpRh6l7C5B5itmzVkk1MIJXTAGdvB4LWd7iJYbnj6Cmx1rB8yo
         h5pABrDUMrxWVnxyZpopCEHSjx71eTO1zFyKXBsQV0W9meEJjFZfQ4LagqSznx8ILajl
         Dze6wTBX9vIywEaBcxvM5AAH+ztbON7w93TYMMmKbdq/NH4nRK9ckvL8b20VGZHie4bH
         KbCf0tGKRzXtBrYIcfoC+P3yYCp29GxkDMDjuBCq5tx3MKWtFwodSxeRmskpS0LtHuHi
         L9SYbXg7YQI5laj3xjg913zBjQUevbZzrMzlMt0z38nYGvEp4HXWNa/bg1kLqyh9EkbV
         QnMA==
X-Forwarded-Encrypted: i=1; AL+hErEPfFu+++4oQpH0pTU9dApVJbcMEapZvCWqcNxGnWl9fz6xhF4Px/zpyTe4DYPgne7s+KnOTUib3Rcm@lists.infradead.org
X-Gm-Message-State: APuU4Z9dWpTwE8yEHRsH3SHk0toAL9/3zNns2Jkrlt63QIQLdqhHt8Jg
	G2FMvrXH1M7pOGSZ5ZS3GEOJGANW/qGCYICeGcI4QaQx3AaG4weJxZHVFyhTOZRBZzkwXK3BLwP
	9c4eXG14jrRvW0Jpz3Zvf0h55uVJVP4M=
X-Gm-Gg: AYBFou0CpnVyfBj5WXstoj2nWmuHDFXs9lILlq6UPpBSJpkcscWYAv17LRuov+SDqsS
	bzB0gPO48tTu5ugl8lUv1baIoKzvEgeMir/rW3JhF1npX8siHXzxo88ioJ51J1meGD7CU4lVvpQ
	FNElnHmQX99IDvh1XwSF9N02wVlnGkHjxhvNwm7PRn9AuBP3TPlYsGNDHhuo3ytzULRV9pxvTS2
	189exNCyBXirs7RKuE64HE1QvpdKxAktIJhHZAWvTVgrdi6LqKIOz1RLYjFQAEtnaE2zNJhBdxH
	XC8PeoR85ihNuOoNFDExHMYtZtBsOZ5dDqrZgKHz2p8nmuYmuALwYlO+9Sr/RAM/Ip18Ht06kFt
	MLR43HixTgnDSAkIyljvR1u0muWVzbewiRrOOzKyYgvJEx/739lGflHop4tHhjQV+uGXbS4oncr
	riR1Rqxwke8tL+QhA9Yuzw9IEp26Ke
X-Received: by 2002:a05:6808:2383:b0:4f7:8bdd:b74 with SMTP id
 5614622812f47-56e64f07813mr7362776b6e.51.1794810797985; Sun, 15 Nov 2026
 22:33:17 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106163123.208454-1-yupeng0921@gmail.com>
In-Reply-To: <20261106163123.208454-1-yupeng0921@gmail.com>
From: peng yu <yupeng0921@gmail.com>
Date: Sun, 15 Nov 2026 22:33:06 -0800
X-Gm-Features: AclHuK8Ey-D1J4zBl2f0fI1lLG2haCzaZjnWU4D6k-akiRvq9vj4Nja4mUoyrU8
Message-ID: <CAG3TDc1bDm7Dg7OcwOzBbEsyjgYOwt9RMF96OhQE0e65qsnnUQ@mail.gmail.com>
Subject: Re: [PATCH v13] nvmet: add cgroup_id to charge namespace I/O to a cgroup
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	Maurizio Lombardi <mlombard@arkamax.eu>, cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261115_223320_095476_26EFF6B7 
X-CRM114-Status: GOOD (  41.20  )
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
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,BITCOIN_OBFU_SUBJ,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BTC_ID,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi, Keith and Christoph, any opinion about this patch?

On Fri, Nov 6, 2026 at 8:31=E2=80=AFAM Peng Yu <yupeng0921@gmail.com> wrote=
:
>
> The nvmet issues namespace IOs from kernel threads. So the io.max and
> other cgroup controllers can't apply limits to the namespaces.
> Consider this scenario: LVM creates multiple logical volumes on the
> same physical disk, and the logical volumes are assigned to different
> nvmet subsystems/namespaces. We want to stop a remote noisy user from
> using all the disk iops via nvmet. So add a per namespace cgroup_id to
> associate the namespace with a cgroup. Each namespace can then be
> throttled separately.
>
> The per namespace cgroup is good enough for the io.max, but is not good
> enough for the io.cost and io.latency. The io.cost and io.latency may
> put a thread to sleep. If the thread is shared by different namespaces,
> all of them will be impacted together. Submit the IOs via a workqueue to
> avoid this impact.
>
> With cgroup_id set, every I/O command except Reservation commands runs
> from its own work item on a per namespace WQ_HIGHPRI workqueue. Zone
> management and the file backend's Flush, DSM and Write Zeroes run
> directly in that work item. Each work item runs under memalloc_noio and
> looks up the cgroup's effective io css. A command whose queue is being
> deleted is aborted. buffered_io is not supported.
>
> Performance test:
> On a 4 core VM and 4G ramdisk, export tcp-nvmeof targets to 127.0.0.1,
> run fio with below parameters:
> fio --bs=3D4k --rw=3Drandwrite --iodepth=3D32 --numjobs=3D4 --ioengine=3D=
libaio --direct=3D1
>
> file backend result:
> |                            | IOPS   | Mean Latency | p99 latency |
> |without this patch          | 204.4k | 625.8 =C2=B5s     | 668 =C2=B5s  =
    |
> |this patch, cgroup_id unset | 204.4k | 625.7 =C2=B5s     | 668 =C2=B5s  =
    |
> |this patch, cgroup_id set   | 155.9k | 820.6 =C2=B5s     | 1139 =C2=B5s =
    |
>
> block device backend result:
> |                            | IOPS   | Mean Latency | p99 latency |
> |without this patch          | 216.0k | 592.2 =C2=B5s     | 627 =C2=B5s  =
    |
> |this patch, cgroup_id unset | 216.0k | 592.1 =C2=B5s     | 627 =C2=B5s  =
    |
> |this patch, cgroup_id set   | 160.0k | 799.6 =C2=B5s     | 1090 =C2=B5s =
    |
>
> With this patch and no cgroup_id set, the performance is almost the same.
> When we set the cgroup_id, with no io controller limit, we can see a
> performance decrease but it is still very fast.
>
> Signed-off-by: Peng Yu <yupeng0921@gmail.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> Assisted-by: Claude:claude-fable-5 [Claude Code]
> Assisted-by: Claude:claude-opus-5-5 [Claude Code]
> ---
> Changes since v12 (Tejun's review of v12):
> * Comment at nvmet_req_run_work() that the file backend's Flush, DSM and
>   Write Zeroes and the zone management commands hold one of the
>   namespace workqueue's max_active slots for their whole duration.
> * Added Tejun's Acked-by from v12. The comment is the only other change.
>
> Tejun's v12 review: https://lore.kernel.org/all/95403f5dce741c515718b2fc7=
f5dcc64@kernel.org/
> v12: https://lore.kernel.org/all/20261104071600.470430-1-yupeng0921@gmail=
.com/
> Tejun's v11 review: https://lore.kernel.org/all/17d94c41da65e31e1579a7211=
ebb7aa1@kernel.org/
> v11: https://lore.kernel.org/all/20261029153103.13689-1-yupeng0921@gmail.=
com/
> Sashiko's v10 review: https://lore.kernel.org/all/sashiko-outbox-185466@k=
ernel.org/
> v10: https://lore.kernel.org/all/20261026153020.47791-1-yupeng0921@gmail.=
com/
> Tejun's v9 comment: https://lore.kernel.org/all/aee729fd53ef9c7c084a44321=
6cfeb39@kernel.org/
> v9: https://lore.kernel.org/all/20261023043423.176002-1-yupeng0921@gmail.=
com/
> v8: https://lore.kernel.org/all/20261002152821.410591-1-yupeng0921@gmail.=
com/
> v7 (with test steps): https://lore.kernel.org/all/20260929232411.101087-1=
-yupeng0921@gmail.com/
>
>  Documentation/ABI/stable/configfs-nvmet |  21 ++++
>  drivers/nvme/target/configfs.c          |  47 ++++++++
>  drivers/nvme/target/core.c              | 153 ++++++++++++++++++++++++
>  drivers/nvme/target/io-cmd-file.c       |  10 +-
>  drivers/nvme/target/nvmet.h             |  46 +++++++
>  drivers/nvme/target/zns.c               |   8 +-
>  6 files changed, 275 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/ABI/stable/configfs-nvmet b/Documentation/ABI/=
stable/configfs-nvmet
> index 36b587404ee7..c0b0b7ff100e 100644
> --- a/Documentation/ABI/stable/configfs-nvmet
> +++ b/Documentation/ABI/stable/configfs-nvmet
> @@ -314,6 +314,27 @@ Description:
>                 attr_subsys_vendor_id: Shows or sets the PCI subsystem
>                 vendor ID. Displayed in "0x%x" format.
>
> +What:          /config/nvmet/subsystems/NAME/namespaces/NSID/cgroup_id
> +Date:          November 2026
> +KernelVersion: 7.5
> +Contact:       Peng Yu <yupeng0921@gmail.com>
> +Description:
> +               Shows or sets the cgroup2 ID of the cgroup to charge this
> +               namespace's I/O to. Writing 0 clears it. The I/O is
> +               charged to the cgroup's effective io css: the cgroup
> +               itself or its nearest ancestor with the io controller
> +               enabled. The namespace must be disabled before
> +               modification. Enabling the namespace fails if the cgroup
> +               can't be found in the cgroup namespace of the enabling
> +               task, or if buffered_io is set. If the cgroup is removed
> +               while the namespace is enabled, the I/O goes to the
> +               effective io css of its nearest remaining ancestor; a
> +               cgroup that is removed and created again gets a new ID.
> +               Reservation commands and the flush of a Set Features
> +               Write Protect are not charged.
> +
> +               Only available when CONFIG_BLK_CGROUP is enabled.
> +
>  What:          /config/nvmet/hosts/HOSTNQN/dhchap_key
>  What:          /config/nvmet/hosts/HOSTNQN/dhchap_ctrl_key
>  What:          /config/nvmet/hosts/HOSTNQN/dhchap_hash
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configf=
s.c
> index b3a5242d06f9..622559022f07 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -572,6 +572,50 @@ static ssize_t nvmet_ns_device_path_store(struct con=
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
> @@ -844,6 +888,9 @@ static struct configfs_attribute *nvmet_ns_attrs[] =
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
> index 1dede04c204a..67aeb704b015 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -4,12 +4,15 @@
>   * Copyright (c) 2015-2016 HGST, a Western Digital Company.
>   */
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +#include <linux/cgroup.h>
>  #include <linux/hex.h>
> +#include <linux/kthread.h>
>  #include <linux/module.h>
>  #include <linux/random.h>
>  #include <linux/rculist.h>
>  #include <linux/pci-p2pdma.h>
>  #include <linux/scatterlist.h>
> +#include <linux/sched/mm.h>
>
>  #include <generated/utsrelease.h>
>
> @@ -483,8 +486,152 @@ void nvmet_put_namespace(struct nvmet_ns *ns)
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
> +        * Writeback of buffered writes is charged through the page cache=
's
> +        * memcg, not to this cgroup, so we don't support buffered io.
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
> +       /*
> +        * WQ_HIGHPRI: the tcp and rdma transports execute the commands f=
rom
> +        * WQ_HIGHPRI workqueues; keep that priority on this one.
> +        */
> +       ns->blkcg_wq =3D alloc_workqueue("nvmet-blkcg-%u",
> +                       WQ_MEM_RECLAIM | WQ_UNBOUND | WQ_HIGHPRI,
> +                       min_t(int, num_online_cpus(), WQ_MAX_ACTIVE),
> +                       ns->nsid);
> +       if (!ns->blkcg_wq) {
> +               cgroup_put(cgrp);
> +               return -ENOMEM;
> +       }
> +
> +       ns->cgrp =3D cgrp;
> +       return 0;
> +}
> +
> +static void nvmet_blkcg_ns_disable(struct nvmet_ns *ns)
> +{
> +       if (ns->cgrp) {
> +               /*
> +                * No command is left, but the work item of a command tha=
t
> +                * completed from inside ->blkcg_execute() may still be
> +                * returning: destroy_workqueue() waits for it.
> +                */
> +               destroy_workqueue(ns->blkcg_wq);
> +               ns->blkcg_wq =3D NULL;
> +               cgroup_put(ns->cgrp);
> +               ns->cgrp =3D NULL;
> +       }
> +}
> +
> +/*
> + * Charge the I/O that the current work item submits for @req to the
> + * effective io css of the namespace's cgroup, looked up for each comman=
d.
> + */
> +static bool nvmet_blkcg_begin(struct nvmet_req *req)
> +{
> +       struct nvmet_ns *ns =3D req->ns;
> +       struct cgroup_subsys_state *css;
> +
> +       /*
> +        * A disable waits for the command: don't throttle it any more. T=
his
> +        * catches only commands that haven't started; io.max holds the b=
ios
> +        * already submitted and releases them at its rate.
> +        */
> +       if (!test_bit(NVMET_NS_IO_LIVE, &ns->flags))
> +               return false;
> +
> +       css =3D cgroup_get_e_css(ns->cgrp, &io_cgrp_subsys);
> +       kthread_associate_blkcg(css);
> +       css_put(css);
> +       return true;
> +}
> +
> +static void nvmet_blkcg_end(bool associated)
> +{
> +       if (associated)
> +               kthread_associate_blkcg(NULL);
> +}
> +
> +/*
> + * The io.cost and io.latency enforce their limits by putting the thread=
 to
> + * sleep. A transport thread may be shared by multiple namespaces. In th=
e
> + * tcp-nvmeof case, all namespaces in the same subsystem may share a
> + * thread. So we submit the IOs via the workqueue, thus the current thre=
ad
> + * won't be blocked.
> + */
> +static void nvmet_blkcg_work(struct work_struct *work)
> +{
> +       struct nvmet_req *req =3D
> +               container_of(work, struct nvmet_req, blkcg_work);
> +       unsigned int noio_flag;
> +       bool associated;
> +
> +       /* its queue is being deleted: abort it rather than throttle it *=
/
> +       if (unlikely(percpu_ref_is_dying(&req->sq->ref))) {
> +               nvmet_req_complete(req, NVME_SC_ABORT_QUEUE);
> +               return;
> +       }
> +
> +       /* reclaim must not wait for I/O queued on this workqueue */
> +       noio_flag =3D memalloc_noio_save();
> +       associated =3D nvmet_blkcg_begin(req);
> +       req->blkcg_execute(req);
> +       nvmet_blkcg_end(associated);
> +       memalloc_noio_restore(noio_flag);
> +}
> +
> +static void nvmet_blkcg_queue_req(struct nvmet_req *req)
> +{
> +       INIT_WORK(&req->blkcg_work, nvmet_blkcg_work);
> +       queue_work(req->ns->blkcg_wq, &req->blkcg_work);
> +}
> +
> +static void nvmet_blkcg_init_req(struct nvmet_req *req)
> +{
> +       if (!req->ns->blkcg_wq)
> +               return;
> +
> +       req->blkcg_execute =3D req->execute;
> +       req->execute =3D nvmet_blkcg_queue_req;
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
> +
> +static inline void nvmet_blkcg_init_req(struct nvmet_req *req)
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
> @@ -611,6 +758,10 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
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
> @@ -1170,6 +1321,8 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req=
)
>         if (ret)
>                 return ret;
>
> +       nvmet_blkcg_init_req(req);
> +
>         if (req->ns->pr.enable) {
>                 ret =3D nvmet_pr_check_cmd_access(req);
>                 if (ret)
> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-c=
md-file.c
> index 695963dd932e..b9d221eeef57 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -265,8 +265,7 @@ static void nvmet_file_execute_flush(struct nvmet_req=
 *req)
>  {
>         if (!nvmet_check_transfer_len(req, 0))
>                 return;
> -       INIT_WORK(&req->f.work, nvmet_file_flush_work);
> -       queue_work(nvmet_wq, &req->f.work);
> +       nvmet_req_run_work(req, nvmet_wq, &req->f.work, nvmet_file_flush_=
work);
>  }
>
>  static void nvmet_file_execute_discard(struct nvmet_req *req)
> @@ -325,8 +324,7 @@ static void nvmet_file_execute_dsm(struct nvmet_req *=
req)
>  {
>         if (!nvmet_check_data_len_lte(req, nvmet_dsm_len(req)))
>                 return;
> -       INIT_WORK(&req->f.work, nvmet_file_dsm_work);
> -       queue_work(nvmet_wq, &req->f.work);
> +       nvmet_req_run_work(req, nvmet_wq, &req->f.work, nvmet_file_dsm_wo=
rk);
>  }
>
>  static void nvmet_file_write_zeroes_work(struct work_struct *w)
> @@ -355,8 +353,8 @@ static void nvmet_file_execute_write_zeroes(struct nv=
met_req *req)
>  {
>         if (!nvmet_check_transfer_len(req, 0))
>                 return;
> -       INIT_WORK(&req->f.work, nvmet_file_write_zeroes_work);
> -       queue_work(nvmet_wq, &req->f.work);
> +       nvmet_req_run_work(req, nvmet_wq, &req->f.work,
> +                       nvmet_file_write_zeroes_work);
>  }
>
>  u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 3cd58e813aa7..96306f5c09ae 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -118,6 +118,22 @@ struct nvmet_ns {
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
> +       /*
> +        * The I/O commands of a namespace with a cgroup, except Reservat=
ion
> +        * commands, are executed from their own work items on ->blkcg_wq=
, so
> +        * the cgroup's throttling doesn't put a transport context to sle=
ep.
> +        */
> +       struct workqueue_struct *blkcg_wq;
> +#endif
> +
>         struct config_group     device_group;
>         struct config_group     group;
>
> @@ -510,6 +526,11 @@ struct nvmet_req {
>
>         void (*execute)(struct nvmet_req *req);
>         const struct nvmet_fabrics_ops *ops;
> +#ifdef CONFIG_BLK_CGROUP
> +       /* the backend's ->execute, called from ->blkcg_work */
> +       void (*blkcg_execute)(struct nvmet_req *req);
> +       struct work_struct      blkcg_work;
> +#endif
>
>         struct pci_dev          *p2p_dev;
>         struct device           *p2p_client;
> @@ -756,6 +777,31 @@ void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_=
req *req);
>  void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);
>  void nvmet_bdev_execute_zone_append(struct nvmet_req *req);
>
> +/*
> + * A command of a namespace with a cgroup already runs from its own work
> + * item on the namespace's workqueue (see nvmet_blkcg_work()), so run th=
e
> + * backend's work function right there; otherwise queue it on @wq.
> + *
> + * So with a cgroup, the file backend's Flush, DSM and Write Zeroes and
> + * the zone management commands hold one of blkcg_wq's max_active slots
> + * for the whole vfs_fsync(), vfs_fallocate() or zone operation. That ca=
n
> + * only delay other commands of the same namespace, which are charged to
> + * the same cgroup.
> + */
> +static inline void nvmet_req_run_work(struct nvmet_req *req,
> +               struct workqueue_struct *wq, struct work_struct *work,
> +               work_func_t func)
> +{
> +#ifdef CONFIG_BLK_CGROUP
> +       if (req->ns->blkcg_wq) {
> +               func(work);
> +               return;
> +       }
> +#endif
> +       INIT_WORK(work, func);
> +       queue_work(wq, work);
> +}
> +
>  static inline u32 nvmet_rw_data_len(struct nvmet_req *req)
>  {
>         return ((u32)le16_to_cpu(req->cmd->rw.length) + 1) <<
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
> index 92f5c1435582..38455481da24 100644
> --- a/drivers/nvme/target/zns.c
> +++ b/drivers/nvme/target/zns.c
> @@ -335,8 +335,8 @@ void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_r=
eq *req)
>         if (!nvmet_check_transfer_len(req, (numd + 1) << 2))
>                 return;
>
> -       INIT_WORK(&req->z.zmgmt_work, nvmet_bdev_zone_zmgmt_recv_work);
> -       queue_work(zbd_wq, &req->z.zmgmt_work);
> +       nvmet_req_run_work(req, zbd_wq, &req->z.zmgmt_work,
> +                          nvmet_bdev_zone_zmgmt_recv_work);
>  }
>
>  static inline enum req_op zsa_req_op(u8 zsa)
> @@ -534,8 +534,8 @@ static void nvmet_bdev_zmgmt_send_work(struct work_st=
ruct *w)
>
>  void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
>  {
> -       INIT_WORK(&req->z.zmgmt_work, nvmet_bdev_zmgmt_send_work);
> -       queue_work(zbd_wq, &req->z.zmgmt_work);
> +       nvmet_req_run_work(req, zbd_wq, &req->z.zmgmt_work,
> +                          nvmet_bdev_zmgmt_send_work);
>  }
>
>  static void nvmet_bdev_zone_append_bio_done(struct bio *bio)
>
> base-commit: ca7e6a9a693240f059a0b47726f64a3f0573011a
> --
> 2.53.0
>

