Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B61C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 16:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0OnG4BzavkIkRsoSKPQtFcsTzHVmQDZ4N5dtwuYHgN0=; b=oQzSatIz9NMoR0ed33vjD+FzG/
	O3u/lLexrbZtSBXIFhscrosXTSUbYK7Zco2KMfLFKu2Bg/iNw1GJ0baFju/0xVO1Uo7MhginZPGgw
	XnL/owbsQWCAquYzPJG5xJ0ZnOWvr/Zx9rRkJg2KpNFZGLvgMQ+SzcVxIXmfway5vDy/CHTEch9gS
	1fTHekeFJ6ZR6uJblCRpf9lOsOW8CJNiB6WEOdOoJ6LW2/sa5uy8FQMII+41jVwqoedNvYEI4Vvcl
	ufWBfCWswE0ktYVIg74KNgEJobO+EUG81TTErBuutj3ARGGqD2KGkDnw3WaGGv1Awd9dnS9EW3wP+
	sZ9B8aPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3gJE-006HbC-Q1; Tue, 21 Jun 2022 16:00:56 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3gJB-006HaD-RV
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 16:00:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 065C9B81A3C;
	Tue, 21 Jun 2022 16:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CA8C3411C;
	Tue, 21 Jun 2022 16:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655827250;
	bh=0OnG4BzavkIkRsoSKPQtFcsTzHVmQDZ4N5dtwuYHgN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ccIuAgjpgdBgta17whvS45YMBQaf//uh9nNWQbFat4RW+/TOzLyN3TzsmkR7Vswk5
	 al24NP/CvbzWe2f4/iPS7JwReblJI0IH4jK17LWXeY5Anr7xwo4T+CtdM1irHvkG2S
	 36TLx3TLKN2NxCscDXWv0S5SczBB+eKvYO/+d1EitdpfHN7s7OfQ8pUrL9cmrF78Dj
	 t0Z2ROQDvsJ10hkyeTRyGajNnzqRhmJroE8na/QkvDk1jrNNxQdKVKq2E/uUFRnd1n
	 SCzjwVIAH5TQvCvEqng0DJiIJoiSQ3VK0gMYl0wUyICkTbmcCoEci4XAFjHbMXzI4h
	 xkFPsXM9LbnaA==
Date: Tue, 21 Jun 2022 10:00:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leo Savernik <l.savernik@aon.at>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] Introduce NVMe quirk for multiple Micron MTFDKBA2T0TFH
 SSDs
Message-ID: <YrHrL6I3Tl5zZIum@kbusch-mbp.dhcp.thefacebook.com>
References: <af7628d5-2b91-4fea-a2bd-56825dbcb02f@aon.at>
 <YrDs2sPzH4RPzhGI@kbusch-mbp.dhcp.thefacebook.com>
 <86c55fb7-ef0f-4c3d-82cb-9d655f17baf9@aon.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86c55fb7-ef0f-4c3d-82cb-9d655f17baf9@aon.at>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_090054_072600_1DFDB6D4 
X-CRM114-Status: UNSURE (   6.80  )
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

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

