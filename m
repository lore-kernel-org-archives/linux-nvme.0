Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587E1C3ABAC
	for <linux-nvme@archiver.kernel.org>; Sat,  3 May 2025 03:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vU9ZUo64QD4UA1qeXQwBzwLAxuQVVlCjsAPF9UmwhA0=; b=SOkO/Mgkx1jzeeViLRjyVrpzWH
	vMIgiQ5BPN5hmkhUr1c3vtskW+bJCcuZvBEeMyNo9KJTpj8Coaw5GurdyWB6OAapUUaITOEtZpNeK
	r26vI38lC+l2w4N8tJObjosrSwXjKqjZpnYH9fYT3GLQ/DlitnltClGP49yZ1rphs+5f8R4Ibl3Vx
	g5JSgPnSAj33kdsyh161OahVo5qSIHKsAPqTUaA8g5Sy1psVoQxoB5EDVlpMzi45G8V0YY/2VwxbQ
	WaFm/DC72gbrNaIji8XX+vBvNFB8DDA9FfjfvN//EmXXShif1s6F+lU7QQoi2F8ZxVpQolND0VHBb
	QYCHoOKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uB3pO-00000003SLm-089R;
	Sat, 03 May 2025 03:46:14 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uB3pL-00000003SLP-2K87
	for linux-nvme@lists.infradead.org;
	Sat, 03 May 2025 03:46:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 815C443A48;
	Sat,  3 May 2025 03:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41763C4CEE3;
	Sat,  3 May 2025 03:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746243968;
	bh=Fmgv9Cp8dolCTo5O2sjLH6PKjP7SgvgvacCW80opf3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XlYD9+E8ek88N7FQw6vE9FsTFmo6juAhq2j4IxjFlaZ5QOqrugFf5q1yZPexdWgQB
	 QOTV7lWd1VaGjEOk+BCPt50GyG1QoWuB7ESsYOeOTPI8Jk8w6fpXARa2YqLllXHcKj
	 ZAmSqhyr8kAS/K5vcQZYVNae3Lo3tiMHL+6EhXlAcADhetfBWmZLhjNGrpZVRMlC6Z
	 ivHFEjxweZ3r25PKX9OPS7bmbdWRMLeecjFfb+dgfOt1Fgm5VyDEQQnTgNTm89ihz+
	 1ZKBOVJpb+vKGI1Zn93AvW0V6BJdsH+Cm2dejh23NGwSk9tZspsiNGcB69OtyBbxGp
	 aaLsTG+vWOrAA==
Date: Fri, 2 May 2025 21:46:06 -0600
From: Keith Busch <kbusch@kernel.org>
To: Judy Brock <judy.brock@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>,
	"Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>,
	Hannes Reinecke <hare@suse.de>, "hare@kernel.org" <hare@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, "wagi@lst.de" <wagi@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Javier Gonzalez <javier.gonz@samsung.com>
Subject: Re: [PATCH 0/2] nvme: handle partially unique NID value
Message-ID: <aBWRfiwJkeYGB0Og@kbusch-mbp>
References: <20250414090959.2015-1-hare@kernel.org>
 <20250414111916.GB13225@lst.de>
 <3e6fb1f6-d6f0-4f33-9389-dff37daae7b0@suse.de>
 <20250414114128.GA13822@lst.de>
 <PH0PR84MB1358448342C273E7C7BA808898BC2@PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM>
 <CGME20250502082359uscas1p1e2a9858dcc9200ab1d1d863c4495fc0a@uscas1p1.samsung.com>
 <eee8de0a44074dd3bfb0fc6ec425b647@samsung.com>
 <20250502102505.GA13055@lst.de>
 <27a99b458f0144fba094726e4f470552@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27a99b458f0144fba094726e4f470552@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250502_204611_614760_27B6758F 
X-CRM114-Status: GOOD (  10.72  )
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

On Fri, May 02, 2025 at 11:26:47PM +0000, Judy Brock wrote:
> For example, both companies have "admitted failure" but you haven't
> heard it: the FW in question definitely has a defect. Neither company
> is holding it out as compliant. Both companies have indicated going
> forward, the defective behavior has been corrected.
> 
> Not sure why you keep saying that neither company is willing to fix it.

I'm a little confused. If the conflicting behavior has been corrected,
why is this being discussed here? A device side fix is surely the best
possible outcome for everyone here. Requiring a kernel upgrade to work
around undesirable firmware behavior is a bit unpleasant for end users
when you already have a solution that works with any nvme capable OS. ?

