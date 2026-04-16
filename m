Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6664BF8DFD0
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Apr 2026 22:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RiJai4MeY+i8IVQOOnpF0WI27vuNYc4LJ9DgY+G57No=; b=TXH7Fn6lAxn6MhphMUDnebyCME
	9A2p4ism5MwbjUkw4CHe8QRWB6ITZBfH5NxmZyL5zBUeSQ7S5Itu1Yj8YnETam7NEvXdB8UFPHNne
	CXCkQOLVt/icB9R8R03nTwwIzUQLsWtmi2sgfQewTFuIAqPpdxWqwcYS9gNKYeopwDj7a+BlOhdrf
	qOL08uIb8cjPjlqNp/+8EatB/JIs30/o94fd0KdVjucq7OMO+Q4LepTRFF9Lq1Gsu2bgLVd9ZWvTJ
	0FJ5BkhwGYYfhWfgwwJ2nBOBaZmlQV1OdVFo4R9IfYX5UuaogZOv2Gu910tfA1tuZ4411mpf//Zol
	+IWG5cMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDUrz-000000037bg-2tPb;
	Thu, 16 Apr 2026 22:07:31 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDUry-000000037ba-1hkm
	for linux-nvme@lists.infradead.org;
	Thu, 16 Apr 2026 22:07:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6C4CE60128;
	Thu, 16 Apr 2026 22:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF62AC2BCAF;
	Thu, 16 Apr 2026 22:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776377249;
	bh=61sgJtIqq8zo1aQ7v363fv690pZpMoHlAB1cTHsxuFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nOAK0skt+e5SewzHFkr7ViYH/8beaPWpuTgY97oMkDUiM/cmY0fY53cJt5a9j0McL
	 HMWP/x0UggoqguTr76/xchabSL19SSBoD6603zplWkIQ8PWh7h80gOQJTVak1qepU2
	 433ObClpllTVUSY/k3Yc4aq646bAG3Y2s/p0GPKeP0hOUjpPRMp4CVbuckgAT3eddu
	 vU5BM24i4b4WE6D+YpekEpImdLiu0gycqxZlCTQXH7YCj0Bpg/oYhMQVrGaRlC1Ct6
	 weBcGD3Gt0622ORRcqZu7h2daNZcdKDKcivHxQt1vQZaDjZUukrTyOkjHsjjVClsFS
	 Oqg3cqE7UilXQ==
Date: Thu, 16 Apr 2026 16:07:26 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <wagi@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvme: expose TLS mode
Message-ID: <aeFdnk4Qd4Tj1q1S@kbusch-mbp>
References: <20260408-expose-tls-mode-v3-1-b869da028eff@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408-expose-tls-mode-v3-1-b869da028eff@kernel.org>
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

On Wed, Apr 08, 2026 at 06:19:56PM +0200, Daniel Wagner wrote:
> It is not possible to determine the active TLS mode from the
> presence or absence of sysfs attributes like tls_key,
> tls_configured_key, or dhchap_secret.
> 
> With the introduction of the concat mode and optional DH-CHAP
> authentication, different configurations can result in identical
> sysfs state. This makes user space detection unreliable.
> 
> Expose the TLS mode explicitly to allow user space to
> unambiguously identify the active configuration and avoid
> fragile heuristics in nvme-cli.

I'd applied v2 earlier, but I'll force push this one instead since we
haven't done a pull request since then.

