Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E46FC19F32
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Mar 2025 00:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iHl9Oju+aJz06Fk/fy0O9qH+Kn2Nshi8ktnY87jOX/Y=; b=oBPtghPTFXopqdPafh7VtZRSyl
	4sHdGOo7mBBtbCAbYdRJ6AlvTZgImFlfq70QqZ+AnBE33/yF9MrtU8JCgpWiNHPFfFO0hx37T/Slk
	RflRRws1JK/XR/jUVPIW4ofVEK6ri2aRW3r6HPEo73V/NUHUa0azz50plnxillghXGOiEeQi/ESk3
	+yz5hzQjscrRnTxCz55nG8PKcptjHOfekvEYL/00ItzFv+JAA9+OFBYVWIcRpfgQeRYcRCrdA8PVD
	okKj8gljVzJJVj0PPq8xZRLuYc9MZmC/WSBewYZmlsq498jpbjN6/KKOCzqUs4xpUKF/Y8dgJV39U
	Tm1fctRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpytY-00000009gOT-3YFh;
	Thu, 06 Mar 2025 00:15:24 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpytW-00000009gNq-3T5U
	for linux-nvme@lists.infradead.org;
	Thu, 06 Mar 2025 00:15:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 39B83A44134;
	Thu,  6 Mar 2025 00:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DABAC4CED1;
	Thu,  6 Mar 2025 00:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741220121;
	bh=Adg+t74yvHJFHoXDLdfTv32xGE3wVBh+8yopvBgugco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mx4PrFjiz7pideDtrB1Pi9/1K1KLoBEmSepuhUg0qkS74e/21ucT+PHiOT31LbxHY
	 sMQz9yqDhjS1FtToBn+F4dki0/zy2ZfhO1LddCPdE9F29q5QlZkWnIcA+x91H9Fesd
	 BrO5ezSG75UinDnJvxr4UCWTq+OJ6KLQV8U4J3DyT3VqL1DKUDROAj7EXAojvHvH+H
	 kVBRxtG4FvI8Kv1axUDCYREFrgriy8ySrMctRU1WsOGdRaBdAyUB+3oHT3SR6hY/+o
	 mzJIdU1Fhgb72pZt3RX4nFkWgJ5OnyI8Nw81f4PQRsywU4/FnHEtltM9czBShyNo6T
	 yq3QJzWjCq78w==
Date: Wed, 5 Mar 2025 17:15:18 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	John Meneghini <jmeneghi@redhat.com>, bmarzins@redhat.com,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
	axboe@kernel.dk
Subject: Re: [PATCH] nvme: remove multipath module parameter
Message-ID: <Z8jpFkHsN94nVgEf@kbusch-mbp>
References: <Z7TARX-tFY3mnuU7@kbusch-mbp>
 <2ff87386-c6db-4f2e-be91-213504d99a78@linux.ibm.com>
 <0656b66c-dd9c-495d-b1fc-4f09e763fa66@grimberg.me>
 <Z7dct_AbaSO7uZ2h@kbusch-mbp>
 <91ae613a-7b56-4ca0-b91c-6bc1eee798b8@suse.de>
 <20250305141554.GA18065@lst.de>
 <Z8hrJ5JVqi7TgFCn@kbusch-mbp>
 <20250305235119.GB896@lst.de>
 <Z8jk-D3EjEdyBIU5@kbusch-mbp>
 <20250306000348.GA1233@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306000348.GA1233@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_161522_935227_2EAB9CD8 
X-CRM114-Status: GOOD (  12.81  )
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

On Thu, Mar 06, 2025 at 01:03:48AM +0100, Christoph Hellwig wrote:
> On Wed, Mar 05, 2025 at 04:57:44PM -0700, Keith Busch wrote:
> > In my experience, it's left enabled because of SRIOV, which many of
> > these devices end up shipping without supporting in PCI space anyway.
> 
> If a device supports SR-IO setting CMIC and NMIC is corret, but I've
> actually seen surprisingly few production controllers actually supporting
> SR-IOV despite what the datasheets say.

And I bet at least some of those devices left their {C,N}MIC bits on
despite not even supporting the virtual functions in their shipping
product.
 
> > Not quite the same thing, but kind of related: I proposed this device
> > missing debounce thing about a year ago:
> > 
> > https://lore.kernel.org/linux-nvme/Y+1aKcQgbskA2tra@kbusch-mbp.dhcp.thefacebook.com/
> 
> Yes, that somehow fell off the cliff.

I'll be happy to revive it, but I don't know how much time I can
dedicate to seeing it across the line.

