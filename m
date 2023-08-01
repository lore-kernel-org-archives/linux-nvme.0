Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA1EC0015E
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Aug 2023 20:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7gYI6K1KzOgeyxpWIXxWymeJqYtQUwHhg9RbBScKAng=; b=dxLTSRz9ladedBi+6buKJ/XbOh
	cA3TW4758Tkt6nqvEDMKs2SZqDaLWR69T/tj7jjWoI4DahhKdAIOG5XV5MruX2mmnSLRJFNxsmC9O
	7aru3c9kQ/TOtxMqo50bisAaJOV/r/54+46gTFHzbzVBBgT8SK4oYscanpFXEsixzJD3U8BxGmrdl
	2aqt/601llpqcwumU9WStcT3hFDlTgqlz8tYJIvGzEmSU0O6EttNvo/tFaDDyEA5Jq6DV6enG4hju
	OzsLNw9ia4wEFuQHHnPsWtlMqIa2OB3dyzCfkuaIIXfh69dR6x1AGTsUQAVtfi+NSs9cIneJ4O9Zm
	y5RMOZkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQvzd-003FNd-2Q;
	Tue, 01 Aug 2023 20:29:21 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQvzb-003FMd-1V
	for linux-nvme@lists.infradead.org;
	Tue, 01 Aug 2023 20:29:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 37CC2616D4;
	Tue,  1 Aug 2023 20:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF19C433C8;
	Tue,  1 Aug 2023 20:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690921756;
	bh=p+7E/WM0NDbhkT9TKeC9SNk+BVr0nurH4zEykwDbelQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XE6BjJp76eN2scRQ4ZgWTyi4mmDNPtMWf1s/Eu3jEi49VoMtTWf2NC9wZbJJl/zEn
	 bk4j1MRrY8D+r0wRfuCE7vprO25GWfwhKa9YzlM4hoGGAmxyXYoJDAYqRFmn9an/QY
	 7bxQ9n+46AkRCW+n7LHUHRQnfS1hRh4Ia7cl0iTqs89//Ge+sPtBkGZgR5FjyvR0Nn
	 j6iI0Pf3ZBKNOsmu5QtZTVcN1shgx1pdAmKAsvnHse7Ycll5/dql7g3P/uReBxNsuv
	 WkGijE12KZl7iF3HITwJkAE/pswqInX3x5i3JB4Vj5huRPlgvi2ZwBnbJlgrD+Lg7/
	 YwE/lS22+gKFw==
Date: Tue, 1 Aug 2023 14:29:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Christoph Hellwig <hch@lst.de>,
	August Wikerfors <git@augustwikerfors.se>, axboe@fb.com,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, nilskruse97@gmail.com,
	David.Chang@amd.com
Subject: Re: [PATCH] nvme: Don't fail to resume if NSIDs change
Message-ID: <ZMlrGNw5OMW3yxId@kbusch-mbp.dhcp.thefacebook.com>
References: <20230731185103.18436-1-mario.limonciello@amd.com>
 <ZMgHE2wu4T4OfrTR@kbusch-mbp>
 <040c5788-1a7b-26ea-23cc-ba239c76efa9@augustwikerfors.se>
 <39697f68-9dc8-7692-7210-b75cce32c6ce@amd.com>
 <20230731201047.GA14034@lst.de>
 <36319a0f-34a6-9353-bc52-4d4d0fac27a5@amd.com>
 <20230801112403.GA3972@lst.de>
 <ae7fb9b2-d692-f9b8-5130-4555cc489846@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae7fb9b2-d692-f9b8-5130-4555cc489846@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230801_132919_568369_CCFF67B4 
X-CRM114-Status: UNSURE (   9.66  )
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

On Tue, Aug 01, 2023 at 06:30:52AM -0500, Mario Limonciello wrote:
> 
> Do you want that re-sent?  Or can you just pick up from that lore link?

I got it, and applied to nvme-6.5 now.

