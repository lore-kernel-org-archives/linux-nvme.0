Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828E3C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 11 May 2022 00:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UR8rKkpnpJyWubmNr2BSdEma35BpZzHmAuaFPKXtSVM=; b=vuLifUusK5Vq587Q4Hq1utnytI
	Y7HFzTfEzlkCVzLIAzJ8WUHKkNYLqpx+XsXIdadzejFUW+lnH4cKkfs3aU6w1LBAadxcWWcU6uBDN
	ouw12KmXjarlXREqQSKlPhot4ijEEKT59J0M9b7dQTsg9pDYC4OzukS/qPoHfchnvBMOrBT9gl0iM
	DN9g5gptAsKknqoO/7YL+nBr/RsTtawQvD50p1sYWI2LrSV1jalOWT5Eenbe7uUjFf9SOnJhX4MkG
	5NtiN1XiYkkE8PbH9EXz1mLnT5MrByJU5d4NrWfDzLEGcyteoKxmSeDmeA3KvzrT/JmyHGEXPdlcY
	1l4umfYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noa1B-004U7x-1x; Wed, 11 May 2022 00:15:53 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noa18-004U7V-0Q
 for linux-nvme@lists.infradead.org; Wed, 11 May 2022 00:15:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 81AC3B81DF5;
 Wed, 11 May 2022 00:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B39C385CC;
 Wed, 11 May 2022 00:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652228146;
 bh=hYy9/T8alTMFblsqWXwOqr8PM7k5mjb7MEGFn//cibY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZvU5sUx0+s+DpW8YVG8hqk9TjTowwkH/9povmsI08TIJ2uzf4hNNHWB2CHafAviS3
 FfFN7C/0Mg+ic9CQy2ekxgEbsN4mDh6VVkUKvNNMm3xocxocGK28Q7lAVYT7jNAjZZ
 dVQsVRZKEbeWbYs3bgpzC48MHjXsLFwfuLC0LO51L/ugkANd/qYYk/0E7aGz98jgDL
 dCzTx7lIFK8Er+F2WzPVAGn7A8l8kgUCzN/7FmsaaFYRYeZi7YtNY8sGifRvn9EpPT
 KFh8kVYJXkU5ewPJBgM1WfTXLUDYcjov6klTgGjhHexHOy9GP6ij4NzGKJu6VRabNr
 4yYzn2CylBCKw==
Date: Tue, 10 May 2022 18:15:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@fb.com>, linux-nvme@lists.infradead.org,
 axboe@kernel.dk, hch@lst.de
Subject: Re: [RFC 0/4] partial sector read support
Message-ID: <YnsAL+1BeM4gs3tw@kbusch-mbp.dhcp.thefacebook.com>
References: <20220504163207.891761-1-kbusch@fb.com>
 <c0f8f6f7-f345-7064-da5e-9051ca7cdd03@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0f8f6f7-f345-7064-da5e-9051ca7cdd03@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220510_171550_236408_854B3AEE 
X-CRM114-Status: GOOD (  15.49  )
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

On Tue, May 10, 2022 at 03:41:35PM -0700, Sagi Grimberg wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Don't you just hate that you must read a full sector when you only cared
> > about a few bytes? Well, good news! Standardized protocols provide a way
> > for the host to describe unwanted read data, allowing partial sector
> > access. This lets applications reduce allocated memory that was used to
> > hold the unwanted data, while also reducing link traffic.
> > 
> > This series enables this for the NVMe protocol through direct io. With
> > this, a userspace app can read a single contiguous byte range, subject
> > to hardware DMA constraints. An in-kernel user could theorectically
> > construct a bio to read multiple discontiguous ranges if desired.
> 
> So userspace needs to look for both bb queue flag and dma alignment to
> infer supported range(s)?

If you don't know ahead of time, then yes, userspace will need to query the
attributes. There are existing attributes that inform userspace of unique
hardware capabilities that affect their access: 'dax' and 'zoned' are such
examples that come to mind.

