Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184CCCD6E44
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 14:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uFbJkSdTC7x0Ukd0ylRpVZgbAUY2iq/+kf4grEFg6Mk=; b=SXEbv5nQfR393V08zK50gLNI0R
	bU0866bqbDVir90ssXRVGhED2cglEoB7mHxcbVZDxxrv+87L34kJGkXtPY08ifxoo4AuYO/o280Yl
	nCWz9gNRb2zDlpchnkynTDRLO46xSJ9IFC19xSPZz81QoVJ1MJSlxYjQvnQF5GU986ROLsejrPVS7
	BYgOQBSTM9qspe17C4OGqQh/Oc4+jGrssTPWGODMpfWldZREtyVVw5PQ89VhVWx4Fm0LoY9BorAHS
	n/ZcggdE5dcNYgB7O58Xv02IPMStEpqnrg6Fa3Qw4RJEJUh2N0yw3DSpq7/vfpX18DUehfdpbmc+V
	f+pO8FWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSbIk-00000005oto-4Av0;
	Thu, 28 May 2026 14:01:34 +0000
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSbIh-00000005otS-13wW
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 14:01:33 +0000
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-43b69833d10so4913261fac.1
        for <linux-nvme@lists.infradead.org>; Thu, 28 May 2026 07:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779976889; x=1780581689; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFbJkSdTC7x0Ukd0ylRpVZgbAUY2iq/+kf4grEFg6Mk=;
        b=epF5KlBmEnf4cqxD++2cH1x54Yapz2jnr8Vj4Fx3hjbjQqz3R2HTMZGT8ttq6wSL4F
         BdS+pYJ5oEYCz9r+tKgMT76azO0dwBqe4oI4BiQyzzoWXingHt7G3yWY5NtUcTepvDxJ
         RC4fHgOAS7Q0psIa+iv6Iek59p2Dsb/Hi7P/GunCjgTfBkvPpRRJyIcPQqvaWeJycU4R
         +qOkPbKlXEHc6jmYRJyOd3qotlcn2nK+ait8gf90v1KGxLc/PLN0dWwwleYBx7zgphhT
         tWTvbh5ckyx7l0Tr3XSfmRUdMXPb01s1hQVu1L/5+4SWxbQwy8Rpvk2UjRwxuOU4/dhS
         cDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779976889; x=1780581689;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uFbJkSdTC7x0Ukd0ylRpVZgbAUY2iq/+kf4grEFg6Mk=;
        b=ENfqiejKmzP8ehDWWPDnpmOWZORn13KLUO8G6oYS38qWgEcCsUGn0ZuI5RDzd3znlk
         cINqsfCOo+jVNfFKkoH9nDWrxwnQmXl3NFB9lU3vNYl9QkAMV7Zl0OwqcqYC7Gd+f+lM
         Os5PjMnP2PXVKRM+//TX+y5nb8ko1cKADBc+jUujs3Zi8mWh5mt6+SFCo9MuWaXMI6BS
         ssLwhw4LuL96XIvbfxb0WAD6rry9hUqqFTj3s/+jeGKImOAigtOqxb61w46RzqVE7znE
         epRqxJuQczmrDLj2Dl+0YmG4TIC9/eeyEQeCCImGBrJCIUnFcnXJZjSEJpIV5dPIJbXe
         jJ7w==
X-Forwarded-Encrypted: i=1; AFNElJ8dT1ssGFf14r57TYu+xOtTEBLCKmD9d6YYMaXrEaXFy6nYjBthTzUNCTGujZh24hXqpmvWA91zTiNC@lists.infradead.org
X-Gm-Message-State: AOJu0YxXtqdmRHKlGQsvO+wcatJTPFzS2R57ovnlItI0P3dm0/UGBnOp
	wTiM8KBaLbxVVFeWdmSGXIUGRZd4DVJnIMuAX75Tt4uDDobm4QJJw42W7mRgpbhl6lk=
X-Gm-Gg: Acq92OFq05MQTXsmsT3MgKJEi1Q+ONAtvJr/21Z+0/ILDhHBKpHGN75yel9iWeNoN/u
	GxmFmODMioiNWOmpcTQhQWlnpiqShZDwjEmSAnUXXHaMq3COf5CADqDODjZYW3KQG8l9ttsUUkv
	BjOYcSZsdcV+6y3v89WT0/f0pN8dp8eramNANJx2jGvTa4zcxSbKvLXQ6GQa6to2gp25mEsnyHT
	6+TmTSUEc7vLDBNLJJJf4joOCzaCMLIxmviXyF9S4Txsx/rUDeRCXxXjjAwOrbTMSYhOFAEuKzH
	lPOWtxwuuQIdMahyaYPXqV6euKU/e5Jg4ObPIyXq3LcnZYhuJwrj8uD6K9Js5tnPZRfYs7w7X22
	xpW2iX3pPbYTmiVvbD0aqT7BVXMyzzOIgxG/E+SrWQKiNcOKvJQH9avSjtTTUUbShJqtb6u0pas
	EQepA8IcHD9mNgVEG6kgg7aOYQrQXf4+rqXoaX+3bJjykprPKKSXTHTHnU6tw9JZauqTxSr7jNB
	rYj2jYP/m7KI2uRhluvxnZy
X-Received: by 2002:a05:6870:3292:b0:43c:4d4e:734 with SMTP id 586e51a60fabf-43c4d4e1fe8mr2788634fac.32.1779976888372;
        Thu, 28 May 2026 07:01:28 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b63976202sm17356278fac.12.2026.05.28.07.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 07:01:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
 Ming Lei <tom.leiming@gmail.com>, Bart Van Assche <bvanassche@acm.org>, 
 Caleb Sander Mateos <csander@purestorage.com>, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org
In-Reply-To: <20260527151043.2349900-1-hch@lst.de>
References: <20260527151043.2349900-1-hch@lst.de>
Subject: Re: clean up bvec iter helpers
Message-Id: <177997688714.93541.1880481294502134735.b4-ty@b4>
Date: Thu, 28 May 2026 08:01:27 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_070131_559389_3DA2E38C 
X-CRM114-Status: GOOD (  10.70  )
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


On Wed, 27 May 2026 17:10:19 +0200, Christoph Hellwig wrote:
> this series converts the bvec_iter helpers from macros to inline
> functions, and to facilitate that cleans up a little bit of code
> in the loop and nvme-tcp drivers first.
> 
> Diffstat:
>  drivers/block/loop.c    |   24 ++++-------
>  drivers/nvme/host/tcp.c |   27 ++++--------
>  include/linux/bvec.h    |  101 ++++++++++++++++++++++++++++++------------------
>  3 files changed, 84 insertions(+), 68 deletions(-)
> 
> [...]

Applied, thanks!

[1/3] loop: cleanup lo_rw_aio
      commit: 7dea9029721675d475e093116cef569253960e06
[2/3] nvme-tcp: cleanup nvme_tcp_init_iter
      commit: adf3a5cef1a839e388dc382b3e07623f52746322
[3/3] bvec: make the bvec_iter helpers inline functions
      commit: f6fe52a7b18675d76d7f7dae0c16f412a4e33f9a

Best regards,
-- 
Jens Axboe




