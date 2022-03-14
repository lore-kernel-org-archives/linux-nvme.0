Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67EEC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 07:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H+ZrdKEXKEGrT5jOhUGJAlN2MccDjHKg9oyR2nKfTgc=; b=XJ/fZKv5iLfYCBPXwXzPjje04Q
	3RRaLKnfnMn4aDY/8BGzJrfvIvvkgbRRfqhEZUG/xZE/PpqJNBro/K+GSWgWpkMRdlhw+bWn+Zd1r
	wa6pLhkfGzcUyjB/kA5U9gOT/UIbZcB4rJCb+T9k4hzz/JpuPk81BpWqlaJP+O2ddpGHGj3oKqeBq
	E68991Wg+cjktj8QX3Aj0dDwLsmmxVLWsIIFvGmi5qqfp8I5YteEZy08NPrxyiwRlV+FwwpGrGQ60
	jE8LSX95AS9MheCT66HVUeFa+vGrmhjTAmf+/WW1jDVgIdAkoOXV0msp+BPtNbEQzQiQ9pQdtRojH
	IzwFMXXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTemG-00418I-Ng; Mon, 14 Mar 2022 07:06:00 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTemD-00416z-BX
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 07:05:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3FB7F68B05; Mon, 14 Mar 2022 08:05:53 +0100 (CET)
Date: Mon, 14 Mar 2022 08:05:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Niolai Stange <nstange@suse.com>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCHv8 00/12] nvme: In-band authentication support
Message-ID: <20220314070552.GA3806@lst.de>
References: <9853d36a-036c-7f2b-5fb4-b3fb4bae473f@suse.de>
 <4328e4f0-9674-9362-4ed5-89ec7edba4a2@grimberg.me>
 <56f1ce1c-2272-bed2-fd6b-642854b612bb@suse.de>
 <483836f5-f850-6eac-8c38-3f03db3189ab@grimberg.me>
 <0c4613ff-ba30-c812-a6e9-1954d77b1d1b@suse.de>
 <ad9af172-4b7b-4206-feab-8ab54ba7cfe5@grimberg.me>
 <e2ccd5bf-c13f-8660-c4c0-31a1053846ed@suse.de>
 <1d1522c6-7f6b-7023-9e66-a05ac5a5a0be@grimberg.me>
 <ac3056fe-e5bb-92cb-2d4f-a86c04117e5d@grimberg.me>
 <e9b43c80-0eb7-99ae-55d5-aca9bf2a308b@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9b43c80-0eb7-99ae-55d5-aca9bf2a308b@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_000557_562490_AE62AF1A 
X-CRM114-Status: GOOD (  13.17  )
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

On Mon, Mar 14, 2022 at 07:54:28AM +0100, Hannes Reinecke wrote:
> Pondering what the next steps should be. Herbert Xu has merged Nicolais 
> patchset, so I _could_ submit the patches, but then I would need to base it 
> on Herberts cryptodev-2.6 branch.
> And without these patches my patchset won't compile.
> So no sure how to proceed; sending the patches relative to Herberts tree? 
> Waiting for the patches to appear upstream? Not sure what'll be best...

We're at 5.17-rc8, so hopefully they will in mainline for 5.18-rc1 in
a few weeks. Let's wait until then to avoid complex tree dependencies.

