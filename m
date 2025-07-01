Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E064EC83038
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jul 2025 21:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E3QAp+njIqgagygGelfi+VFuGwWXW8+PeuSHzW1GgA0=; b=sYKa/HiMLtlCmcLHYbMHTU5fTT
	yzw/MQTpBQ/l7m0+dHKwlUQ2EweVWEzZ/e4D2vuyxfd+Ve2l6Z9sEXhQi+MiVgDnAtipDiVzFwmbk
	YdLlBnLZ83COVzaxS2PvfJlZTYSjeXf7KDTXv7RZWlzPkpsXpwk3dYF+DfVpRD81G8bVeU71+69Ut
	5t2DGFSwgLbsuhQ6RRBTutYx6T0BpHIxHAnmROK8OwbWikyid9HUzBsDXW4zhRm4DLO+Ryyyzpg0N
	qQP2Hoi6uP8vLbjMePqgIVvPE9AI3wBRJE+cE+jeEiSLcON7eToA4HUWO+3c8nnpe4HKzE6/p+RPY
	lGjWrNhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWiCS-00000006eCC-3eRH;
	Tue, 01 Jul 2025 21:07:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWheo-00000006aNw-0hPf
	for linux-nvme@lists.infradead.org;
	Tue, 01 Jul 2025 20:32:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751401963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E3QAp+njIqgagygGelfi+VFuGwWXW8+PeuSHzW1GgA0=;
	b=gDnjOWiwk8ZzzhbK5AHDf74EV/+Mpx+bipui+hfGCE7BrK7SfpiRmvPNGnVIkQk4FSdoL8
	m/xncv6mgiQ+YBIWrjCt677tKggJBf6ceEBJg5LQAFB262SOP6a3CpEkm7bH1mmHTlPyLZ
	yVsYTsGRyPdWcbfhFBUlxw53B/TPNgk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-76oCjln8NYuRVZ3NQofvzA-1; Tue, 01 Jul 2025 16:32:40 -0400
X-MC-Unique: 76oCjln8NYuRVZ3NQofvzA-1
X-Mimecast-MFC-AGG-ID: 76oCjln8NYuRVZ3NQofvzA_1751401959
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a3696a0d3aso1739771f8f.2
        for <linux-nvme@lists.infradead.org>; Tue, 01 Jul 2025 13:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751401958; x=1752006758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3QAp+njIqgagygGelfi+VFuGwWXW8+PeuSHzW1GgA0=;
        b=UixCqqIvdxF9h+MST0fux8W86dmAjzErWfD96zS8TjaWtKI4kxusa2dRBxB/0W2oD0
         UciaRL21FEP/PUtNQK+CaPkb59sIgp4xF8x/0xVIrjcRzCs+Yo9G9YLtDIpAH3o1PE4J
         X4ci6wXqfvTRE3fQyTrcwxw3mRXvuvljqzvuJ2j5HCagYT2NXzd9qY7v68/Yb1D7MQ+Q
         /FnWZ4Eg/6cOks1hD+XmPrmpOFR1cB05z2w3Ultzwx60PRnv/iSQ3fce/Ik8rW8n/sFC
         ERxwgkZCfSkGfpBoLxZpRnE7zmNeMg3gAO7Bvi4dR29c2oUmSHJIPD1ChY5ZzghRxbSU
         /sdA==
X-Gm-Message-State: AOJu0Yw9nxo038k87vJf18VrCbBTNO7NyLcPTZrzvlAzyXzVkHeU56rp
	LbaVV/vEC5VU+LwQYqGU2kMBkStWSdhMZDMRsXov9J9jC8o7TWyMCTtwAyffuxBhz29jCzlDHO9
	n3VBLJ+xvEP+YeZmh+21otlHSnmAXp72hbX0uEKEeJw3wx6pb1rIsLuMvrTBOQJrqtOLMBmeLW4
	DOmBIyO6jzdLu1MU5FFg+EZbn3J9/23U5101TvR5xSnz1Yy1NW0mSYcQ==
X-Gm-Gg: ASbGncsiA/DyYmOkUC8FL53Zcx7C35UjcYdBdZCbV4rjxvnS6KkCBfl5Wo+B+9oN7Sc
	mlftQ0HBDsWrGHQ9sjfw08xqBmlP/xGNenxLMsH4ykGV32nXsYtcKX1Q+uKPgV2Df/GtypP3WTt
	aoprEC
X-Received: by 2002:a05:6000:25ca:b0:3a5:8abe:a267 with SMTP id ffacd0b85a97d-3a8fe5b1cf7mr15747179f8f.29.1751401958015;
        Tue, 01 Jul 2025 13:32:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaXTrHdYMTTka2N0mDvXTqVTj3B/c609I9qCTvVCH95ljEAo/uWdP4xeb+yfNBMzV+3n9TvAoTLAQSpx33k7I=
X-Received: by 2002:a05:6000:25ca:b0:3a5:8abe:a267 with SMTP id
 ffacd0b85a97d-3a8fe5b1cf7mr15747169f8f.29.1751401957535; Tue, 01 Jul 2025
 13:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250624202020.42612-1-bgurney@redhat.com>
In-Reply-To: <20250624202020.42612-1-bgurney@redhat.com>
From: Bryan Gurney <bgurney@redhat.com>
Date: Tue, 1 Jul 2025 16:32:26 -0400
X-Gm-Features: Ac12FXzlbt2uDX9BNpN5evNVgF5ZoZ7CRlSkxe-hfkTmpSFBIUZ-ko4ETlTFq7w
Message-ID: <CAHhmqcTO_Q59aDr3DywC-tPF=9pe3gxbyn6J4ycdf+eYEOayHQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] nvme-fc: FPIN link integrity handling
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de, 
	sagi@grimberg.me, axboe@kernel.dk
Cc: james.smart@broadcom.com, dick.kennedy@broadcom.com, njavali@marvell.com, 
	linux-scsi@vger.kernel.org, hare@suse.de, jmeneghi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: o8uU9ONW2BKqhuzKSkRFT1k34cGX3s3kahSO2-zLU8o_1751401959
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_133246_289628_48B805A8 
X-CRM114-Status: GOOD (  32.72  )
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

On Tue, Jun 24, 2025 at 4:20=E2=80=AFPM Bryan Gurney <bgurney@redhat.com> w=
rote:
>
> FPIN LI (link integrity) messages are received when the attached
> fabric detects hardware errors. In response to these messages I/O
> should be directed away from the affected ports, and only used
> if the 'optimized' paths are unavailable.
> Upon port reset the paths should be put back in service as the
> affected hardware might have been replaced.
> This patch adds a new controller flag 'NVME_CTRL_MARGINAL'
> which will be checked during multipath path selection, causing the
> path to be skipped when checking for 'optimized' paths. If no
> optimized paths are available the 'marginal' paths are considered
> for path selection alongside the 'non-optimized' paths.
> It also introduces a new nvme-fc callback 'nvme_fc_fpin_rcv()' to
> evaluate the FPIN LI TLV payload and set the 'marginal' state on
> all affected rports.
>
> The testing for this patch set was performed by Bryan Gurney, using the
> process outlined by John Meneghini's presentation at LSFMM 2024, where
> the fibre channel switch sends an FPIN notification on a specific switch
> port, and the following is checked on the initiator:
>
> 1. The controllers corresponding to the paths on the port that has
> received the notification are showing a set NVME_CTRL_MARGINAL flag.
>
>    \
>     +- nvme4 fc traddr=3Dc,host_traddr=3De live optimized
>     +- nvme5 fc traddr=3D8,host_traddr=3De live non-optimized
>     +- nvme8 fc traddr=3De,host_traddr=3Df marginal optimized
>     +- nvme9 fc traddr=3Da,host_traddr=3Df marginal non-optimized
>
> 2. The I/O statistics of the test namespace show no I/O activity on the
> controllers with NVME_CTRL_MARGINAL set.
>
>    Device             tps    MB_read/s    MB_wrtn/s    MB_dscd/s
>    nvme4c4n1         0.00         0.00         0.00         0.00
>    nvme4c5n1     25001.00         0.00        97.66         0.00
>    nvme4c9n1     25000.00         0.00        97.66         0.00
>    nvme4n1       50011.00         0.00       195.36         0.00
>
>
>    Device             tps    MB_read/s    MB_wrtn/s    MB_dscd/s
>    nvme4c4n1         0.00         0.00         0.00         0.00
>    nvme4c5n1     48360.00         0.00       188.91         0.00
>    nvme4c9n1      1642.00         0.00         6.41         0.00
>    nvme4n1       49981.00         0.00       195.24         0.00
>
>
>    Device             tps    MB_read/s    MB_wrtn/s    MB_dscd/s
>    nvme4c4n1         0.00         0.00         0.00         0.00
>    nvme4c5n1     50001.00         0.00       195.32         0.00
>    nvme4c9n1         0.00         0.00         0.00         0.00
>    nvme4n1       50016.00         0.00       195.38         0.00
>
> Link: https://people.redhat.com/jmeneghi/LSFMM_2024/LSFMM_2024_NVMe_Cance=
l_and_FPIN.pdf
>
> More rigorous testing was also performed to ensure proper path migration
> on each of the eight different FPIN link integrity events, particularly
> during a scenario where there are only non-optimized paths available, in
> a state where all paths are marginal.  On a configuration with a
> round-robin iopolicy, when all paths on the host show as marginal, I/O
> continues on the optimized path that was most recently non-marginal.
> From this point, of both of the optimized paths are down, I/O properly
> continues on the remaining paths.
>
> Changes to the original submission:
> - Changed flag name to 'marginal'
> - Do not block marginal path; influence path selection instead
>   to de-prioritize marginal paths
>
> Changes to v2:
> - Split off driver-specific modifications
> - Introduce 'union fc_tlv_desc' to avoid casts
>
> Changes to v3:
> - Include reviews from Justin Tee
> - Split marginal path handling patch
>
> Changes to v4:
> - Change 'u8' to '__u8' on fc_tlv_desc to fix a failure to build
> - Print 'marginal' instead of 'live' in the state of controllers
>   when they are marginal
>
> Changes to v5:
> - Minor spelling corrections to patch descriptions
>
> Changes to v6:
> - No code changes; added note about additional testing
>
> Hannes Reinecke (5):
>   fc_els: use 'union fc_tlv_desc'
>   nvme-fc: marginal path handling
>   nvme-fc: nvme_fc_fpin_rcv() callback
>   lpfc: enable FPIN notification for NVMe
>   qla2xxx: enable FPIN notification for NVMe
>
> Bryan Gurney (1):
>   nvme: sysfs: emit the marginal path state in show_state()
>
>  drivers/nvme/host/core.c         |   1 +
>  drivers/nvme/host/fc.c           |  99 +++++++++++++++++++
>  drivers/nvme/host/multipath.c    |  17 ++--
>  drivers/nvme/host/nvme.h         |   6 ++
>  drivers/nvme/host/sysfs.c        |   4 +-
>  drivers/scsi/lpfc/lpfc_els.c     |  84 ++++++++--------
>  drivers/scsi/qla2xxx/qla_isr.c   |   3 +
>  drivers/scsi/scsi_transport_fc.c |  27 +++--
>  include/linux/nvme-fc-driver.h   |   3 +
>  include/uapi/scsi/fc/fc_els.h    | 165 +++++++++++++++++--------------
>  10 files changed, 269 insertions(+), 140 deletions(-)
>
> --
> 2.49.0
>


We're going to be working on follow-up patches to address some things
that I found in additional testing:

During path fail testing on the numa iopolicy, I found that I/O moves
off of the marginal path after a first link integrity event is
received, but if the non-marginal path the I/O is on is disconnected,
the I/O is transferred onto a marginal path (in testing, sometimes
I've seen it go to a "marginal optimized" path, and sometimes
"marginal non-optimized").

The queue-depth iopolicy doesn't change its path selection based on
the marginal flag, but looking at nvme_queue_depth_path(), I can see
that there's currently no logic to handle marginal paths.  We're
developing a patch to address that issue in queue-depth, but we need
to do more testing.


Thanks,

Bryan


