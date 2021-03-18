Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50E0C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 14:19:36 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59E9764F24
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 14:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E9764F24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2jADWPtmrImmX1OQx7ffc2a8dLbwDBUMerQaFLUeRpw=; b=FBpEVY8e/TaywlzNCRGB4Nofi
	aRCLuZlMVumyT7CjTPZ8V50lJJ1WNXQnrCsAusFRJ85BOt4Hdhk9MxXGBpxhdHNWNiWdlVS6+RkME
	Zq0n9nN/PVYCsY1crvraEd6XvdYxKcQGAaTayTL0pysyfZjAJie1xmknuJ4sAgGN+EpeNELcp8xjF
	vey3AmZ7TlRFA/+vcPkN9KXbxdtP+/oWm8W26CC1K39Qs0rVK7qZ8lsUQhIbaKXpoPSSGAQjfxG1n
	rqv0GbvaPHxFsCoiLj11cx3ef3Nv8qmJ49DsrtQFyd2EUBzZxBmJd0DIiOxFmWhHrWiwtrI1fD/B5
	OyOInPMXw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMtUc-005TCo-0K; Thu, 18 Mar 2021 14:19:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMtUV-005TC1-8s
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 14:19:13 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id E75DC64DE4;
 Thu, 18 Mar 2021 14:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616077149;
 bh=xgCbwYA/GTgsYF0QSILSxoBV1ODPvHoyM1rxx2aFtYQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hJWDTVThEqbNsUaEKWMM6drnJdZapWBF8w6oF3ho2cil9MHlfPEzZw7cjLC9ZJ3hW
 NuwzHw/Dqsv5z1T8V+MzVSIPaoIfzruEoUbuaUQQLg9mNbDmNP3HEgxWikk438moGV
 zTdniMjoppDpWLmjyG4JRI2Tj1E4PVraa6j1KJmYDhUh5i9NCl+81H95ZLe0mWQidW
 NK9ihWE6l9gEFD1nLm6ubWrcNzqWqcDRsviwOlfceZ9BHdmQu+U3v4rTS7kFAUZsVe
 Kq9WhNJc9NQUepwrAXIgKG3UCNLsnRRfg7AC0A1aOBv3Ks0TngM4fgtEfWtjUMZQZH
 0WK/4K28PbDFQ==
Date: Thu, 18 Mar 2021 23:19:03 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alan Adamson <alan.adamson@oracle.com>, linux-nvme@lists.infradead.org,
 axboe@fb.com, sagi@grimberg.me
Subject: Re: [PATCH 0/1] nvme: Export CSTS register via sysfs
Message-ID: <20210318141903.GA31228@redsun51.ssa.fujisawa.hgst.com>
References: <20210317204615.13971-1-alan.adamson@oracle.com>
 <20210318043828.GB26988@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210318043828.GB26988@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_141911_636584_4CD38BBF 
X-CRM114-Status: GOOD (  12.83  )
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

On Thu, Mar 18, 2021 at 05:38:28AM +0100, Christoph Hellwig wrote:
> On Wed, Mar 17, 2021 at 04:46:14PM -0400, Alan Adamson wrote:
> > This patch exports the NVMe Controller CSTS register via sysfs.  This
> > feature can be used by userland executables that accessed CSTS and
> > possibly other registers by mapping them into user space.  Since this ability
> > may not always available, exporting certain registers via sysfs provides
> > a safe/read-only way to access registers from outside the kernel.
> 
> So what is this application doings with it?  Should we just have a
> ready attribute instead of exporting a raw register encoding?

Isn't that captured by the existing 'state' sysfs attribute?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
