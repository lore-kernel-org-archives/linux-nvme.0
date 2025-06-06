Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555F2C5B543
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Jun 2025 01:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qDpd58J4s7WwvI1/iRGGpuy3gTH6y2JQCLm0hLYTmco=; b=qrCYYHW9rkqEe6X67Wq1kB7eFh
	iQsR/sVsDjp3v7CpTYACWjDWPWtsfiK18w2eJaaJaeUR2UXsY8TymuBZZ674KXBpAawRs2YR8Hdp4
	Odb+ocBJcyOq8eR2U9iHlBWkZEzOJZmIwOOdDYam0cj8v/L7s21jQmLEhBgkgvZha6ZRJrHnHgBDe
	EPi8qfuMRjhSbxU6wZnKf4XlfZ360wl/6jZ1HwGnSCrycOH1S49ygUqNMVQoY+vFrZQ7lblFyE5jD
	a6eYPtitTK1U8sL5u9cnSgOoIX25D/7nh+jRSaVM749BUMksUeNHNgj101EpYrZG4PnWKNBgTrV8A
	a2+VkVzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNM5r-0000000GuSh-2isC;
	Fri, 06 Jun 2025 01:42:03 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNM5p-0000000GuSM-0Rhr
	for linux-nvme@lists.infradead.org;
	Fri, 06 Jun 2025 01:42:02 +0000
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-ad88eb71eb5so211995766b.0
        for <linux-nvme@lists.infradead.org>; Thu, 05 Jun 2025 18:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749174119; x=1749778919; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qDpd58J4s7WwvI1/iRGGpuy3gTH6y2JQCLm0hLYTmco=;
        b=BXSMXet3S79ac/C9uFNg+6zZXnq/Jj/W0wanSJ3MmkOvvWemNscdcMvGCpaSnpr4px
         OUbEeOc+85rQzEhY7oxIUelosvXJ99h5nEQI6nNpCiU4YcQ51Z15rylPFiM2vi+ducSo
         AeWOGKW3jtKzyceYSLs68GPoxeJVji/EFLkACRmVmMAaAyJL3v5LQ+5p49tjuoj7gl98
         hwxdGXoiArWBg9V2ngapup2OMPWvSryzEl/RWATzF0ovS48WSSEhQbbPbv5Uizi2TJ4T
         PSJ9QOLGlao/HdlOohIXUOUXLE43f1naPyCEqaY6lxm2F74KgM7v9/oaMGEVUdnEJaRO
         mXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749174119; x=1749778919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qDpd58J4s7WwvI1/iRGGpuy3gTH6y2JQCLm0hLYTmco=;
        b=saNuEtlSiEJ1iSio/NAHVia3BsOPxmNWsFzwjgpv7nIUVf5gXJVTTnFWvk/+y6cMNj
         2yWsD/Je+tY1X9DSJJIwiZeAPdTAuf6LzVI0SG8EVTDAIOOZpR7eTA66wsL/rI7G8pO3
         avv2h0CX8Q42BvxMXbCSk8uyDJoG2cPp+K3vQfprEyX/R2amdHen/1LhmPVhxiiLlPgU
         ypxN2ZGJNco9DputLtLlr5zRlcqBGeXFjwGHpFGnqNV5lDkw55sFtAzfTOTElDES86bd
         o0Kt5V4nK7UN97PW9Rj7mnjCM1/HgI9SHcXOFhRud2HGoQ8Fy0+boA3bx7++TGkmyP32
         hVSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsFa7GSdSo4j5yJldXbfOpfvPMafNukbaHiEjUuv2RstlUpKtT+4UVB6U5vhmu4oMcYA37KyH8Z75T@lists.infradead.org
X-Gm-Message-State: AOJu0YwJT3GvMTZ55ep4Fzls3RQ6gyG55mada4aCG96UV0e6D2iPukL8
	FkGxF6QHuFkkc4CF0Iz/252TNzB0rSTdtMXOWraILSKgHOWI8JvLWQ551VES5vlMxuY4KiYSoBl
	onFjzrZlgcXtDVivgH1UyYA56/Y0tyQ==
X-Gm-Gg: ASbGncs9psP1/PHr2b9+WTHGBiVKqWb+e9pd/S5Fx4c5lan4iBc8n54Ft9iIT6Bw4+W
	xFYSjFYQMvbyIZdfnNAJO1AfeRaZi1Q11AjgWxzUU/kHgcKSwV/GPph2FN0jyRlkXCW+6sy4Hl0
	KmitBqvJOcaslUjRCRPz2RW7csEozODI8KGdGxabxrCvRdgiRcJ8+8yfnBY/trZSc=
X-Google-Smtp-Source: AGHT+IFuZFMm2ddZwYaRiJpBVjSh4uUIeGdOOcI8W1e3S+MB8ZowXyooOoqYTMwUzzjW9o51zm7m+mYpT5kIVW/TGbs=
X-Received: by 2002:a17:906:c110:b0:ad8:9428:6a43 with SMTP id
 a640c23a62f3a-ade1aa1476emr110874566b.25.1749174118478; Thu, 05 Jun 2025
 18:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250606003015.3203624-1-kbusch@meta.com>
In-Reply-To: <20250606003015.3203624-1-kbusch@meta.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Fri, 6 Jun 2025 07:11:20 +0530
X-Gm-Features: AX0GCFswOvy7WbzUT2aNeMAGx7c3_8X_WI71937EsQxNOeFvgvgMrSmFw6LRfns
Message-ID: <CACzX3AtTwR3dWpYw_jwWKTZziz251cb7xobgF2ta5WL6Kr2uBQ@mail.gmail.com>
Subject: Re: [PATCH blktests] block tests: nvme metadata passthrough
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	shinichiro.kawasaki@wdc.com, axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250605_184201_145424_7657162F 
X-CRM114-Status: UNSURE (   9.28  )
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

> +       /* this should directly use the user space buffer */
> +       meta = mptr;
> +       cmd = (struct nvme_passthru_cmd) {
> +               .opcode         = 1,
> +               .nsid           = 1,

Minor nit: should use `.nsid = nsid` instead of hardcoded `1`

> +       /* This should not be mappable for write commands */

Maybe reword this to:
/* This buffer is read-only, so using it for write passthrough should fail */
-- makes the intent clearer.

--
Anuj Gupta

