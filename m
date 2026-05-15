Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2A8CD37AC
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 02:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/pieHtFHQgUyOXmbCiZqNqH99lX7Mrk5MZndFr6Thl8=; b=SzORRDl10jzgWnfqfIjY8Ou9vD
	CC01OTqS1hg09q1T8PfPHm0W6seDP7StkVK7BWNkWSjxNF1bKI+/OkQ9imYNvvGQF9NxS0mkkPNKj
	QckAuTo5Y0eyNzF8p7YUg52RI358W/bUtzPaYb7qykBGUpOYTYzAV7jFXqy6bP4Qsl8Z+rX2IyZ8k
	g8ToyZ+HH4zajJNcBwJAk0rEoIFTvJR2WIOzejUdK4RevBA+5x/JZhFbUHsCzccItb4NiYdbtjgxj
	LZrM+eqdxh4PifSJ8f5J6Ahog0djCSg8iR7p28lVmI8kqxN3jF8D9F+VVbaFZghEemu8uoLORB7eb
	mDN9fjGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNiaN-000000079q7-0NQS;
	Fri, 15 May 2026 02:47:35 +0000
Received: from mail-vs1-xe2e.google.com ([2607:f8b0:4864:20::e2e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNiaK-000000079pS-1vrS
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 02:47:33 +0000
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-63270abd14fso2067391137.1
        for <linux-nvme@lists.infradead.org>; Thu, 14 May 2026 19:47:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778813251; cv=none;
        d=google.com; s=arc-20240605;
        b=EndcedzS0uzezfSBGtzsUuMlAk+zeh94pd4v1ABBoRtLDdHFoXl+2oL2NoFtGGhwbe
         VM2mvhFllgCStBiiS3WDZoOBsegX+oOSPGj9cX9BmCKVjivveCf/PcQNqz6LdNsPl7/n
         972W03IMLtUtK/i4qzmElCV0aRF1DoTD8MBz+iO6VLdFEp0EXJCkH/MBdLgEk6o9Y+98
         dUa9odxIHEcSzziCCoyVJGdQKWD+qAMu4zdQf8TJpm9baLH40yNoBG/RJ+w7udJSr0EC
         Nlr/esbkoJUUqZlph0q+wdAhypSSwvi/zsFEjPT4S1K9btfJiFoEOKQNt91OfslIlDSI
         cxpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/pieHtFHQgUyOXmbCiZqNqH99lX7Mrk5MZndFr6Thl8=;
        fh=jVTSTJ9N9UfCDv467Ri+w7UdE09DK1Qxo5ADX48EXYI=;
        b=C5IsKa6wuLescupyRSRd3nOP11D4stb7SLkNdRuDQW+/WzBd66LJaO68PAmeLxBoxn
         1X/1dKEbCSVUrdMr3KnDBobJg6cvJ23Djx7u/3NyivKyEJBersFPKZm/7aQHyBc0ZrxY
         PpQzE3KcNk4zySXXr9kFbPmd08rHMUeKig1WdtQAQU8FyPNG+FZmgY86Ft/8JaxKx6Te
         nYkRCGm9gxEtPYSm3yOBmePrZNU8CuKP5RkwY2Y4yCvPGCvGRFxNajbbUPfAXpC4JToe
         1WfaUoAe0tACjd8Pwi386C+CbQWOeniSxwkf7CaXMGT9Wck1wxVeND125CEQnHn3nkGG
         6hDw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778813251; x=1779418051; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pieHtFHQgUyOXmbCiZqNqH99lX7Mrk5MZndFr6Thl8=;
        b=Mww3zVpdDoxgNG2nCvYf+7/wdfhoVqYtk9nNwbrPCJf5t7AEPjXq9RYe7jADnOGFnl
         r04c6vzZOKGSCkZrG2mfYeu86uvkIGi95kBi79C72544bSdDYKtbh/qLOlpUCixDYZj6
         LC1ct4wM7H4yj809hyiSzoD97ctK8aXQw+oc0pt/r0Iq3vEmKKskXM8f+b26El4ZRu0U
         tNmS5heKqoHGa7BV3xoofhSFl26Guz+oQWlbwwqOStwwJ0hgFlsL90w22PZYR8WEfF3n
         iRC3w9y/jW3ScqdY3oNE6R9AuBX2tu71UfteByoFms8nJCUFzRBniJ8ikD1Huda822re
         fR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778813251; x=1779418051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/pieHtFHQgUyOXmbCiZqNqH99lX7Mrk5MZndFr6Thl8=;
        b=LqLuaY0kQSkz/YxgsCVM7NY9JCDyrkCe7FqwvbzCcZedDzvGdBobkl2xsJC+P29Efa
         XOgQpxLbWOzeTRQhv7FXb+MDtoQm9LUofbzMVswE5NxxG5DLgc6wgOr36AJzPyHvZcSC
         WauazqPY1lQ9fOOXUWbSv6fuHf9FZ/bHuC9UFuCO+/tHkSeF/9os/XyREoisxt/w24GC
         BMiAipV3NpI4sjvoToptsUFvLLs7cRt2kMpCcExmInE6U5vLRpJX0lH2p2kwhHXOQcGG
         OD8+ZoLTqTZSqLGJYk8gqP0ryPM6vNyoOUaIeqgW9z5z4VGGokPzZ/CZqi7TVJZamkSG
         aX6w==
X-Forwarded-Encrypted: i=1; AFNElJ9SFeu8hh8qUoYzZ3phvPBkTWy9EyxkuiMAa5KqHG0v18zQr29AJ3pVoroIn46k1XSNUoRmXekOLN5o@lists.infradead.org
X-Gm-Message-State: AOJu0YykZM9xC4kJ+oT4sNfGfO1fLQDUBgS3KgYvC4qQmwg23qxZS4ah
	OWCL90ZH1O4IetbelnHj5KsmQJnDX2xQbavmqVYgqjvTVvh02J1G9bbLNBynhWjwRTrT2AzoN1F
	dw/cfYCJacAeAXGp4cSFwhGiNS+f0Kud3uZG95d9NCA==
X-Gm-Gg: Acq92OHDRPH1ss1aRG7V9CJBkKXCGeJCNxVAOVHoa4wrvXQrpfqKkArh29hTVTjJgjQ
	yHSyXXeRLvdVCE0WDiKCaU8KJeDyeMb3C+SorwYOtYwTEFHAOLSLbA66BENkF0K7134vaqo/hQp
	H37sbgmlTZg+DLE5iB81JDIZ4gqNpK2NUibm3rsOw0jsIVZatrR/u5+CupEwOsNYx5GBwncYCIs
	QmJmuRj7C79WjjTqtdmCndUVNKxzaQFtX+4cPYwlb+BGKhqYzb1LnEs8dXmKPUom8L+kyFkz/nh
	e5+3FSo2A4niMpxUt5bKEcCyVYXW/QAfiC+D+ym+cV0ABe0q9/fR5Bt+n3tf/99P+uaWpg==
X-Received: by 2002:a05:6102:f85:b0:631:4d87:ba5f with SMTP id
 ada2fe7eead31-63a3d0182e9mr1112388137.3.1778813251172; Thu, 14 May 2026
 19:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260328004518.1729186-1-mkhalfella@purestorage.com> <20260328004518.1729186-10-mkhalfella@purestorage.com>
In-Reply-To: <20260328004518.1729186-10-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Thu, 14 May 2026 19:47:20 -0700
X-Gm-Features: AVHnY4JPt2CbMBOdgwCipYN2HuDbwjm2sVPDCu5zNsKTMChe-hQMmhEjCRfdwwk
Message-ID: <CAPpK+O15L_y8Qt0rEEhurbCHX9-e5W_uL2t-jJD7T8UhbExRkw@mail.gmail.com>
Subject: Re: [PATCH v4 09/15] nvme: Implement cross-controller reset completion
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
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_194732_512987_6011C296 
X-CRM114-Status: UNSURE (   9.18  )
X-CRM114-Notice: Please train this message.
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
>
> An nvme source controller that issues CCR command expects to receive an
> NVME_AER_NOTICE_CCR_COMPLETED when pending CCR succeeds or fails. Add
> sctrl->ccr_work to read NVME_LOG_CCR logpage and wakeup any thread
> waiting on CCR completion.
>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
> +       ret =3D nvme_get_log(ctrl, 0, NVME_LOG_CCR, 0x01,
> +                          0x00, log, sizeof(*log), 0);
The 0x01 is the log specific parameter.  0x01 sets the Remove Completed fla=
g.
Please explain that in a comment (if not assigning it to a well named local=
/
defining a constant).

Sincerely,
Randy Jennings

