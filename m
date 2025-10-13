Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEECCCD185
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Oct 2025 06:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dB3nhuPqDO6IDC2mB8jProA51TcS6zTe5hYSpG+4odM=; b=pgE5g04cAWHaEH+M9mBkixl/4h
	UMK9LQljpdgNNcGMucsACFaGF1WW0ukJtQeoBgdwdErIwoBiHKc8uV5zKNw8PbY2sIADwKBJ5mGhc
	+JS7EzVaBSBDIGpGso9yFDWS5R764IhAt3sPL1p5xURaI2FDT5pjP/z7kkgU+23eplv4PMrciQt81
	Cmnm0UNOC0oUXEKTDkNrA1eyztXSHz/mh3Kow1dRGNVpLXDjtWmvp1ysDu51wF5FBY4AmACGI7JLa
	DgKkztR6YAN7EF1KG/BfVEipVLOYMJAQvwwyULQRqUUif5Wb54jOUZxKEW92KqARzGGpdn1nA58Yo
	PVzqFd+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8CKw-0000000CQXa-096c;
	Mon, 13 Oct 2025 06:47:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8CKt-0000000CQX9-00yI
	for linux-nvme@lists.infradead.org;
	Mon, 13 Oct 2025 06:47:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9565B227A87; Mon, 13 Oct 2025 08:47:00 +0200 (CEST)
Date: Mon, 13 Oct 2025 08:47:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: libnvme API design
Message-ID: <20251013064700.GA2140@lst.de>
References: <9812534f-6a15-4126-a4c0-7b4ae39e327b@flourine.local> <20251010072658.GA17812@lst.de> <204cb4cc-33b4-40ce-8554-13436048f8d4@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <204cb4cc-33b4-40ce-8554-13436048f8d4@flourine.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251012_234711_206397_3E0FF169 
X-CRM114-Status: GOOD (  16.90  )
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

On Fri, Oct 10, 2025 at 10:44:39AM +0200, Daniel Wagner wrote:
> > > 	cmd->cdw11 |=  NVME_SET(nvmsetid, IDENTIFY_CDW11_CNSSPECID);
> > 
> > And NVME_SET still feels very oddly name..
> 
> It's on the TODO list but we might address this at the same time indeed.
> 
> Is it just the name or the macro itself?
> 
> Something like NVME_FIELD_PREP, REG_FIELD_PREP, FIELD_ENCODE,
> PACK_FIELD?
> 
> Yeah I am struggling coming up with good names...

I'm not good either, but the above already are much more descriptive.
But I'd keep thre NVME prefix.

> 
> Just for reference what v1 currently defines:
> 
> #define NVME_GET(value, name) \
> 	(((value) >> NVME_##name##_SHIFT) & NVME_##name##_MASK)

I'd preferable avoid the magic naming pasting as well, and just pass
in the shift and mask.


