Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A191AD29DDE
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jan 2026 07:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LQd3vxsUZRJv7WZFMtICgw6IRAMKxGAqoJIgASYztt4=; b=xDSu0sysFm4T3h3FgxTpK/v4W/
	uhnBW+2p6Remfx6kOTJmVkeU5jDEwbaJucHIkp58T2cIdqUG5wybXGdSOR4DlMRfmXA86bM+oWj16
	qujBG8pATh6AGQ0qnNU9pWkRlixi6WgZverfn0ko6VlW55/UnUwpsIHO9nM/T8UHsq8t2J1p0d9+X
	0bPaMJ37JBnoKaZ8tMVkfRXS7ZfVyw/fw0GcpYmD5jnZ/eK2rP4yDKpSEBX55tso+Rr/3+iixr8FC
	ZO9Ja1Tdzzq7xk8p9zUC7yH2RgjI7Dlirls+B5jXe0Dpn7YQtEoi+Tzq/0pmhFPyrNiEIo7Iz8E7L
	oCkjwvtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfYqB-00000006ezC-0WwW;
	Tue, 13 Jan 2026 07:29:23 +0000
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfYq5-00000006ewz-2urm
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jan 2026 07:29:19 +0000
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-c551edc745eso1664038a12.2
        for <linux-nvme@lists.infradead.org>; Mon, 12 Jan 2026 23:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768289356; x=1768894156; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LQd3vxsUZRJv7WZFMtICgw6IRAMKxGAqoJIgASYztt4=;
        b=kNqkbdM7WITCyd4+4dk5jSzExbFZCcq6hRNGPcGOu1bjuCE9+nfB+uuq8haE6uxgKd
         3r1fBY43OCl1ZbWLg42KL6aBhmw7wHecqsKlutNZ9uQFfW/59C6qHuQ35evVSnXhA1Ir
         hjh9dP9d3t+2fhsRPFhrcyAB98SyLEdaWaZgTueKTY+A7v7wppRhCMaNErv+8UyTBhFA
         cP+LUzvJTPQRG9qq5b2CmvgfK8jBHBfXjD/8tZGYBHF6Tf8ksrURgUmxCVb8xNeJdYWP
         0jSQrr1P62oc/1v7DOxRULE0uB1w1esnn5lvRxri6GmPiWisblNvKLTNZyHfxUKvf5zP
         X8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768289356; x=1768894156;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQd3vxsUZRJv7WZFMtICgw6IRAMKxGAqoJIgASYztt4=;
        b=sGAaKkgJkSVTwVkbYytfFBi9BQEmy20/sOEfKOm6uTv48KiPsxovgdKfBtcLgOFHzK
         M2sgtv5WjC+Do/yAlEbJQC6Yk+PvSinR/KHtliUU47WTdceboa+a3wgSzZoxQ5eqNkNi
         3iNJA63uD6UXjWgP4WLGvd+/Qu/DwHH+Gjbc/5icP3fLdHyKzNdJOP2mTAaaIwKleAh3
         S1S9X8wRtaP95IKETPwIkhgi7nKc7usWTjJy9qZNndaVivi+DId4S39Qqkmh5dEbeZpX
         QHkLlao0xOcDs3el2DmefxAETfhWHSEtSlolzZvKD9o7s/OupAK9rzbco2xxJyF0QzF0
         pjvA==
X-Forwarded-Encrypted: i=1; AJvYcCXKjFfVCc1MEZQVCapK5z1jowFtE9Vr8MrBHdZWSA3J88QCoexOGgZ2cGBM810lpSQbZXYdWYf3Okyk@lists.infradead.org
X-Gm-Message-State: AOJu0YxtJtoVqjJDS2Pnu86aI0iXBT+LzX4Flg5vnN0x2fvvC5/QdYyz
	ou5OpW8EZ8aFqJ0WpTlezhpX8ms0vTKVi9YUNbCTlLovwbJ/8voGL4E5
X-Gm-Gg: AY/fxX4mPL9F5o/5+pedzadfg4PJQ9E7+cjlEWV/jlqz+PV9uxZ1bM7p/S7Tkao8dPM
	fgDRyLqpFENim7RvE93Td4d3Rw1BezNCgZDxySGAiTDTfcc1YVDsNR9GrGrnEApbJZ+fJyGPULX
	jkO3DWdfx8Dtp8UQ0p1ENbgFDEnmcarwHqSul/y1qh4rW1IQz/ITvvIz/72Yi12WezsBpxylPPD
	j6RK6KYoc2cP2FlL1UsWA3FrS1udBjfuhdrJI4KJrhihhX7WtJ2o+pqhT+BFZSxTeQdI4ymnmfW
	EtDDmz6mQRa7NZ4UwD2lbUgqKztQKa+721AlKPq/P8iSqA6RJcNIK+6D+b2d6FX9BkcQZoEBOz2
	Y6gkxgtkNmNGWk1uhitzKmbRbW8YMcre7J1oV86IWiCtmx/o3to3HJiCsfdgzlpowuND7Ba6DjU
	f18efJyUYyxoJPgA2X36gm/VUS
X-Google-Smtp-Source: AGHT+IF+P7mNgMK+z+6OftBDsqXdcFIvN6VmOQ6tpOTXR8rblMAeCkMhX00MF/UbyewjZizDemLN5A==
X-Received: by 2002:a17:90b:5906:b0:340:2f48:b51a with SMTP id 98e67ed59e1d1-34f68b68c61mr17775450a91.15.1768289356099;
        Mon, 12 Jan 2026 23:29:16 -0800 (PST)
Received: from [10.0.2.15] ([202.3.121.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f7b1d81sm19342105a91.1.2026.01.12.23.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 23:29:15 -0800 (PST)
Message-ID: <51de382f9f337cb7249e357fe6a798dca88e8249.camel@gmail.com>
Subject: Re: [PATCH 1/2] nvme: avoid printing iopolicy in list-subsys output
From: Martin George <martinus.gpy@gmail.com>
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: wagi@kernel.org
Date: Tue, 13 Jan 2026 12:59:13 +0530
In-Reply-To: <20260112111731.1631091-2-nilay@linux.ibm.com>
References: <20260112111731.1631091-1-nilay@linux.ibm.com>
	 <20260112111731.1631091-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260112_232917_760319_50293323 
X-CRM114-Status: GOOD (  16.98  )
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

On Mon, 2026-01-12 at 16:46 +0530, Nilay Shroff wrote:
> Since commit d0b4c6cf0006 (=E2=80=9Cnvme: extend show-topology command to=
 add
> support for multipath=E2=80=9D), the subsystem header printed by both sho=
w-
> topology and list-subsys includes the iopolicy field regardless of
> whether the verbose flag is specified.
>=20
> For show-topology, this behavior is intentional and useful. The
> command
> now prints additional columns such as Nodes or queue-depth depending
> on
> the configured I/O policy, and displaying the iopolicy value makes it
> easier to correlate the output with the active policy configured for
> the subsystem.
>=20
> However, the same iopolicy field is also printed in the list-subsys
> output, where it is not always relevant. This happens because both
> commands share the common helper stdout_subsys_config() to print the
> subsystem header.
>=20
> This change fixes the inconsistency by always printing the iopolicy
> field for show-topology, while suppressing it for list-subsys unless
> the command is invoked with the verbose flag.
>=20
> Fixes: d0b4c6cf0006 ("nvme: extend show-topology command to add
> support for multipath")
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
> =C2=A0nvme-print-stdout.c | 14 ++++++++------
> =C2=A01 file changed, 8 insertions(+), 6 deletions(-)
>=20

Reviewed-by: Martin George <marting@netapp.com>

-Martin

