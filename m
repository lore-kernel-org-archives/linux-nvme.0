Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BD8C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 15:42:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17E7C64ED3
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 15:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E7C64ED3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JPxf30xEhV2LbTbcKYZAEcazisuraqJauDJ6CclPKT4=; b=GT2Ay+m3MmiuM6unFuxuIcozf
	8AtFew/PRRrVdGCzRkE+0WMlf1c3bK/fk4Obd9CeiiAlKg1TEZBJ10baWPJEHin+l9g7eV5QEsjXo
	bQHgssHGH9C2dYVpGRDwP+LETKxJRCNTPNKRNVdKcF9IF0qZh4zP/D2KtO3B4BFym8hEKxtNYRDk5
	GGpvxgCRkYLNhYqRS0JAyW7dmsqDi2rZEzFMtkFVz8DWl8JAtNTlk//Uf88/0TmCRpwsXB8uUD9BA
	1pONhq+sOHnKAQwNaaKH5FEIScpENaqcku6PQtjcQAEnWvSrKy4pbrfwEfPqnpa+YxGDfQqohoq0F
	mGV1OAkeA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEwJD-00008y-R1; Wed, 24 Feb 2021 15:42:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEwJA-00008c-OT
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 15:42:37 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F12064DD3;
 Wed, 24 Feb 2021 15:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614181355;
 bh=A4bc4cnLlB2jMzfRd7+UAq8fwhkI3TLLuE89poqrezE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=M654niRl9+1JdCgWxGHVoCd7fll6T941R6+tA/a+Caln8WsLFsrbqfv77zI5hcqZQ
 XAainoLpT2up7mPNaIBcQS390GF8OInnYFfxf6bb1vpipq9lAGDFOP9qWZJmQYDj0J
 E6DRC5hiPYQZIzbaZKcniJjg6YEZHPRTTSuebVh6oTxrc5/pkROuFcihAjAYBItegN
 FFKmy7+RNx163ryMvxryAf8wEayCEx5O6BtO4Yk9Jr1HJaYR3Hq7ET0MZqcOKJUlfu
 aRUHgiXpe9pG597JG6uT8bMQ7pxr03ey768EwNynmTCnuMGpjx8XkD0q7Bw8noxEDw
 a5XYT1Kd4q2ZQ==
Date: Thu, 25 Feb 2021 00:42:29 +0900
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 00/14] nvme: few cleanups and small improvements
Message-ID: <20210224154229.GA26830@redsun51.ssa.fujisawa.hgst.com>
References: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_104236_928028_CC071D9D 
X-CRM114-Status: GOOD (  15.44  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Feb 16, 2021 at 04:10:18PM -0800, Chaitanya Kulkarni wrote:
> Hi,
> =

> This has few cleanups such as variable data type, removing=A0oneliner
> wrappers for single callers, removing duplicate kfree() and small
> improvements for NVMeOF Passthru fast path such as likely annotation,
> removing the extra checks, making function inline for host/core.c.
> Last couple of patches fixes warning for FC function header
> documentation.

The two documentation fixes at the end look fine, but much of the rest
looks unnecessary. =

 =

> Chaitanya Kulkarni (14):
>   nvme-core: remove duplicate kfree in init identify
>   nvme-core: don't use switch for only one case use
>   nvme-core: use right type for ARRAY_SIZE check
>   nvme-core: fix the type for shutdown_timeout
>   nvme-core: add helper to init ctrl transport attr
>   nvme-core: add helper to init shutdown timeout
>   nvme-core: add helper to init ctrl subsys quirk
>   nvme-core: move util quirk at the top of the file
>   nvme-core: mark nvme_setup_passsthru() inline
>   nvme-core: remove one liner wrappers for streams
>   nvme-core: use likely in nvme_init_request()
>   nvme-core: don't check nvme_req flags for new req
>   nvme-fc: fix the function documentation comment
>   nvmet-fc: update function documentation
> =

>  drivers/nvme/host/core.c | 333 ++++++++++++++++++++-------------------
>  drivers/nvme/host/fc.c   |   2 +-
>  drivers/nvme/target/fc.c |   1 +
>  3 files changed, 172 insertions(+), 164 deletions(-)
> =

> -- =

> 2.22.1

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
