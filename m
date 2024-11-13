Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E619D637B2
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 20:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dguBOGoGelrYVmBNPYN9y9wYEeTWSEzdw6LC5L93zYc=; b=eDFgOzy6ZYzUfTqqQRdpInYGgf
	i8bpz7IFHK45nrHmD5T2J0m8qztbrilYNU5Zz9Z2P1ZHAiw12KZuU8MivVaSrKUG+eQQWW7SCrHOF
	LIYjeXMCkId8S3qnemF/ClXlxuyyHhruE6elAFng7QXT0iTLnsEnHIRjIeC5gRtdY5sqMJkHrv+Io
	dZnFWMe8N4wOQTrS+zoavTMsJSAiN8QYxkfLLtlxDlomqg9Yu72SSrCSrrN7uOulHtGyvMMeozlCL
	r7QsXH2AL2kHMgNcOspP3Wjwt9dcaQra3xsUOGHjE999OBUYQ/WSFoS6Al6cPhtp0XEihxgdiRToO
	qu2qHvEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBJhU-00000007vMY-1ojL;
	Wed, 13 Nov 2024 20:10:52 +0000
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBJg9-00000007vDR-12QF
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 20:09:31 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1731528559; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZFzX5aS+y1VRNZ7MaWQQQyDPBqnPt7/jrgPProgeKZ6Zl2VespVImQD2sq9WDv7hrxdPPBiR+B+T2MIws1qRd9DQRC/rwiNkIqktyXwJvw4YvwRNOoqY0oo113lGJ/QrfbmvYlWsdE9R1VuDn4lrD/nuUjkmpT8U/+Y62Wdida4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1731528559; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dguBOGoGelrYVmBNPYN9y9wYEeTWSEzdw6LC5L93zYc=; 
	b=JwcEuR6zKWXyi8xQBJX0DJl9HBu6W04HSEEQm3cmmnF2wB+ANocSQRB5NOUAowjFBiwgoSlGrLDA5xknwm7GCqFY9P4JTiKy1w/gFvDHBBzltAy+7xbtTiZQsvGIivfNvzzbvQaHMsJ0zzsHp10o4sEhcP8v1Hs6Nt32IbhNUjk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=bob.beckett@collabora.com;
	dmarc=pass header.from=<bob.beckett@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731528559;
	s=zohomail; d=collabora.com; i=bob.beckett@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=dguBOGoGelrYVmBNPYN9y9wYEeTWSEzdw6LC5L93zYc=;
	b=HL9WTd8/38/qjcGLHF57Lh1gXYxUV5k3u27JC5CI0Zt31pKIWok2LoyEbDpXJg8C
	ptG6eUZvxrJR9lIa3mNZGjg1ku1F4azXtvIhBPxeX/Yg5wSp5IPMqsfubLGWRaAeufl
	WamOmKSFLYR1YyKirHd4RIeM83Q2Y10IQ6sGjojk=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1731528528260910.1748320725312; Wed, 13 Nov 2024 12:08:48 -0800 (PST)
Date: Wed, 13 Nov 2024 20:08:48 +0000
From: Robert Beckett <bob.beckett@collabora.com>
To: "Keith Busch" <kbusch@kernel.org>
Cc: "Christoph Hellwig" <hch@lst.de>, "Jens Axboe" <axboe@kernel.dk>,
	"Sagi Grimberg" <sagi@grimberg.me>, "kernel" <kernel@collabora.com>,
	"linux-nvme" <linux-nvme@lists.infradead.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19327249129.1131b0ddd320896.1106904208694557670@collabora.com>
In-Reply-To: <ZzTqgXqjN4UrT392@kbusch-mbp>
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
 <20241113043151.GA20077@lst.de> <ZzTqgXqjN4UrT392@kbusch-mbp>
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_120929_426261_AC591810 
X-CRM114-Status: GOOD (  19.64  )
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






 ---- On Wed, 13 Nov 2024 18:05:53 +0000  Keith Busch  wrote --- 
 > On Wed, Nov 13, 2024 at 05:31:51AM +0100, Christoph Hellwig wrote:
 > > On Tue, Nov 12, 2024 at 07:50:00PM +0000, Bob Beckett wrote:
 > > > From: Robert Beckett bob.beckett@collabora.com>
 > > > 
 > > > We initially put in a quick fix of limiting the queue depth to 1
 > > > as experimentation showed that it fixed data corruption on 64GB
 > > > steamdecks.
 > > > 
 > > > After further experimentation, it appears that the corruption
 > > > is fixed by aligning the small dma pool segments to 512 bytes.
 > > > Testing via desync image verification shows that it now passes
 > > > thousands of verification loops, where previously
 > > > it never managed above 7.
 > > 
 > > As suggested before, instead of changing the pool size please just
 > > always use the large pool for this device.
 > 
 > Well, he's doing what I suggested. I thought this was better because it
 > puts the decision making in the initialization path instead of the IO
 > path.
 > 
yep, this avoids any extra conditional in the fast path


