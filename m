Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADBDC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 15:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AfMbrsHcB5wy+lcsErUtznDk0JW9A3Tm6G0/li7w4WA=; b=Kcanuvad2EQZrbZ6qRSnq0CMtq
	g+v2a2CVMUHHstYN1fGVWMAGu+BwHLWQXXIQbZ892Kbh9ptThS1BYLvK9DKRA20ZUnYaD+2w/SXA+
	sOoC/bzx+mQlAJM+s98v9+6D2Gb5Kaw89/oMhi56yz4offUTjnUGbxuE01qOWH/6yKBdrsmXvhX/S
	l/8ywjtstN+wKLmESSqReUxnOEVFPg0+l75vJL+N66JIjj3bAhDMX1IzLujK65ARQmBdLcOlUdgQx
	bL7IHdLm3cpr5tcGIGpXTT5m1TTQ5NSu206XBiNgl5SWct1TqfhMTZCVeMlHJNNTW3EwGi8xjRVMr
	3rw3S2LA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox8ps-00FGh7-1j; Mon, 21 Nov 2022 15:35:52 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox8pn-00FGeL-T7
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 15:35:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 314706129B;
	Mon, 21 Nov 2022 15:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D1AC433C1;
	Mon, 21 Nov 2022 15:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669044945;
	bh=TcFJ/jYKlA/8snoN0r865xfjD7rqC/PKwNwd7j0Oqqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PHmYE061Fz4my2dlwNIAjgxrqXMYvJZi0ucUkuz/zFAAAX7qomJQphb0rc/zRL6uA
	 4OaojE+z87H3o/GugGhHVlfRHyuuYbcvICvetTAeohvPcgH/bZqTfHdVylPmZlIIb4
	 mHbGWFSsyP29HVOb2iR+CoIpAGSczBI3d7uBSn3bnMhOVPTHYoxJAqIqmGYOOX0BVl
	 Qd5LGGi79YfFEXnh6inbwQ/7EXVIE3v8yQNTrn6rleVeD3LjeoiaDUsPpgzqXTLBfD
	 v5T+b5hFfcrNQh7pP5n3WrEkxrAIR7wqQyHAiI5VxwdTOWrWY35/gQrciKFMIolQ8p
	 QBRrdXNlsH62g==
Date: Mon, 21 Nov 2022 08:35:42 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: block dangerous passthrough operation
Message-ID: <Y3uazieJ5xRR8jg7@kbusch-mbp>
References: <20221116130104.2186334-1-hch@lst.de>
 <256d34ff-3979-9780-4426-6d913a3a9707@kernel.dk>
 <20221121074647.GD24507@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121074647.GD24507@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_073548_008471_B2E6F7B1 
X-CRM114-Status: GOOD (  15.95  )
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

On Mon, Nov 21, 2022 at 08:46:47AM +0100, Christoph Hellwig wrote:
> On Wed, Nov 16, 2022 at 08:49:42PM -0700, Jens Axboe wrote:
> > Honestly, I think this is a mess, and it's exactly why I didn't like
> > going down this path to begin with. I'm assuming that last 'now' above
> > should be a 'not'? This approach is not going to be maintainable.
> 
> What else can be we?  Allow people to put the driver into all kinds of
> weird states without us even knowing and just deal with it?

It's not like just anyone can do this kind of craziness. It's like a
soft equivalent of pulling a cable. There are usually access
restrictions for untrusted people.

