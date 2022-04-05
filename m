Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECE5C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 06:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EYidTHKYAOWxGe80GFxOX7iEsRTNQKDVVEEmKhylM8s=; b=BI5GcB/MGrmWn4y8wbDtvllFs6
	ro7iXLVw3iyYf+A7oR2CN4IA+r8g4OPOk1zV3CT7PuNlfBnSivrqIvTUHj7S9bXtSiDNy6dbTL7Zc
	S5sYlJWkrGagqMP4TEYkBKFdIbqyLaSMQ29RZ3j6drsno4KOo2Lo2KtwDusBe4a/UtbcPsEmCqSxz
	7qUESWuDxNcLeatMoglXjtcxV/DOcqv3FPA87C6tgdy5ZjC6T62b0KreOop41wwy5b6NGnOPfFs+p
	auZPpwLasTUEVmfzy0/W66ZKaKTRT2mhrpg80Ktg8M/cc1t8aFp5jW8cnT7OMb/+vA57garD6fLlE
	+DFMwL4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbcM0-00HG5q-QJ; Tue, 05 Apr 2022 06:07:48 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbcLx-00HG5A-U8
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 06:07:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7F2C968AFE; Tue,  5 Apr 2022 08:07:42 +0200 (CEST)
Date: Tue, 5 Apr 2022 08:07:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] nvmet: check for subsystem type in
 nvmet_find_get_subsys()
Message-ID: <20220405060742.GA24073@lst.de>
References: <20220317142634.49324-1-hare@suse.de>
 <20220317142634.49324-2-hare@suse.de> <20220405054536.GB23466@lst.de>
 <1c44e4aa-f966-5767-a147-a7f24f6753ee@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c44e4aa-f966-5767-a147-a7f24f6753ee@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_230746_151899_69A337EB 
X-CRM114-Status: GOOD (  14.74  )
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

On Tue, Apr 05, 2022 at 07:53:43AM +0200, Hannes Reinecke wrote:
> Do we want to support unique discovery controller NQNs in nvmet?
>
> Previously there was a rather strict policy of implementing only the bare 
> necessities in nvmet, and unique discovery controller NQNs is arguably not 
> a necessary thing.

I don't think there has ever been a policy of only bare necessities.  But
more one of checking if features are useful for nvmet.

Given that we basically need unique discovery controllers to usefull
support authentication it seems like we have to support them, even if the
feature on its down does not look all that useful.

