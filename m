Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DF0CD4F3C
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 04:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=uQjmMVfW/4KlV32+ehLtv9CIsT
	vyfWXpPYtu2lKhIF1jo91DHWlLD/3obxn3yaiNPfveTNcV0iCFmn0nojjS0uyk1wgaxHK3rVfymja
	E2KdHA6/Kwp4bN6/Eqh5TtzdYHtM8pvRBI1gBiPA/RMGRxQhgSC0fQxRdGXzUn4XqNMrzrEVSO+UI
	cPJa9iMJsbbxAXVIIJ5lfpkmqy4TTVjM5aXO/cFUJIlCOs0W2G8M+vx9DEPUFQL3j8MslW2TQuO+m
	YpmfVRrAN47DRWdsVO8uYLMi8fe0l/yStzcKIDHIBb0Lcn50sAUTtrZxVgIuttIozXto2XQLNBIiQ
	U974ma8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNkCc-00000007JCh-1IdU;
	Fri, 15 May 2026 04:31:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNkCZ-00000007JBz-1oeT
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 04:31:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BDE3B6732A; Fri, 15 May 2026 06:31:04 +0200 (CEST)
Date: Fri, 15 May 2026 06:31:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com,
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
	dwagner@suse.de, mlombard@arkamax.eu, mkhalfella@purestorage.com,
	chaitanyak@nvidia.com, hare@kernel.org
Subject: Re: [PATCH V5 4/7] nvme: add sysfs attribute to change IO timeout
 per controller
Message-ID: <20260515043104.GC3685@lst.de>
References: <20260514083255.41109-1-mlombard@redhat.com> <20260514083255.41109-5-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514083255.41109-5-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_213107_611586_0995348C 
X-CRM114-Status: UNSURE (   8.41  )
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


