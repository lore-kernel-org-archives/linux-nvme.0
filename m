Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FD3C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 14:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0f2JILxat4B5Xza6OXB81zOAxegSw+zejfwTm4OdfN0=; b=4n9ncbRljjz6E2zOTjCHMoeCTK
	nT3UTce2Us32i+10T/DuWVnVpNAXFAvOuOzgeNV1PSRf14i/EtP6W41tWrcttimIw+v5JVK8EJEqB
	agKF9+ee+AvKy9MXRVUShEg/nNtWO3HhMVeteE7Or+RnYu2bOGwr2uvxNhQmts3pv30Cv9B3EFXQw
	fu9Vzmd2FHVKEpTVgfDsO0nR1gXICcvSmaNI7SZsz8ZwfcjBMbivOQN4ixkZC59D18sI6vQFg6gcZ
	1hQ6lVU1Pl5DCbFPhWG1OiOtyXWzWFKzCyC2yx2jVoceMh+hif72spHieqmr2hJOxIsIjIXMC2vkm
	NQDjVivA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKLcC-007Nc8-GR; Wed, 16 Feb 2022 14:49:08 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKLc9-007Nb1-3M
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 14:49:07 +0000
Received: by mail-pj1-x102d.google.com with SMTP id
 n19-20020a17090ade9300b001b9892a7bf9so6630365pjv.5
 for <linux-nvme@lists.infradead.org>; Wed, 16 Feb 2022 06:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0f2JILxat4B5Xza6OXB81zOAxegSw+zejfwTm4OdfN0=;
 b=CG5KedL4GZw0xS4VC3TVUZ/egR6n9M9sPdmeLrs0uSME8Fa/1Is23W0jMwphKKXAUg
 znkvjh6atDxCss+9/8YeKsrB/aK3SsW0wID6NIEFw4ustYWLeb43EF/8Tz5BciHqrUr6
 dMycz/1fyrgatbw3W/eeFCCm9wV2XXR4H8BS/om5sTSCvfPBXhil6iOat4hj1Pj/tWTK
 sHBCelO9EaKpdQpKIcLu4ju9FiJfUP0t2ch2SnSTJnJmCKVNK2PChtmbLuBdBqrXQhej
 T6Wf97yJVWQ/2QF/cj3p3WzmzIaGfnVouVGa3c/dz1iBPbhBa+J5v+j+pY+N0oO5+Uf0
 e1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0f2JILxat4B5Xza6OXB81zOAxegSw+zejfwTm4OdfN0=;
 b=RXZ3VQp1EFsS2Q/djH432fkYc1ze4nTPmjWOGI/99a19JxQ3GlMSp9+X8cFb/S24qH
 JZY7H3BZIxrwntKEWhXvc03aJqS4Bod8q/rI2xkVl4ijbHenGPkUTj6iWVhy1+fqLrIs
 st8thXANv9JyRoZSGAP6Doxd8in+1Sqc+nyB36qNE+1sTPrtkO0sxDW6UW9vgZm6pq8P
 6Nn4Ax0R/CxqbPhObf3DHQtO/itsOVz3/Dlr42gMQFeJzr5Arcfzw/aAScnHzuVC72AE
 lj8ZICr2/raQ0/AHN8tQZTUqc5KEiWk2B1chnuGLaRIkcW9EHMtCHnvfRNSrzB+VUE4r
 qPEw==
X-Gm-Message-State: AOAM533LR2cAZHMNJ8bvyh1VWAZOSwjhaF5+ONzxSyMtf5IVGjGibIM+
 RZ5JOGyRhAXaUiVQgnzNqMHR8PR1z55rpuTyVVY=
X-Google-Smtp-Source: ABdhPJyoBXjIRq17wEAFYDxT6y3grnEea6O4oWjMPk0fhz4FNL1VYbt1bcU4PUKg9v2htEjLDASEntkAZovIV6JsNEY=
X-Received: by 2002:a17:902:7584:b0:14d:77f4:5598 with SMTP id
 j4-20020a170902758400b0014d77f45598mr2738684pll.1.1645022944071; Wed, 16 Feb
 2022 06:49:04 -0800 (PST)
MIME-Version: 1.0
References: <20220216141220.4162670-1-hch@lst.de>
 <20220216141220.4162670-2-hch@lst.de>
In-Reply-To: <20220216141220.4162670-2-hch@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Wed, 16 Feb 2022 20:18:38 +0530
Message-ID: <CA+1E3rJLDHzVbhjrdrzL=Pyrc-7mUz8h5r3Ypfjv7417UF9zDQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme: also mark passthrough-only namespaces ready in
 nvme_update_ns_info
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, 
 KANCHAN JOSHI <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_064905_179348_CF29506E 
X-CRM114-Status: GOOD (  11.38  )
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

On Wed, Feb 16, 2022 at 7:46 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Commit e7d65803e2bb ("nvme-multipath: revalidate paths during rescan")
> introduced the NVME_NS_READY flag, which nvme_path_is_disabled() uses
> to check if a path can be used or not.  We also need to set this flag
> for devices that fail the ZNS feature validation and which are available
> through passthrough devices only to that they can be used in multipathing
> setups.
>
> Fixes: e7d65803e2bb ("nvme-multipath: revalidate paths during rescan")
> Reported-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good and works fine.
Tested-by: Kanchan Joshi <joshi.k@samsung.com>


-- 
Kanchan

