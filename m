Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BC1C5B567
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 19:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NElMQPNI9f5GGkELtJSS+OwnoJjZJSrx2kCV2ynFUQE=; b=FjxCCvXT0MAhtc8SB3FGoSp0lf
	P4lXMAYmVc84MQ+4OIJS4VYY5lJAK7EVwOykoVq736MkE/jMbOCLEaK1qY0dwQLpw1M3/CTVZXbKj
	OKXVtJejwbbvoANr76Ernt0gNUAFTAgtOEGYy+gRCLZzpa9S+HDgrCa/zo0W5nKdnpXlB3IJCxEPQ
	24WEyv5l7ARXCkOVnFqRiOB6HNL520gODmCWhDm4YipI91M+BEMbt+hSJqJ0xd96IQ9ZeVFu36FoP
	tmnMA4BQGRXz3PHdg+5lCfkCGNQnEzxS2bFwIx3oIBMEWRHBBG9RlaeqbedB+2A2fY9rzZ43+2tcr
	3k6NoTUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtVoZ-0000000ClOR-3DX8;
	Mon, 10 Aug 2026 19:37:39 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtVoY-0000000ClO6-1574
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 19:37:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F1EAA4164F;
	Mon, 10 Aug 2026 19:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939B61F000E9;
	Mon, 10 Aug 2026 19:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786390656;
	bh=NElMQPNI9f5GGkELtJSS+OwnoJjZJSrx2kCV2ynFUQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MicdOTysomoYVBRQcudKAK67+UVpi+CutG1dzNk8eutEdzYKBUpUfMsJNVjYNYyOR
	 xYQVeyZC02ZPFEdtqMOdkGEBRcrRiLA5PCgTtmz3+MLIE1c+lWWRhVCAo8yjvqjWKB
	 JuGMiDhTX7AUtirj7FhKhAZ6O7tOWFndC1kEGg3ZCYljh+AzQBnnA3AVhqwnL4kSWG
	 1JAXrB8QOJ8V2m6OxgTthlLs1+/0ZLPNd/q//94EfGSmF1ElkcYTa0fRoskIhAb+yt
	 7J6FaB9JMcB2/ZXosQNcDhzbUjPGhfjrUuXuoPV0SI715yWyHSU4HVE3uaNleZywsU
	 73jh1sjLDYGJg==
Date: Mon, 10 Aug 2026 13:37:35 -0600
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: fix heap out-of-bounds read in
 nvmet_auth_negotiate()
Message-ID: <anoof83wAQ2zcO97@kbusch-mbp>
References: <20260804033800.3975537-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804033800.3975537-1-kanie@linux.alibaba.com>
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

On Tue, Aug 04, 2026 at 11:38:00AM +0800, Guixin Liu wrote:
> nvmet_execute_auth_send() allocates the DH-HMAC-CHAP message buffer with
> the host-supplied transfer length (tl) and hands it to
> nvmet_auth_negotiate() without passing tl along. nvmet_auth_negotiate()
> then reads the negotiate header and, for each of the halen hash
> identifiers and dhlen DH group identifiers, indexes into the fixed
> idlist[60] array (hashes at idlist[0..halen), groups at idlist[30..]).

Thanks, applied to nvme-7.3 with the formatting updated.

