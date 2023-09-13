Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EE7EDEC72
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Sep 2023 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i51ND6Tfo8Fzra+mDWphk0Mu6PIAw7jP7tj3RUPLE6I=; b=zFQ4l5bens+FnYIPyz4IQyAcDm
	zEg8TrB51BIPjuV3L7yxkES7arruF8zeegwhpXEjPIj2gZ800qBHLhsOolZz/BbyzS2FmXfkmefDG
	pL1TZ6lTDO72MUy7Na+ndFPl8mumQncwIFvjUlWCSoIbF50HjU6B/2PIJnDxcyA3QtkxiUxOat95E
	vt9cdU343JUlg1GUm2P/v/026bYMGhhz0aWb5oOu5EmI4Urz0QtEBbxRmS5GyUW81LWFh5QVQTzvg
	+0/7KNawQZLdpGO0WvOa/s2WTJIUEkAqOSXS1+m76SY78USB5KJ+IhQw4w7NDSnlcq8Krr8bBFM7L
	FyuzF5yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgRfA-006CsQ-1Z;
	Wed, 13 Sep 2023 15:20:20 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgRf7-006Crs-1h
	for linux-nvme@lists.infradead.org;
	Wed, 13 Sep 2023 15:20:18 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 4AAE8CE2224;
	Wed, 13 Sep 2023 15:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D906C433C8;
	Wed, 13 Sep 2023 15:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694618413;
	bh=OnjCgKC9sRBkyqkiWh4wZF7cKjcLN+SZjyqwvX/4gew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iyD0pSGOtb6wNEQnS38laXi2vacZU3Ib9LL48ivvmkzb3VBVvhIetfeaIOPxv5D5T
	 xrU5BdElUQhSglXcuHeJnlfxLQopt9LUC3I6sFHMZynDiAG+4Mgfc9MyHNsGHQsfUA
	 /xr6ll/kYwbS3LlGw98J0I95FuoLqkUZFxPCL0R0cFvrx283AbOxhL3GEmVGHkvuRI
	 hnKGSCIgOdIOwltE1RYNRGMibfJglNbP+Pv3pizLz2K76TRS0Y3gpt3ejAbJBfXHwq
	 nZgaVeKlomZvbJLvYErplpwKnjNYQ673IO/gpnM4Wqe/hnknPWczLWo6ytgZzTxAej
	 HQz8XB6/D7U5A==
Date: Wed, 13 Sep 2023 08:20:09 -0700
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Keith Busch <kbusch@meta.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	=?iso-8859-1?Q?Cl=E1udio?= Sampaio <patola@gmail.com>,
	Felix Yan <felixonmars@archlinux.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] nvme: avoid bogus CRTO values
Message-ID: <ZQHTKQLKFE9Iupp0@kbusch-mbp.dhcp.thefacebook.com>
References: <20230912214733.3178956-1-kbusch@meta.com>
 <ZQGqNZD9QweQQRmF@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQGqNZD9QweQQRmF@x1-carbon>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230913_082017_739622_E2300E32 
X-CRM114-Status: GOOD (  13.18  )
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

On Wed, Sep 13, 2023 at 12:25:29PM +0000, Niklas Cassel wrote:
> > +		if (ctrl->ctrl_config & NVME_CC_CRIME)
> > +			timeout = max(timeout, NVME_CRTO_CRIMT(crto));
> > +		else
> > +			timeout = max(timeout, NVME_CRTO_CRWMT(crto));
> 
> I saw the original bug report.
> But wasn't the problem that these were compared before NVME_CC_CRIME had
> been written?
>
> i.e. is this max() check still needed for the bug reporter's NVMe drive,
> after NVME_CC_CRIME was been written and CAP has been re-read?
> (If so, would a quirk be better?)

The values reported in CRTO don't change with the CC writes. It's only
CAP.TO that can change, so we still can't rely on CRTO at any point in
the sequence for these devices.
 

