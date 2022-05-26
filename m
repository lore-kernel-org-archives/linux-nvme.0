Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAECC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 26 May 2022 09:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pb7etm1hOOJ/vnDDGSN24xm7oYveVINDOoNTz137E2k=; b=JfrWledzxSqBU5wkAqnPCOJPeM
	C77VU9JANRqpj5FUYg4iBaFmkFBhqUt9SgmMRrm5AVHOgZMlPJ31sHB1IelXS3kTRdJpeugkvqdMy
	X2mBA0ZePgWCDawG/kYaTODIeiunOv5N0mHzF7eGxvkY8kmC/tmIxW+n2Ic1ZYvpyqmWvaxTt3ibg
	FjbJz5HwO7o3Ioj50PG+uWcSmreiMMoHVSABdGWhSGVMlK9900kKeyTz+ni9QG//Svv/e0wWEwEmt
	ubBpIHjS9DYC9yEMT1PnNYlI58axdch6xAr6SXP8MeLq8/e6vCptUU6vBMtApUkSWZTmL75OPAPEG
	YbicMC9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nu9Mj-00EAH2-GV; Thu, 26 May 2022 09:01:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nu9Mg-00EAEo-9w
	for linux-nvme@lists.infradead.org; Thu, 26 May 2022 09:01:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 912DD68AA6; Thu, 26 May 2022 11:00:56 +0200 (CEST)
Date: Thu, 26 May 2022 11:00:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCHv12 00/11] nvme: In-band authentication support
Message-ID: <20220526090056.GA27050@lst.de>
References: <20220518112234.24264-1-hare@suse.de> <bc8bea8b-2cdf-4d41-65b0-5c2bf28457d2@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc8bea8b-2cdf-4d41-65b0-5c2bf28457d2@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220526_020106_554803_68F7FCD5 
X-CRM114-Status: GOOD (  12.26  )
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

On Wed, May 25, 2022 at 11:54:54AM +0200, Hannes Reinecke wrote:
> How do we proceed here?
> This has been lingering for quite some time now, without any real progress. 

As said it is a high priority for the upcoming merge window.  But we
also really need reviews from the crypto maintainers for the crypto
patches, without that I can't merge the series even if I'd like to.

