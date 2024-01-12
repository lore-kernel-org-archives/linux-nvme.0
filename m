Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562D2C4706C
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Jan 2024 15:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DjVPjjjOC9+VfIQIJ1ZCZOkIJE5V+3KCLHNSv8iSUzM=; b=qNBvw9DX1aGRhmb91WUlDcazu6
	12yl8cUrSnNd4HhPWVQtBkSJHp0dSvcSwDwCSbLtqnjIRzre8g3fzUBp8F5zS76GGql9rYnVoXJhX
	qKQSOVN2eJdapYK7kE2uVzIdR0vy9YzzFJIxKwhqGbUQ+K5jh0nPtmkNQXCVmmdvBWCh3hYVVLgrs
	qrghzPlzhG77cNjqhRkNmJZq91WKfJEITSz7MN4oHxDXYS6KtCtHV5xmaUYznJX0iDSQiYwj9D7Au
	gIcmNL+PzPUtJmWr0VklNdByAIgpjiCSxZBE//G/vNf2ZL7xVnGMFJs77yPPZY3RfGNpPMGrSC/Su
	HdvRBozQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rOJeT-003Bbt-0p;
	Fri, 12 Jan 2024 15:40:57 +0000
Received: from mout-p-101.mailbox.org ([2001:67c:2050:0:465::101])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rOJeP-003Bai-2w
	for linux-nvme@lists.infradead.org;
	Fri, 12 Jan 2024 15:40:56 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TBQjS18ptz9spj;
	Fri, 12 Jan 2024 16:40:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1705074044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DjVPjjjOC9+VfIQIJ1ZCZOkIJE5V+3KCLHNSv8iSUzM=;
	b=zKBAK2OEqLzWPvOw5JB/dhK2JTaVuc25nJgUcgCQYSRZZ/biXbLqIpI+ECzQKHy0aF8yP+
	p1my3UGhK29FORk4ewodR9ldGGBjZFZAb8b3mRJopsKsfI7R6DlDr1AMPBcMfgvlSK8mk6
	rJpWCsO2VWw+wKpGUw3qdE9XN6J3wiaOaMYtLNicjYW4IS7ev4lTnWJKQCp2Zw4H4driOy
	qlYweryOcYIvRu0iVRVR3hkNuKY5A/2/LzWCm+2HDK7EHTQBNCrQ8MABxC5OMZZhbjQ8Ux
	7ZjxeJxfYC11GaFO46EH2EM5l2/+8AhisWxOc4SSiIuAH69f9BX4C7poS2AuxQ==
Date: Fri, 12 Jan 2024 16:40:40 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, 
	Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>, 
	John Meneghini <jmeneghi@redhat.com>, linux-nvme@lists.infradead.org, hch@lst.de, 
	Keith Busch <kbusch@kernel.org>, p.raghav@samsung.com, javier.gonz@samsung.com
Subject: Re: [Report] blk-zoned/ZNS: non_power_of_2 of zone->len]
Message-ID: <pvojitlhpwnxoc3zws5ufwsg2wnygirzobuuktbrcfv3b2zcyo@oevh6e2x3adx>
References: <ZaCSOH7L+Nm6PvcN@fedora>
 <20503cd0-3a99-45bb-8374-40296a3cb92a@kernel.org>
 <ZaCyC5RIAcbkBYeL@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaCyC5RIAcbkBYeL@fedora>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240112_074054_119496_C3328BC3 
X-CRM114-Status: GOOD (  19.78  )
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

Hi Ming,

> > 
> > It is the latter. There was a session at LSF/MM last year about this. I recall
> > that the conclusion was that unless there is a strong user demand for non power
> > of 2 zone size, we are not going to do anything about it. Because allowing
> > non-power of 2 zone size has some serious consequences all over the place,
> > including in FSes that natively support zoned devices. So relaxing that
> > requirement is not trivial.
> 
> Just saw Bart's work on supporting non-power_of_2 zone len:
> 
> https://lore.kernel.org/linux-block/dc89c70e-4931-baaf-c450-6801c200c1d7@acm.org/

As Bart said, I did most of the work in 2022.

> 
> IMO FS support might be another topic, cause FS isn't the only user,
> also without block layer support, the device isn't usable, not mention FS.
> 

I also added a small dm target in the series that converts a non-po2
device to a po2 device to support existing FS without modifications
until native support is added in them.

One of the main arguments against the support was the fragmentation it
may cause in the FS world for zoned devices. Given that F2FS already
supports non-po2 devices, it is only btrfs that will need some work to
have native non-po2 support.

> Since non-power2 zoned device does exists, I'd suggest Bart to restart the
> work and let linux cover more zoned devices(include non-power 2 zone).
> 

I would be more than happy to provide my reviews if someone wants to do
a respin on that series. IIRC, the changes to the block layer were not
very intrusive.

--
Pankaj

