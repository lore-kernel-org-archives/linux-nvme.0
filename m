Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6287FEE57DF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Sep 2023 18:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KQWdx/Fl0YYS27pw8mW5NagTbUm9aANbYaGKwBbxMRg=; b=xwCTt7qsBd17NQ340gciLSpSBd
	2eJ021LQUBxIn4Kf18H9vu2WY6e/BKesyorezsxFW2+iTOaApw05lMtklmJKMARF61Sb2IOM8NxiT
	R9yuhsRSd0HqeCqpQ9xptS/lLokNfheXE5Pc3JHwP26N9GEXiAndRgdnHjllXeX7NgWrMRrdVUInr
	P47u8sbsXZBHHBphimpYnLB3jmkPPzmHRpy/naQIDZSNSTMkyhlpkVyyvMzBbJtruH+G0aye8m/MR
	0mjLeSg+X3ENDKOwCqbnYjq9dbTvYUjeFEEU4aTD2CEIkMudH3ivYqSjiOcsH7MaIuq5JlnoNaXHI
	Lblp5uTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qflqP-0018rX-0D;
	Mon, 11 Sep 2023 18:41:09 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qflqH-0018qV-2x
	for linux-nvme@lists.infradead.org;
	Mon, 11 Sep 2023 18:41:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 983ADB81088;
	Mon, 11 Sep 2023 18:40:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B48EC433C9;
	Mon, 11 Sep 2023 18:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694457658;
	bh=KQWdx/Fl0YYS27pw8mW5NagTbUm9aANbYaGKwBbxMRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fjn3MsGes9YA8GWfL0TlxGW4rS6yrqd0+qvR+ILrrE7snCVKKbdDZTCSCcBTvjYz+
	 DoElXtK16OBKquPLHS7B1SFDLvPEZ9KL3wD/FMv4bUA7P5TOnmCJJnVGVBs1YPfaEF
	 1xs04pKLUTzfeZ6wO2aPKaM5sOmmpKieUNcSUz26eU1GQzFF2lI58iBnKcjJ9G+81k
	 s07y3fThthSSr+BKkvOSUWmCAXrED0Dmn4yBKs++t4c5B6gl5DEj7TDEdfRiT3vnL8
	 rgchc02OxVFYnZKZ9IJpnQPxBbBw32o4VtVqUyc9478Mpf1u1SqvrfOO+FPLKSETz+
	 Llh7+5huQZafQ==
Date: Mon, 11 Sep 2023 11:40:56 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ameer Hamza <ahamza@ixsystems.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-kernel@vger.kernel.org, mav@ixsystems.com,
	edmund.nadolski@ixsystems.com
Subject: Re: [PATCH] nvme: prevent id ctrl csi for specs below 2.0
Message-ID: <ZP9fOBSl59u8u0hq@kbusch-mbp.dhcp.thefacebook.com>
References: <20230910212641.338438-1-ahamza@ixsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230910212641.338438-1-ahamza@ixsystems.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_114102_112028_AAA29BD6 
X-CRM114-Status: GOOD (  12.22  )
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

On Mon, Sep 11, 2023 at 02:26:41AM +0500, Ameer Hamza wrote:
> The 'id ctrl csi' command was introduced in version 2.0, as specified
> in Section 5.17.2.6 of the NVME Base Specification 2.0. Executing this
> command on previous NVMe versions returns an "Invalid Field" error,
> and the error entry is saved in the log page. Although, Commit
> c917dd96fe41 ("nvme: skip optional id ctrl csi if it failed") reduced
> the error occurrences, but the error persisted during the initial
> module load. This patch ensures the command isn't executed on versions
> older than 2.0, and it also eliminates the skip implementation because
> NVME_ID_CNS_CS_CTRL is expected to succeed with version 2.0.

NVMe TP's are allowed to be implemented by versions lower than the
release that first included it. I recall the first nvme controller I'd
seen that implemented this identification reported itself as 1.4.

