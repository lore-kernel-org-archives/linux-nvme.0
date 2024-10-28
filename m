Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FACD13570
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 11:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qtgc3m1K/ZzL0/0ZTiBF6D2yHug4fQrxZmvqfWJOzCk=; b=ZXDd07o/SDzorviTEt7ZRs1A9I
	QE2eItXJiy4QasEX+JewTSsxUF1Ayh2f7DWf1LupiBCXe3xQDn1JxFStlBWV/N5WjouGlEYs2Tr1C
	drvJEXHM+eCrIkNE+idE0IEycMLfHll0HYtv0/Yu8ELpGNu77LEq4mHHpH+qqhlpnyDmPHG7FeWaN
	Ui+hVmeQZkWAqnrcGbbWnmElIrtztBTEwKJwV+uj99x12aiXf/6/jK0vmYkm9BgGVltLkg/dA6Q+J
	dv93F9RY4ZUr8nSf3WybPzdaic66dISvq+33ZqBVjognbk3NMCyBrv/ihrAkcyCER/N3gvXX3jZJY
	Tae73cpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5NcU-0000000AWOx-2rB5;
	Mon, 28 Oct 2024 11:09:10 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5NcF-0000000AWKO-13xC
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 11:08:59 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 372D521AF4;
	Mon, 28 Oct 2024 11:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730113733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qtgc3m1K/ZzL0/0ZTiBF6D2yHug4fQrxZmvqfWJOzCk=;
	b=0nBfkdAGHO715WES7RlIg1+zXK8KPWqAzNviC2xiEEgD2hdzQP+B6nXkHmkwnLGVPElhaU
	4FwMOD4cQKYS2DpRfqRz6PM+bLKu3/r5QX+LpQg8I9wSFTnd/9/eJ/HdViyjd3vbtqVotY
	dRN6zoI8dZRQDWbZm/F7WH6rCqj81nU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730113733;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qtgc3m1K/ZzL0/0ZTiBF6D2yHug4fQrxZmvqfWJOzCk=;
	b=IeWWVeQJCVIarqE6Fa8YYr+J9zkDufaTU39svwEhDrJAajJ7QR0UandhWvTWbwVEm9w6bd
	X7KFR+8MTzZgkfCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0nBfkdAG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IeWWVeQJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730113733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qtgc3m1K/ZzL0/0ZTiBF6D2yHug4fQrxZmvqfWJOzCk=;
	b=0nBfkdAGHO715WES7RlIg1+zXK8KPWqAzNviC2xiEEgD2hdzQP+B6nXkHmkwnLGVPElhaU
	4FwMOD4cQKYS2DpRfqRz6PM+bLKu3/r5QX+LpQg8I9wSFTnd/9/eJ/HdViyjd3vbtqVotY
	dRN6zoI8dZRQDWbZm/F7WH6rCqj81nU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730113733;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qtgc3m1K/ZzL0/0ZTiBF6D2yHug4fQrxZmvqfWJOzCk=;
	b=IeWWVeQJCVIarqE6Fa8YYr+J9zkDufaTU39svwEhDrJAajJ7QR0UandhWvTWbwVEm9w6bd
	X7KFR+8MTzZgkfCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DAC2136DC;
	Mon, 28 Oct 2024 11:08:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YM7gBMVwH2e2RAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 28 Oct 2024 11:08:53 +0000
Date: Mon, 28 Oct 2024 12:08:52 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 11/15] common/nvme, nvme/003: add --no_port
 option to _nvme_connect_subsys
Message-ID: <0e57af1b-5eec-44ee-bba3-9ebecd317287@flourine.local>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
 <20241024010025.2216242-12-shinichiro.kawasaki@wdc.com>
 <80050767-185a-42b0-b4af-3f6e2c921b1d@flourine.local>
 <nfnhajw3njwoyitpsltx2p2blif4js5s7zwqmd22hxt4tx3ptm@6x6rz4pfqjlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nfnhajw3njwoyitpsltx2p2blif4js5s7zwqmd22hxt4tx3ptm@6x6rz4pfqjlk>
X-Rspamd-Queue-Id: 372D521AF4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_040855_466234_4FBB47FC 
X-CRM114-Status: GOOD (  24.65  )
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

On Mon, Oct 28, 2024 at 07:07:15AM GMT, Shinichiro Kawasaki wrote:
> > I am not so sure about the --no_port argument
> > is a good idea. And if a test wants to use a specific port, we have the
> > port option, no?
> 
> AFAIU, there will be three kinds of _nvme_connect_subsys() calls from port
> parameter point of view:
> 
> 1) Default port(s)
> 
>    No port related option is specified to _nvme_connect_subsys().
>    _nvme_connect_subsys() gets the ports prepared, and refer to them.
> 
> 2) Specific multiple ports
> 
>    --port option is specified to _nvme_connect_subsys().
>    Following series will add tests for them.
> 
> 3) No port
> 
>    nvme/003 creates a nvmet subsystem with default port. The test case
>    also connects to another subsys "nqn.2014-08.org.nvmexpress.discovery"
>    by calling _nvmet_connect_subsys(). In this case, port related parameters
>    should not be specified.
> 
> To clarify that the _nvmet_connect_subsys() call in nvme/003 is the 3) case, I
> suggest to introduce --no_port option. It will explicitly show that
> _nvmet_connect_subsys() does the exceptional parameter preparation.

After looking this and previous patch, I think we should aim to make
this a bit more readable. I would suggest to move the whole port
handling code inside _get_nvmet_port_params(), this is

-       ARGS=(--transport "${nvme_trtype}" --nqn "${subsysnqn}")
-       if [[ "${nvme_trtype}" == "fc" ]] ; then
+       if [[ -z "${port}" ]]; then
                local ports
+
                _get_nvmet_ports "${subsysnqn}" ports
-               if ((${#ports[@]} != 1)); then
-                       echo only one port is supported at this moment...
-                       exit 1
+               port="${ports[0]##*/}"
+               if [[ -z "${port}" ]]; then
+                       echo "WARNING: no port found"
+                       return 1
                fi
-               local port=${ports[0]}
-               ARGS+=(--traddr "$(_fc_traddr "$port")")
-               ARGS+=(--host-traddr "$(_fc_host_traddr "$port")")
-       elif [[ "${nvme_trtype}" != "loop" ]]; then
-               ARGS+=(--traddr "${def_traddr}" --trsvcid "${def_trsvcid}")
        fi

and just pass the --port argument to _get_nvmet_port_params().

Instead adding a new --no_port, just allow '--port none', '--port
discovery' or something similar. I would like to avoid to have a --port
and --no_port argument, because this is very confusing IMO, e.g. I'd ask
myself "If I don't use --port is that not the same as --no_port?"

And also this next block should be splitted somehow:

+       if [[ $port != none ]]; then
+               [[ -d "${cfs_path}" ]] || exit 1
+               trtype=$(cat "${cfs_path}/addr_trtype")
+               traddr=$(cat "${cfs_path}/addr_traddr")
+               args+=(--traddr "${traddr}")
+               if [[ "${trtype}" == "tcp" ]] || [[ "${trtype}" == "rdma" ]]; then
+                       trsvcid=$(cat "${cfs_path}/addr_trsvcid")
+               fi
+       elif [[ "${trtype}" != "loop" ]]; then
+               args+=(--traddr "${traddr}")
+       fi

The first block is guarded by the port argument and the second with
trtype. It's not obvious how these things belong together. Maybe make a
big switch at the beginning of the function on the trtype and add the
arguments accordingly. I think being explicit here and having some
redundancy/repetition is better to maintain.

What do you think?

