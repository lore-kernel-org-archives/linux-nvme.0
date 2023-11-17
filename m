Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFD5C072A2
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Nov 2023 16:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1UWtUcZ+ULqkb+2mxMxQKRqpF5fngwhegwTTzpThneo=; b=AHDnJHIFfy7K5fdp3ZIpsUeRV/
	WM+cl3hC4TDfPMF1ceX1ihj3AtgR6Nu8TQZFR6dhkqeNxUVeHOuaxSJydk0M+0Zrmp58cOzWzNWh8
	hLgNhmRhB82RuLr4QfUan1/yDppnmkkjX+U3yBABMV96rB1d8nyGHYuv9KJCKEtt+Jd9BvSIOi8pi
	J9FGlttDs8fhOnb36uwsm2BD61i9domJ/Xlxx1t+mdpISJ8nEwp3rg7dEO2I83CP2M0zrDXONS6A7
	RdArH3/w0Sp2phmzzwery8GhYO4wVg9KrFZNnAbosD3I1ypBRhdWZ2gX5FGScxsqu3k0WyZlsDXlB
	KNAjTNzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r41v2-006xNY-0W;
	Fri, 17 Nov 2023 16:42:12 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r41uz-006xMO-15
	for linux-nvme@lists.infradead.org;
	Fri, 17 Nov 2023 16:42:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 1C4FAB81F9B;
	Fri, 17 Nov 2023 16:42:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19212C433C7;
	Fri, 17 Nov 2023 16:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700239323;
	bh=dourSXcxz/wWV8qmbkzARcK539zuAd16osqZZCPZlCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VoXQi2TmwmuhkgH5O03oqePt0lWX6/n1gpsS4cNb0vW0UCDqLyfQGGEHV5TuKmDmp
	 fySgeIwdcwfGaO9b+QSQepOhfIYdjjS6Ms1Ld4CEKCaW2CR+u4vr5oAVIPkE1kszJF
	 XzpXOKsK6KtGogKoEynC/aniJjSHiK18B4eNHkFfHoyV+Kn7GmiCNoV585tssFyf4R
	 kI7zl4GuT9q2Cur5TyaMT/KyYwO4YfXEmpkb5+/D609rHLsfTI1INOaKFU2mfi1Ysk
	 haA3BfxT6a6pHjQxJVkZs2qVpQd5w8R2LOFEWCqFANtGf4+Ug2amxm/3I6XDqmu57K
	 6FAtUWFlqmdeQ==
Date: Fri, 17 Nov 2023 09:42:01 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCHv2] nvme: blank out authentication fabrics options if not
 configured
Message-ID: <ZVeX2ePLZgKZGA5S@kbusch-mbp.dhcp.thefacebook.com>
References: <20231116121435.17340-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116121435.17340-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231117_084209_503536_87B39183 
X-CRM114-Status: UNSURE (   9.16  )
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

On Thu, Nov 16, 2023 at 01:14:35PM +0100, Hannes Reinecke wrote:
> If the config option NVME_HOST_AUTH is not selected we should not
> accept the corresponding fabrics options. This allows userspace
> to detect if NVMe authentication has been enabled for the kernel.
> 
> Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Applied for nvme-6.7, thanks!

