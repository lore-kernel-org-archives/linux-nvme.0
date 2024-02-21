Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24582C48BF6
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Feb 2024 07:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d4RBk4EdC5VO3NbmM+NYJfJSgp1rireslQHqicwu9Kg=; b=pAEZAQLz3fOtOiY/lbX4zzv9he
	Mag3e8GZ5R4HrsQDIITncc7qC7IZzyfSlfyg4ndoJGGMk+LqAiToBi9R1Bx9GwpPJenQQeWPcRECY
	xtDB8o4PVgVf/Yqkj7hWNKk8fyh4y3WQx+ZSIHhWpkoE6oTlMlARFLjAef7FtvjDTexp6iZ+OHAIt
	Us/x50G2saEOCyNGcYSaqUCxJK69KFGzQTZfMejMtXoTuMrjbQLsCHnX8UCfGy/SbpLcRka85yyYO
	D3YwYW6Ce5xAPXVdLaGM/Xoe+a7FnNr+VMtcp0ymKwkgFAtMzAkz0cupEcy1/mVIx4h3MaKFqeah0
	JabutvEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rchAv-0000000HWUt-2RBM;
	Wed, 21 Feb 2024 07:37:53 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rchAq-0000000HWRI-367Z
	for linux-nvme@lists.infradead.org;
	Wed, 21 Feb 2024 07:37:52 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED70E1FB45;
	Wed, 21 Feb 2024 07:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708501065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d4RBk4EdC5VO3NbmM+NYJfJSgp1rireslQHqicwu9Kg=;
	b=h5gq9O5bTVnLpAceRrP5rg47UegDl3Zgddg+Tvgh99FrxoGcMWsTRdWzRdu7hiiDNLGmN6
	MiCASgElC+YJDFg56G3t8fV3mwBPktbl/+NsKCdUNDMxgIEaOUIrZ5f2nqlPExzcRFqcJc
	NT9jSMRrQuX/vTj2AdmnhjYFJrYiZyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708501065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d4RBk4EdC5VO3NbmM+NYJfJSgp1rireslQHqicwu9Kg=;
	b=CEtx7bJ6UUcyY5cKfjsS6CW9/cYo813lAsXauFE9jNGV+XAwZOL+03BrszrzkVT2P+K+tS
	Wlck+jBUvYW3CwDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708501064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d4RBk4EdC5VO3NbmM+NYJfJSgp1rireslQHqicwu9Kg=;
	b=V7yKBsAwPex/8AHmLXUtdYkGceqJ1FTrVyBIHc8CVfdAw7sVoudZD2Hly1NpmcqX6iB7cC
	PnfDwrk2yXnS1H993VC0MSFmoPhEURM6FskwLtgfj7e6jPy9BgwvYhaQYOsRYutypcQmA1
	7RdD/mTJqKWzIj54bP5F+7OJ1Ru4EII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708501064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d4RBk4EdC5VO3NbmM+NYJfJSgp1rireslQHqicwu9Kg=;
	b=JBVTCLS60cWqjYp+F6fXV2EN9XH4ssTbAxjmjhEMT9JCc/q5ivpKdOFqV02OXvrBu0T8aa
	fr7iXy4+ayWK6dDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D997D13A25;
	Wed, 21 Feb 2024 07:37:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id C3l5M0io1WXZbwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 21 Feb 2024 07:37:44 +0000
Date: Wed, 21 Feb 2024 08:37:44 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	Keith Busch <kbusch@kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: Re: [PATCH blktests v0] nvme/029: reserve hugepages for lager
 allocations
Message-ID: <eo2iqix7vzrjgjs6bhx44s3rxblxorc4za62rrzaw5hqb5xqlh@uad7uc4lx35z>
References: <20240220081327.2678-1-dwagner@suse.de>
 <6xxslyeuaetammpqcsekkmzmuz5vmtscrhczi6inwoj2ne52se@mh2zrp6kxgiv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6xxslyeuaetammpqcsekkmzmuz5vmtscrhczi6inwoj2ne52se@mh2zrp6kxgiv>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=V7yKBsAw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JBVTCLS6
X-Spamd-Result: default: False [-0.69 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.88)[85.78%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: ED70E1FB45
X-Spamd-Bar: /
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240220_233748_965086_B5378685 
X-CRM114-Status: GOOD (  15.89  )
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

On Wed, Feb 21, 2024 at 06:22:29AM +0000, Shinichiro Kawasaki wrote:
> I found this changes makes the test case fail when the kernel does not have
> CONFIG_HUGETLBFS. Without the config, /proc/sys/vm/nr_hugepages does not
> exist.
> 
> When CONFIG_HUGETLBFS is not defined, should we skip this test case?

Obviously, we should aim for really solid test cases. Though it is not
guaranteed that the test will pass even with CONFIG_HUGETLBS enabled. I
suspect we would need to make some more preparation steps that the
allocation has a high change to pass. Though I haven't really looked
into what the necessary steps would be. The sysfs exposes a few more
knobs to play with.

> If this is
> the case, we can add "_have_kernel_option HUGETLBFS" in requires(). If not, we
> should check existence of /proc/sys/vm/nr_hugepages before touching it, like:
> 
>        if [[ -r /proc/sys/vm/nr_hugepages &&
>                      "$(cat /proc/sys/vm/nr_hugepages)" -eq 0 ]]; then

Sure, I'll add this and also fix the typos in the commit message.

> 
> Also I suggest to add in-line comment to help understanding why nr_hugepages
> sysfs needs change. Something like,
> 
> # nvme-cli may fail to allocate linear memory for rather large IO buffers.
> # Increase nr_hugepages to allow nvme-cli to try the linear memory allocation
> # from HugeTLB pool.

Ok.

