Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860E8D74963
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 05:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SU/XmvEAEa5q37B6RBI70LNF+4LJK5baqLboneZ3m5I=; b=PKfedHeII9iYOFbVFUk0j/aqxM
	pOxJcYmWm/ZUinzrhUF6u3fkgZ/VI7cg+0rYDMyLTwYZYOxqbM9ned4eA9UhUOnn4Uvv1iPAxTSAo
	TRTxFV1XOKDTPYbmpWD4V2NfWshAd2VRdXUlLrZTA58UyV7TNebIaKaYKlAdraibrDFBElj5i1/kP
	EJxaK8YyJxOLQHul+Fi4xRG6lSXlmcas674wrjQZ7/SiSYtcVbBkUKm2CaepqMYLYSsNnb5HTsEC/
	iDCqwDb/2s7te1kvYpSDd80lOQo86T7TpBgm3hAeaJeKaRWF3hZdTOVS4mhzI2SmpQuwaAcTl3T0I
	WTyeh7rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t61ZH-0000000GoiK-0sEh;
	Wed, 30 Oct 2024 05:48:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t61TB-0000000GnlY-08C1
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 05:42:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A1C4C227A8E; Wed, 30 Oct 2024 06:42:07 +0100 (CET)
Date: Wed, 30 Oct 2024 06:42:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	javier.gonz@samsung.com, Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
Message-ID: <20241030054207.GA604@lst.de>
References: <20241029151922.459139-1-kbusch@meta.com> <20241029151922.459139-10-kbusch@meta.com> <20241029152654.GC26431@lst.de> <343c29f2-59d6-48c5-937f-a02775b192ae@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <343c29f2-59d6-48c5-937f-a02775b192ae@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_224213_239835_4E38FE92 
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

On Tue, Oct 29, 2024 at 10:18:31AM -0700, Bart Van Assche wrote:
> On 10/29/24 8:26 AM, Christoph Hellwig wrote:
>> Bart, btw: I think the current sd implementation is buggy as well, as
>> it assumes the permanent streams are ordered by their data temperature
>> in the IO Advise hints mode page, but I can't find anything in the
>> spec that requires a particular ordering.
>
> How about modifying sd_read_io_hints() such that permanent stream
> information is ignored if the order of the RELATIVE LIFETIME information
> reported by the GET STREAM STATUS command does not match the permanent
> stream order?

That seems odd as there is nothing implying that they should be ordered.
The logic thing to do would be to a little array mapping the linux
temperature levels to the streams ids.


