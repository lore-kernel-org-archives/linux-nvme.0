Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B05D15DB2
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2024 15:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iUxU/SbBqeS8z9T/ZxLn0yuvb7pyvFsqDApPN3QDuwo=; b=wkLlLeNFsOfnYpqhzwMsWfU1qk
	YkdmI+xL8zrp2Cwr+bMhZ5Am6TTLaaUAEZAPStAfSuay+2vlNomCGeamMX39Nrm54Fkft3vta1W2e
	1Wa0if5KNFgDjEuqG+AD3+5EmfZEb0AtrQ6o971i1e6029sy+tq4NJByXRC8YxMZunpTH+3uKWRjd
	J20qO8oNjEbWNxiRRjngP+QERYyz7Qj54uGp9FxSMmiFyOUxahu2kekQL+HAadkXAti2krml6+HxD
	PpCO+T2W7yL7oNfx8qTZUKcS73FTIDDqx4oAkdbRG9dgpSGXr5HYkmMO8EqEX7+oMZwyNgS6x5h+r
	OxyQna0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2uKU-00000007mjL-06L6;
	Mon, 21 Oct 2024 15:28:22 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2u13-00000007jUZ-1V4M
	for linux-nvme@bombadil.infradead.org;
	Mon, 21 Oct 2024 15:08:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iUxU/SbBqeS8z9T/ZxLn0yuvb7pyvFsqDApPN3QDuwo=; b=J4kfUUTVTDvvlWWGBJCoJE6jdq
	cSYf+Wl4aUoT2edNnuI9jUknd852EhypxXtK9PanSGAKE05X0u6/nD1lPvwg8pUECjC3fdTHr0WGa
	ekTemqtbx5kFj+Jecn9UWEwDAep/l7yGrwDNNg76vF3AsASASqbAsGYnNsUpcCHRtUdbFW1OCjqAS
	Sj2whzC7xjm4TlUorPldaUhvoNRv4DPjIfInc58vpiw8dEEFxwibNdQ2DMGjxZbbM3TAlV4oXf0S0
	6QR1UoTak7SWxBGnrQ2/5l3B0hOG6ew0vgf20VhXCBEHCiAm1WhRiSAi7EeVtEEbKBshMo5BIB4XD
	myiqFk3w==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2u10-00000007zAt-05k3
	for linux-nvme@lists.infradead.org;
	Mon, 21 Oct 2024 15:08:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 32B855C58B1;
	Mon, 21 Oct 2024 15:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E82CC4CEC3;
	Mon, 21 Oct 2024 15:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729523290;
	bh=ReDL3ufF8xB34lUBND8ER2zp/tzHMXqwl2b0BMRiFlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jHHwG50fipS1cWs6q0NWC5JzV1tgFDLB49GWxMwYiuJtR2QzwHZ+xEkBGp7NLloBf
	 aAxT+dwH97OWjJ7WuBE/1ektMGpuezO5/ZIV/rOvjW7U64lYdIox9bmniMlYoMwoqO
	 CEqJMun2yuzWK9KVH/YXoti/6ktOkwdy7G6FrDu+wL9RC0mrkfZMZ08meJzzrROVaj
	 J7BhgObQSS0Ye0DFNrisLOiXzZQg0EGgN0iNcMJmoWYyPwyI946cT4XMfc0h/sIKmx
	 MrWi1MreXE/CYwf+vzKBM//agLH14PIg51ZInXlMmVojCKEDO15kFMmo1gXuHh955A
	 vWypV/7h0Ro2Q==
Date: Mon, 21 Oct 2024 09:08:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	javier.gonz@samsung.com, Hui Qi <hui81.qi@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv8 6/6] nvme: enable FDP support
Message-ID: <ZxZuV0Uzn5qNmwAc@kbusch-mbp>
References: <20241017160937.2283225-1-kbusch@meta.com>
 <CGME20241017161628epcas5p1006f392dc6c208634997f3a950ec8c67@epcas5p1.samsung.com>
 <20241017160937.2283225-7-kbusch@meta.com>
 <77feb398-d6af-4f07-93bc-b12165604f04@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77feb398-d6af-4f07-93bc-b12165604f04@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_160814_294484_D8BBBE35 
X-CRM114-Status: UNSURE (   7.71  )
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

On Fri, Oct 18, 2024 at 04:18:17PM +0530, Kanchan Joshi wrote:
> On 10/17/2024 9:39 PM, Keith Busch wrote:
> >   
> > +#define NVME_MAX_PLIDS   (NVME_CTRL_PAGE_SIZE / sizeof(16))
> > +
> 
> Seems you intended sizeof(u16).

Ha, yes, that's the intended type. I don't have anything close to 1k
placement hints, so would have never noticed this was the wrong size.

