Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD90C021B1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2025 17:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jU0y90Jx2vJo4YxiWr/ZSTzpxkqae/0MM0PkLDWoPho=; b=JjVPBq67ZgMYaCFEIE0CDHsLmF
	qjvlviBjDeOVBZAm/rGl0+Oek039O0DRl5gb3borNi4WG1w0I4ajj4q4WfNtrj5sQF44v8E90Yrq9
	o6hroFK7R9bJAQkL2iM6FkRqzwkNc5stPQ/yh3TUsosrQ5qw6ICotpNyke18Z6ujCQ9l7tTywzUsQ
	pxnxPdGNLlgtL5VHuKQM7AEK9zsIsw3WPV943bdkzdGHf4bh4XnrowbaTuFfPIkNsxHNX97pRrc/o
	oOuTGTQTHZ2JQZnSlTQ1Mqs9ju68Ez8YjyfwMaAfO3tlOCHrO/pKxdd5K9O1mQp04NKer8Ctc13KH
	5ioEpB8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlAGe-000000027G7-152p;
	Thu, 20 Feb 2025 17:23:20 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlAGc-000000027FC-05Xx
	for linux-nvme@lists.infradead.org;
	Thu, 20 Feb 2025 17:23:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5F4F25C572D;
	Thu, 20 Feb 2025 17:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1C9C4CED1;
	Thu, 20 Feb 2025 17:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740072197;
	bh=jU0y90Jx2vJo4YxiWr/ZSTzpxkqae/0MM0PkLDWoPho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AmNt2Hr6fYQuZcTQqakiFecbm3l0lopndbswp4ki5JUwKf+onb3o21qZGSl52urNk
	 rx7Rvk2af5dlaZ+Pa9b+Uc1vQMpzhs0LfqUof+BogwIZJ2v7fXrN5yTD02BbpIcr4W
	 4nWOyWQE232XH5GjGJVB8bCP2inFK+FX/H1t9JnGmFU6jQRcMC7LXNBDEn45LX9g22
	 cVUmA2y4Tv8enzZaRCUKhVnc3QxiFaA4xDbEB1jlZ7zWEKYMnXPMtDdnLmLyFXm0nz
	 vV5RiEuvdclSFn+w8KEjowGiKCAhDZEd1DLf6CSZVOG2VqxY/amef8TEDYgWFTycOF
	 ULU8EhLWtHEjQ==
Date: Thu, 20 Feb 2025 10:23:14 -0700
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] nvme-fc: fix schedule in atomic context
Message-ID: <Z7dlAjUXh2XU0HWw@kbusch-mbp>
References: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_092318_102175_3B26DBB6 
X-CRM114-Status: GOOD (  10.61  )
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

On Fri, Feb 14, 2025 at 09:02:02AM +0100, Daniel Wagner wrote:
> Shinichiro reported [1] the recent change in the nvme-fc setup path [2]
> introduced a bug. I didn't spot the schedule call in
> nvme_change_ctrl_state.

Thanks, applied to nvme-6.14.

