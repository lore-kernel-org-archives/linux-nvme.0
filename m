Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D7FC77B7F
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 11:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=giRbGlJ7BtkMEI2nBL5riFwP8VXDM1hYxyICWNGQcyM=; b=IDlLbTG6ugw7DqB0RWGinDhQjH
	13drn3nHo2glbwe3WDZ+e1q1v+ZFhTQpr5R9yq4EipGJ60oAesHsYgMeHUz8FsUk/zASzBsPbyPdl
	sAbArpaXp6OzfHQPQC9MYqgSgPCqKCuCkyoxsOIDu4xXQ00erxo7062RixHoKFO238sClcMSxHpRe
	1iQbmWcBXtyS1vbL/jdtVcoNt/f6cwxN4J/W3ayw/n/Gf4UJ2CDC9pmHmK2iScnNeG6wktcTjOhea
	/b4JBrvegsqK3UZ1ajSGJXWAX60EbHLv6uGVUzelsFvfH7t1Jv0T2MW93wiV+OIQBGVMkOzQR8QGF
	mYtgrGcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puAEn-004Kcw-0h;
	Wed, 03 May 2023 11:01:33 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puAEl-004KbT-0r
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 11:01:32 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 57D2E2026F;
	Wed,  3 May 2023 11:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683111685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=giRbGlJ7BtkMEI2nBL5riFwP8VXDM1hYxyICWNGQcyM=;
	b=SC5qFogIbsLugdAIrv4hGxyeN3T2YqLS9zASugfAgtpyJ01F/oTNgVLMtcpsHotcQVyxk5
	x9l95/yUuejIdovQRC0wLRjr1kxdiUE/VGbq8N2wE9xXP0bv1TZSdpg8yS9NfJDyFZ1fIQ
	ZT4+dRTJx8AJF0FUADr9BaIJp3z1AH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683111685;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=giRbGlJ7BtkMEI2nBL5riFwP8VXDM1hYxyICWNGQcyM=;
	b=joH9aa7l4k8xl5k6sZVzBoaCUNoVdvP2ciAkdZMazpiVVakMp+sWyzJ5HW6JTH3kfEu/Sx
	W3OuEb/Qft3nOpCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4703B13584;
	Wed,  3 May 2023 11:01:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id d3ouEQU/UmRCSgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 03 May 2023 11:01:25 +0000
Date: Wed, 3 May 2023 13:01:24 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 09/12] common/fio: Limit number of random jobs
Message-ID: <2ercejt6r2qjkbpaoueh66nred4ooqb5wskx5m3xn2slb5kasw@zwssje3pm4mu>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-10-dwagner@suse.de>
 <99a6cc5f-31b2-787c-f448-53239a351ddd@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99a6cc5f-31b2-787c-f448-53239a351ddd@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_040131_454157_F02671DB 
X-CRM114-Status: GOOD (  16.72  )
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

On Wed, May 03, 2023 at 09:41:37AM +0000, Chaitanya Kulkarni wrote:
> On 5/3/23 01:02, Daniel Wagner wrote:
> > Limit the number of random threads to 32 for big machines. This still
> > gives enough randomness but limits the resource usage.
> >
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > ---
> 
> I don't think we should change this, the point of all the tests is
> to not limit the resources but use threads at least equal to
> $(nproc), see recent patches from lenovo they have 448 cores,
> limiting 32 is < 10% CPUs and that is really small number for
> a large machine if we decide to run tests on that machine ...

I just wonder how handle the limits for the job size. Hannes asked to limit it
to 32 CPUs so that the job size doesn't get small, e.g. nvme_img_size=16M job
size per job with 448 CPUs is roughly 36kB. Is this good, bad or does it even
make sense? I don't know.

My question is what should the policy be? Should we reject configuration which
try to run too small jobs sizes? Reject anything below 1M for example? Or is
there a metric which we could as base for a limit calculation (disk geometry)?

