Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913EFFF8850
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Apr 2026 23:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z9hoo3Aj3OMTCdAdL5pdB24PyuPuGUKt1qHQWg3xRu8=; b=bz6pnNQRkw63gEPleNFo5lPc81
	n3ckrENti9FAeJOstUlD/PmmZ/uMAkSWdWchabaa1u2xXHG/51VKapw06FflB3LW0lhqBoyia8ql3
	63UVWn0Wxr/RSJewZuOZ8vrGJKAQ8rqgFbbrRo+ZYBr8SxKPzz2PYJgKGsdTQ0FG1Ep8IjKyZ1NOR
	yY+EVALoukOaGL0FNQmhrbQoD8dDzaLhqiT9G4+IUBLlmKqwCD+p1xLlp2Cxg/ceSyQoJmjYb9Ntn
	Mz5Gr2zCdDhJhQynG1rEos47iztXpdXoa/SBtinunTdCBi+4R7dcLHNODR/c4QgPcx/GttLj/nCDL
	znlEOuhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGPd6-0000000DsAy-3EIW;
	Fri, 24 Apr 2026 23:08:12 +0000
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGPd3-0000000DsAZ-2rgp
	for linux-nvme@lists.infradead.org;
	Fri, 24 Apr 2026 23:08:11 +0000
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-56f6afbd205so4076919e0c.0
        for <linux-nvme@lists.infradead.org>; Fri, 24 Apr 2026 16:08:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777072088; cv=none;
        d=google.com; s=arc-20240605;
        b=Uy3kOfpZarCmgcAEBrBtQhAkmLYVunigZYvxWrYL7uWQnjIGuLGQwRQb/Mcx9jrcAj
         O0aMzEtvi/us46H9PlkneyDodR8MTlAqtwej0+TMtvh1GxTcY9coN6x9BQzjtEqzofTZ
         0GSCChdwnxRIqymot+flIRnFbNNOH8rOyltSK8JKI6PVMKQ6fP2BzwuqPi1NBsreDMzh
         MsL8Yy4o2sWSpReP2eQAehExqSMApYIbJWN+htnGzZO2WslulnQKzA2rLbtC2uqV8IXS
         R0z95TEOxSNzoVemX/7srLNqNGE+RiAXjFO4VrFykvCFcxrzDcLQwBL4AQJsM+nbDrmo
         Nt9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z9hoo3Aj3OMTCdAdL5pdB24PyuPuGUKt1qHQWg3xRu8=;
        fh=4k83Cj6h9JaatoqLhJcfnSA1ySgHVxCgGQ7DhNbsYWI=;
        b=b5fn6z8EwSxsyNiHhi4S4d/WPRCh5AcwfnZmk7mOhHC6cVvuDS2fVhyiHMjSUQnrA0
         5uC3qM+xkS+nANXxicqLuGRb+dGdgbxwDnmz6yONevZh8iqBRSxLHf+HK4YVlIYE4Fp+
         rOJ7tVlRZJ7nM14rV9u9f/Wtde5N5Al0GCdM66l/1gi5XliMbK+2jbCdm1zC3HgDZzM/
         dJbyvQihGcllrOb6Zz+GAYAmC7Mn0z2c3IMTlgIm4BImXa7OwAnccMklns6HexCk13g4
         7Ta/FAjNQWS2CcbaRTWkwJTM37C8ovPADyfLbBUR5HLjSKP9SuQFEjId+h4e0RstMcD1
         FshQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1777072088; x=1777676888; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9hoo3Aj3OMTCdAdL5pdB24PyuPuGUKt1qHQWg3xRu8=;
        b=BP/6lVRezj/3jHKfZcXGJ7KzSBiPeJDIHejg+JAeAFOwiRKJEhaFeY7Jlfyoam0JOD
         Lpth5z4S6Afw7PNaKWyl9vrcwpRvP3r3KQ8/JWsF/rFctmWgFpPIwqVghZevz/BwZmQJ
         3QjmoArwJ5YB8s3y+O5U+vbxaKtrufMhHh4aNTAABj4hIXmpkEk+O749CUV38TZ2nrI0
         OY9uVSYxT0/b/ptYhbeAzf2jj+ZT8nY4CfIGqBpp/FIXYINtXciq5VTG7z/8JCs9nQ0Y
         cMFVHMLBaA+0jcDnrw8b6fimKZ9+HeBupK/ftawM8N/aXlukAmHL8JuNrKg4l3440nFe
         SgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777072088; x=1777676888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z9hoo3Aj3OMTCdAdL5pdB24PyuPuGUKt1qHQWg3xRu8=;
        b=Me8I7Jc27Y7AyG39YyJapdjS7Q17NG/ufPomunn1cusW8D0+y6tjVlALT3ixMiakgl
         JsOAfvH7csUiV8swbzC4j4oQPoW/379Ye0oFzGIuEtkfE9JY4GhLCanW8rcHlm1b3kBs
         yt1penGvxlgtk3BP2HALfJTKoMh16t/hesP2CAsAZr8WJVLfE1xGhn/9wHfQb7Amqsa0
         +w4rvrLcEiDNooJirn72x0zub5VsoZQ4Y7XR6Z/JDnPLAyn8p2gFaqPczoa5wdI7jZuX
         MN9Dku19avRFM1k9hcAawWj4RYDyAQUwWPnbMwjVhSvGJnGLWgN7mDvGhaHfC465gPvr
         IarQ==
X-Forwarded-Encrypted: i=1; AFNElJ9srSMdsF2SrVuWa5AJdkYMPrltlNp42vvS4/buP7LRiJFIXJZVZR6yG+PL6SjXqGH2KhTxzZZ9MgX7@lists.infradead.org
X-Gm-Message-State: AOJu0YxXjhre+9Nq92rvFIg/2HrreFYNj9/GjdvHrSG/gstk+Oi0JdCM
	PKQbEmb21A0HaeHgNrJM2xS4ivIhYmX/hi1/thm3O72Yn4AmKt+tjn5YYLk6QRRTlIHiqXC8ML7
	dsTrmkTnxhm6nKsuA1ueO6pKRrGaqNwV5iQ9FdtzHew==
X-Gm-Gg: AeBDievTyyaAiVSgLW2c5Nn9KOTZTj21v5lQE3ipawa7S1nJPQ/D0NTxf9gPLwyrwzH
	5BUMj8It2af858CUUj4Nxg4HsDnKnK2cgrh+kIBicMgQx0K5yInlojOc1j9k89oWsxlwMuht7Yj
	9uky9z0qOncDJ1BSg+Zj1Ux37Ju1eghxfN3JpKWc/Nkq4UkVRcEvXY23K9p7XfrZXh8GyLEQNzF
	klv88HmbklHhp4QqSrS+GosbYITYkSJFdH6Jc1t4Rh/96xtdFCoEvhVJZ034CgD/zgua3xOxAZL
	/IFfBZYrzEPAlSGmE68Vt8BmcAbfWO01q87+kOpnUw8SamGY+lQ5QSX+68Sc2wQKUhqFcyPlR2s
	AbghK7UVM3eZPQlI=
X-Received: by 2002:a05:6122:54:b0:56c:f222:7d7e with SMTP id
 71dfb90a1353d-56fa66f10f5mr9371550e0c.10.1777072087674; Fri, 24 Apr 2026
 16:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260328004518.1729186-1-mkhalfella@purestorage.com> <20260328004518.1729186-9-mkhalfella@purestorage.com>
In-Reply-To: <20260328004518.1729186-9-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Fri, 24 Apr 2026 16:07:55 -0700
X-Gm-Features: AQROBzBdQDa9UOIagUC-tWyUKBTg9KNOHrhr4PW5klIoTJhm_exXVVinflPqDQs
Message-ID: <CAPpK+O0vhPPphUong9reR72bpCaWrvPwumgHP6Zo1Wn3iGy9zQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/15] nvme: Implement cross-controller reset recovery
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart833426@gmail.com>, 
	Hannes Reinecke <hare@suse.de>, Aaron Dailey <adailey@purestorage.com>, 
	Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260424_160809_787273_0601D862 
X-CRM114-Status: GOOD (  14.30  )
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

On Fri, Mar 27, 2026 at 5:46=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>

> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c

> +int nvme_fence_ctrl(struct nvme_ctrl *ictrl)
> +{
> +       unsigned long deadline, timeout;
> +       struct nvme_ctrl *sctrl;
> +       u32 min_cntlid =3D 0;
> +       int ret;
> +
> +       timeout =3D nvme_fence_timeout_ms(ictrl);
> +       dev_info(ictrl->device, "attempting CCR, timeout %lums\n", timeou=
t);
> +
> +       deadline =3D jiffies + msecs_to_jiffies(timeout);
> +       while (time_is_after_jiffies(deadline)) {
> +               sctrl =3D nvme_find_ctrl_ccr(ictrl, min_cntlid);
> +               if (!sctrl) {
> +                       dev_dbg(ictrl->device,
> +                               "failed to find source controller\n");
> +                       return -EIO;
> +               }
> +
> +               ret =3D nvme_issue_wait_ccr(sctrl, ictrl, deadline);
> +               if (!ret) {
> +                       dev_info(ictrl->device, "CCR succeeded using %s\n=
",
> +                                dev_name(sctrl->device));
> +                       nvme_put_ctrl_ccr(sctrl);
> +                       return 0;
> +               }
> +
> +               min_cntlid =3D sctrl->cntlid + 1;
> +               nvme_put_ctrl_ccr(sctrl);
> +

If we remove this code from here
> +               if (ret =3D=3D -EIO) /* CCR command failed */
> +                       continue;
> +
> +               /* CCR operation failed or timed out */
> +               return ret;
to here, failed CCR operations (not just failed CCR cmds)
will get retried (until we run out of ctrls or time).  This is
important if controllers cannot handle a CCR for some
other controllers.  Sagi, you requested that we not retry
the CCR operation on another controller, and I told you
that was affecting Igor's and my testing.  May we please
remove this code?

> +       }
> +
> +       dev_info(ictrl->device, "CCR operation timeout\n");
> +       return -ETIMEDOUT;
> +}

Sincerely,
Randy Jennings

