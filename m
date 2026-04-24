Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A00FED3C9
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Apr 2026 13:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iTLpaH7qNaq282caOOHODCWmDH8S42JCPFaI45hEEfY=; b=xTuZ/nG/S9pHRO5jkRGpH6CHve
	XgaFR1GtXMiHNfWfVyUBh2QSA4YeEsPILmAnYAcHtY3GeCCu6wNUMMGB3zInLyxfbKCow8AzK0p9P
	jX+DntNeoH9beqqpjufqHU96+rcH0NNkhAWWboatOVcQ1ImxE5F1eea30HaImrENttilJykDass1w
	QAToWCZjKvd9jbmwrzMfFuCQfU2WupJGvqtHGhZ3Qfe2a3p7/ekBjIRbWdfPuhkvPP4+KLAtkAAsu
	I0xVfs/+i3WwPjgAB4F0kXgDp0swBcA5AuvUDvmh+tAJHS5Y//J4qIIYG1l4YJTthspScoWg/ip1H
	Ym17n9RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGGla-0000000DG7e-22v9;
	Fri, 24 Apr 2026 13:40:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGGlY-0000000DG76-1bSi
	for linux-nvme@lists.infradead.org;
	Fri, 24 Apr 2026 13:40:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B1C7F68C4E; Fri, 24 Apr 2026 15:40:16 +0200 (CEST)
Date: Fri, 24 Apr 2026 15:40:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com,
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
	dwagner@suse.de, mlombard@arkamax.eu, mkhalfella@purestorage.com,
	chaitanyak@nvidia.com, hare@kernel.org, hch@lst.de
Subject: Re: [PATCH V3 4/8] nvme: add sysfs attribute to change IO timeout
 per nvme controller
Message-ID: <20260424134016.GB16434@lst.de>
References: <20260410073924.61078-1-mlombard@redhat.com> <20260410073924.61078-5-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410073924.61078-5-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260424_064020_596059_2FFDE242 
X-CRM114-Status: UNSURE (   7.21  )
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

nit: the second nvme in the subject is redundant.


