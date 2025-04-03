Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E964AC3600C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 04:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ZHL0huwRhwxcwVdcEUCNSWB2egqoobyqM+nwG96Ldo=; b=LpCEDH+GOAPrVaFQXW4fIE7rXl
	fXW7DWBKomW5Y6EXktvePokSCcIKZZfG88aTxXbIydb9P1sFhQDiLV8o30K/76pggoNoYCjYOXNVX
	JPV0p7+yyH4uFj3oEhF9s7sZIDN7+HxIE3+bVmDevt5/J0POJTJb57VHRkJearJhT7ukTS9FmnSEZ
	JJ35hDAsTW0aOokL/4eF4s1eVEjbX0XhTKx9N85tKR3Ijl2L8bClCmLSjqZL0oBwEeTH4/Mgxs+1+
	QqEaMks121la/eWNEWZKtS8r6eBpixaqxnx9r9juLTImn52T4P9IlTwFb1Ek4/gxDxTIoR9zLvMGf
	ceQ+pA/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0CKL-00000007l0H-3Qii;
	Thu, 03 Apr 2025 04:37:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0CKI-00000007kzs-3fld
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 04:37:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0F8D668CFE; Thu,  3 Apr 2025 06:37:11 +0200 (CEST)
Date: Thu, 3 Apr 2025 06:37:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, mikhail.v.gavrilov@gmail.com,
	hch@lst.de, linux-nvme@lists.infradead.org,
	mlombard@bsdbackstore.eu
Subject: Re: [PATCH 1/1] nvme-pci: do not call nvme_write_sq_db() if the
 commands list is empty
Message-ID: <20250403043710.GA22720@lst.de>
References: <20250331162859.1407725-1-mlombard@redhat.com> <20250331162859.1407725-2-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331162859.1407725-2-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_213715_056514_222B82F9 
X-CRM114-Status: GOOD (  12.11  )
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

On Mon, Mar 31, 2025 at 06:28:59PM +0200, Maurizio Lombardi wrote:
> nvme_submit_cmds() should check the rqlist
> before calling nvme_write_sq_db();
> if the list is empty, it must return immediately.

It would be useful for future readers to state why it is important.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


