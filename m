Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC613EB64D8
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 17:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gQMScDX/cvgFRjCGIqLHXDTtERLukXLjwnsLxfJ35pI=; b=PUCWfff5UWKplymCM3huu7OlHO
	DT55+z/2vIrS7htWXA6367ryKD+mF+JygJk1Sz2xg2ik+cyxkOTbb5vMELIsGd5KP26UjqeVD/KlX
	Sb4rBJ0WzzRScXKfU90blHwFT6kx8ZvSMKg1vsXnfGx6E2ak4xaSOV4iatdFyCEL/9Z2eEBPL2I8g
	4Rjww4ru2Ydasm+2ExPRXh3qvB+ks3xf71DfZyGl05Wp6ELpyoNXhkdN24YcJbNRjBW6wZIwmbBHC
	WLF/ExrY5BUrQmpCvZGa/wuSSeK6N4kEgCh6KrtrYVvkX3HG9G7baRQEpLzCsxxIvbO9SnMQ4oM8Q
	1gf0aC3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBfIb-00BxHT-0v;
	Tue, 20 Jun 2023 17:37:49 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBfIY-00BxGO-2e
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 17:37:48 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8D9611F390;
	Tue, 20 Jun 2023 17:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1687282664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gQMScDX/cvgFRjCGIqLHXDTtERLukXLjwnsLxfJ35pI=;
	b=rXYzckEAd/l0kJ6YfTeJZg+wCkmRdBLJw+hsF38Y+EoKp8QkwqmTXIGeD2ViXZfzTOTdEq
	8hTq2EbCpTiZB/mzgnd6hDcKITLPZ5Kifz6/BaILvMXYTFa+bIEBIw2Bb3e7fMXYWm7Cg7
	OvNH7suvloGx3Cywr5diI5eRlzlwlJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1687282664;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gQMScDX/cvgFRjCGIqLHXDTtERLukXLjwnsLxfJ35pI=;
	b=ns9MlZGHKJUhM/aNne/k5Ws/X7/tyzNRTdXuOac/x2eUDnoTTbJ0BAEtPmUfqYluuO+4dx
	8imqchkZwihWjsAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C5E21346D;
	Tue, 20 Jun 2023 17:37:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id TYX+GejjkWSAMAAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 20 Jun 2023 17:37:44 +0000
Date: Tue, 20 Jun 2023 19:37:43 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>, Hannes Reinecke <hare@suse.de>, 
	James Smart <jsmart2021@gmail.com>, Martin Belanger <Martin.Belanger@dell.com>
Subject: Re: [PATCH blktests v1 1/3] nvme/048: Check for queue count check
 directly
Message-ID: <f6rvvhgim4nk34onfgbwyfctgvgdbdigwbsugjvizgtli46p57@s7c4gkqrpjqy>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-2-dwagner@suse.de>
 <380cde65-8794-cfbc-237f-30a8d7e9330c@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <380cde65-8794-cfbc-237f-30a8d7e9330c@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_103747_006304_C69F95D1 
X-CRM114-Status: GOOD (  12.26  )
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

On Tue, Jun 20, 2023 at 04:49:45PM +0300, Sagi Grimberg wrote:
> > +nvmf_wait_for_queue_count() {
> > +	local subsys_name="$1"
> > +	local queue_count="$2"
> > +	local nvmedev
> > +
> > +	nvmedev=$(_find_nvme_dev "${subsys_name}")
> > +
> > +	queue_count_file="/sys/class/nvme-fabrics/ctl/${nvmedev}/queue_count"
> > +
> > +	nvmf_wait_for_state "${subsys_name}" "live" || return 1
> > +
> > +	queue_count=$((queue_count + 1))
> > +	if grep -q "${queue_count}" "${queue_count_file}"; then
> > +		return 0
> > +	fi
> > +
> > +	echo "expected queue count ${queue_count} not set"
> > +	return 1
> > +}
> > +
> >   set_nvmet_attr_qid_max() {
> >   	local nvmet_subsystem="$1"
> >   	local qid_max="$2"
> > @@ -56,10 +76,7 @@ set_qid_max() {
> >   	local qid_max="$3"
> >   	set_nvmet_attr_qid_max "${subsys_name}" "${qid_max}"
> > -
> > -	# Setting qid_max forces a disconnect and the reconntect attempt starts
> > -	nvmf_wait_for_state "${subsys_name}" "connecting" || return 1
> > -	nvmf_wait_for_state "${subsys_name}" "live" || return 1
> > +	nvmf_wait_for_queue_count "${subsys_name}" "${qid_max}" || return 1
> 
> Why not simply wait for live? The connecting is obviously racy...

That is what the new version is doing. It's waiting for the live state and then
checks the queue count.

