Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D55CD1294
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 09:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uj3ZK2qaxJqUha5DMBX9muFYXtessbM4SY4bEyWSKQg=; b=ooEcaI1OkxyNvKP+zD7hN7XCoC
	1IXXR6AFr80cmoqdj222crFAJPuuPpdNM5/ZtpgVWOXUZ+GgKft1IH4wOL4xZwHuBPECp2TQpOWug
	WSv1CkZ0DPp21AZD0eIOPgEajVZVic8ikJ7QR/sLHq6U9pqHiS1r2shzSdUNBgqHg98S/vSqe/lo7
	Lw2xqlkurhjWqgueq32lsO7l2hr9vGU0x4s84wz5qz88/xLkU3n+koONb+1mdJY4uFUjB4i9t7Vqc
	Vm/lqnsRR3Cb1F9GyzqEeIjfXmt2p3whA4dQeFskOXf9jKjL+nlTjafV5nIoE4H3OFUiOLOZ2KWwp
	nt9nxGzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrwTi-0000000F54a-1SPx;
	Wed, 03 Apr 2024 09:00:18 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrwTc-0000000F50J-2Yh4
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 09:00:16 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 729412174C;
	Wed,  3 Apr 2024 09:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712134805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uj3ZK2qaxJqUha5DMBX9muFYXtessbM4SY4bEyWSKQg=;
	b=vdolQ4xJ22KQ7clven2QzFmbxIDVJ6VveNv/xS50wribLM/fbRoLkJwlAaLzT7dVax8DvI
	QU9/3AuK9I6ETcy9npCl6KWx38zNhdrnq9+yJ43CjTOR9l7SeMljEXq8/7MITJfq3qtVV1
	KeIUkgrlYfbRdG5ahrYcwXIwCIfWKaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712134805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uj3ZK2qaxJqUha5DMBX9muFYXtessbM4SY4bEyWSKQg=;
	b=LoAsumvZF6I0mqjmvWYQpvK7uvYtbBrQgaEbL3Yw5ufKUNtgHqo3xLqGS8tT+TqlpkjeCO
	HGpbshXmxMCJS1Dw==
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FE5A13357;
	Wed,  3 Apr 2024 09:00:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id +nC+FZUaDWYebgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 03 Apr 2024 09:00:05 +0000
Date: Wed, 3 Apr 2024 11:00:04 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v1 0/3] add blkdev type environment variable
Message-ID: <j6awxljufwg6r5rs5kojwsnatfb4aj3vnqsq43hkuuhgvcflvh@u6l5cf2ponaw>
References: <20240402100322.17673-1-dwagner@suse.de>
 <mqpuf2a7obybtw42ydte2wq7ktema5odvc3dqm32hknjmamgdb@rbo3i6lqqkld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mqpuf2a7obybtw42ydte2wq7ktema5odvc3dqm32hknjmamgdb@rbo3i6lqqkld>
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_020012_970076_40C50778 
X-CRM114-Status: GOOD (  24.63  )
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

Hi Shinichiro,

On Wed, Apr 03, 2024 at 04:54:28AM +0000, Shinichiro Kawasaki wrote:
> On the other hand, I see that the series has a couple of drawbacks:
> 
> 1) When blktests users run with the default knob only, the test coverage will be
>    smaller. To keep the current test coverage, the users need to run the check
>    script twice: nvmet_blkdev_type=file and nvmet_blkdev_type=device. Some users
>    may not do it and lose the test coverage. And some users, e.g., CKI project,
>    need to adjust their script for this change.
> 
> 2) When the users run the check script twice to keep the test coverage, some
>    test cases are executed twice under the exact same test conditions. This
>    will waste some of the test run effort.

Yes, I agree. These drawbacks should be addressed somehow.

> To avoid the drawbacks, how about this?
> 
> - Do not provide nvmet_blkdev_type as a knob for users. Keep it as just a global
>   variable in tests/nvme/rc. (It should be renamed to clarify that it is not for
>   users.)
> 
> - Introduce a helper function to do the same test twice for nvmet_blkdev_type=
>   file and nvmet_blkdev_type=device. Call this helper function from a single
>   test case to cover both the blkdev types.
> 
> I attach a patch at the end of this email to show the ideas above. It applies
> the idea to nvme/006 as an example. What do you think?

Ideally we don't have to introduce additional common setup logic into
each test. Also for debugging purpose it might sense to run a test only
in one configuration. So it might make sense still to have user visible
environment variable

  nvmet_blkdev_types="file device"

as default.

> -test() {
> -	echo "Running ${TEST_NAME}"
> -
> +do_test() {
>  	_setup_nvmet
>  
>  	_nvmet_target_setup
>  
>  	_nvmet_target_cleanup
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	_nvmet_run_for_each_blkdev_type do_test

I was wondering if the nvmet_run_for_each_blkdev_type logic could be in
common code, so we don't have to add a do_test function. Basically
having a common code for a bunch of configuration variables (matrix
tests). This could also be useful for nvmet_trtype etc.

The generic setup could be requested via the require hook.

requires() = {

 _nvmet_setup_target
}

What do you think about this idea?

Thanks,
Daniel

