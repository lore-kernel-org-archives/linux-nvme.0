Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF33C28B28
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Mar 2025 13:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=oEq3J9E1K1xnQXEQ8yGDyBgds9
	uAaY0aW9jmMCCVKbbGgCYRXthb+PvBRoMlQIWIfcsaaaq2ZFMR92GiYV2PXVYEfnGIfex/qgRhV+g
	DI+DItEQ2Nz+LyM/uSYcTY/UJ4atIoWc70m6U3z+duT2cozqy1L/gnqpfhMBek49/907QV3ogN4lc
	92zaB0oUN3tHMddSi/+YhZ+je1iXTLZi+dIGF2UEaVJPFYBrpeCXnTWO85gHW/sndoUoaAOmq0UgS
	9suynbEJhGSK6yINr1k9ZR3ETBfPR+CnSMxwymGSBBmyYhyUI6yPGSFWGszeiH3GzDP8ZlHnWFIx+
	MHZRHdvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsMap-00000008dTP-33jS;
	Wed, 12 Mar 2025 13:57:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsMaK-00000008dPg-13vM
	for linux-nvme@bombadil.infradead.org;
	Wed, 12 Mar 2025 13:57:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=HzP/TnOdOFC+DTlQBcjhttGLDb
	kCL7Abp5PguZMnoHm64NpjTS7XE5xLby4fSV9w39Y7iFHZPG4gJdnMVYFxVEgDxQ2vZClp3FcJq9m
	+irokuwmJMNCzXxYxqTZyR4IVkxvAQepwcewlHaCBDjUFvNtdqF30fKLvrLQsByfJ4QWXmBibDL+r
	EOe8Y4CxAx0mhLXb7+Xl1HF2RrH1M/2n1rImDMeQFMA2oLXfzZRS+8yfvFKFrGMQirJaYmGD/Gd4k
	mLXKxisYmbbZYXTlTCMKFzMMGVXIe0KNhl2WnKLhu6783VEecE9I7Vyl0S+a7IOWfiY5egZZ+9N7t
	87GqS95Q==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsMaH-00000002OtF-0pjC
	for linux-nvme@lists.infradead.org;
	Wed, 12 Mar 2025 13:57:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AA40E68BFE; Wed, 12 Mar 2025 14:57:13 +0100 (CET)
Date: Wed, 12 Mar 2025 14:57:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: pci-epf: Remove redundant 'flush_workqueue()'
 calls
Message-ID: <20250312135713.GA12488@lst.de>
References: <20250312085625.1624394-1-nichen@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312085625.1624394-1-nichen@iscas.ac.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250312_135721_330365_63583750 
X-CRM114-Status: UNSURE (   8.76  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


