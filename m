Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD02C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Feb 2022 14:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aF9FNQ3XB0zpAx/DiGr9Xekb9i7R0465sIiqPYunR2w=; b=m7dZW5vcHKK9YfGxMwnZQR2+y8
	4dGDwTQByRVViyNpmj2J5Id8QIfpkafMRMU1mKbwyTH9ZccATrJMe+eHu+BfmhR8LCCp/r8/wJ9WE
	+GRJVQrQPzK/P8LsIwOlXGQHmUosQKofBS83EvKpoIw21b8FKF2u3m+DAqQfs3Nwtd5aymhGKoePS
	Hu/Uyr4AzB/+CR9iATmaS5TtzMPrYtaVjkWGxhZwlzvsZ5FPXC8Ul8szlcHYbRKH/I0A5p5Q13MYE
	uXx/AEOh6TCSksMkp9RvXyZi3yxQ6+0fmWGmZtuVc6rNh5jnfTM81siDT4XkHItzcG3PWL06p0Dqr
	xTjRHMRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNErJ-0015kV-NO; Thu, 24 Feb 2022 14:12:41 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNErG-0015k1-T5
 for linux-nvme@lists.infradead.org; Thu, 24 Feb 2022 14:12:40 +0000
Received: by mail-pj1-x1029.google.com with SMTP id gb21so2091311pjb.5
 for <linux-nvme@lists.infradead.org>; Thu, 24 Feb 2022 06:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aF9FNQ3XB0zpAx/DiGr9Xekb9i7R0465sIiqPYunR2w=;
 b=Csn/R+74p6ouDTWl6CkZ4B2nAEMQ4BlBAqxxKOUontIJiMyVkDHWCNNM1lNTT+sF/k
 UvY43SOARqFzVpGFq0T3Bt9X0nFL4zshLnQG/JWfwK4fXuk3PCETQdFsjCn5l8auvnrh
 X1lcp5OJtt2FIVh7XyG2yz1mWNP4pGQlgC5W3s+I1sMpnXKt0EA0jcFgSK9BZlicFGNs
 YVqn8yFLuAhBS+jzo+y2lSWgtGSiMH4LjetuDA1LwrbJKY/OjAGnihpASJVOL6/r6XL4
 MXnmSQt2rIJdOKCWIBbqHqvM0iMXE/3VhDexiHiwZBw49z95BKPz62sAt5RiDg/ZEv83
 ngsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aF9FNQ3XB0zpAx/DiGr9Xekb9i7R0465sIiqPYunR2w=;
 b=sftmI/WhBiJQEdB79Mh4EX9oklb6sqI/4Nd705iFTBtvd7w7rTO3CrDrbXqyxKmn02
 rPJ1voTpiSKRONjIMguxUxdG/83DFCZfVTTWU/E6ZLvjmeGVBt01AZaISWve41CMq5C8
 qirjkU4W4Jdzn28VWdWyVdH3hoEuMBPpWfbxhGGoIqzlMTkNWZOl9ZXx8qrqaiM8FYxf
 b1VCWJsmoHaeWY51Q1plwGSCGpoIwv0+XVWWXDPmTJiVbbdTcbUK0wsK6Nqy/I+OnIq0
 Him/I5LPyLK4cTaYpBVIv9uTeiHxCiuY0kea2+11F0B4vAelwdWF2SF1a3ymlUYmEycA
 bqeA==
X-Gm-Message-State: AOAM532Yb46DMTg5DXnSajRXDo6TtktgfzwWUOLzXzGGKvCDYoLCLgjQ
 E/cffd9hpksOXnCMl5SBAYhHWLgycmIc4x/GRrk=
X-Google-Smtp-Source: ABdhPJwNqpiIw4StH3pfm/5SPjpiCTCGqnBPLaYLsG33Tdp+UE2RaKVAxjeepcx579bbpd2QoHE46dFya98QsAUboXk=
X-Received: by 2002:a17:90a:b396:b0:1bc:588a:c130 with SMTP id
 e22-20020a17090ab39600b001bc588ac130mr14538985pjr.97.1645711957992; Thu, 24
 Feb 2022 06:12:37 -0800 (PST)
MIME-Version: 1.0
References: <20220224105852.862715-1-hch@lst.de>
 <20220224105852.862715-3-hch@lst.de>
In-Reply-To: <20220224105852.862715-3-hch@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 24 Feb 2022 19:42:12 +0530
Message-ID: <CA+1E3rJZwb--R0qUd2HMhR4aOnRMHvyEHjZVKPQXB-nftwKT7g@mail.gmail.com>
Subject: Re: [PATCH 2/3] nvme: fix the IDs equality check
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220224_061238_962750_7906DAE2 
X-CRM114-Status: GOOD (  19.04  )
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

On Thu, Feb 24, 2022 at 4:33 PM Christoph Hellwig <hch@lst.de> wrote:
>
> In nvme_subsys_check_duplicate_ids we care if any of the IDs is the
> same, not just if all of them match.  This also requires not comparing
> the CSI, which is rather irrelevant here.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 076a03b801b7e..ac4749f257439 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1716,13 +1716,6 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
>                 blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
>  }
>
> -static bool nvme_ns_ids_valid(struct nvme_ns_ids *ids)
> -{
> -       return !uuid_is_null(&ids->uuid) ||
> -               memchr_inv(ids->nguid, 0, sizeof(ids->nguid)) ||
> -               memchr_inv(ids->eui64, 0, sizeof(ids->eui64));
> -}
> -
>  static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
>  {
>         return uuid_equal(&a->uuid, &b->uuid) &&
> @@ -3681,7 +3674,14 @@ static int nvme_subsys_check_duplicate_ids(struct nvme_subsystem *subsys,
>         lockdep_assert_held(&subsys->lock);
>
>         list_for_each_entry(h, &subsys->nsheads, entry) {
> -               if (nvme_ns_ids_valid(ids) && nvme_ns_ids_equal(ids, &h->ids))
> +               if (!uuid_is_null(&ids->uuid) &&
> +                   uuid_equal(&ids->uuid, &h->ids.uuid))
> +                       return -EINVAL;
> +               if (memchr_inv(ids->nguid, 0, sizeof(ids->nguid)) &&
> +                   memcmp(&ids->nguid, &h->ids.nguid, sizeof(ids->nguid)) == 0)
> +                       return -EINVAL;
> +               if (memchr_inv(ids->eui64, 0, sizeof(ids->eui64)) &&
> +                   memcmp(&ids->eui64, &h->ids.eui64, sizeof(ids->eui64)) == 0)

All the "ids" only checks can be consolidated out, and the loop can
keep only comparisons involving "h->ids".

