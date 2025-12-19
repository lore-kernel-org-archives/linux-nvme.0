Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D7CD711CC
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Dec 2025 02:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kr4RA84MCew2A553jwuKuFmSpxT505rp3MhtjmHRllA=; b=m8R5pwqnrG2/BONQmJTLEN1TMP
	8ifk2rVF8fu6+gl/3/cMkztiCKHVVq8TUTUQw93fjvkwoDIB579PSmQJa662Js2rDD6m2i/FH8+U1
	nG8ZFXRfPdaQQ4vaf9rEVm+tnq4tmNGvyZoZywx1qK8pu5DJ8hq15JYQPkPUvOE5ko2zzlwbLndV+
	ybGw5Iw70wqpBGNPG7VS0xGaE0Kfnn1ZmDWVnFmP7zsaYBYf20FfiBA2D+nEcMFufiG/J3u2nFt7z
	QyofsN1p1OQbq63jwd081ffgj1nZUF7wKD7+kpd1KynAEkzX4nFgCh1JoxwvqR+sA80Tz1uM6Fe7b
	49twjaPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWPsp-00000009TOY-3E5S;
	Fri, 19 Dec 2025 02:06:19 +0000
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWPsn-00000009TNn-0AAA
	for linux-nvme@lists.infradead.org;
	Fri, 19 Dec 2025 02:06:18 +0000
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-5e5478f3dedso894478137.3
        for <linux-nvme@lists.infradead.org>; Thu, 18 Dec 2025 18:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1766109975; x=1766714775; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kr4RA84MCew2A553jwuKuFmSpxT505rp3MhtjmHRllA=;
        b=gVZyxYgSyjna64/GlE00t9gGGdW+hnSkKnU2TUv/s5JQ5slWNkkx9xIU/9k4rlFDlz
         8oDRS4SUFtBunTSUlUW77i/Nz/9FSzZbuAHd2lkiyASaUsdtCWNZ9xWqCS/FXyqmouY2
         qAc3MfOu33nM0eWQa9PUSptv1fEczvfFMPz/9ptJ/xoQlrTQNC82E1Od4ao6Nx4UaEAL
         hhM7Axd4BRFS6oXmcVSk+zpkDB/yEHKa3ano0eBJhJrJ2ANJHlJ0I+pj5Kx0dZS60Dzb
         f8r5LOXPi41mATye6ZjnWNPnsmMNSRAWics4FS+/3bSHT5xWv3TU3r4XVdeuf5AMM1wW
         7tYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766109975; x=1766714775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kr4RA84MCew2A553jwuKuFmSpxT505rp3MhtjmHRllA=;
        b=fX5uGvQtI4dXQnkPHqkVTz8g5PdbxmzUxPnmdSvqTGk5WJQ1c03gSebVw1oIetIf+m
         onwjkItuFsjsTAGW40sDrI/xLZtM/Ak+QI7NyHWRfnZlqHd9L7EbFlvqncJriCvZkc2W
         Yw74wKp8dOy+9ikpYHp5moUR6/56RB3TWm8r9y2HeYhnHSwfc7ufQaIhrbJgR833DIDL
         XKZw8lgPRtJAYekWRWYCiaFkzBmGAX/Y7NTQDl59gPFsP0AsfH8ZjK5Vw2lWKa9Ry0hA
         K9un4X6vxbAe9S5S7l7LXtCchyacKQuGY0+Kmg4hdykbaKXxAXuI7zgU4v3f2dTY+cj9
         nedQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE2Na3ZCrNUcZRDn0prDtu/b5CAJYopawH4uImiWim9KJXMZvyTG52Nd1alOwncJgebCp8KjDfOpO9@lists.infradead.org
X-Gm-Message-State: AOJu0YwmZg2w/np1WPEb09oov+6hFD6yhP8Z7kF9snPFLvmRSpqCogfn
	X1ugmwQR2U7sdlm47XVM0wjYbeTB7vb55D9sX+jORr8JS8hw/WyoHX/77mgqRPJeYytaoO5hHzS
	G/z9lbrig7V78PEMA9qi0Qxk7O5sASNFH3VwCw4nDbg==
X-Gm-Gg: AY/fxX5ZLb6i0Y/EM4yW7Xrg6b2gc9tyu8Vpcs7NVAsuG4YbHt7IniZBPmSZEZENRK8
	05uopaXUdvLrEm0ArI+AjIsnsw4snIyZXAbjjvNaWVaWZ41oMSMvbu0oHCTPG2w5J/I4ZkHGAis
	rFv7cY7aPfJXdfPemt7uMzs+NrL3bwRxIs3W3Iv4Cz8pr6mZtiONa+iNUujFbme52Q5QFPN5OGO
	V1e54G1a2q3Z4+i7kOZQjrvSoRLZQ36Q7JKED91CLwrYs0to5gVC1dL4qkz4zgNnAAdPbjJ
X-Google-Smtp-Source: AGHT+IHgm72D+lk9mx5DF+8C3d/1H9gAx8OisHt/1431lMsBRgAHKmQBBCVmiA8YFppSbEiqL5cllcObWsNiwwR96bc=
X-Received: by 2002:a05:6102:3f8f:b0:5dd:c3ec:b66 with SMTP id
 ada2fe7eead31-5eb1a816a4cmr537418137.30.1766109975648; Thu, 18 Dec 2025
 18:06:15 -0800 (PST)
MIME-Version: 1.0
References: <20251126021250.2583630-1-mkhalfella@purestorage.com> <20251126021250.2583630-11-mkhalfella@purestorage.com>
In-Reply-To: <20251126021250.2583630-11-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Thu, 18 Dec 2025 18:06:02 -0800
X-Gm-Features: AQt7F2p19XRpvJkzddiX9qHPEsc3pNLYcW3G5h6tbJwahqRPdo_yH-eZAHam-xY
Message-ID: <CAPpK+O3zU_+UTGx044iCfsUzwD7Dy+X5DC=N6Dr9BNzrrjxqEQ@mail.gmail.com>
Subject: Re: [RFC PATCH 10/14] nvme-tcp: Use CCR to recover controller that
 hits an error
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Aaron Dailey <adailey@purestorage.com>, John Meneghini <jmeneghi@redhat.com>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251218_180617_087211_C714246A 
X-CRM114-Status: GOOD (  18.88  )
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

On Tue, Nov 25, 2025 at 6:13=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> An alive nvme controller that hits an error now will move to RECOVERING
> state instead of RESETTING state. In RECOVERING state ctrl->err_work
> will attempt to use cross-controller recovery to terminate inflight IOs
> on the controller. If CCR succeeds, then switch to RESETTING state and
> continue error recovery as usuall by tearing down controller and attempt
> reconnecting to target. If CCR fails, then the behavior of recovery
"usuall" -> "usual"
"attempt reconnecting" -> "attempting to reconnect"

it would read better with "the" added:
"tearing down the controller"
"reconnect to the target"

> depends on whether CQT is supported or not. If CQT is supported, switch
> to time-based recovery by holding inflight IOs until it is safe for them
> to be retried. If CQT is not supported proceed to retry requests
> immediately, as the code currently does.

> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c

> +static int nvme_tcp_recover_ctrl(struct nvme_ctrl *ctrl)

> +       dev_info(ctrl->device,
> +                "CCR failed, switch to time-based recovery, timeout =3D =
%ums\n",
> +                jiffies_to_msecs(rem));
> +       set_bit(NVME_CTRL_RECOVERED, &ctrl->flags);
> +       queue_delayed_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work, r=
em);
> +       return -EAGAIN;
I see how setting this bit before the delayed work executes works
to complete recovery, but it is kindof weird that the bit is called
RECOVERED.  I do not have a better name.  TIME_BASED_RECOVERY?
RECOVERY_WAIT?

>  static void nvme_tcp_error_recovery_work(struct work_struct *work)
>  {
> -       struct nvme_tcp_ctrl *tcp_ctrl =3D container_of(work,
> +       struct nvme_tcp_ctrl *tcp_ctrl =3D container_of(to_delayed_work(w=
ork),
>                                 struct nvme_tcp_ctrl, err_work);
>         struct nvme_ctrl *ctrl =3D &tcp_ctrl->ctrl;
>
> +       if (nvme_ctrl_state(ctrl) =3D=3D NVME_CTRL_RECOVERING) {
> +               if (nvme_tcp_recover_ctrl(ctrl))
> +                       return;
> +       }
> +
>         if (nvme_tcp_key_revoke_needed(ctrl))
>                 nvme_auth_revoke_tls_key(ctrl);
>         nvme_stop_keep_alive(ctrl);
The state of the controller should not be LIVE while waiting for
recovery, so I do not think we will succeed in sending keep alives,
but I think this should move to before (or inside of)
nvme_tcp_recover_ctrl().

Sincerely,
Randy Jennings

