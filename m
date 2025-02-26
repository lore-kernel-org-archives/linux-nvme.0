Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A350FC021B8
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 18:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lHjb7cprCWmCiSQDWLFIs9PflfliVjGgCgC+q4i5VRg=; b=rKYQ/Zu2+q2548+h841WcCxDHa
	OzHQDXh5SIuoo+ckOPFe36hMHQBD3MW2hNaxlEmQq6XT4mbsVG5cZ2Si4sx3OXVEQI4jFIEPdwk8m
	pIKX/ZKjbHcrBkJIerXltW30Qx2cxNdCbIlFqjVRcBacdhXO4nevHmLya+iRUvi/q6C4EFKog+hXs
	IuPQjWr3GOpZMJ1BvuBTR6FRUDNSLSypxiiqdteqLzLpDGeAv82fHQw2u6I8pT9Ol8AWcenyvZSP6
	HTEDV2/HsBzaXLmBqTb9Ki7O6oka0vIonmgccdbR41Im/HibJVDUVwrFaodfTusHx4XA5asiQ4tZZ
	97HspSeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnLyS-00000004tmT-1yUT;
	Wed, 26 Feb 2025 18:17:36 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnLyQ-00000004tm8-2uZq
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 18:17:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BF0355C57CB;
	Wed, 26 Feb 2025 18:16:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3A2C4CED6;
	Wed, 26 Feb 2025 18:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740593853;
	bh=lHjb7cprCWmCiSQDWLFIs9PflfliVjGgCgC+q4i5VRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f4OChAa47qOxVn4GDFrav27LqCAOEyAgXnEmUqqAi7smtqWzYs1zerN0diDGFYTnS
	 DfrfV7cgT7n1QgUavHmBtyid+1DGSSR2NxfswtTXyEs7Nuu3lTV7hZHd1QZTI7lisa
	 EPxPR1z4ZW4LuC9yM5MlGcNwNjhToNRjGIoJqqbGt7ekfqljtC+oJGMkXKKbvsUBpd
	 MUO5pHKJKfLNk3x6Dh3BXSdKhF1NbmmUzS7TYbJmAj0UilAkoPrjNLMKPlbNDDv27y
	 ogXuyp9Ic9ES4zBxb+hOZizKxsjsEROmxnD2pSM3OPQMVygShsfESk3LPTBChbK0Ye
	 KRWLZNTi7BwPQ==
Date: Wed, 26 Feb 2025 11:17:30 -0700
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: ming.lei@redhat.com, asml.silence@gmail.com, axboe@kernel.dk,
	linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	bernd@bsbernd.com, csander@purestorage.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCHv6 0/6] ublk zero copy support
Message-ID: <Z79auss5rprO8Dwp@kbusch-mbp>
References: <20250226181002.2574148-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226181002.2574148-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_101734_770874_6FEA7AEC 
X-CRM114-Status: UNSURE (   5.77  )
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

I duplicated the format-patch command into the same directory, so I
completely screwed up this patch thread. Please disregard this one, and
we'll start a new one. Sorry for the noise.

