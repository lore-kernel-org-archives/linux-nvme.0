Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E747CCD184
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Oct 2025 04:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4i6SE/uyeSuKlAxxkPErIXnGYNzKxIcLA8m0riS0IQE=; b=OSZ7KE11Byby3qsLyPaG1/97S+
	fT+nEuQysgm7+iNgSN9kJ+iGjWeHe+7DIC/OlthyVBMgIKZDEcLd/8/vyVZaazR3BgzGyWN9WizXm
	xK1+S2YdUNuMQ7lcu1RO4hOfAFi5fV85pdTt876WTxz8z6TUuzFlwX7zycj5mVYOeaYF8DwzX1II2
	NnDVOnFFZtoZBYl26KTA+PUNiJbu269cnJGgNR+AuRf41hS+5Z4XkQYOfuOxSPuuWFUvDutSX+7MX
	0nU3ega9vVD0fr3CCoDT3xXYjHVg1Uv2/vpNqFUjQVst1tcm84h3jXA7rfClke0MkKdWBbx6c9Nid
	KugAh/mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8WWh-0000000F6JG-2CD9;
	Tue, 14 Oct 2025 04:20:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8WWf-0000000F6Ij-1guG
	for linux-nvme@lists.infradead.org;
	Tue, 14 Oct 2025 04:20:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2ECE9227A87; Tue, 14 Oct 2025 06:20:36 +0200 (CEST)
Date: Tue, 14 Oct 2025 06:20:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: libnvme API design
Message-ID: <20251014042036.GC30344@lst.de>
References: <9812534f-6a15-4126-a4c0-7b4ae39e327b@flourine.local> <20251010072658.GA17812@lst.de> <204cb4cc-33b4-40ce-8554-13436048f8d4@flourine.local> <20251013064700.GA2140@lst.de> <0fe148ad-e2c9-4aee-9d2f-5c6eaefddca3@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fe148ad-e2c9-4aee-9d2f-5c6eaefddca3@flourine.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251013_212041_588589_9FA0DC9B 
X-CRM114-Status: GOOD (  12.42  )
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

On Mon, Oct 13, 2025 at 03:02:07PM +0200, Daniel Wagner wrote:
> I am not a big fan of the repetition but at least now tab completion
> works, so it's not too bad.

Yeah, being able to grep or complete is the reason for not doing
the magic string pasting.


