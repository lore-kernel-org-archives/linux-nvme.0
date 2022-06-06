Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505D5C43334
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jun 2022 12:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:From:To:Date:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zTkZg3ERlsGk/HZmzK3uhsbkpn1sOGwO/4BNl4C2x9g=; b=C9eGFMfAdcpEfTy299P76/DoRC
	ZWhJ6FLx8QjXT9PmpmiBfOhyQFwa2sxNvElplWM9jULNboSfYk4G3bT/Kp0U8Nzxrajv48dTTdngb
	DN7+S4yERWEM/3BuS0RsQUkshNIjw9OfzYSRfz/1UdUAGdg1lYoXFS9cwbyEHDMJ9wFwwSqA/Mu2y
	ommle4TbucQPKmbxF/PS75L78//AQYyPcuTZq8QYXoAU+/fg8pB9BHMAwjX1FeVwSoGNDDPxugqq5
	KTwogowBY2xd1A5BUDHarPhc4/Yw2fn4KSAbuNAYbMbJma/NSIhnqSEjxyKqtCP3PR4lxmlv3maRY
	VtNw1EWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyC9T-001Dwr-DP; Mon, 06 Jun 2022 12:48:11 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyC9R-001DwW-FB
	for linux-nvme@bombadil.infradead.org; Mon, 06 Jun 2022 12:48:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Message-ID:Subject:Reply-To:Cc:From:To:
	Date:Sender:Content-ID:Content-Description;
	bh=zTkZg3ERlsGk/HZmzK3uhsbkpn1sOGwO/4BNl4C2x9g=; b=D38cN/8Wg6oHznDxIogLTogMG7
	syIB0q8u8PYuQ5hgR1gBOrVbYelOta0QMH6qcFZzTn4rVdG/kMMwsp63DRHyKBXU7tfs5iNJFB2rK
	0KJB11VRdGfUbIdAS37HAl4tNCN3gltyixqH3Vi1CspdY6+iLqHcesV72A+D16eghlLWQWiLg7729
	CAdX2Wv2LzegW3RGZ1FNhM3hllv+fwtLCoa3J3mbmM12Q5+yrLX4gTbE7o9CT03oLj8h2HyhgmP8t
	EN2KoecaRrB6dZxjax/uA3TnLeEdYDxxliWTSzdkodMN/WpQBKpkFB/N/plq63FryIUab8xxT4gNO
	SLJQsOcA==;
Received: from mail-4018.proton.ch ([185.70.40.18])
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyC9L-005SQV-Oq
	for linux-nvme@lists.infradead.org; Mon, 06 Jun 2022 12:48:06 +0000
Date: Mon, 06 Jun 2022 12:42:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pimaker.at;
	s=protonmail2; t=1654519371; x=1654778571;
	bh=zTkZg3ERlsGk/HZmzK3uhsbkpn1sOGwO/4BNl4C2x9g=;
	h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
	 Feedback-ID:Message-ID;
	b=KQv619hp1zawRe03J3P+BD0wt0GmYA/aY77pm9yTfLQ5moWkoE/Y4fS+ODlp9ZkQc
	 9QxP/p6vzqDePW4TTngpk+of0NV5zusauMPW8kzsIRz4aZxg2R/zLNhe5XnIIkzmnI
	 FOeWpkPPvggkfkfuPFfbmut80y/JOkIqzIVUhmJyK4OIaU95XszSwrWQEgD2j3ZNsk
	 WOHWYAwJIq3UHGcgDOdoEcR2ScYJZAKDsySnHk8BatU8/SxH9XQSlSOfR1Hgt9oQyL
	 sF5fF5F5DrT1zXKftuYTsKegZW0TiydbCQwzc6RQQzhKbCUkiStZDNR6SxIlGMyiHY
	 lC4cWqzAw9RDA==
To: Christoph Hellwig <hch@lst.de>
From: Stefan <stefan@pimaker.at>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <yvyNnbOuo1IZcw39mQoii7v-nZd1UfjV4OpU7gDT5Nacp5OsOzOvQUruPUp4haa2EX3dyB03_ye1D16XYFbY1-IWvHESkp3OWxIjSQO1WVg=@pimaker.at>
In-Reply-To: <20220606064055.GA2450@lst.de>
References: <6d463ee2-62d6-e36c-7059-af7fbf8639c8@pimaker.at> <20220606064055.GA2450@lst.de>
Feedback-ID: 6415277:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_134804_993509_A8EC2621 
X-CRM114-Status: GOOD (  14.13  )
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
Reply-To: Stefan <stefan@pimaker.at>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> On Sun, Jun 05, 2022 at 01:58:07AM +0000, Stefan wrote:
>
> > Ran into a boot failure on my workstation today and I traced it to this
> > commit, reverting it on v5.18.1 makes it work. Quad-nvme boot raid.
> >
> > I saw some follow-ups adding quirks, so I added NVME_QUIRK_BOGUS_NID to=
 my
> > drives (1cc1:5350 for reference) and that worked too - if this is ok fo=
r an
> > actual patch let me know.
>
>
> Yes, please send the patch, the controller reports a non-uniqueue EUI64,
> the rest seems to be not reported at all and thus actually ok.

Will do, but just to clarify: Is this a problem with my specific drive or
with the controller? FWICT my drives use a Phison PS5016-E16, which seems
quite common in consumer PCIe 4.0 SSDs.

If I add the quirk for 1cc1:5350 it would only override it for this
specific ADATA/XPG model, correct?

