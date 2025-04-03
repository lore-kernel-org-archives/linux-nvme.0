Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46552C3600C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 15:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7Paev1UznFISPdf7f3oQhQF6ucKiRzrhD7pWESqJzkE=; b=E9rjyr9Jjn3TlyyKnwG6WVdRQO
	y3CQ2tuLR2OzdZqyPNdFVUqdUnJGCJyPYdjgGYexEQVpu9HgI6MVXYU2YkYmlKsLdq9/Tv0bVAJVT
	EZVCQvAyj3EIDgqyNLhVLavWbMQnftGaSEGh+XHdhBvxKGD6YLiakzQO1jIO/XrLtec/H75dxMgEE
	iYiR1K5wVoNFKcMo2fRphRbhAjIP9syEkkuv5LjVX6oQPn4ruUMdXUeaQiProAWtJh/ZDNdodUWPH
	MLzpP4iFqOJruURQDEr8uK8Ryd9qyypOvAQaPHqASM3nMIup6PABT3l+1dWahMhrK4RJlSvpvIJ2i
	FsYEufYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0Mds-00000009FhA-2Lcr;
	Thu, 03 Apr 2025 15:38:08 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0MdZ-00000009Feo-1ABj
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 15:37:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BAC9F5C621C;
	Thu,  3 Apr 2025 15:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37449C4CEE3;
	Thu,  3 Apr 2025 15:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743694668;
	bh=9ZQNI4mqXE9vOVnXPFO4dyQGGBEqrf0Xx1uyjbvSvNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=syaNVHiFrXWGM2YIRBQSwHWPQx6qx20w0/5fTu1FJ4lEn3L4HfiJW5PfQ+JlZFfWT
	 M7XW0JyrzYPgTnWHinmrfHhmkr0b2hAQ4blF65EI/337dDlLLtVgySa+W6bGr2lVEa
	 HNoyUVRVwu4+qXgQ/EO1h6lxT5oPbL0fNR/9o1q+c/6MB95RxUtCHbgc0vMzbRZi8u
	 wNkPGeah7RcAlt2oskFDekyiP0F99Sre3O2Q1tdzwm/2Tr7wjNcwwD7nBVpq6XpxNr
	 LuDFbUEPCgObEh97qV3r8dqwG5tMyOlvYbDHReEl3LisTe3UPSY9ClTDTJxnC37t/m
	 F/wQg+Ssf3hdA==
Date: Thu, 3 Apr 2025 09:37:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme: re-read ANA log page after ns scan completes
Message-ID: <Z-6rSkBZ5g9FiTXq@kbusch-mbp>
References: <20250403071930.52154-1-hare@kernel.org>
 <20250403071930.52154-3-hare@kernel.org>
 <Z-6haRYmf7PMn3vW@kbusch-mbp>
 <c304f189-cc59-4ae3-b42a-282eb74f02cf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c304f189-cc59-4ae3-b42a-282eb74f02cf@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_083749_359692_B350CAF9 
X-CRM114-Status: GOOD (  16.50  )
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

On Thu, Apr 03, 2025 at 05:32:59PM +0200, Hannes Reinecke wrote:
> On 4/3/25 16:55, Keith Busch wrote:
> > On Thu, Apr 03, 2025 at 09:19:30AM +0200, Hannes Reinecke wrote:
> > > When scanning for new namespaces we might have missed an ANA AEN,
> > > so we should always re-read the ANA log page after scanning to ensure
> > > we don't miss updates there.
> > 
> > Worst case we might check a log page that hasn't changed. Rescans should
> > be rare, so I guess it's fine. But I'm not sure why scanning might cause
> > an ANA AEN to be missed. ?
> Well, it's not that we're _missing_ AENs here.
> As per quoted spec ANA change events are not sent if there had been
> an event (on the controller) which would have caused both an ANA change
> event and an NS changed AEN to be sent.
> 
> So any NS changed event really needs to be treated as a combination of
> NS changed _and_ ANA changed, and after each namespace rescan we need
> to re-read the ANA log page.

Oh, good call. I forgot about that text.

