Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814C0C41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 16:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ac6JQGVOD2RdLWhY6qwXp6LE6p86nLkR6D9PL50b2vw=; b=qmYiLO7kzXDnIOv5kHYRVaEQxJ
	Oi+ihcM0JddRg5x4zlHIdy3XxxhPGMZWDpoOBG8qRXOPThADvKzbt8UphQcCdwAiJrkiW3z6F5wFp
	k+WAeJsL9oz2KpTxlNW/RUFsrDbzIlpzzC/39I6+PBMCww6yOl7w5Q8SPiIt++pv/vgiZVCGjuqPm
	IeXQ5yr/qSc5W2fIwca4mRGZFMFlIbRo1PqvPgdAJiFr1jYMaJhRBDhnVfxh2S/dSuc/VIPsd/YIs
	0pyzFRqS7i33FEi87ykh8Ll133aW07aDM+z/hdPwuLtWzmgVQyjXrlz8yTjF9Pq+2uF/YLzYq2kJS
	3bu4vhew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFckY-00EeaQ-1n;
	Tue, 19 Dec 2023 16:15:18 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFckU-00EeXw-2D
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 16:15:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 5AC4BB816CE;
	Tue, 19 Dec 2023 16:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DABEC433C7;
	Tue, 19 Dec 2023 16:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703002512;
	bh=3f/Rj2ZC5nAEd/nVnTGRLMiDTuXMfeJ5NMzGLKxbr/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UCebW59BZ8cqOlDsFgwVYC5r2KxUocwOKLrMUzfM9p0kuvtFraXnT4HFZ4wGmx7P4
	 196h6Fcdk9FxPi2Ty5qdKjgOjHQEEh7BBgNhxChKmshkBhEAZNlC1v7PBoyVrns5ye
	 0B7o7e8xwQsFVTT0d5I3CbcmrOt+vNGuz9jeRzlrueZSSLwhfvtnCzqB8SBZIy59mG
	 HmQuoyhKy83CRCfwSKRMDXoR6YrbhHzc5E2Gnu6Mpzl+jRKszQP4mgSr/u9gQaGajH
	 G6pFw3LBLBFF1aqVM/yeTfcwKyeo0MolJXToXzrT+wQBdc6cwdG0ks61dgsmRk+R4O
	 39cQJnUG5wbqw==
Date: Tue, 19 Dec 2023 09:15:10 -0700
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, chaitanyak@nvidia.com
Subject: Re: [PATCHv2] nvme-pci: enhance timeout kernel log
Message-ID: <ZYHBjllwmdS8BIjA@kbusch-mbp>
References: <20231218224633.2963811-1-kbusch@meta.com>
 <20231219050108.GA31771@lst.de>
 <b0bb838e-761c-4857-9647-515f50d7ebf0@grimberg.me>
 <2863ba06-747c-401a-85db-2ecbdfc78e04@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2863ba06-747c-401a-85db-2ecbdfc78e04@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_081514_862428_6F10EA9E 
X-CRM114-Status: GOOD (  14.87  )
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

On Tue, Dec 19, 2023 at 06:09:23PM +0200, Max Gurtovoy wrote:
> 
> 
> On 19/12/2023 16:15, Sagi Grimberg wrote:
> > 
> > > > -             "I/O %d QID %d timeout, completion polled\n",
> > > > +             "I/O tag %d QID %d timeout, completion polled\n",
> > > 
> > > Q: should we use the Linux term tag or the NVMe term command ID
> > > (or command_id) ?  I don't really care, just thinking out loud.
> > 
> > I was fine with neither tbh, but tag is better than command_id I
> > think.
> > 
> 
> In the current Keith code it is actually the tag.
> If you would like to print the cid please use: nvme_cid(req).
> 
> I guess the cid will be the useful value that we can compare to the
> wireshark or the target prints.

Yes! This currently prints the "tag" from blk-mq. I can change it to
print the encoded command_id in the SQE. Or both!

