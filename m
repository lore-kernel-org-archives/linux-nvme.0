Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DF9D3A67A
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 17:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WTbE7avthF/y+v2dzntAEefZYA3DsSxukZp2ES8GUbs=; b=SaQBbEUJtrORwtBQVps2yZ19Dm
	yXlh9GVCEFXEw0vhggvYusHSPJGIRr58F1C2hbpRP1KRhiSxQTF5V10wqEWCTCub62onHNqvdiVw1
	USoD67dTRM9UZGcflS7Vf2EUe4jLDN9wy7F5klKSftygKp4qGBx+sRJZ9sF1wZVwn4eTES4usyJZk
	w5Kb5eUGVaT02ju2ZpBMcd58xiw54CbLpTlJsA7g3S4gLTgufvTXkGumKkiZboD6h/mMR9uH7T0py
	6TyeEjXWnvPUgARM7TuhZxwWdviIEJMYjh0JJdh5KFpZKcq1l1NHl8/tWEAFyguJHmA/WUEoFGbW8
	ZRdqC5KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5q7x-0000000FHX0-10nH;
	Tue, 29 Oct 2024 17:35:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5o7X-0000000Ev8w-3Cgr
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 15:27:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 064C7227A88; Tue, 29 Oct 2024 16:26:55 +0100 (CET)
Date: Tue, 29 Oct 2024 16:26:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hch@lst.de, joshi.k@samsung.com,
	javier.gonz@samsung.com, bvanassche@acm.org,
	Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
Message-ID: <20241029152654.GC26431@lst.de>
References: <20241029151922.459139-1-kbusch@meta.com> <20241029151922.459139-10-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029151922.459139-10-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_082659_962864_46635395 
X-CRM114-Status: GOOD (  16.42  )
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

On Tue, Oct 29, 2024 at 08:19:22AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The block limits exports the number of write hints, so set this limit if
> the device reports support for the lifetime hints. Not only does this
> inform the user of which hints are possible, it also allows scsi devices
> supporting the feature to utilize the full range through raw block
> device direct-io.
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Despite the reviews this is still incorrect.  The permanent streams have
a relative data temperature associated with them as pointed out last
round and are not arbitrary write stream contexts despite (ab)using
the SBC streams facilities.

Bart, btw: I think the current sd implementation is buggy as well, as
it assumes the permanent streams are ordered by their data temperature
in the IO Advise hints mode page, but I can't find anything in the
spec that requires a particular ordering.


