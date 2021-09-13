Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65716C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 16:08:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10B91604D1
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 16:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 10B91604D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yerqAOtn5vz8uqjdAhjZ7LkqvhLLM4yqoypkdPZuC+E=; b=QG8nnlFwRrHufC
	BuLhkPSWqyydPQJwa20CDpXRrAJesggsB9sgGl6jmQpnJyY0VGIo8bd5qpjsJNSourfA3mdeQ21Ub
	mYJ/ldO6SZ8YAuFKqfXE4sXm7TQzhR4R0tLmEw2np/TJSDiwyADf6/RMc7Bi5dKOlweeEQTHRiClO
	UVRBl82eX0bwQt8S60Wpk2OHKtfFOztNZ4X6GSKCYl0BMizje5svoBCUTIlsbC1cIWXYFYG6bEPBZ
	fzCMoca3KsuR0GozhhBiT4Vg/Qm65k9StNN/cjyxVIzuvhF389H9LQz7nLNNH6nqlsOhKPdPJFOjo
	Sv1MGUUnPRCuiavAxj1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPoVY-002IVw-L7; Mon, 13 Sep 2021 16:08:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPoVW-002IUo-1X
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 16:08:35 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AF0E604D1;
 Mon, 13 Sep 2021 16:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631549313;
 bh=RNDuyHF3ElCSeyXN/hD6wu/dREr1q6jCsj0cYl0lO/w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mWWaOH7wML9OU5fi+L13ZVCo05LzcPnHkoHlq98loX0qlYXCeDZuKq7P1Xzuq5BCk
 GafSXEa+H+oKLNcnnbedRBbhGjEIHH5qHhra5t+4EZ9FUvC+sfHIevUNuTlvN0iXR7
 ASOnT6U+5JycPz5rXbkJEhKDo2/M9GczXgJz30Ye7obuaEYGKkZcBiZiv6lapBfUK1
 fkPibaC0gsCCmzBBBb6RkX4dKBBIUgkHYkztFnXXpKA9mFoUhntT3cI8Adbd81UHAD
 TDvn5/Qu8eDLNNzyrVcxpFpk9KAeHudFMkZ9kCK2uRl8f7gaA4RCNRSDxT8EyhvbCm
 p9Yol1G8WhPHw==
Date: Mon, 13 Sep 2021 09:08:31 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Anton Eidelman <anton.eidelman@gmail.com>,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, axboe@fb.com,
 Anton Eidelman <anton@lightbitslabs.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 3/3] nvme/multipath: fix stale ana state for
 namespaces just added by scan work
Message-ID: <20210913160831.GC3283786@dhcp-10-100-145-180.wdc.com>
References: <20210912185459.13496-4-anton@lightbitslabs.com>
 <20210913153023.70879-1-anton@lightbitslabs.com>
 <20210913153023.70879-4-anton@lightbitslabs.com>
 <20210913160310.GC6442@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210913160310.GC6442@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_090834_147319_A882454E 
X-CRM114-Status: GOOD (  15.66  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 13, 2021 at 06:03:10PM +0200, Christoph Hellwig wrote:
> On Mon, Sep 13, 2021 at 09:30:23AM -0600, Anton Eidelman wrote:
> > Scan work initially adds new namespaces to ctrl->namespaces TAIL.
> > They make the list unordered temporarily until nvme_scan_work()
> > finally sorts the list.
> > 
> > Solution:
> > In order to preserve the way ctrl->namespaces is updated and sorted,
> > make nvme_update_ana_state() deal with the case where ctrl->namespaces
> > is not fully sorted and has new namespaces appended with potentially
> > lower nsids.
> > nvme_update_ana_state() keeps track of the nsid seen in the list,
> > detects the unsorted case (rare), and restarts scanning of desc->nsids.
> 
> Can we dust off the patch from Chaitanya to switch to an always sorted
> xarray instead of papering over this delayed sort?

Yeah, that's what I was going to say. :)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
