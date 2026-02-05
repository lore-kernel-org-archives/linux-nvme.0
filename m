Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FA2ECD981
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Feb 2026 15:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=maBt/weT8xd/WMfC6J5vpq71Vbylf1C39LyoRb2Ah1o=; b=cAJnkMm6bAQ+Epwp7qQTgZvHCP
	7WfZIFyA3UBFaeQnPR4kA9EFTdceqOeUhMpIJjZQZQNaOp1kBIdWMtnHpAaL2qQI4F42K1tbPQUD0
	f3K6a/kWf8cVk8i/pzZCQXrndKGK7mrQTLpgRFXHzW3rXucdJM/SZ3ZjKCGvIELIzwkiDuwYB5PGz
	Tukw2WMENUK7gZzVkG3vtU/SlzBIKXCr9htM4/ADYBZ7M3RQan9FystwdGf6jgcYK6KuGmNAfQhtF
	F5/r+UFoVBaxmGxzft2GI+HPID2TlG52lA45Ibnfk/vTMDWGmN4xhDQ8LNKWJSR4DSaRTczQi+Eg7
	faa+a0bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vo1bq-0000000AAYr-37JI;
	Thu, 05 Feb 2026 15:49:34 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vo1bq-0000000AAYT-0BeN
	for linux-nvme@bombadil.infradead.org;
	Thu, 05 Feb 2026 15:49:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=maBt/weT8xd/WMfC6J5vpq71Vbylf1C39LyoRb2Ah1o=; b=EEzfNRWe5QINEBcKbOffoAZfrH
	VimXt7IWzyifgvFbmcm21EUdqIfkDPEHFtYG3Es9MdLVJT8UFKRgQ55H3Ld2JO5yBff+dHTA916Ul
	KIQgr4O7dVkHt7UPYNKd8dQUIDKxa/LZs8tOebfS/NuSonrS+u+tPoXGv+JUA0mvw76kZdE4+DheT
	0XTSdTGsymMge4IMIlCfo9DzTiah0FnqTroluvgphTITBSz1PeQQMzJkapmN4QDbCKpGF8f3f9KyJ
	xgp5KpyFOnnqsHDMTa4v1WvIAEDM5E8HeugBVcOmYVyvxc4Ln4VNX9XhZGqxFU6kpA/XAmsG2Bqcv
	xIg9ccFw==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vo1bm-00000002R1L-3HDG
	for linux-nvme@lists.infradead.org;
	Thu, 05 Feb 2026 15:49:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EE19568D09; Thu,  5 Feb 2026 16:49:22 +0100 (CET)
Date: Thu, 5 Feb 2026 16:49:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	hch@lst.de, linux-block@vger.kernel.org
Subject: Re: [GIT PULL] nvme fixes for 6.19, final
Message-ID: <20260205154922.GA28226@lst.de>
References: <aYS5ZlwruxpNCdTL@kbusch-mbp> <d114450b-2405-4ed0-bcda-03e08f48ba1d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d114450b-2405-4ed0-bcda-03e08f48ba1d@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260205_154930_925887_0B57946F 
X-CRM114-Status: GOOD (  10.60  )
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

On Thu, Feb 05, 2026 at 08:47:48AM -0700, Jens Axboe wrote:
> After this one, iod in nvme_pci_prp_iter_next() is now unused, which
> will trigger a compiler warning...

Must be compiler dependent, because it does not for me.  But yeah,
it should go away.


