Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F283DD5B86D
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 15:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YhnBuWQWpZpHtHUpTn6eq03wsGYxzqxeisyq++iAu5Y=; b=tkVvg/BGSJjS6E/fIpYLcinvu8
	psTB3yyVGm3iaMoyBd2/FoEMEmsG8Q9CWPbzl/cjqxUl4BRUl4lztnxmJV7lw31N44uBSmKk5a6s4
	bYH+RFRGrkAv7Rtqv8TrOc4oWiU9xmhZTiMjtn7FpHXRdhbZsbW5H3GvPZOLt92lkrYd79bPCEyXZ
	lkmAtl2n3jkglvWWGSLEI2P2OJnejdM21Y/wgjOjSp0AmhRaEctQdtrAs57FjFM5A6Qa6gMRSXQ99
	1bwuw2CCzYFTXc437pXhrx/+NsE4rcTDjBFJNzdj1L9tJRdqAVKX1kWcaMY1CcE1lDMAeD74/mT9b
	OKYZ30Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6B4y-00000000yRT-2Qrs;
	Wed, 30 Oct 2024 15:57:52 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6ApL-00000000umO-2hFI
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 15:41:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 946175C59D5;
	Wed, 30 Oct 2024 15:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822B9C4CECE;
	Wed, 30 Oct 2024 15:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730302902;
	bh=utkGkIOuyAypc5KWyKHdZPW7ZaIs7bjNM3+PPMYDXx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E4+EK1i+uqMZAzhr3niOIOpMznn1nE/QRf8KI0TYOSRYmGtNNLZJHDw+1/IFQKmzH
	 fgy1C9dnab1BHJjhU6RaRtvPJihIfcI+Y3ZYKP2yEkTxWOxnSl/MEVY6K/YBTxabxq
	 8Rr8zXkHQo2RH64xzqPoNSbxTRUYZrmOBP7sPwsih5Rf3g+CA+GDtFwi8xAOTYPR5E
	 pwegXoh3EznGFIrhbSzymoA49utLWxetwb51M93vhihKuFjmS4Iz9Ue/Xtvj7O/A/r
	 kjTLnvRNLlgudf1AXgt46rnqb6N2AagNNV/2EFnS/IEDgSSSvdyK1gvfC7nLgk/wZm
	 HreLOajjVKngw==
Date: Wed, 30 Oct 2024 09:41:39 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, javier.gonz@samsung.com, bvanassche@acm.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
Message-ID: <ZyJTsyDjn6ABVbV0@kbusch-mbp.dhcp.thefacebook.com>
References: <20241029151922.459139-1-kbusch@meta.com>
 <20241029151922.459139-10-kbusch@meta.com>
 <20241029152654.GC26431@lst.de>
 <ZyEAb-zgvBlzZiaQ@kbusch-mbp>
 <20241029153702.GA27545@lst.de>
 <ZyEBhOoDHKJs4EEY@kbusch-mbp>
 <20241029155330.GA27856@lst.de>
 <ZyEL4FOBMr4H8DGM@kbusch-mbp>
 <20241030045526.GA32385@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030045526.GA32385@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_084143_747730_56E0F89C 
X-CRM114-Status: GOOD (  16.48  )
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

On Wed, Oct 30, 2024 at 05:55:26AM +0100, Christoph Hellwig wrote:
> On Tue, Oct 29, 2024 at 10:22:56AM -0600, Keith Busch wrote:
> 
> > No need to create a new fcntl. The people already testing this are
> > successfully using FDP with the existing fcntl hints. Their applications
> > leverage FDP as way to separate files based on expected lifetime. It is
> > how they want to use it and it is working above expectations. 
> 
> FYI, I think it's always fine and easy to map the temperature hits to
> write streams if that's all the driver offers.  It loses a lot of the
> capapilities, but as long as it doesn't enforce a lower level interface
> that never exposes more that's fine.

But that's just the v2 from this sequence:

https://lore.kernel.org/linux-nvme/20240528150233.55562-1-joshi.k@samsung.com/

If you're okay with it now, then let's just go with that and I'm happy
continue iterating on the rest separately. 

