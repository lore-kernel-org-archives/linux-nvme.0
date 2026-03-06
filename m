Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAE7FCB619
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Mar 2026 16:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wGHWWTLDDQmRCds/h045QrF0Wfv4NxOu2mD/ZnVQFzM=; b=E/oDwZzGjtSiYpbUPt4BoIDqmP
	pDL1sG7iHy17rHPmTbROgrrkPj94fGR3RtBFST6xUeZg6At3XZ+7paJRQPm7UVpr10msI6lEWHnrA
	SDsuOrV1sNaxHsd9/k4iJPydkczHAyNyYP4skZzvppuFx98HgiG7kdi99xqMGI8U/E0TVRdJ95HCx
	OhEt3nLLEoJLFFgNEXdG85GLEfuSwdEHL2ZEXGZ1ibeNBjLhDRp9FB/m7nx+k5wrSM58kLDtda6yE
	5yxoxPLy8CFldyhzH9q8+mCjjODTNgWmJcHpBfPS7V0SJgaAAPGDZGsvRbXE8FAWK1CJXK8oAR9AG
	L0m2Fu7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyXdE-000000046ln-2UtJ;
	Fri, 06 Mar 2026 16:02:28 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyXdD-000000046lf-06uj
	for linux-nvme@lists.infradead.org;
	Fri, 06 Mar 2026 16:02:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1BD9260053;
	Fri,  6 Mar 2026 16:02:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C53C2BCAF;
	Fri,  6 Mar 2026 16:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772812945;
	bh=4ubdWUKI2IH47oyR4Plt1bXTkvreDY844SkPqywtmKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MIk8prkaJzIMpZfQxoBS+7MPtOuVfkGCN0Ybs40xe8J0GpHJZr9U81Sl/72Dq/HxQ
	 ForKivozYVik7RzQgtKjtqIjzeTlORarARxFlt21SQuNLa8ut0XGkRWa3Xfzuiu4e9
	 t+LCpRW7Tp8FM79dqYr6aEDrV7EsBlJvhCPQOWpTzJZDLJiDFCHnEx84fm+bg6qIAR
	 crlgq2qGosxactqqAmf47CP3PU0AILQTTVRu5zeZRw8Qfe4mazHpdeWCPZaQ1Gb3FA
	 1DotVIXGpdbUtdJux4kBpTsEmTb2HGw9srZB343SqYRVbgwqocSmwkKbMoG9NrlgmJ
	 ygBuYxMJyVIVg==
Date: Fri, 6 Mar 2026 09:02:23 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, hare@suse.de, dwagner@suse.de,
	wenxiong@linux.ibm.com, gjoyce@ibm.com
Subject: Re: [PATCHv3 0/7] nvme: export additional diagnostic counters via
 sysfs
Message-ID: <aar6j8S1O-mjqqxN@kbusch-mbp>
References: <20260220175024.292898-1-nilay@linux.ibm.com>
 <92f27319-649b-4957-9de7-619d76faa1ce@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92f27319-649b-4957-9de7-619d76faa1ce@linux.ibm.com>
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

On Wed, Mar 04, 2026 at 08:03:02PM +0530, Nilay Shroff wrote:
> Hi Keith,
> 
> A gentle ping on this. I´ve incorporated the review comments,
> and the series has already received Reviewed-by and Tested-by tags.
> 
> Could you please consider pulling it? Also, please let me know if
> you have any further comments or if additional changes are needed.

Thanks, I was hoping free time would show up to let me look closer at
this, but that doesn't appear to be happening, so looks like I have to
force the time :)

We always need to be a bit cautious on adding user visible attributes,
so just throwing out some thoughts on this feature.

The event counters are not atomic. I know these are informational, so
maybe it's not important to be 100% accurate in the reporting, but I
don't know. Maybe you do want accuracy in which case using atomic_long_t
might be the right type. I think that should be okay to use since none
of these counters are in the normal fast path.

The names of the attributes are a bit inconsistent. Some have a "_count"
suffix, some have "_events" suffix, and some have no suffix at all.

In order to keep sysfs a bit cleaner, should we consider moving these
attributes under a sub-directory specifically for reporting event
counters?

Last thought, as you are probably aware, John Garry is proposing to
lift the nvme multipath into a generic library, which suggests many of
these events would also need to be generic. Should some of these, like
error and retry counts, be appended to the generic disk stats instead?

