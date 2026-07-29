Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F9BC53200
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 11:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XbgqTYonIsiTok+qEzE9jOZisSU/5kPo/KCsXMi5+z0=; b=v8/TPVI8a1S3D1cQDXPgg3YXD+
	8rHZ9P/9cFqh5zS2Ko+kpldhL/wiIP5VFAS5z/9bXLHcHw6rzIQZqeqWTDrvouoVXabLj2cJnOxP2
	xrYvYqpdrSiLO1kfoUlbxIL5L/faSRE0OmRfd/jDKVgWAXqaWJwjXX6YcwFQWIf9ylq0Jk3BqqWQ/
	Jtzrr3Jtw2znYYwkKMcUDo+dgmzFd1XR2mveyUGYT+adpP4JoqrHbViQAOqHTRbmPw5awEFuF3t5w
	70c6qpX8M2laXAfuOZfJf0r/CxRtNq+PVZGKY2Sw92KAvj303HXjyjwKS/ou0GjeysEpMmzcnGusA
	5528VKAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp2lW-00000007mXQ-1aKY;
	Wed, 29 Jul 2026 11:48:02 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp2lU-00000007mW5-1GqX
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 11:48:01 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-38e08baf860so895073a91.2
        for <linux-nvme@lists.infradead.org>; Wed, 29 Jul 2026 04:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785325679; cv=none;
        d=google.com; s=arc-20260327;
        b=CEntxC5GqXmuO0mQyIVBm40SepVCGxFEdShbGqlC2SWuYkr3IYbicwDGwmpp1z92TC
         aq0hCsQuLIuUd8FaQpmxLzlvO0afyLnGUFS+Wi3sxyY6z8KjnHAuiPfQz8GKztRN25uq
         7QonlpcX12Tl7ZSMDUtmmVLGeY1EM0p04o+RbJQgU1ce2pXEztrlkVqpPUGKflZibsXH
         nqNKV/YTu/QYQwVpqLJpBa8uCTx7xlBn2s4yQWqjGLFjI6g5i5jR1xIVHfCc9MFwiJlt
         LJVTqi5yIz3DnSVXvJzwrTNLl7PDNxRXVZTDu8fhoE75Q/WkW0xia5d5b8L4p7p/luj6
         EOwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XbgqTYonIsiTok+qEzE9jOZisSU/5kPo/KCsXMi5+z0=;
        fh=rRB/rn21n3CXjsjXIG3B1sNVY7g0GjQ2oLvywdpn6as=;
        b=NhObhfDl2z0ORRO1dGfb2prF92JjcFQbVRDYvxpN1G6I1+0tybPmkbk13NAr3hVKs7
         Ywdbunfv8IH5VJqIT/i9HoAHf9UGNLUmE7pkx7WmYVP0z+2joeWQd6K2qO0WYk7AWLa7
         eeLsVMDWcU2HHtMSRl8UU9mPYd/f6+PUkwzOfhszlo2jfaYCjHWqWpdECqfIYOBStAgR
         YwW5xJOO0U5t43wfsne4A3XRvXCbY6utuQMeisbJMxUwAEJMh/kUKLUsgB8MYIhb3t+1
         OqwdH5nPuan/qbdCr4sswxw8ft/blpOVZyIEShXVFQHLJbiuGaroIYixdfNnAmxXGHge
         O06A==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785325679; x=1785930479; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XbgqTYonIsiTok+qEzE9jOZisSU/5kPo/KCsXMi5+z0=;
        b=eklYo5MOKExj+fzDE+HVeMV9QH2Ffmp7/YoAX2CwUHQwdb+xaZF/KxldYf+nIXvMUo
         5HFm28kggUrrn3gPZNoIik3hhWbCqrP7yuC208yRyQ700/ehivq9gKTjaqdW4CQTXjRY
         /JdnXrZ348K5oLzfOi9W3M32bVu7VmVhnoAuVWSBQINLBP8eXKN/cQup2R9QDYC72j54
         qJgEszkqN4f/ntdUE6KXrQj+8SOPkSmQwrM6uK/4Db9a2cgreiW6d2rPWRVfxu2aPxDa
         sixDxfgkiHyxkIULTeD5ms+fl3oxDJC10nrklBkTOS55sDVVhrB2s8ppTVZAP97WDkwT
         w8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785325679; x=1785930479;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XbgqTYonIsiTok+qEzE9jOZisSU/5kPo/KCsXMi5+z0=;
        b=sY1VAGIlxB1dEYJR95epFfAgPuwJ+2tRs4/dXNrseMjHW5W8ZP20jh46l1v0D6JVTY
         mKJxSkTOzBwrTXd49u/ne3XXMFS12O3rIRwwsekt1ryYNRRdlIkTSlBvG6EIP2VlhTuw
         DZ+G+yEkv18cMLvGN9irlxEeetxW3tmdCX4S32xW+gHAFZ3Si9L/CvWtkvorEoXIuszB
         P2KB1z1dmZml7zIGc8IzUsq5l/43ZUl7C52zfxbl2guHs7KkpdR6IkADSxjhMHE6tbhO
         n1zNvn1Q8JD6GrltbPenbL3hYO790rpAIbPJp8en/sAnLXtZaqd7lqYrfH6NbtQo/LEv
         vROw==
X-Forwarded-Encrypted: i=1; AHgh+Rooxgn8/Sq2d73qIDaD88HsJwzx0DOqpmKtE1i7Slkien+H1ieexWL1TuCN7wF8xQ0ykQHlouoOcoy4@lists.infradead.org
X-Gm-Message-State: AOJu0Yy38sjL5tIYl+t81LZR3RtF2ePl7BX+UIX+1SyGRmzse2NNh6Ub
	Z+iZk9o4I7XroeQxGrHyRm4Nws76YNzy/8n+2kppCZCwFOXGpdrHOUJHGET+jlx3JofMYO9ejW7
	K24FcnaSF60CVU1KDOYFfgu8hQsw1+z0=
X-Gm-Gg: AR+sD11S0NRsEspXQLeCChKzAknhap91XBpiKw+bqd1ZZhLQmTCaASoeKmVoS6o/i4v
	+WeJubxkZxk2HlaVKJcn/ZG0duHA6mmUK4L8F8Ilh94rUviTwGOjc6h8OPg69Zjav2A+vEXpBJP
	kFurMIOm45CyhvdL3VtD2qB1b1O1fIgBZtHsS4LTNScbgNY1XaZV8vjItUvFyrBbWQkn9jh65Ih
	LQltIy2uSL0ZhU3Jvtv6EN6ppvlPGosFlbmrm9ytT1dsR42QpxhYQ9wV67QWLA7pK1N1NtfTr7t
	/QPRN+RPVpEKikHS7f9NdOH4uD3/yERfJm4R7iTwGqWW5Asxhu7JIzIxTyWTAc0fSHldfTLdALc
	=
X-Received: by 2002:a17:90b:57ce:b0:37f:c69d:ce69 with SMTP id
 98e67ed59e1d1-38f6a44abe3mr6919667a91.10.1785325679116; Wed, 29 Jul 2026
 04:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260725135111.14041-1-harimishal1@gmail.com> <CGME20260725135125epcas5p26801513d440f066295ef2d44035ce3db@epcas5p2.samsung.com>
 <20260725135111.14041-2-harimishal1@gmail.com> <7c3e3243-0c9a-436b-b5c2-e6092e181435@samsung.com>
 <96dadac7-a072-48ba-b282-356d29ed789a@samsung.com>
In-Reply-To: <96dadac7-a072-48ba-b282-356d29ed789a@samsung.com>
From: Hari Mishal <harimishal1@gmail.com>
Date: Wed, 29 Jul 2026 13:47:47 +0200
X-Gm-Features: AUfX_mzrIMij8r9fxCL9MagYftn2Du-QFu2rnD7-Yg_9GpKfy_yGuArlYpOYvrg
Message-ID: <CAMmC+=ApjmaGpnsxYBo7C-0BsROWJ=ffDc9FQSs9fn4wr7Amxg@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvme: fix racy access to FDP placement ID array
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Nitesh Shetty <nj.shetty@samsung.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_044800_352951_69161814 
X-CRM114-Status: GOOD (  28.25  )
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

Hi Kanchan,

I think your patch does solve all the problems. Should I resubmit the
patch as a V2 or a new one?

Cheers,
Hari

On Mon, Jul 27, 2026 at 4:22=E2=80=AFPM Kanchan Joshi <joshi.k@samsung.com>=
 wrote:
>
> Hari,
>
> Can you please try this patch and see if this solves what you saw?
>
>   drivers/nvme/host/core.c | 38 +++++++++++++++++---------------------
>   drivers/nvme/host/nvme.h |  1 +
>   2 files changed, 18 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 453c1f0b2dd0..09cb22f6509c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2320,14 +2320,6 @@ static int nvme_query_fdp_info(struct nvme_ns
> *ns, struct nvme_ns_info *info)
>          size_t size;
>          int i, ret;
>
> -       /*
> -        * The FDP configuration is static for the lifetime of the
> namespace,
> -        * so return immediately if we've already registered this
> namespace's
> -        * streams.
> -        */
> -       if (head->nr_plids)
> -               return 0;
> -
>          ret =3D nvme_get_features(ctrl, NVME_FEAT_FDP, info->endgid, NUL=
L, 0,
>                                  &fdp);
>          if (ret) {
> @@ -2374,6 +2366,7 @@ static int nvme_query_fdp_info(struct nvme_ns *ns,
> struct nvme_ns_info *info)
>
>          for (i =3D 0; i < head->nr_plids; i++)
>                  head->plids[i] =3D le16_to_cpu(ruhs->ruhsd[i].pid);
> +       head->write_stream_granularity =3D min(info->runs, U32_MAX);
>   free:
>          kfree(ruhs);
>          return ret;
> @@ -2421,12 +2414,6 @@ static int nvme_update_ns_info_block(struct
> nvme_ns *ns,
>                          goto out;
>          }
>
> -       if (ns->ctrl->ctratt & NVME_CTRL_ATTR_FDPS) {
> -               ret =3D nvme_query_fdp_info(ns, info);
> -               if (ret < 0)
> -                       goto out;
> -       }
> -
>          if (nvme_invalid_lba_sz(le64_to_cpu(id->nsze),
>                          id->lbaf[lbaf].ds - SECTOR_SHIFT, &capacity)) {
>                  dev_warn_once(ns->ctrl->device,
> @@ -2469,10 +2456,7 @@ static int nvme_update_ns_info_block(struct
> nvme_ns *ns,
>                  capacity =3D 0;
>
>          lim.max_write_streams =3D ns->head->nr_plids;
> -       if (lim.max_write_streams)
> -               lim.write_stream_granularity =3D min(info->runs, U32_MAX)=
;
> -       else
> -               lim.write_stream_granularity =3D 0;
> +       lim.write_stream_granularity =3D ns->head->write_stream_granulari=
ty;
>
>          /*
>           * Only set the DEAC bit if the device guarantees that reads fro=
m
> @@ -3964,9 +3948,10 @@ static void nvme_add_ns_cdev(struct nvme_ns *ns)
>          set_bit(NVME_NS_CDEV_LIVE, &ns->flags);
>   }
>
> -static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
> +static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ns *ns,
>                  struct nvme_ns_info *info)
>   {
> +       struct nvme_ctrl *ctrl =3D ns->ctrl;
>          struct nvme_ns_head *head;
>          size_t size =3D sizeof(*head);
>          int ret =3D -ENOMEM;
> @@ -4002,15 +3987,26 @@ static struct nvme_ns_head
> *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>          } else
>                  head->effects =3D ctrl->effects;
>
> +       if (ctrl->ctratt & NVME_CTRL_ATTR_FDPS) {
> +               ns->head =3D head;
> +               ret =3D nvme_query_fdp_info(ns, info);
> +               if (ret < 0)
> +                       goto out_clear_ns_head;
> +       }
> +
>          ret =3D nvme_mpath_alloc_disk(ctrl, head);
>          if (ret)
> -               goto out_cleanup_srcu;
> +               goto out_cleanup_fdp;
>
>          list_add_tail(&head->entry, &ctrl->subsys->nsheads);
>
>          kref_get(&ctrl->subsys->ref);
>
>          return head;
> +out_cleanup_fdp:
> +       kfree(head->plids);
> +out_clear_ns_head:
> +       ns->head =3D NULL;
>   out_cleanup_srcu:
>          cleanup_srcu_struct(&head->srcu);
>   out_ida_remove:
> @@ -4103,7 +4099,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns,
> struct nvme_ns_info *info)
>                                  info->nsid);
>                          goto out_unlock;
>                  }
> -               head =3D nvme_alloc_ns_head(ctrl, info);
> +               head =3D nvme_alloc_ns_head(ns, info);
>                  if (IS_ERR(head)) {
>                          ret =3D PTR_ERR(head);
>                          goto out_unlock;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 824651cc898d..3ae73b36866d 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -560,6 +560,7 @@ struct nvme_ns_head {
>
>          u16                     nr_plids;
>          u16                     *plids;
> +       u32                     write_stream_granularity;
>   #ifdef CONFIG_NVME_MULTIPATH
>          struct bio_list         requeue_list;
>          spinlock_t              requeue_lock;
> --
> 2.25.1
>

