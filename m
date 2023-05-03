Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDDCC7EE22
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 09:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wuc1vTQ8wQRR6tjkgMtetfqYzZutfpJcCtXQCNyxPaE=; b=wLweMevJwkJWnmVqOsc88HlkYD
	trjBMZunnTMUoY1WNwJ3ws/a5/UhcKfk/FV6zy80Ssds5PWxTfb4XHzu3gbcfyFpamHxeIEsW2tke
	EYGv1M9wR/E+ioA8aFVPtnuVofH4vyTsP5K2F1PBCCG5jJ768qv02Se2g0btM9hu+cKnJ2yA0nOp5
	GCt3sxyptc8a802/uhcEb/siIU531KGQikOB4S9bO01GpeXLX/KHWInTkeocXfvpXEGlEDnjFMI62
	QtcHsRHJXIBX1XJiFQSE7EMpzGk5waRlt1/rNiQdGCLI04g2IHRjjP5c2bM7WcUGRrUptuiqh+D9Q
	qwga4YfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pu90K-0043HJ-1G;
	Wed, 03 May 2023 09:42:32 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pu90H-0043Gk-16
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 09:42:30 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 61AC0201CB;
	Wed,  3 May 2023 09:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683106947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wuc1vTQ8wQRR6tjkgMtetfqYzZutfpJcCtXQCNyxPaE=;
	b=onzzM/v1oyKFB4FXmhHjMFCMfyCMsRPoN8kNryQXhOdlgGhF+7N7l93bcEVNHsoDxefF9t
	7lhSxjb+agVtwS0b+PBPmQNxbun2z2IzZu4y1LvLwHFf9qf8TW0n6sfpcUE+WtyTSMNG+G
	gs6QJhk4Grrkztl4tS0n8NiLwWIl1Q0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683106947;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wuc1vTQ8wQRR6tjkgMtetfqYzZutfpJcCtXQCNyxPaE=;
	b=BlObSjVxACe5A1daCOXZ1F33pExCCXIO/Pa5F8XFQ6vTAq64KzieqEx9wywLowDfSiLzW+
	c8gKFw4Fjt5kW/Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53B021331F;
	Wed,  3 May 2023 09:42:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id hEARFIMsUmSaHAAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 03 May 2023 09:42:27 +0000
Date: Wed, 3 May 2023 11:42:26 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 04/12] common/xfs: Limit fio size job to fit
 into xfs fs
Message-ID: <qv4br55wggqf46jomv7r7ern6e6s7kprqh65wtqvmcnvrlqvl2@kahiiqhulyan>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-5-dwagner@suse.de>
 <74e9c631-23cd-705c-7043-88f345598ad1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74e9c631-23cd-705c-7043-88f345598ad1@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_024229_528866_9C7B2D5E 
X-CRM114-Status: GOOD (  24.77  )
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

On Wed, May 03, 2023 at 09:29:04AM +0000, Chaitanya Kulkarni wrote:
> On 5/3/23 01:02, Daniel Wagner wrote:
> > The usable capacity of the filesystem is less than the raw
> > partition/device size due to the additional meta/log data.
> >
> > Ensure that the job size for fio is not exceeding the limits.
> >
> > Because we have hard coded the path where we mount the filesystem
> > and don't want to expose this, we just update max size inside
> > _xfs_run_fio_verify_io(). No need to leak this into the caller.
> >
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > ---
> >   common/xfs | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/common/xfs b/common/xfs
> > index 413c2820ffaf..37ce85878df2 100644
> > --- a/common/xfs
> > +++ b/common/xfs
> > @@ -37,6 +37,9 @@ _xfs_run_fio_verify_io() {
> >   		sz_mb="${avail_mb}"
> >   	else
> >   		sz_mb="$(convert_to_mb "${sz}")"
> > +		if [[ "${sz_mb}" -gt "${avail_mb}" ]]; then
> > +			sz_mb="${avail_mb}"
> > +		fi
> >   	fi
> >   
> >   	_run_fio_verify_io --size="${sz_mb}m" --directory="${mount_dir}/"
> 
> 
> this is exactly how it should to start with, the only
> is now we are silently reducing the fio job size maybe that is okay ?
> 
> or we should error out here instead of being smart ?

The problem I try to solve here is that on the caller side (nvme/035) we don't
know yet the usable filesystem size. We only the size of the nvme_img_size.

If we want to move this logic to the caller side we need split
_xfs_run_fio_verify_io() into steps. The first step which creates the fileystem
and the second one which runs fio.

I don't know if this is worth doing it though.

