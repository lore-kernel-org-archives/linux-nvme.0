Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF00FC77B75
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Apr 2023 06:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3hdtJCdV4hUpc6gHqFh0/2IfdOW4eHyRTAp7Qb3jl5k=; b=m12Ug+jkHudDHdGj1gOyPXm7Bp
	9Ku1oKOgfGvLUqYLynfjcWzoprGVJygzV7FzOH51/n40yWLiMgnERsFNX2VH71qnT77L1/qeu/DDP
	jEOhdH8kAskJjcz+dopixILxL2+eFHW8NbHzw30gm6Oi6okR5km/+WUzCTDbGj9iPUqNL6hMBn7Vh
	3+w8qjohmqspYjqWVoIyGDtQH+pyeQc5WGMPpV2nHvogBOuSEBrVQpRaVP89ZOrZpLvUjxW33c3Ev
	/b6TIJgUAvsJmpfSKU6UdcxDPDmSbJGrqGWo2ZUX0osi98VRohUEW4rlSrP2qQPdkafaSoBNyR5zQ
	Adv8dAYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppkfP-009t3U-39;
	Fri, 21 Apr 2023 06:54:47 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppkfM-009t35-32
	for linux-nvme@lists.infradead.org;
	Fri, 21 Apr 2023 06:54:46 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1AFA721A32;
	Fri, 21 Apr 2023 06:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1682060083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3hdtJCdV4hUpc6gHqFh0/2IfdOW4eHyRTAp7Qb3jl5k=;
	b=EGV+wfOgweTtILWDEVpszyk0KAX2oVgcuANPxAQv/kPcHsakeWVMVfsRJzSYCHs/S4mef/
	x4wEE8DemnwzYTyzRovVlyvmjvc9VJG/7CosIy1PEateonPzvsF9FjoNLFBm8QAPFfOjBv
	5i6VFSqcQat2+v7K7aVLKtY0MrtIlnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1682060083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3hdtJCdV4hUpc6gHqFh0/2IfdOW4eHyRTAp7Qb3jl5k=;
	b=qsAcG2m6qDbLpy7hyoK8ri5Sv0mekZr93Xmyhn4tln3Oc3L1Zxkras32rPKr8tKS9bqkzX
	vxxXjvxj2fWkKtAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0BC7813456;
	Fri, 21 Apr 2023 06:54:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Uzy1AjMzQmSifAAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 21 Apr 2023 06:54:43 +0000
Date: Fri, 21 Apr 2023 08:54:42 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 3/9] common-xfs: Make size argument
 optional for _xfs_run_fio_verify_io
Message-ID: <s4xicrnevbwapdwvw5wl2z4bpm6vv6q62lcgimy6wcqnbf6tbo@u7alfvt4bmen>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-4-dwagner@suse.de>
 <1089a043-a40c-6b49-f0a0-38ca3bcd8f91@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089a043-a40c-6b49-f0a0-38ca3bcd8f91@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230420_235445_138929_53538F0C 
X-CRM114-Status: GOOD (  19.83  )
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

On Fri, Apr 21, 2023 at 08:27:35AM +0200, Hannes Reinecke wrote:
> On 4/21/23 08:04, Daniel Wagner wrote:
> > Make the size argument optional by reading the filesystem info. The
> > caller doesn't have to guess (or calculate) how big the max IO size.
> > The log data structure of XFS is reducing the capacity.
> > 
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > ---
> >   common/xfs     | 6 ++++++
> >   tests/nvme/012 | 2 +-
> >   tests/nvme/013 | 2 +-
> >   tests/nvme/035 | 2 +-
> >   4 files changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/common/xfs b/common/xfs
> > index 2c5d96164ac1..ec35599e017b 100644
> > --- a/common/xfs
> > +++ b/common/xfs
> > @@ -27,6 +27,12 @@ _xfs_run_fio_verify_io() {
> >   	_xfs_mkfs_and_mount "${bdev}" "${mount_dir}" >> "${FULL}" 2>&1
> > +	if [[ -z "${sz}" ]]; then
> > +		local avail
> > +		avail="$(df --output=avail "${mount_dir}" | awk 'NR==2 {print $1}')"
> 
> df --output=avail "${mount_dir}" | tail -1

Sure, don't think it matters.

> > +		sz="$(printf "%d" $((avail / 1024 - 1 )))m"
> 
> sz=$((avail / 1024 - 1))

I tried this but the devision is likely to return a floating point which fio
doesn't like. Is there a way to tell bash to do a pure integer devision?

