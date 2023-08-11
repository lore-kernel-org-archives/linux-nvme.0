Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF252C0015E
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 20:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9vnb0LUtFIzM3i+dHAplRe9+3aKzWBKHkBcPDINO9GQ=; b=NUWGqx9NJ4bCQkC+V+Y2Xf3/BO
	9OUchNiDpt8958biSKaHM03u/GPaWSppQ9QuUS2S4ReHk8C1qW0i+0S8XfIASnOQCRIVMxA7APL/k
	Fx71DDOpxiMkUfWSltBR6xwX7GVchX5ucgvj2cP8K/1BM/xYD0vOG/m0YTsVDAcsmJLGstgp7Psk6
	+d/0SVtfY//A6zAHzuv0rQ46ZJMOE42vPDMmu+Y5Chfja4cJD0WMHU6sPDgT4Cr9oe67gBJdEUypK
	ghniLWEYQ4TAoF1UX9FVrAkGjr4k/SwfZuXE/kGrWTBNFGH4rorbO6LpXQocvr5vVfbkpnlPpqKFG
	4hfNM2cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUZES-00BdOp-1r;
	Fri, 11 Aug 2023 20:59:40 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUZEQ-00BdNy-06
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 20:59:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id EA1AC64817;
	Fri, 11 Aug 2023 20:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0393C433C7;
	Fri, 11 Aug 2023 20:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691787576;
	bh=kdOkYOLUIHXvpGrXXLNbvMVFBY5bjHVGpejjL6TXi+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UdYSsKSDT5puBMDQgCfso6AoxmNYinDHjhuqqDe0ajCer3AbOx8YVG8iQi3HsMbV+
	 o57KmNkTGERDZIVfzA2xXXI9PFMJuhaRDLa68W5mvO/XcF/8UNghtfLdyGab0cbYfQ
	 GiYVsHpCdhyjR+aTo3GPhp+Ev/fsfTtf1zq2O3sYqetbmtCT6KIAHTFYtUH53IMABj
	 7R9Pm2I5bYbN9QaX/mdlKvL+8f3l7rOvJmi1RmfX3E9wMdxO2xssUlWG6oi1j+qGXZ
	 WhnObYYeFf+8HK7QXm3zweML0JPQc6s2Kq0fdfvQuzzdt0OURKyHP9CxlB0a/drdky
	 WRq50273Bcwgw==
Date: Fri, 11 Aug 2023 14:59:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: August Wikerfors <git@augustwikerfors.se>
Cc: stable@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
	Christoph Hellwig <hch@lst.de>, axboe@fb.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	nilskruse97@gmail.com, David.Chang@amd.com
Subject: Re: [PATCH] nvme: Don't fail to resume if NSIDs change
Message-ID: <ZNahNYGd3L8YYtiQ@kbusch-mbp.dhcp.thefacebook.com>
References: <ZMgHE2wu4T4OfrTR@kbusch-mbp>
 <040c5788-1a7b-26ea-23cc-ba239c76efa9@augustwikerfors.se>
 <39697f68-9dc8-7692-7210-b75cce32c6ce@amd.com>
 <20230731201047.GA14034@lst.de>
 <36319a0f-34a6-9353-bc52-4d4d0fac27a5@amd.com>
 <20230801112403.GA3972@lst.de>
 <ae7fb9b2-d692-f9b8-5130-4555cc489846@amd.com>
 <ZMlrGNw5OMW3yxId@kbusch-mbp.dhcp.thefacebook.com>
 <b2e741b3-b581-40fe-2c28-e4660f52003d@amd.com>
 <0f422dbe-2e3f-4401-be87-2963cbbc1234@augustwikerfors.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f422dbe-2e3f-4401-be87-2963cbbc1234@augustwikerfors.se>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_135938_111802_D661B47C 
X-CRM114-Status: GOOD (  11.37  )
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

On Fri, Aug 11, 2023 at 10:19:35PM +0200, August Wikerfors wrote:
> On 2023-08-01 22:34, Mario Limonciello wrote:
> > If you can still change it before sending out can you add a stable tag
> > as well?
> 
> This didn't get added in time, so, stable team, please backport:
> 
> 688b419c57c1 ("nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1 256G and 512G")

Perhaps bad form on my end for relying on it, but in my experience, the
stable bot has a great record on auto selecting nvme quirks.

