Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BFCC83F2C
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Sep 2023 15:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MZxTQDzJvL3TKBJNWbi9qEr79IBFR2kYRZ8zfG3sVtc=; b=03scapcUFtfiJCIFEZe85FhijS
	6N/fVIGU//EDq/R/gthXIQELHwK2gZoxYOJ7vWLdyepPDjMabaKYFgb2Uiman8DAWDvGk/jh3pTaR
	CreyVIV7WxP2NQcTpph0j9rnyrxtcUlGY85zMrcau/QZsQx2vq0osxKvxAXOG1rvIC9WIrIVYPeUK
	ks8qJm95HWGXoKAW9BlfCNvZblkZhkiqrrbd+GZGalXAUGkSs41XlFUsF0wLBs32aUcfDRjQChVzD
	6q2/Zmi+Wm7R38HCFcp3p5GD8g5XhBb0F4VwAgMMyqOzruwus8hnG7fL4aBttS3q9kFlfBPo3Wr8z
	mH8maYwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdXlf-006FIQ-2U;
	Tue, 05 Sep 2023 15:15:03 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdXlb-006FHB-2f
	for linux-nvme@lists.infradead.org;
	Tue, 05 Sep 2023 15:15:01 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 685A1B81201;
	Tue,  5 Sep 2023 15:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9375EC433C7;
	Tue,  5 Sep 2023 15:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693926881;
	bh=MZxTQDzJvL3TKBJNWbi9qEr79IBFR2kYRZ8zfG3sVtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ooglhayVbYjqTRt3Zcgr4L3EZ6hQTlB2Y2JzzB9M5z9u9B0ZS0l/WDjCZLnwIGTrl
	 7U8cMIqE/QLjvdRdDDZiUMCbauATB8gi7x/ZoqSP52J2uAbC9Fmn4yLiUvldPicDuK
	 S8GqMDYxrKLlPyXwAcpNn3ycBD/fILkFqrPp+ULMoACZcUUKa0VFSZmQ283b5PEuv2
	 JaKCllNqV3SgauysH/VIYuMG284xPSXjY0X5ycfGiNHqX7mtpgNlb0Y/1NanrgMLRq
	 91Owc/PaAwDW5oqeBXdoA6xvSYOhnucprNoVIn2WwiUntTlMfrjrU/huLhaIMLjeP3
	 MWD1kviohfq9g==
Date: Tue, 5 Sep 2023 09:14:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Claudio Sampaio <patola@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux NVMe <linux-nvme@lists.infradead.org>,
	Linux Stable <stable@vger.kernel.org>
Subject: Re: Fwd: Lexar NM790 SSDs are not recognized anymore after 6.1.50 LTS
Message-ID: <ZPdF3uqbJNSZADzv@kbusch-mbp>
References: <8af186ba-5f64-2102-8f9c-3969b0906893@gmail.com>
 <faa245bf-e925-45b0-9827-b0c9c117e06c@leemhuis.info>
 <ZPc8v9-lHF4jAcxL@kbusch-mbp>
 <2a379b3a-6ff3-444b-bbad-0fba0bc3a28b@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a379b3a-6ff3-444b-bbad-0fba0bc3a28b@leemhuis.info>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230905_081500_143202_906CE8BD 
X-CRM114-Status: GOOD (  12.67  )
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

On Tue, Sep 05, 2023 at 04:49:11PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> But what can Claudio do to find the root cause? Check hardware
> (especially the connectors), update firmware, ...? And if that doesn't
> lead to anything, bisect the issue?

Try the current 6.5.1 as-is where the failure was previously seen and
verify if this observation is indeed 100% reproducible with the "device
not ready" kernel message. Full system power cycle between tests, too.

If this is truly a regression, my only guess is some platform power
setting that a newer kernel changed. I am currently suspicious of that
right now since 6.5.1 was reported to fail but succeed with a "quirk"
that doesn't accomplish anything. I'm more leaning toward my "device is
not reliable" theory.

