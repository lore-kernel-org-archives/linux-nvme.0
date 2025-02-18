Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBA6C02198
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2025 15:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WbcJRgQJ6ddllzrvFBpRAUqbFrtzYQbQEWYt3FtmWV8=; b=in/S3NkJHOrMDwTF8gC2f6rfKf
	GcZ4D6zDVWOaq8+XetE4X7L1Db71PVsqgbYpW+szSVKTZLD+xS4IJeQmEPgnqFbhJpcICIibG60R/
	hiMLr/HVv/2vFUwFgZvIb/zd4SXmTkp701SVBLlICcMV319zBH+5g6SLBWRFlnCFUbbniWArAAVaF
	B9hKFF5NdQSqbwyXpKL9mBgllVReVX03Iu0slwYTcGo8WQG0EoyTvu8RllYjZB7YKBIkhh4HZBBzK
	/tH/JP2hKAMQe8bCxiSHIiK5fok5c8O8joFnHSfLre0uVNisBZs7k4Eej8wz/e8YfNRtcOC3qE10R
	ZB6XZ64Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkPmE-00000008oBj-2U1a;
	Tue, 18 Feb 2025 15:44:50 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkPmC-00000008oAw-2Dft
	for linux-nvme@lists.infradead.org;
	Tue, 18 Feb 2025 15:44:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BF21F5C4CCD;
	Tue, 18 Feb 2025 15:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC59C4CEE2;
	Tue, 18 Feb 2025 15:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739893487;
	bh=WbcJRgQJ6ddllzrvFBpRAUqbFrtzYQbQEWYt3FtmWV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E7J4EcTuZyaJ9ue1F9w/j+cm95NAUjv8Ic7KxO19Tp3qp1y+BIMQKB960Yp6F3s1f
	 ZDJt3oF0pbmkOK0oqZlcFacwVfTHC0FrbubGyLxm7sdhbkY62XrWVWBITVPWiZ+u56
	 2FoDOHyeoxXtW8Qub7KD2LWqb/HAtPXBzeBV0tzeF48F+0xTqlsEO8yGwwtwmZYtyI
	 AgMK7gthgQUhjXnty63b7ZRSRtWY5oO5JUYVJDmnb2874p6u3Z6UFWzK7bhDwcov4i
	 V8D0cfTHDrPqg8qjOHpzw0B6pGNZX/k1HGRTsEsdf3gsBsHZ1QThBUVoxVVx6dnwmt
	 5QY2IsmpjV5fg==
Date: Tue, 18 Feb 2025 08:44:45 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCHv2] nvmet: Fix crash when a namespace is disabled
Message-ID: <Z7Sq7QKDMwqDajO3@kbusch-mbp>
References: <20250207124134.114622-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207124134.114622-1-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_074448_607051_ADF75642 
X-CRM114-Status: UNSURE (   7.46  )
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

On Fri, Feb 07, 2025 at 01:41:34PM +0100, Hannes Reinecke wrote:
> The namespace percpu counter protects pending I/O, and we can
> only safely diable the namespace once the counter drop to zero.
> Otherwise we end up with a crash when running blktests/nvme/058
> (eg for loop transport):

Thanks, applied to nvme-6.14.

