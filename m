Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56376C001E0
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Aug 2023 14:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GOj5vqEBCGVZTE/uLdUG8o3NQamjXmeqO4V0Lf5FTJk=; b=nhV13j8hV83c1nwqqUf7yWqQkN
	92HzXxVl8FDxheAl57IOZ2hpezsJwYJrOxgBjuwl202V8yfOqPK7apDN2IeftcdpmuilhO+fo13TN
	bOX5ydiqmkVJyXSpIvqwnUgvGT3r5VhYA2rzmqZRW/oE3AZ4Ua0BjNKRooJxpanlG+jGm42t2NEdK
	qx/PHBC3EUsho6NMZNsPWXKo1rWiotGY80RYdI1fzQc/g4lydD9e+oCT8/HUhZqvACvT17c36igw2
	ZctTZf1c/tSWZfcHIxUTuuxiaoneeDYInzyjc2oYFBplTE1LO64ZaprwWILBz7ubbL9KzVzA93BKN
	5GpuDxNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWHI3-004LLy-2S;
	Wed, 16 Aug 2023 14:14:27 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWHI1-004LKz-1l
	for linux-nvme@lists.infradead.org;
	Wed, 16 Aug 2023 14:14:26 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 153052193C;
	Wed, 16 Aug 2023 14:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692195263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GOj5vqEBCGVZTE/uLdUG8o3NQamjXmeqO4V0Lf5FTJk=;
	b=EKSsnfF2FPVjmROp8oATkXTVc0l16M3HUuAu1h6bMO5mF0FH4Wz9kQTRiK8/bpaVjAXYXR
	5ZBJUNCNhYXlENTuomJbJwTP4kOsvZ0IBaj5x9mC1ZcHUV+YXr9AHl7UQu9GHF371sSXEL
	Ivc99UoomzFFceAws6whxW/VjagHFlk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692195263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GOj5vqEBCGVZTE/uLdUG8o3NQamjXmeqO4V0Lf5FTJk=;
	b=qHz2GP4WnHaU/T42nb4r6cchR1nkB7AnxIJWdlabuADd/oMzUCDRNMPB0wvX4tCtpuSepL
	e0ect8DVZfYgXDCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 05A7E133F2;
	Wed, 16 Aug 2023 14:14:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id AkxaAb/Z3GRmcQAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 16 Aug 2023 14:14:23 +0000
Date: Wed, 16 Aug 2023 16:14:32 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Yi Zhang <yi.zhang@redhat.com>, 
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests] nvme/rc: fix nvme device readiness check after
 _nvme_connect_subsys
Message-ID: <bwprzz5jxwrsnfycw5hh3wvyke3rnpzt3cozeddmfabbv2eubj@uk25btx723lb>
References: <20230811012334.3392220-1-shinichiro.kawasaki@wdc.com>
 <6x55ggt7k2kjgd6lr6ykubwmo2qfilz3k32ywfuun2zhat2p5v@7aohs7kgb23x>
 <dsb7kr6wzpebiruz3uqrl2mfhahsv4pgmvojeaeshn4to6csrj@iape74ngcwg2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dsb7kr6wzpebiruz3uqrl2mfhahsv4pgmvojeaeshn4to6csrj@iape74ngcwg2>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230816_071425_729091_36E74201 
X-CRM114-Status: GOOD (  28.38  )
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

On Wed, Aug 16, 2023 at 12:04:24PM +0000, Shinichiro Kawasaki wrote:
> > Not sure if this going to work for the passthru case as intended.
> 
> IMO, the check above is not for the passthru case. The function
> _nvmet_passthru_target_connect() has the code below:
> 
> 	while [ ! -b "${nsdev}" ]; do sleep 1; done
> 
> This checks readiness of the device for the passthru case.

I am worried about the case that in _nvmet_passthru_target_connect we
call first _nvme_connet_subsys and then we do also the above loop.

> For that case, the check in _nvmet_passthru_target_connect() ensures
> readiness of the passthru device. The drawback is that the check for
> namespace 1 consumes 1 second for nothing.

And this is something we should not do on purpose, IMO.

> > Thinking about it, shouldn't we log that we couldn't find the
> > device/uuid/wwid at the end of the loop?
> 
> Not sure. For the non-passthru case, it will be helpful. But for passthru case,
> check result log for namespace 1 can be confusing.
> 
> I can think of two other fix approaches below, but they did not look better than
> this patch for me. What do you think?
> 
> 1) Go back to the fix approach to add another _find_nvme_dev() in nvme/047.
>    I worried this will leave the chance that we will fall into the same issue
>    when we will add a new test case with multiple _nvme_connect_subsys
>    calls.

I'd rather not go down this route. Ideally, the infrastructure code does
the right thing and we don't have to deal in each test case with this
problem.

> 2) Rework _find_nvme_dev into two new functions _find_nvme_ctrl_dev and
>    _find_nvme_ns_dev, and do the readiness check in _find_nvme_ns_dev.
>    IMO, this confusion comes from the fact that _find_nvme_dev returns control
>    device, but some test cases use it to operate namespaces by adding "n1" to
>    the control device name. If a test case uses namespace device, it's the
>    better to call _find_nvme_ns_dev. But I worry this approach may be too much.

As we already have an argument parser in _nvme_connect_subsys, we could
also introduce a new option which allows to select the wait type. With
this _nvmet_passtrhu_target_connect could be something like

_nvmet_passthru_target_connect() {
        [...]

        _nvme_connect_subsys "${trtype}" "${subsys_name}" \
                --wait-for=device || return

        [...]
}

and for the rest of the test cases we just set the default for
--wait-for to ns.

