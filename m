Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94A6C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Feb 2022 13:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gCF7EnF+3r3wNzYDzCRl1zaPJfcw7gN5Ls4qnXiZILs=; b=HJoGUKEX9rJPZqVEX48gGgwSFB
	sMRovoiMBjgx7yYpmphjQ3EB0e20ItSxm2vBMYhq7XlIu3zVACdLU6DzxzMQDOuxAB9BK/xMaqPkd
	JseUqTE6jsOBRqq07nM1R4r+XuHWCyDtaMIyNEkH1lYRnGfKV+vyT2Ufyop1uhzd8JTZavjnI54rU
	tp2n7+jTKMyfURlRakcEm8JbwxaeUUikd/PBO3/kl4VLacNwFvouuECxG3P4I9io5zqUeBiVH8LP3
	XYt7vTnMczeAuX+wBkjmO6K5V/+3lHLXUM4tFA0VlcL6IP04PcUJtf6CHRWVkjGX9BkSvvZI9oNKx
	uA5+EF5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNEDw-000wHV-BA; Thu, 24 Feb 2022 13:32:00 +0000
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNEDs-000wEt-VM
 for linux-nvme@lists.infradead.org; Thu, 24 Feb 2022 13:31:58 +0000
Received: by mail-pg1-x529.google.com with SMTP id 195so1747602pgc.6
 for <linux-nvme@lists.infradead.org>; Thu, 24 Feb 2022 05:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gCF7EnF+3r3wNzYDzCRl1zaPJfcw7gN5Ls4qnXiZILs=;
 b=JQZ4HCniBF6t9GPcb83t0YafMkL8i9GIRpIn5ivPUk0ZsCB+LsIUkula7lUFfheBUX
 wT2BPA1As7APqyUHR2PQNqmXPJAHtF1G3a4LZ3QfA5MO/u/iVeIHbjLINEUQu9rx4Zcz
 hyvJu54440t5ldYh+ox/g8Xss5dDkrXzAdPqSoMzUJf/yLm0YiIol3kzcoGr3uJlsUq8
 grpSE7hBl1IhGLOU7I8Bcsf1eUWDs8EiEBSwQTKcaOTMDAJt4Haz0fad+AYnximjvLmH
 G+ocxZAfCqFmnAYQufQ/jLLNmuu7zqPiLALxlt1v6F2rOypw3AHAeJFrAJRgytt7+N/0
 gU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gCF7EnF+3r3wNzYDzCRl1zaPJfcw7gN5Ls4qnXiZILs=;
 b=4/cbeuLfUYdlLjfuUaep/mpA8Q05kG/uIgCCSbkYXyz/pZMWa9vtyxxjXaVN8mt1l1
 KvL2L4ComT/DdjS4b3L7ko/omz7yowh0gQW3QE7fZLjKMJ5ir8wniP+PJWzAn+8tTsdv
 4Qi5eXe6rd5+++Q0JLcaga0ND+xVbIM7ch9A+zA0G95DDpJs4jonWePptD3aehgrPkUN
 k50vOFoS6sXZP77Sc6nx0OmaRkxWCCV0zIApCCz3FA2p8FZG7NDIWny5PJ8eDMiIWCN8
 +6Moxe5KUbc0hvxa+sPRjYW8DrgS6O94GZrFmDT9mHWOdqtn28PaRofbPdHZ9FJtwN0z
 iqoQ==
X-Gm-Message-State: AOAM532iVaGeU/uoCl5T4dHnMFUptNoGiwDV02cFYNs0e+lLwufItF4V
 2lbQn2pIIeGunEPslZerKRU27xiMrRi+UEQfYIM+qWzN
X-Google-Smtp-Source: ABdhPJwmbvvr5Gh+0w3rdEX/TcuAdBCs+19xHKxplE7WEOiTHBIyftOIMTYDqHG7Kl5AK/CYbj+5ctuD97dH3JHC3cg=
X-Received: by 2002:a05:6a00:a8b:b0:4cd:6030:4df3 with SMTP id
 b11-20020a056a000a8b00b004cd60304df3mr2942928pfl.40.1645709515155; Thu, 24
 Feb 2022 05:31:55 -0800 (PST)
MIME-Version: 1.0
References: <20220224105852.862715-1-hch@lst.de>
 <20220224105852.862715-2-hch@lst.de>
In-Reply-To: <20220224105852.862715-2-hch@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 24 Feb 2022 19:01:30 +0530
Message-ID: <CA+1E3rLtzaRuE2SW+vYR0MS3tJBODQ3RWpEqAjKH0pzUx5jLFA@mail.gmail.com>
Subject: Re: [PATCH 1/3] nvme: cleanup __nvme_check_ids
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220224_053157_057885_46F75673 
X-CRM114-Status: GOOD (  18.39  )
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
> Pass the actual nvme_ns_ids used for the comparism instead of the

s/comparism/comparison

> ns_head that isn't needed and use a more descriptive function name.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 9cffc4770e737..076a03b801b7e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3673,16 +3673,15 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_subsystem *subsys,
>         return NULL;
>  }
>
> -static int __nvme_check_ids(struct nvme_subsystem *subsys,
> -               struct nvme_ns_head *new)
> +static int nvme_subsys_check_duplicate_ids(struct nvme_subsystem *subsys,
> +               struct nvme_ns_ids *ids)
>  {
>         struct nvme_ns_head *h;
>
>         lockdep_assert_held(&subsys->lock);
>
>         list_for_each_entry(h, &subsys->nsheads, entry) {
> -               if (nvme_ns_ids_valid(&new->ids) &&
> -                   nvme_ns_ids_equal(&new->ids, &h->ids))
> +               if (nvme_ns_ids_valid(ids) && nvme_ns_ids_equal(ids, &h->ids))

Why the first check is inside the loop? Seems we can move this outside
of the loop.

