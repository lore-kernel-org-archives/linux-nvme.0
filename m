Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA80D13570
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 08:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SoZ+VB/bu/IrZnVLSmDBgNcSodM/sDPVlVEXitmbXkw=; b=I/UNkFZxjvuNyml7OnLAY7MXYZ
	lO2hm3eDcJSBI5kdjHvMcUpT/i9llkX9YkOkXTCohus4db7RDEa1LwRcu1XzO9dCYKS/tVMRzcoKw
	M7bUHbFKTux9scZ7OVv+r6S1kmSt0KrLwKwVLWCCpAKrht7NhbWlRSs6BO+Ukn5G1mIdjv38Wku/+
	30aM9X9UsX9bPReQyTa88WY1MvwoqUBiSGV5OTc9WO3AQwtSzEuSiGM0sTUAvY0wDeTLEBOg9JZ5F
	F2s2bk2N56leY5fr2MThkLvdQpGJ89CYTgWIn6udQbllTXaMj2caFtIPQmRJFFWC+ro8Ivz6cxEYj
	WjQdjsmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5LKL-0000000A7tm-2lT4;
	Mon, 28 Oct 2024 08:42:17 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5LKH-0000000A7s6-2luo
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 08:42:16 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4A06E21A13;
	Mon, 28 Oct 2024 08:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730104930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SoZ+VB/bu/IrZnVLSmDBgNcSodM/sDPVlVEXitmbXkw=;
	b=ooUJmdyx+dTDg7Bm++xRZ96y5LiGJGQCMnDLrmRS5/bvXKQ03v1B6Lb6vt0Tp4gYm6Sj8s
	ANHVj7f3LCjWXWrfwQxyQ/je+cOcbZr0oAVffdFu0zgXW/giTGsaBpuyrAH67REnh0KUOu
	HPUfwrB6w/we0DhtQ5BOA64Hc82rKT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730104930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SoZ+VB/bu/IrZnVLSmDBgNcSodM/sDPVlVEXitmbXkw=;
	b=UlNf7aLto0dUH5lHj9Dcnl/YeBkOBbuoa0H7dYtvT2dcMVQCrlIiufhuv2/IRqtEj0gr/f
	7hy+INXRseW8nRBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730104930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SoZ+VB/bu/IrZnVLSmDBgNcSodM/sDPVlVEXitmbXkw=;
	b=ooUJmdyx+dTDg7Bm++xRZ96y5LiGJGQCMnDLrmRS5/bvXKQ03v1B6Lb6vt0Tp4gYm6Sj8s
	ANHVj7f3LCjWXWrfwQxyQ/je+cOcbZr0oAVffdFu0zgXW/giTGsaBpuyrAH67REnh0KUOu
	HPUfwrB6w/we0DhtQ5BOA64Hc82rKT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730104930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SoZ+VB/bu/IrZnVLSmDBgNcSodM/sDPVlVEXitmbXkw=;
	b=UlNf7aLto0dUH5lHj9Dcnl/YeBkOBbuoa0H7dYtvT2dcMVQCrlIiufhuv2/IRqtEj0gr/f
	7hy+INXRseW8nRBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30471136DC;
	Mon, 28 Oct 2024 08:42:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0IKICWJOH2eoFwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 28 Oct 2024 08:42:10 +0000
Date: Mon, 28 Oct 2024 09:42:09 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 09/15] nvme: check for controller device in
 _nvme_connect_subsys()
Message-ID: <77a5a431-ffea-433f-a7fd-fcb16fd140ae@flourine.local>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
 <20241024010025.2216242-10-shinichiro.kawasaki@wdc.com>
 <82cad6a8-c249-445e-9836-f9c234add172@flourine.local>
 <6tkr2mnx6o3lbqj7jpcb7livwbx7c6g3hzg77cbskczj3ihozs@44ilfnnrmnmn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6tkr2mnx6o3lbqj7jpcb7livwbx7c6g3hzg77cbskczj3ihozs@44ilfnnrmnmn>
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.941];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_014213_877649_CD9D2DF8 
X-CRM114-Status: GOOD (  16.98  )
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

On Mon, Oct 28, 2024 at 06:39:59AM GMT, Shinichiro Kawasaki wrote:
> On Oct 25, 2024 / 16:40, Daniel Wagner wrote:
> > On Thu, Oct 24, 2024 at 10:00:19AM GMT, Shin'ichiro Kawasaki wrote:
> [...]
> > > @@ -408,21 +411,17 @@ _nvme_disconnect_subsys() {
> > >  }
> > >  
> > >  
> > > -_nvme_ns_ready() {
> > > -	local subsysnqn="${1}"
> > > -	local ns_path ns_id dev
> > > -	local cfs_path="${NVMET_CFS}/subsystems/$subsysnqn"
> > > +_nvme_ctrl_ready() {
> > > +	local ctrldev="${1}"
> > > +	local subsysnqn="${2:-$def_subsysnqn}"
> > > +	local ctrlpath="/sys/class/nvme/${ctrldev}"
> > >  
> > > -	dev=$(_find_nvme_dev "$subsysnqn")
> > > -	for ns_path in "${cfs_path}/namespaces/"*; do
> > > -		ns_id=${ns_path##*/}
> > > -		if [[ ! -b /dev/${dev}n${ns_id} ||
> > > -			   ! -e /sys/block/${dev}n${ns_id}/uuid ||
> > > -			   ! -e /sys/block/${dev}n${ns_id}/wwid ]]; then
> > > -			return 1
> > 
> > IIRC, the uuid/wwid test were originally from nvme/004 and copied to the
> > other test. When we refactored we moved the uuid/wwid here. I suggest we
> > add this part back to nvme/004 so that we don't loose this test case.
> 
> I checked the history the uuid/wwid test here, and it does not look originated
> from nvme/004:
> 
>  8251c724 ... Ofar moved it from tests/nvme/rc to common/nvme
>  8fc8eb14 ... Shin'ichiro turned the test into _nvme_ns_ready()
>  c766fccf ... Bart introduced the test
> 
> I guess the uuid/wwid test Daniel mentions is in the _check_uuid() helper
> function, and it has different story.

Ah indeed, I've mixed these two things up. In this case all is good.

Reviewed-by: Daniel Wagner <dwagner@suse.de>

