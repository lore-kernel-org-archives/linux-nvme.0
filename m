Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D7DC77B78
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 07:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P7KFfZgfUOGCrZjJOU3dZ6YY+ZZX/Sqbf17UCyuAZPA=; b=Dq30L6/67UH50GdTU1yEbIil0F
	vRQWcDvDDYIPlHyy6lQALElj2WPlJnuyJ+nMgkcdu2OWIG5j+eGqXzs6NSUmDkBxU4x2txAtwimb0
	9jodW4dAfO6V7S1sT4p3cda25JFniaJpi1N5F0BwXFrorXkyrVU9+tLZC4WORbwTlJGkmAAQxDC7g
	S1ujNr8wmMuc8Tl/fzlKwkJau36TkNKsXJ7Z7hFenwhsZJyE0geO/WOESmMVDpn79zYgg9U3tsiIt
	7vjqlkwPir++qf/vLQkyWVLrc9fOzsyQTeDTTYJXpO7vopEhBe2yjE4ZuGf5Sn0TDEYqY7EE+H6jF
	KCCPPFdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pu6w2-003fAJ-2f;
	Wed, 03 May 2023 07:29:58 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pu6vz-003f81-1d
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 07:29:56 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E760223CE;
	Wed,  3 May 2023 07:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683098986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P7KFfZgfUOGCrZjJOU3dZ6YY+ZZX/Sqbf17UCyuAZPA=;
	b=pDL9w7lL01OOZBiHOzlVkR+tqWpgSXZzyxQQU52B08+zukoCgwIlOZtFwYltYfCXR85jr1
	8sl1afPq5eGEAfbCF8R+IjklsQwbtnEJ8JZTAFQ2XEcVRDFfdjzmJfDQMhHR+91u9bp6v7
	MTmqZPrAQvgATsqPC48ucKbcubYeQ8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683098986;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P7KFfZgfUOGCrZjJOU3dZ6YY+ZZX/Sqbf17UCyuAZPA=;
	b=oTuyHFxgFqQu/dkYaNqPqKL156YfwEo6K2Ca0Phs3du/8EOmuY2i5jDFGizBU+yi5R9/rF
	BvcKKMlPYFpXqFBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 706091331F;
	Wed,  3 May 2023 07:29:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 8OZiG2oNUmQ8TwAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 03 May 2023 07:29:46 +0000
Date: Wed, 3 May 2023 09:29:45 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 3/9] common-xfs: Make size argument
 optional for _xfs_run_fio_verify_io
Message-ID: <rjzhz2pa5cjdeeubeo36d7lskhwcyfla6dszrhlwlmlxrek7vl@hsctyaj6ko4f>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-4-dwagner@suse.de>
 <le6qqxhkbdaacsifz4b3mody53gllg4rzhowm2j62y56y56y6k@pmlukhvwjw24>
 <clh6gmnivvi5e4o7pzr3mxfale3vlymgepdntkjtvub4cazyvk@myovldb6bcnx>
 <i426otrfqbck2q5cwgzre52zsiaqviqz4jchszqmvbvgc64cue@a7d3frn6b64x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i426otrfqbck2q5cwgzre52zsiaqviqz4jchszqmvbvgc64cue@a7d3frn6b64x>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_002955_693571_3274CC2D 
X-CRM114-Status: GOOD (  18.50  )
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

On Wed, May 03, 2023 at 04:04:50AM +0000, Shinichiro Kawasaki wrote:
> On May 02, 2023 / 15:23, Daniel Wagner wrote:
> >  > --- a/tests/nvme/035
> > > > +++ b/tests/nvme/035
> > > > @@ -32,7 +32,7 @@ test_device() {
> > > >  	port=$(_nvmet_passthru_target_setup "${subsys}")
> > > >  	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
> > > >  
> > > > -	_xfs_run_fio_verify_io "${nsdev}" "900m"
> > > > +	_xfs_run_fio_verify_io "${nsdev}"
> > > 
> > > On the other hand, this change for nvme/035 does not look good. It runs the
> > > test on TEST_DEV, which may take very long time without TIMEOUT config.
> > 
> > I'll add the nvme_img_size argument here instead (nvme: Make test image size
> > configurable)
> 
> If TEST_DEV has the size same as nvme_img_size, xfs log data will consume some
> part of the TEST_DEV, then _xfs_run_fio_verify_io with nvme_img_size will fail.
> 
> I think the size argument of _xfs_run_fio_verify_io should be,
> 
>    min(size of TEST_DEV, nvm_img_size) - log data size of xfs
> 
> But I'm not sure if we can do this calculation correctly.
> 
> If the calculation is not possible, it would be the better to leave the hard
> coded constants (1GB for TEST_DEV size and 900mb as fio I/O size) in this test
> case, because nvme/035 is rather unique in the nvme group, which uses TEST_DEV.

I've solved this by extending _xfs_run_fio_verify_io() to limit the max size of
the io job:

_xfs_run_fio_verify_io() {
	local mount_dir="/mnt/blktests"
	local bdev=$1
	local sz=$2
	local sz_mb
	local avail
	local avail_mb

	_xfs_mkfs_and_mount "${bdev}" "${mount_dir}" >> "${FULL}" 2>&1

	avail="$(df --output=avail "${mount_dir}" | tail -1)"
	avail_mb="$((avail / 1024))"

	if [[ -z "${sz}" ]]; then
		sz_mb="${avail_mb}"
	else
		sz_mb="$(convert_to_mb "${sz}")"
		if [[ "${sz_mb}" -gt "${avail_mb}" ]]; then
			sz_mb="${avail_mb}"
		fi
	fi

	_run_fio_verify_io --size="${sz_mb}m" --directory="${mount_dir}/"

	umount "${mount_dir}" >> "${FULL}" 2>&1
	rm -fr "${mount_dir}"
}

Anyway, I'll send out the updated series shortly

