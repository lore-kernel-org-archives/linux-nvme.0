Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2291CD5BC9
	for <linux-nvme@archiver.kernel.org>; Mon, 25 May 2026 20:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=evOf6OjsacDhvWXWbJVQf9b5BL5/AqphoOMr2vwYlUc=; b=SnODdbo1LZyMkIJ8YFgjKgAHZV
	47LDQsw1P2sS2FwSsq6gA7FgOrxbMQwyh6nRnSUqIxMtKRMbILI8iMJ09exkkkHWnOJCCBSWINmAU
	rcUvzS619wKYi6/hRdSrihgwUf1JhztEvmVrwc1SbUrNx/0vUKEHZao3g/p4VTenjJEB0O9mWDvWW
	0ulZI2EdH027e9jwBHsFKjQy6zsbE50SSp6NlHdTUjHo5ASGLWAKrN5yEpKMLiqGxbHxcUBQdTi7t
	o/B8zh+5cuxdHRbkq2HX6Z+Z2FZusmuHPZBJsUlLqraP+TigXU7j3Mo7AN44ZUnBrOYLQWqhDhToy
	+ofl0uMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRbts-00000000PSR-3QGy;
	Mon, 25 May 2026 20:27:48 +0000
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRbtq-00000000PRv-1hnM
	for linux-nvme@lists.infradead.org;
	Mon, 25 May 2026 20:27:47 +0000
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-bd8f9889a8cso1141734966b.1
        for <linux-nvme@lists.infradead.org>; Mon, 25 May 2026 13:27:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779740864; cv=none;
        d=google.com; s=arc-20240605;
        b=jEaySjFtVXnDBA/ZP4GaojUlNeepVRJLdMuxma3EwImWSUr3kCAs8h4CRGkQrvrw5V
         uyYsLXQuqqcqcNlGcaNSVorQvST8pNAqtZsvcP9DVe2FnmmFmVhaBSkd2Wm4lkbNFzp4
         X8prWZUhtBzOnA0fDE40JpV+Oua2RzgirxFvHdoZuvw+/TJO9MxZjCs+oqmCZCl2vJ3a
         jegcC30HarH9OGBIm5DhR0kCRSBIWhcc08By2Sz5WV6WFFQjZa2ruIVZOSEuFKgsquzz
         lS2Acd5K/ZyF1/pVvYMPX4KVEONyVCn5fn3qj9l7REI6pu6QZ4Y548NPO33m5f7XkDtZ
         zMtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=evOf6OjsacDhvWXWbJVQf9b5BL5/AqphoOMr2vwYlUc=;
        fh=dsYq0PN3qx4Qy+GbIKMS4QJXHZ2EiiMoragERfG1joo=;
        b=ZnmX0y3FRUad0bDHP0K4+4QG/Gm5j5b2NB8E10MYLi3Pl5cT5kmrWj7krFDu5/99o/
         L83arKozq1gvDAHHb+FvbuK227EmDoK+yqbDLM/9s+K9HqCFqGnmyhnhVmMIL+K9M0c3
         MkuEeq8T+MY0G+W8zPld13E70wcrzvW4HIUGUBkg72tbVfXvYY+q1cZGDGYTJr6midwq
         0cZkFxVUq2yA2sVBbipxCemOCgl5P9JRVqM1NJDycNyiV7rWZnZazoyyb6UC8DjMhqa3
         Ym5GDsVjMTHEw4picdIBJz3TN3cjTzL6Miszg7K3e30BiaF9fh67cVjrzngOvDuz+Qsv
         Uhfg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779740864; x=1780345664; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evOf6OjsacDhvWXWbJVQf9b5BL5/AqphoOMr2vwYlUc=;
        b=PMWv5plWYP0wdqhR5Y0/nyp4GPsxy2q46cmaGdYgLXS1Y3ImFTNo10qhmDNctHp42p
         SOiMBnscDO4EZ9fEtIkukKWhgz/oPgI01wlO5ZPD8NVJerekT4Ceo6hIi8sK0hoIffRY
         eMsXhb98Q21M5ZPtm6OGubEFTCW+5kpj7MaH/C5FS8B94aXoFSrCGIiVr8+tngjrSnS8
         Q3LHvdNW7vDxQrcC33KMAywj+nO0+8oengcPIP1O/KQoMrfbL0+uRWCl2BvjhSYryF00
         M/ak00TIOdhd6JasHpVOuctECtKaOfdXqDNPsA+EuXF0ExfjkVqPQezOmTe9r7BwbhBP
         48mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779740864; x=1780345664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=evOf6OjsacDhvWXWbJVQf9b5BL5/AqphoOMr2vwYlUc=;
        b=GYXs+JcKVFz0lShFycekY1ksDnhewRbBcvOnpgtTHWfyUfkzi2mOv40+xNGlcucLRp
         uEbtHeyDB/d3G116BwgdreoUltwIFz3E/4b76Fflc9oo7esFUknSiYkXXxc1A/bKPYCS
         UqyQfOjnbw8MNUh5nd38wTjs4CLyyTy4UQsI4+Al2DWU/CXVny4nsePjqstPQrZ1hWSn
         sjwPzvc4HMn4XnXNBdYnz3yTkLKX3DGS06v+Ofzz85jACrHX8JVKaIINMOqXP3xle5PE
         jlreZpyzlgAx3HQWkR7b7PnpQwQOVuIfmf8New4tCMpjdHRClxe8kbZKcAyqMWu+Qum3
         VLSw==
X-Gm-Message-State: AOJu0Yy8n46rIO0ydCVA9/S8R3aqefsoMcFb5PXDaNmehIoJPcVwIHhZ
	iP6VHULa8RjelGrUHk7ZHfeKoBgTy7/04cUK1bMHkcV0Ss+odryDbzghLymiZIQ5TOxqMxIycci
	YLxt1ohRXNaV6TMSu1J/mAQNqHcXKdzV2B4lA5987aA==
X-Gm-Gg: Acq92OGN8udrhlvvKRm/AQ5CvR3RlvJt9SMqvWIcoGRfHRFxtD/8xjObSEsUI0O/Uiu
	utrD1QPOd527J/pHmzMWne/XEfH6l2FKs365iikHyAqKlBUqIY21wHgAGPdtlwufUm4SiglUr12
	XgQu8/9rEp3IkV7Krak5elb28AQ2NpgpfPSTj5kUv4BGNwl99GR3VY1gvX8sYGR9UCqjCYrauL6
	DPpDJcxuVHvv+vA5nELptHvSx//6kSih5cMfWzn4pA+MyAEOB7cu7OsazSYINjU08yrKLVnB67p
	oNLwcik=
X-Received: by 2002:a17:907:75e3:b0:bdb:e19d:5253 with SMTP id
 a640c23a62f3a-bdd25ce17fbmr682108266b.29.1779740863568; Mon, 25 May 2026
 13:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260522153034.2168862-1-coshi036@gmail.com>
In-Reply-To: <20260522153034.2168862-1-coshi036@gmail.com>
From: Chao S <coshi036@gmail.com>
Date: Mon, 25 May 2026 16:27:29 -0400
X-Gm-Features: AVHnY4I8fIHaVpc5AucgS8OWb4Z1iaaCEAO1bJcB6eEOJRTuQDcFvSFJdBRnjZw
Message-ID: <CACd_6n2naS4iZkuUbDOUQNu=s9Lmig760ZH=o=dXcYcMp+F9iw@mail.gmail.com>
Subject: Re: [PATCH] nvme: reject completions for requests that are not in flight
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260525_132746_499270_88EF3E5E 
X-CRM114-Status: GOOD (  29.62  )
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

Hi,

Since posting this I reproduced a more severe manifestation of the same
bug and confirmed the patch handles it; sharing as extra justification.

The commit message covers the freed / never-dispatched case (the NULL
rq->mq_hctx dereference).  When the stale command id instead maps to a
tag that has already been *reused*, the driver completes an unrelated,
still-in-flight request -- a use-after-free.  Under fuzzing (a device
that replays and reorders completions) this did not show up as a clean
NULL deref but as cross-subsystem memory corruption: general protection
faults in mtree_range_walk(), unlink_anon_vmas() and the slub freelist,
in unrelated tasks (modprobe, systemd-udevd, ...).  The trigger was a
stale completion delivered for a request that a concurrent controller
reset had just freed.

To confirm the fix addresses this, I rebuilt the kernel with the patch
and re-ran the same workload for ~10h.  The guard now rejects the
offending completion instead of acting on it:

  nvme nvme0: resetting controller
  nvme nvme0: completion for request 0x1c0 not in flight
  nvme nvme0: invalid id 448 completed on queue 2

and no use-after-free / corruption recurred over the run.

The code is unchanged; I'm happy to fold this into the commit message
as a v2 if you'd prefer it spelled out there.

Thanks,
Chao

On Fri, May 22, 2026 at 11:30=E2=80=AFAM Chao Shi <coshi036@gmail.com> wrot=
e:
>
> nvme_find_rq() resolves a device-supplied command id to a request with
> blk_mq_tag_to_rq(), which returns whatever request last used that tag -
> possibly one that is no longer in flight (freed, or never dispatched and
> thus with a NULL rq->mq_hctx).  Commit e7006de6c238 ("nvme: code
> command_id with a genctr for use-after-free validation") guards against
> this, but its generation counter is only 4 bits wide and can be matched
> by a malfunctioning or malicious device replaying command ids.  The
> driver then completes a request that is not outstanding, dereferencing a
> NULL rq->mq_hctx or double-completing a command:
>
>   Oops: general protection fault ... KASAN: null-ptr-deref
>   RIP: blk_mq_complete_request_remote+0xe5/0xa80 block/blk-mq.c:1319
>    nvme_handle_cqe drivers/nvme/host/pci.c:1418 [inline]
>    nvme_poll_cq drivers/nvme/host/pci.c:1449
>    nvme_irq drivers/nvme/host/pci.c:1463
>
> Require the request to be in flight before completing it.  The check uses
> the request state, so it also covers controllers with
> NVME_QUIRK_SKIP_CID_GEN.
>
> Found by FuzzNvme(Syzkaller with FEMU fuzzing framework).
>
> Acked-by: Sungwoo Kim <iam@sung-woo.kim>
> Acked-by: Dave Tian <daveti@purdue.edu>
> Acked-by: Weidong Zhu <weizhu@fiu.edu>
> Signed-off-by: Chao Shi <coshi036@gmail.com>
> ---
>  drivers/nvme/host/nvme.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 9a5f28c5103c..3a525c1dc818 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -615,6 +615,17 @@ static inline struct request *nvme_find_rq(struct bl=
k_mq_tags *tags,
>                         tag);
>                 return NULL;
>         }
> +       /*
> +        * blk_mq_tag_to_rq() returns whatever request last used this tag=
, which
> +        * may no longer be in flight if the device reports a bogus comma=
nd id.
> +        * Completing it would deref a NULL rq->mq_hctx or double-complet=
e a
> +        * command; the 4-bit genctr below only narrows the window.
> +        */
> +       if (unlikely(blk_mq_rq_state(rq) !=3D MQ_RQ_IN_FLIGHT)) {
> +               dev_err(nvme_req(rq)->ctrl->device,
> +                       "completion for request %#x not in flight\n", tag=
);
> +               return NULL;
> +       }
>         if (unlikely(nvme_genctr_mask(nvme_req(rq)->genctr) !=3D genctr))=
 {
>                 dev_err(nvme_req(rq)->ctrl->device,
>                         "request %#x genctr mismatch (got %#x expected %#=
x)\n",
> --
> 2.43.0
>

