Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C014CC54ED1
	for <linux-nvme@archiver.kernel.org>; Tue, 27 May 2025 15:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/nivsDaEg89QD7urhXzA3uOCF4gas09gB0GPcITiBQU=; b=DP9LdaupQQj9jbsc5M4r1q53QW
	AqST7VoYpbn02iMFNx/zSCC+0gKEG/dNFnJoLiDXOTIzewq5zJbFndqUSQrap6xVAjSUUpt3lGr/g
	u98C6G8O+kYccQF3kKoKsV07EGcQ3jvopiIPwC2Cxvy380wga0sDPngatFMISHhF/iWzvrhMbB/8i
	LW37ZYGTDvMRrn71ZAXGkUUiQ4gmK87eCtB3P82xK1wCAlAfNhFVs13DZljr+VcP1XtD1GpXlBUrN
	TgJfq0gt4WtXax+7UOiC95DBTKsLR38rnkKIvp4IHaLHYKC0QXcS2NMd1ljt2YTFEP38s3pL+4kNG
	9VtVyN1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJwTP-0000000B54t-47Td;
	Tue, 27 May 2025 15:44:15 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJwTN-0000000B53z-2jFt
	for linux-nvme@lists.infradead.org;
	Tue, 27 May 2025 15:44:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4A94DA4E8DD;
	Tue, 27 May 2025 15:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817CEC4CEE9;
	Tue, 27 May 2025 15:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748360651;
	bh=C6AAKKj0kx7f3566+hG5k7ZwKSwbsgNBYFSI6iVAUh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XRO4aRpnrxJDPZP3uYMTYCj0OPRs0KUa0cHNvuRitsQ360CQKPT6Z9DyJFzjyprDy
	 1GGjkbQxuXax2Yi/IfC6CrDDdWDk14HVYMi4VjwQ2aLNfg4vq+ayzzJMD+gwY7Wni+
	 pQhirVkMwDNvI1IgHv6QKKpgo6+fb99WyfFUA7+KcSY6vxwnX1CnnA35cD69inovqC
	 Wb0ODwewkcDmu1cWGcizk4PKxT0GlMjYb0P2ag8GoMD5+rdcuc3ZMgewG99PZkcybH
	 g0HidHH9CtdzJ7VrYfq88k346XxkemA3OCddL0+zbwK4k57vfaNgUIoIkKgYGER8Ym
	 BicVqDHH3KOVw==
Date: Tue, 27 May 2025 09:44:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Avinash M N <Avinash.M.N@sandisk.com>,
	Jeffrey Lien <Jeff.Lien@sandisk.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Rahul Jain <Rahul.Jain@sandisk.com>
Subject: Re: NVMe CLI Invalid PRP Entry Status Failures
Message-ID: <aDXdyXtp5D6PpV-F@kbusch-mbp>
References: <MW3PR16MB3897F0E659B34877C4D5197CF391A@MW3PR16MB3897.namprd16.prod.outlook.com>
 <MW3PR16MB38975C2057D1EF440FBD60B0F390A@MW3PR16MB3897.namprd16.prod.outlook.com>
 <aCX3offAfe1k0_KE@kbusch-mbp>
 <LV3PR16MB606775F391112B2DADF64463B590A@LV3PR16MB6067.namprd16.prod.outlook.com>
 <aCcwqhakl4JhrI2o@kbusch-mbp>
 <LV3PR16MB6067E928D739DCB65F31FE46B593A@LV3PR16MB6067.namprd16.prod.outlook.com>
 <aCdOtYYT8f3lL8zJ@kbusch-mbp>
 <F3C3A106-E0AF-4598-9E80-6F10A457F202@sandisk.com>
 <aDHXCFeQSlQjjnmU@kbusch-mbp>
 <aDQToX9eVtNF39G6@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDQToX9eVtNF39G6@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250527_084413_751165_337223BF 
X-CRM114-Status: GOOD (  10.70  )
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

On Mon, May 26, 2025 at 12:09:21AM -0700, Christoph Hellwig wrote:
> On Sat, May 24, 2025 at 08:26:17AM -0600, Keith Busch wrote:
> 
> bio_split_rw_at doesn't look at max_sectors unless that is passed
> in as the argument.

Oh right, this passthrough path uses the max_hw_sectors limit instead.
 
> It would be good to just throw in debug printks to see which splitting
> decision in bio_split_rw_at triggers, including checking the exact
> condition in bvec_split_segs.

FWIW, I can't reproduce the issue on 6.10.

