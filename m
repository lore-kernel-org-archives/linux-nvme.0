Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE272CEFC25
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 15:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nf9Dhp6b0kS9womcIatMbZR8u2SAymqbg1xYhQLv8J4=; b=B0/0w44OkKjgAZDFIMg/yRc9Hz
	+SrrqLIuuX4MwbcVNEMPBj7ZezsUjDOawkJojq28B2tH3QpYTN+9n4c58jxBf35qM6dqm3OKVrrEZ
	HQHDqxkuSHNibcBxNafv8EoZ3fLmMm9rtjXpIiIrneOj7W4RYDluZPRKw0CzaETCxXYxlMzDGeVdZ
	Eu4AQ4kuP4+6tsl2gmK5nc1eg7V1ltAP8rTR2vaaqH5bHQsbAjLULQweDH4kIVCDeHzMWRCAdMZ/D
	J3pS8nrJVUU4K34jtY9vHhi0OYFVV5OobSRa209ZvILCBl0MRjU+jynoK3+bTqqIAVNd5c3keSlA/
	36BkzYKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syC3L-00000006MEP-2I8V;
	Tue, 08 Oct 2024 15:23:11 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syC2r-00000006M8q-2DSh
	for linux-nvme@bombadil.infradead.org;
	Tue, 08 Oct 2024 15:22:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=nf9Dhp6b0kS9womcIatMbZR8u2SAymqbg1xYhQLv8J4=; b=THBrv+QUYxuYtek48CDSd07uQy
	giqFzApcB+/AqS2kS5jE7VDkOdMVF+Rtn8oWAOx2vJKoPlfDgZ4eeUp5WaGPr6FeXo2T56z74YmlG
	fqgcLz8ZblfIKlW28ycmRvRbFDUZ7cJ3n8ytvFrAt4bo2sP6WyoJ7ck5g8teANmuqLKWehk2pYSQw
	sl393jynpP3FjZUpxTdpDQ3yCQgeMS3X1QgIxOEuLUXSrm60iDkQ5sC/7Iw/e56cNCYPjIEJATyg2
	anu6PzsV4Ih9Qq61xeRBcmyQe3OaViSvr+kS1krfOZUVv98+4Ip+y2M+nSJvA/+n/WGYDh0Q/UfWm
	Fl9deq+g==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syC2o-00000004dgV-1mO0
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 15:22:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8DC585C5914;
	Tue,  8 Oct 2024 15:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A53C4FE96;
	Tue,  8 Oct 2024 15:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728400431;
	bh=RaxqMyiV7n8pTDKGMindcS0hrojM1IZNbUWaYp1cp34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GOB8vn8MM0fQ1Yzw42fQ815SS4enmVBSTs86VzkBAAni1P2iuDRI1CvTw7nF7QUK5
	 0O9mzE9PF+eaPoCBBQjElsETSjUw6oVjRGU5ccQgEGfMdGj0+B/73/UpYIsXpVRSSC
	 wUNSIxUcjS+fYha7TJCyfR+3Xj3UOIKuPKwqGQgBuhaOa7L5FjO1Nm0Vp6u49J2o4k
	 P72wyCFqo/Lvc44GxClzEtAc5I+bHg+0+R3dYYfCJp1tNqCPFrvd3Rv93ErfksK+3n
	 Vzir4FMATlL3IdtrgZKKuQhDWheeD6ghAGToGRjF49JZZ85ljHpoHrEpuEL9RSkSqi
	 2fFsDTD2TYtKQ==
Date: Tue, 8 Oct 2024 09:13:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>
Cc: hch@lst.de, dlemoal@kernel.org, cassel@kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>
Subject: Re: [PATCH 0/2] nvme: add rotational support
Message-ID: <ZwVMLIt4iFX9MUjV@kbusch-mbp>
References: <20241008145503.987195-1-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008145503.987195-1-m@bjorling.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_162238_727104_3065B598 
X-CRM114-Status: UNSURE (   7.70  )
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

On Tue, Oct 08, 2024 at 04:55:01PM +0200, Matias Bjørling wrote:
> From: Matias Bjørling <matias.bjorling@wdc.com>
> 
> Enable support for NVMe devices that identifies as rotational.

Thanks, this looks good to me.

I still hope to see nvmet report this. It would be great to test this
with HDD backed nvme-loop target.

