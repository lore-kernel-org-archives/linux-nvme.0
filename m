Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFFBECAAA1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 06:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IQAEPQEEyRJUTzlI/5cTg6JQQmZGIHONFYr4kFEq5u0=; b=jYPB4/siFa9wgT01oIc9b9VD3O
	YhL5mO/Gb1AYgK8GEraOKYMBI1ljfFOdrF/PIba39l6nNA5XLbckT7HAiLWTbY0b4ygk/UNTThoYv
	PsT440+QS08ymY2K1eMpZNJvd9A4V2PIaP7XWv3LTEDkWpVlB4nKkYLTDBX3xWWbFzlUN6JI7KKab
	A+BX4WlUgkSyp54O9rbIRGsqZix2CeZmKRvwjrn2CRp8/x4hSTh48nXUeT8fzhbKWWWCb6ZqGP9vB
	8DMOhu/wb78ZClrX1j3SeBH1xK9lv3iTR5hha0p6xgM6dI1ZEdWPZK3NbtnULK+DV8WklcxTqnhWU
	ixeM5wlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVSR2-00AYrH-F6; Tue, 06 Sep 2022 06:51:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVSQz-00AYpB-HQ
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 06:51:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C77EC68AA6; Tue,  6 Sep 2022 08:51:42 +0200 (CEST)
Date: Tue, 6 Sep 2022 08:51:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
	kbuild-all@lists.01.org, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [linux-nvme:nvme-6.1 9/10] drivers/nvme/host/rdma.c:989:50:
 error: use of undeclared identifier 'nctrl'
Message-ID: <20220906065142.GB2190@lst.de>
References: <202209060308.61PnxPmE-lkp@intel.com> <20220906063903.snht3lkixtdt2tkq@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906063903.snht3lkixtdt2tkq@carbon.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_235145_749358_F3C643A1 
X-CRM114-Status: GOOD (  12.13  )
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

On Tue, Sep 06, 2022 at 08:39:03AM +0200, Daniel Wagner wrote:
> Argh, my devel setup(*) obviously didn't compile the rdma bits. Do you
> want me to send an fix on top of this or do you want a new version of
> the patch?

I've fixed it already.

