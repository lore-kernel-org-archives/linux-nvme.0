Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA5DD216A6
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Dec 2025 16:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ct5qMMwCl1DFvyS7T7hsdybPGPau1DCGQFzZvI46oVI=; b=FhwGCXsRsy5ml/a/+fBlYj7trw
	RhvZZegfYEWUc0SAMQHOgJv/NNQ6BQC2DEfaSkrbc3KClpv6zkABkqzSZ+noGTjw+gbjI6LXGHnVW
	Z/YTRsbjGPEgD89oA9TZBxnoGB/XWcWzc7n77DzYTEohfNpt3PfD9/7cuoXhcPWvOKgjwxDREcmjx
	uToOWT442wyR0OFMkd3fyQmlqApmKLDmFNHXIJfcGUJduFrJHT9z45vvqBmab/SPKg69OOiAtsV/P
	UrSvFbk13uYAhwlk7dcesN0r/strxUebPr41IHLVyqDWQ9IpFRF7Q77aDjpNBMR81dZ8uQqFVL3kE
	/OgO0onA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRBtU-00000008FsM-0Q04;
	Thu, 04 Dec 2025 16:09:24 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRBtS-00000008FsA-3OEy
	for linux-nvme@lists.infradead.org;
	Thu, 04 Dec 2025 16:09:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B069B601EB;
	Thu,  4 Dec 2025 16:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B90C4CEFB;
	Thu,  4 Dec 2025 16:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764864561;
	bh=2HPGvp+0o1MmSecqG0QeZBtdNlHWJScYeXMNm63k7g8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mjZuga8DZPtLQ0hTLFJIi11GB4ipjAPEpIgFMTBxB44ylBXvP4rl9nEnpU/XEYot2
	 zQdzKP2peeOrbi6qJp7uvR8vVyvs7gxMIQUfF8woZJs85VFAZv3Mue37JhNHG26evi
	 imsGLHZ5cfvNBYSpxA2vt6obNS9H0lbHlZqhvZo+c61pzA8L3WO5Buc/w5hxvvmDmc
	 6JX64wyvmvhUWoR5948Ft1kdaVEyuzPpF3bXGQH7XIX9Bo6afLKSzoKyEJ9GqAoA5N
	 o+bik8R2Zd5lXnMgd3jVklptgrOrvWrvv+3DMwt2hseAKXyNuHgjbfZoeOkVInkRqS
	 TThZltkwIZmmg==
Date: Thu, 4 Dec 2025 09:09:18 -0700
From: Keith Busch <kbusch@kernel.org>
To: Eugene Korenevsky <ekorenevsky@aliyun.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] nvme: nvme_identify_ns_descs: prevent oob
Message-ID: <aTGyLlHM2qv8KEDE@kbusch-mbp>
References: <aS8uVVBz_n4lI3bM@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS8uVVBz_n4lI3bM@localhost.localdomain>
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

On Tue, Dec 02, 2025 at 09:22:13PM +0300, Eugene Korenevsky wrote:
> Broken or malicious controller can send invalid ns id.
> Out-of-band memory access may occur if remaining buffer size
> is less than .nidl (ns id length) field of `struct nvme_ns_id_desc`
> 
> Fix this issue by checking (header size + .nidl) against
> remaining buffer length.

Thanks, applied to nvme-6.19 with the line length wrap fixed up.

