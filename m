Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B037DCAC5AE
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Sep 2025 06:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V1Ov7t+E0EmI2/ZNWcLvJzekqpXm5Ugk8erXS/tTst0=; b=ZD3huKUL3s+veOal/drH3tudWt
	Ez2G1/zYkRTG0sxpB/mJ3rHag4i62rNxmu2dypTpo5KXL7Zy6Jfm/APh4fuv9yHawWkhOh1k4Lbiv
	1rJZgS9slpYDbPr+LCBXNHkpJ+ywZMttwa0fnPeJ1VMKsgkGlRG+OmsovMohBKbY1prpkB2wlKdcG
	fMMnDNhDMaCbeOL2tbdSfSbn1HyH0BsrGcJDUdgx+JxfFR2CgPMVGzw4nnriOmfN2Srajww3ZNcxW
	0K9qmn711lUycXZHVNqE/Xay1Pxl5Xy04A1WueIla4NcUzoMJoN+1qaYFan0qkNECcawcA1Ampudk
	3NK4A3Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v22Q5-0000000GZU0-1roq;
	Fri, 26 Sep 2025 06:59:05 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v22Q0-0000000GZPV-3s7E
	for linux-nvme@lists.infradead.org;
	Fri, 26 Sep 2025 06:59:04 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A1527451B;
	Fri, 26 Sep 2025 06:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758869938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1Ov7t+E0EmI2/ZNWcLvJzekqpXm5Ugk8erXS/tTst0=;
	b=dIdPhv6S5ZD9HQZf7mGipQHwm8lXu+4V6RLN1Jm5E8sO4UILUdaCk9eHHftvThFLh6Zxrt
	vpB82nkMaZIQM1lofhhtFLnNIBIxXw/uEq+GJ2dFPWE3ZgKJA1JPqPMqxdaxj39XXb+mfT
	WmUhmj9hfYXCANXfAjwJ1jSA6Vd6VVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758869938;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1Ov7t+E0EmI2/ZNWcLvJzekqpXm5Ugk8erXS/tTst0=;
	b=mD18Eve56KQaB9aqCowt9ps1OVTbjv4pbMv2jCzUEbecwbPd4gPbeHhndUfHZpsuhc/6Nv
	NFJSq3DM6Ykm+gDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dIdPhv6S;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mD18Eve5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758869938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1Ov7t+E0EmI2/ZNWcLvJzekqpXm5Ugk8erXS/tTst0=;
	b=dIdPhv6S5ZD9HQZf7mGipQHwm8lXu+4V6RLN1Jm5E8sO4UILUdaCk9eHHftvThFLh6Zxrt
	vpB82nkMaZIQM1lofhhtFLnNIBIxXw/uEq+GJ2dFPWE3ZgKJA1JPqPMqxdaxj39XXb+mfT
	WmUhmj9hfYXCANXfAjwJ1jSA6Vd6VVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758869938;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1Ov7t+E0EmI2/ZNWcLvJzekqpXm5Ugk8erXS/tTst0=;
	b=mD18Eve56KQaB9aqCowt9ps1OVTbjv4pbMv2jCzUEbecwbPd4gPbeHhndUfHZpsuhc/6Nv
	NFJSq3DM6Ykm+gDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E2921386E;
	Fri, 26 Sep 2025 06:58:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bD9iIrI51mjMWgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 26 Sep 2025 06:58:58 +0000
Date: Fri, 26 Sep 2025 08:58:58 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, kbusch@kernel.org, 
	sagi@grimberg.me, kch@nvidia.com, israelr@nvidia.com
Subject: Re: [PATCH 3/4] nvmet: prevent max_qid changes for discovered
 subsystems
Message-ID: <2715b2ac-0948-4755-803b-7f41768efc6a@flourine.local>
References: <20250924202604.7201-1-mgurtovoy@nvidia.com>
 <20250924202604.7201-4-mgurtovoy@nvidia.com>
 <97291788-f831-469c-b0cd-7fd79678366e@flourine.local>
 <0c96d03b-b98c-4996-8739-e8cd0d6af96a@nvidia.com>
 <bf276b4b-9d1d-458e-84cc-b24969bc0995@flourine.local>
 <8f8d7c9a-02f5-47c0-8f8c-9aae6b969c73@nvidia.com>
 <cf51e862-53db-4fc7-b2c7-bde2ad31e4ec@flourine.local>
 <8cf714c7-a692-4bcf-80f0-780fbc2c27b5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8cf714c7-a692-4bcf-80f0-780fbc2c27b5@nvidia.com>
X-Rspamd-Queue-Id: A1527451B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_235903_176142_66FC70D6 
X-CRM114-Status: GOOD (  11.48  )
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

On Fri, Sep 26, 2025 at 01:09:22AM +0300, Max Gurtovoy wrote:
> I'm not an expert in the blktests but it seems like we should do inside the
> set_qid_max() something like:
> 
> _nvmet_target_cleanup
> _nvmet_target_setup --blkdev file (Add here --qid_max "${qid_max}" option)
> nvmf_check_queue_count "${subsysnqn}" "${qid_max}" || return 1
> _nvmf_wait_for_state "${subsysnqn}" "live" || return 1
> 
> I expect the above to work with and without my patches..

My patch was just a quick hack to see if it works. Updating
__nvmet_target_setup to handle the qid_max argument is the right
approach. 
 
> If possible - lets try it also with tcp/rdma transports

You are proposing a patch which has never run blktests, as it clearly
would regress nvme/048. I don't see myself here to do your work.

