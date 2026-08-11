Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCB6C5AD55
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 00:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=13QA9XrgCpEOPJFZYA83x+4/sewlekQ1XXmwsJB/wfw=; b=hTom+cErWRYzpWoHMYizVQPbj4
	/nHFDnNQaC44czt8487ZXpQ8HO4Zx6LNFMRAaMqJYUGZdNJNg+Tyz84M3bbF0hrebHagz8P9JLrKw
	E4FX1bx1tHRLoyS+ZehVr+toBKwfNNf9+gIlEmkCfxtXYYHq0HxcLH3NIf8wKGYi5mXYiA7+EyzcP
	9Yg/R52FjL1Fx27u8HX8h4oD/RlV1VHvlg0lqK7ZtH1D7d0DrY19gBr52hdNFfgjKxyIU/+NPHYBF
	znk4fK6DAmEYYzqqx9IE9jA+n12NiHJdKBjstjHJmyYUoO0doNc6HERancNNMi94WbuJrFtyqIH/d
	wXmCW5aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtaDl-0000000D4FL-2j0T;
	Tue, 11 Aug 2026 00:19:57 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtaDd-0000000D4EY-3off
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 00:19:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0219A6001D;
	Tue, 11 Aug 2026 00:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784761F000E9;
	Tue, 11 Aug 2026 00:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786407588;
	bh=13QA9XrgCpEOPJFZYA83x+4/sewlekQ1XXmwsJB/wfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=doylKoEcWX7vMJjibJj2seS9b6gXi9CIT9vHP6+Ms5/zVpc5tE7pHUqdMrjgr6DS3
	 TmkG3/WHT/ogZp4abaBoUN9/ksV9p0uqcBAONk0aOExKko6BDCAdIH/IVybRy+hWDN
	 QhRST/Xjn8wBNvldyGuQEeP5LlI0FysckTHPZWDxhocNVlLHtTnBU1y6+OjpLPKGun
	 YooCWEG1OPSx/AIUJsa9l1cy8UM1kamqwbiiguPUZxX8msDNI+5Hhk8rzGppV5WUHo
	 Ynj6IRdYnA9+L+Jlpa0c+yMBBQnIWuXtryBUXRzeuhorj+72ZIBZlCIbg6GCuDcuuW
	 OWsSiV+mbQ0ZQ==
Date: Mon, 10 Aug 2026 18:19:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Xixin Liu <liuxixin@kylinos.cn>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com
Subject: Re: [PATCH nvmet-v2 1/1] nvmet: zns: reject full zone report when
 buffer is too small
Message-ID: <anpqoxWUnPk-mrCG@kbusch-mbp>
References: <cover.1783579899.git.liuxixin@kylinos.cn>
 <cover.nvmet-v2.1783940400.git.liuxixin@kylinos.cn>
 <c7e4a91f2b8d.nvmet-v2.1783940400.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7e4a91f2b8d.nvmet-v2.1783940400.git.liuxixin@kylinos.cn>
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

On Mon, Jul 13, 2026 at 06:00:00PM +0800, Xixin Liu wrote:
> Zone Management Receive uses the Partial Report (PR) bit in dword 13.  On a
> partial report (PR bit set), the host accepts an incomplete listing and
> Number of Zones must not exceed the zone descriptors copied to the host
> buffer.  On a full report (PR bit clear), Number of Zones is the total
> number of matching zones and every descriptor must fit in the buffer (ZNS
> Command Set Specification Rev 1.2, section 3.4.2).

Thanks, applied to nvme-7.3.

