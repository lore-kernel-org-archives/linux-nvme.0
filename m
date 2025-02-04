Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDE0C0218F
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2025 06:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KTogoc29q7zZNa7i73VAxi4bEepNo5+vQgTXKfu0oEA=; b=4MYzQ2VNKHlFB0eB6OZvMwO9nR
	9RNZBkFrx+4E6W/ooRW6PaQf70pAbNV1RH1xz+SozWeA5JG5R8U1DQtrnoBZtSfXRePu0qwt7uddG
	hR1iKQik+ORJ0JE3PatV2JgtvUpB32cFap1/AhG6l3fUMXyl8zTTIRHU+uRMcrO4fXQ0D8oRazqr3
	3E8B6WjeeNyCFDPtE4vhfkX2WsxiTSJEY65LsTyTOGSGfaAh3PBx+6Yz1jnqiAYPkAmFZIpHTNrq2
	urpwKk/JRZ19ZuATEDPrsFU6U9tR6RBT9kofYL0MAPCc/kcfZ4dX3vl1dgPgeqEcCduWCfcKEEAuO
	t6qB3feA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfCJw-0000000HMHR-0JV4;
	Tue, 04 Feb 2025 06:22:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfCAS-0000000HL7a-2Wd5
	for linux-nvme@lists.infradead.org;
	Tue, 04 Feb 2025 06:12:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4A82C68AFE; Tue,  4 Feb 2025 07:12:09 +0100 (CET)
Date: Tue, 4 Feb 2025 07:12:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bruno Gravato <bgravato@gmail.com>
Cc: Stefan <linux-kernel@simg.de>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Christoph Hellwig <hch@lst.de>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Keith Busch <kbusch@kernel.org>, Adrian Huang <ahuang12@lenovo.com>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of
 AsRock X600M-STX + Ryzen 8700G
Message-ID: <20250204061208.GA29300@lst.de>
References: <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com> <3b693647-5e82-4c39-8017-22cada56eb55@leemhuis.info> <20250117080507.GA25953@lst.de> <f81bb87a-c181-4973-be05-f7df84133a46@leemhuis.info> <10e39c88-4667-4c61-b3eb-3dd7ee3074c3@leemhuis.info> <20250128074133.GA22435@lst.de> <379bba80-df0f-44c5-a15e-fd4393c52b8f@simg.de> <Z5jTKTfKUeLm4uJT@gallifrey> <e01fdde0-4760-487d-af0e-2aecf9d7ade2@simg.de> <CAOBLbT8V5DkuXzzgp2dPOZkGomqiLa_cdC=e=uWBtcWpP7L=Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOBLbT8V5DkuXzzgp2dPOZkGomqiLa_cdC=e=uWBtcWpP7L=Ww@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_221216_787462_4F5CDEE9 
X-CRM114-Status: GOOD (  26.26  )
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

On Sun, Feb 02, 2025 at 08:32:31AM +0000, Bruno Gravato wrote:
> In my tests I was using real data: a backup of my files.
> 
> On one such test I copied over 300K files, variables sizes and types
> totalling about 60GB. A bit over 20 files got corrupted.
> I tried copying the files over the network (ethernet) using rsync/ssh.
> I also tried restoring the files using restic (over ssh as well). And
> I also tried copying the files locally from a SATA disk. In all cases
> I got similar results with some files being corrupted.
> The destination nvme disk was using btrfs and running btrfs scrub
> after the copy detects quite a few checksum errors.

So you used various different data sources, and the desintation was
always the nvme device in the suspect slot.

> I analyzed some of those corrupted files and one of them happened to
> be a text file (linux kernel source code).
> A big portion of the text was replaced with text from another file in
> the same directory (being text made it easy to find where it came
> from).
> So this was a contiguous block of text that was overwritten with a
> contiguous block of text from another file.
> If I remember correctly the other file was not corrupted (so the
> blocks weren't swapped). It looked like a certain block of text was
> written twice: on the correct file and on another file in the same
> directory.

That's a very interesting pattern.

> I also got some jpeg images corrupted. I was able to open and view
> (partially) those images and it looked like a portion of the image was
> repeated in a different part of it), so blocks of the same file were
> probably duplicated and overwritten within itself.
> 
> The blocks being overwritten seemed to be different sizes on different files.

This does sound like a fairly common pattern due to SSD FTL issues,
but I still don't want to rule out swiotlb, which due to the bucketing
could maybe also lead to these, but I can't really see how.  But the
fact that the affected systems seem to be using swiotlb despite no
good reason for them to do so still leaves me puzzled.


