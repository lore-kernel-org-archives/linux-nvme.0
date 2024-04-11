Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E77C4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Apr 2024 18:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K78E1oDH9QVROobIPW5crd473QiESO6tyz50+xzp+kY=; b=QKcSGzEyPw6YLczEMGy0SpUnOW
	oWGmJGk/8IKxFsdv2ymqwViYd99NHSODTUKpCdBj+EEveadGWBEkw65aX9e42PxrM7feLDruaT4RO
	bIY5ZxMIZ0fT8RuxALQh0qAEcWoC1GUOfSBl9z5liXL0WkVpAhf4ZOlTMRY2z81uMeAl2GKYPxgsD
	8EogI+eaiHbauxH8VDnk6y6RWsiUWU8pzGt8IT7DEzN9j0YCQIiL5Fxg3/l+S+ptU9DrzSmuYGHG9
	UUAj40V/XohutGz1iO1iSK8GdBjqocss+J20tP8GdeIjg19T1UuZUXnuuEAOKnWCmGOTe7k6ollxY
	S7cJFGXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruzN9-0000000Dk3G-3J6L;
	Thu, 11 Apr 2024 18:42:07 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruzN4-0000000Djyu-3HTu
	for linux-nvme@lists.infradead.org;
	Thu, 11 Apr 2024 18:42:05 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7A0775D3A1;
	Thu, 11 Apr 2024 18:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712860914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K78E1oDH9QVROobIPW5crd473QiESO6tyz50+xzp+kY=;
	b=KX6LE7Kr42MPPdCo/oKoU6ca66MlrlRjO3c9YKZ+q0QMUxpYWBiWnsEHB6XK+nNa7cVZsc
	CHgWwsoglmez044kbC94ZHUuxcMaR8tiAkurCqjlpP090ZSupwrnPf21ay3K+AnAS2RxdW
	lW1/rceYjqrz4Zi6FQuTPJhznIN4TS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712860914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K78E1oDH9QVROobIPW5crd473QiESO6tyz50+xzp+kY=;
	b=jpoCZPlx1/UPBfzQKlT7QllgURAlWXhuUCHJ156NF4dIAKOvkix0Q1OSttnRDMBhT+GCiS
	nEAtkNTenbW5PoCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712860914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K78E1oDH9QVROobIPW5crd473QiESO6tyz50+xzp+kY=;
	b=KX6LE7Kr42MPPdCo/oKoU6ca66MlrlRjO3c9YKZ+q0QMUxpYWBiWnsEHB6XK+nNa7cVZsc
	CHgWwsoglmez044kbC94ZHUuxcMaR8tiAkurCqjlpP090ZSupwrnPf21ay3K+AnAS2RxdW
	lW1/rceYjqrz4Zi6FQuTPJhznIN4TS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712860914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K78E1oDH9QVROobIPW5crd473QiESO6tyz50+xzp+kY=;
	b=jpoCZPlx1/UPBfzQKlT7QllgURAlWXhuUCHJ156NF4dIAKOvkix0Q1OSttnRDMBhT+GCiS
	nEAtkNTenbW5PoCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 671081368B;
	Thu, 11 Apr 2024 18:41:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9iOxF/IuGGY8GgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 11 Apr 2024 18:41:54 +0000
Date: Thu, 11 Apr 2024 20:41:53 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests 05/11] nvme/rc: introduce NVMET_TR_TYPES
Message-ID: <ccnazevlqz6dybzhe6asib3rtlz62ynv24jc22q3cgsf666b4e@6sd6youpsrrb>
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
 <20240411111228.2290407-6-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411111228.2290407-6-shinichiro.kawasaki@wdc.com>
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-2.70)[98.67%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240411_114203_004875_2526E78C 
X-CRM114-Status: GOOD (  11.98  )
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

On Thu, Apr 11, 2024 at 08:12:22PM +0900, Shin'ichiro Kawasaki wrote:
> Some of the test cases in nvme test group can be run under various nvme
> target transport types. The configuration parameter nvme_trtype
> specifies the transport to use. But this configuration method has two
> drawbacks. Firstly, the blktests check script needs to be invoked
> multiple times to cover multiple transport types. Secondly, the test
> cases irrelevant to the transport types are executed exactly same
> conditions in the multiple blktests runs.
> 
> To avoid the drawbacks, introduce new configuration parameter
> NVMET_TR_TYPES. This is an array, and multiple transport types can
> be set like:
> 
>     NVMET_TR_TYPES=(loop tcp)
> 
> Also introduce _nvmet_set_nvme_trtype() which can be called from the
> set_conditions() hook of the transport type dependent test cases.
> Blktests will repeat the test case as many as the number of elements in
> NVMET_TR_TYPES, and set nvme_trtype for each test case run.

I suggest to keep the naming of the variable consistent, e.g.
NVMET_TRTYPES.

