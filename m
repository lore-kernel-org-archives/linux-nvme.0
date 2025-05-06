Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53DEC3ABBC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 20:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LYWN5cRoGfT1PfSiqnzPsV4NQG6bqVTjCaW1CwrUJcM=; b=1drcnZuWgjQ8N32HWFiesHaYF5
	jGLajsly7ySQxzpOyRf3IYzBT57R0cyfozVGYvWQR/dTElovyJz840YFj+iBqmT/h1S9ltPSCMTAy
	mqoRFkrrPkNRWDxK9+Uoj8zcFpcqN9Dr0LeyF6+VUsfVtPWPXGjbjKSK+cMEe6chn2DD1oui9GFP4
	U5XjCQuDUtpe6xeEcVLr0sEVVyjB68QBV5BiYekimzVrxKAAAGWXOeV0ANVQnRg9wW/IcSWjosB5I
	X5fMKA9X2NsSW6vrb9rrwYpObmkgkzYDN9deNSb8MoZ/wfB8RCkyZxpAKtq1cQe6AoB8OqdBYLRcF
	d1jGDDRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCOXS-0000000DJNj-3zas;
	Tue, 06 May 2025 20:05:14 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCKvc-0000000CdZ7-0crE
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 16:13:57 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-3087a70557bso674003a91.2
        for <linux-nvme@lists.infradead.org>; Tue, 06 May 2025 09:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746548035; x=1747152835; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYWN5cRoGfT1PfSiqnzPsV4NQG6bqVTjCaW1CwrUJcM=;
        b=CQbdCw1nzPriWPvC/4Um82UV7P1K66STTjmjpys10HNfs1YoUpRC922w4Kxrbc74v8
         tlrrTfNL9RIiC+766iCp/0U79sp9l3TvefpHveH4LcDhS1lzcZgvHluHoTRFluDvP1+n
         0FciYBhNIS+mVTwebeP6IeV30NDep1ka9diCV/OAXjXMSyiNA0IXp3Xa8hkdiEKpQoX0
         3fNxnqT8ZM5xNpyEVjpO1nZBHLkBPKvUeFj1Dhsh07UGCLS/oWX85YPa8esufjN4eQ9F
         GKs1NwTYpjW8VFClOqT5KE/GKHnkC8PoOrW4o/bNN86WuY6592mH5O0JNqSLl+TOStwX
         816Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746548035; x=1747152835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYWN5cRoGfT1PfSiqnzPsV4NQG6bqVTjCaW1CwrUJcM=;
        b=FeQqV0PkkO/NfKQnIR2EG8w4k9kbDVnzcViYLoN34YFN/rDjZdQjyrlabqIJJBF+sM
         BJh98iuFVh3XwGPFRmq0HbYmICwf74S1ut2rEK93mym+FSHE7afMVFJxHiev+eJjmqqC
         zOSt/043oNRDP54elPonTcMRjMgdb8fO/1XV8jqow89YkMQ9QvTNu60ZhldMQdXFC/vV
         myQqTxPlXnkWzgPiZk2IpVJghqYzpgZ1mg1+CMHv2BRW8Ajt+QjUgK4bJfwlqAens56a
         ZcDT1VSAjFlLd4vy/Qu79IsXZrWP0OqLDlr3rQaUO7O49O5AsDavyoMsXfocDzvKqFTg
         UrMA==
X-Forwarded-Encrypted: i=1; AJvYcCW3t2PMUGk4nbn1S9YgyH2xhD/QTnSIJ2lxcy8cFI/jHXbwlRxf4vQz9jlHXUQLmtwvjSaLJA8dvSTc@lists.infradead.org
X-Gm-Message-State: AOJu0YxlvgtGPYh1jsvL6LdECSpY9wkp47fulxuc6OIvFcKDML93Cb5U
	i1Ojo1PbbL3qcuINks9cXl6hyatJnmq8APFPyQhcgYRix0/CDLL7nEKs9fcjQBYEN7nlmZeXuaY
	dccLIL/oVDRa2wH5cwIdeyd4x4AheWGwwNMz+9w==
X-Gm-Gg: ASbGncs0Wu7nua8MrKLQuELWUIN4yYSF4iG6UW8/AqYtX1MZ7AJik681myUWXQR6JVA
	DlWJCzDkNcke01nqztSaOND7marvssWh7esNDgq6d0Vf+jTB5MarL/wUZZ3KiKAGAUnEVltzJXe
	1LgyRPMdJmpuTXLM7+pehZ
X-Google-Smtp-Source: AGHT+IGOvJyPbLr4kwXZSGT/2CsH/jVCIq02WBu70npsFnHamIQl6sWwQf+KO12hU6AkAJPFapxgBzCBfCm4l5n/zjI=
X-Received: by 2002:a17:90b:33c1:b0:2ff:5759:549a with SMTP id
 98e67ed59e1d1-30aac16c2e2mr36846a91.1.1746548035169; Tue, 06 May 2025
 09:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20250506122651epcas5p4100fd5435ce6e6686318265b414c1176@epcas5p4.samsung.com>
 <20250506121732.8211-1-joshi.k@samsung.com> <20250506121732.8211-11-joshi.k@samsung.com>
In-Reply-To: <20250506121732.8211-11-joshi.k@samsung.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 6 May 2025 09:13:33 -0700
X-Gm-Features: ATxdqUE6maBvoXv4TdPf4qTULxuJw6-FSb-pKV6qaK5B-HKqjYsETzXEW4MddQU
Message-ID: <CADUfDZqqqQVHqMpVaMWre1=GZfu42_SOQ5W9m0vhSZYyp1BBUA@mail.gmail.com>
Subject: Re: [PATCH v16 10/11] nvme: register fdp parameters with the block layer
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, asml.silence@gmail.com, 
	io-uring@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Hannes Reinecke <hare@suse.de>, Nitesh Shetty <nj.shetty@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_091356_241343_4201844E 
X-CRM114-Status: GOOD (  27.34  )
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

On Tue, May 6, 2025 at 5:31=E2=80=AFAM Kanchan Joshi <joshi.k@samsung.com> =
wrote:
>
> From: Keith Busch <kbusch@kernel.org>
>
> Register the device data placement limits if supported. This is just
> registering the limits with the block layer. Nothing beyond reporting
> these attributes is happening in this patch.
>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
>  drivers/nvme/host/core.c | 144 +++++++++++++++++++++++++++++++++++++++
>  drivers/nvme/host/nvme.h |   2 +
>  2 files changed, 146 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index dd71b4c2b7b7..f25e03ff03df 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -38,6 +38,8 @@ struct nvme_ns_info {
>         u32 nsid;
>         __le32 anagrpid;
>         u8 pi_offset;
> +       u16 endgid;
> +       u64 runs;
>         bool is_shared;
>         bool is_readonly;
>         bool is_ready;
> @@ -1611,6 +1613,7 @@ static int nvme_ns_info_from_identify(struct nvme_c=
trl *ctrl,
>         info->is_shared =3D id->nmic & NVME_NS_NMIC_SHARED;
>         info->is_readonly =3D id->nsattr & NVME_NS_ATTR_RO;
>         info->is_ready =3D true;
> +       info->endgid =3D le16_to_cpu(id->endgid);
>         if (ctrl->quirks & NVME_QUIRK_BOGUS_NID) {
>                 dev_info(ctrl->device,
>                          "Ignoring bogus Namespace Identifiers\n");
> @@ -1651,6 +1654,7 @@ static int nvme_ns_info_from_id_cs_indep(struct nvm=
e_ctrl *ctrl,
>                 info->is_ready =3D id->nstat & NVME_NSTAT_NRDY;
>                 info->is_rotational =3D id->nsfeat & NVME_NS_ROTATIONAL;
>                 info->no_vwc =3D id->nsfeat & NVME_NS_VWC_NOT_PRESENT;
> +               info->endgid =3D le16_to_cpu(id->endgid);
>         }
>         kfree(id);
>         return ret;
> @@ -2155,6 +2159,132 @@ static int nvme_update_ns_info_generic(struct nvm=
e_ns *ns,
>         return ret;
>  }
>
> +static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
> +                                     struct nvme_ns_info *info, u8 fdp_i=
dx)
> +{
> +       struct nvme_fdp_config_log hdr, *h;
> +       struct nvme_fdp_config_desc *desc;
> +       size_t size =3D sizeof(hdr);
> +       void *log, *end;
> +       int i, n, ret;
> +
> +       ret =3D nvme_get_log_lsi(ctrl, 0, NVME_LOG_FDP_CONFIGS, 0,
> +                              NVME_CSI_NVM, &hdr, size, 0, info->endgid)=
;
> +       if (ret) {
> +               dev_warn(ctrl->device,
> +                        "FDP configs log header status:0x%x endgid:%d\n"=
, ret,
> +                        info->endgid);
> +               return ret;
> +       }
> +
> +       size =3D le32_to_cpu(hdr.sze);
> +       if (size > PAGE_SIZE * MAX_ORDER_NR_PAGES) {
> +               dev_warn(ctrl->device, "FDP config size too large:%zu\n",
> +                        size);
> +               return 0;
> +       }
> +
> +       h =3D kvmalloc(size, GFP_KERNEL);
> +       if (!h)
> +               return -ENOMEM;
> +
> +       ret =3D nvme_get_log_lsi(ctrl, 0, NVME_LOG_FDP_CONFIGS, 0,
> +                              NVME_CSI_NVM, h, size, 0, info->endgid);
> +       if (ret) {
> +               dev_warn(ctrl->device,
> +                        "FDP configs log status:0x%x endgid:%d\n", ret,
> +                        info->endgid);
> +               goto out;
> +       }
> +
> +       n =3D le16_to_cpu(h->numfdpc) + 1;
> +       if (fdp_idx > n) {
> +               dev_warn(ctrl->device, "FDP index:%d out of range:%d\n",
> +                        fdp_idx, n);
> +               /* Proceed without registering FDP streams */
> +               ret =3D 0;
> +               goto out;
> +       }
> +
> +       log =3D h + 1;
> +       desc =3D log;
> +       end =3D log + size - sizeof(*h);
> +       for (i =3D 0; i < fdp_idx; i++) {
> +               log +=3D le16_to_cpu(desc->dsze);
> +               desc =3D log;
> +               if (log >=3D end) {
> +                       dev_warn(ctrl->device,
> +                                "FDP invalid config descriptor list\n");
> +                       ret =3D 0;
> +                       goto out;
> +               }
> +       }
> +
> +       if (le32_to_cpu(desc->nrg) > 1) {
> +               dev_warn(ctrl->device, "FDP NRG > 1 not supported\n");
> +               ret =3D 0;
> +               goto out;
> +       }
> +
> +       info->runs =3D le64_to_cpu(desc->runs);
> +out:
> +       kvfree(h);
> +       return ret;
> +}
> +
> +static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *=
info)
> +{
> +       struct nvme_ns_head *head =3D ns->head;
> +       struct nvme_ctrl *ctrl =3D ns->ctrl;
> +       struct nvme_fdp_ruh_status *ruhs;
> +       struct nvme_fdp_config fdp;
> +       struct nvme_command c =3D {};
> +       size_t size;
> +       int ret;
> +
> +       /*
> +        * The FDP configuration is static for the lifetime of the namesp=
ace,
> +        * so return immediately if we've already registered this namespa=
ce's
> +        * streams.
> +        */
> +       if (head->nr_plids)
> +               return 0;
> +
> +       ret =3D nvme_get_features(ctrl, NVME_FEAT_FDP, info->endgid, NULL=
, 0,
> +                               &fdp);
> +       if (ret) {
> +               dev_warn(ctrl->device, "FDP get feature status:0x%x\n", r=
et);
> +               return ret;
> +       }
> +
> +       if (!(fdp.flags & FDPCFG_FDPE))
> +               return 0;
> +
> +       ret =3D nvme_query_fdp_granularity(ctrl, info, fdp.fdpcidx);
> +       if (!info->runs)
> +               return ret;
> +
> +       size =3D struct_size(ruhs, ruhsd, S8_MAX - 1);
> +       ruhs =3D kzalloc(size, GFP_KERNEL);
> +       if (!ruhs)
> +               return -ENOMEM;
> +
> +       c.imr.opcode =3D nvme_cmd_io_mgmt_recv;
> +       c.imr.nsid =3D cpu_to_le32(head->ns_id);
> +       c.imr.mo =3D NVME_IO_MGMT_RECV_MO_RUHS;
> +       c.imr.numd =3D cpu_to_le32(nvme_bytes_to_numd(size));
> +       ret =3D nvme_submit_sync_cmd(ns->queue, &c, ruhs, size);
> +       if (ret) {
> +               dev_warn(ctrl->device, "FDP io-mgmt status:0x%x\n", ret);
> +               goto free;
> +       }
> +
> +       head->nr_plids =3D le16_to_cpu(ruhs->nruhsd);
> +free:
> +       kfree(ruhs);
> +       return ret;
> +}
> +
>  static int nvme_update_ns_info_block(struct nvme_ns *ns,
>                 struct nvme_ns_info *info)
>  {
> @@ -2192,6 +2322,12 @@ static int nvme_update_ns_info_block(struct nvme_n=
s *ns,
>                         goto out;
>         }
>
> +       if (ns->ctrl->ctratt & NVME_CTRL_ATTR_FDPS) {
> +               ret =3D nvme_query_fdp_info(ns, info);
> +               if (ret < 0)
> +                       goto out;
> +       }
> +
>         lim =3D queue_limits_start_update(ns->disk->queue);
>
>         memflags =3D blk_mq_freeze_queue(ns->disk->queue);
> @@ -2225,6 +2361,12 @@ static int nvme_update_ns_info_block(struct nvme_n=
s *ns,
>         if (!nvme_init_integrity(ns->head, &lim, info))
>                 capacity =3D 0;
>
> +       lim.max_write_streams =3D ns->head->nr_plids;
> +       if (lim.max_write_streams)
> +               lim.write_stream_granularity =3D max(info->runs, U32_MAX)=
;

What is the purpose of this max(..., U32_MAX)? Should it be min() instead?

Best,
Caleb

> +       else
> +               lim.write_stream_granularity =3D 0;
> +
>         ret =3D queue_limits_commit_update(ns->disk->queue, &lim);
>         if (ret) {
>                 blk_mq_unfreeze_queue(ns->disk->queue, memflags);
> @@ -2328,6 +2470,8 @@ static int nvme_update_ns_info(struct nvme_ns *ns, =
struct nvme_ns_info *info)
>                         ns->head->disk->flags |=3D GENHD_FL_HIDDEN;
>                 else
>                         nvme_init_integrity(ns->head, &lim, info);
> +               lim.max_write_streams =3D ns_lim->max_write_streams;
> +               lim.write_stream_granularity =3D ns_lim->write_stream_gra=
nularity;
>                 ret =3D queue_limits_commit_update(ns->head->disk->queue,=
 &lim);
>
>                 set_capacity_and_notify(ns->head->disk, get_capacity(ns->=
disk));
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index aedb734283b8..3e14daa4ed3e 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -496,6 +496,8 @@ struct nvme_ns_head {
>         struct device           cdev_device;
>
>         struct gendisk          *disk;
> +
> +       u16                     nr_plids;
>  #ifdef CONFIG_NVME_MULTIPATH
>         struct bio_list         requeue_list;
>         spinlock_t              requeue_lock;
> --
> 2.25.1
>
>

