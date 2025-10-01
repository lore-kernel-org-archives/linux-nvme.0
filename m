Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7D7CCA470
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Oct 2025 06:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qe55XZTwkbi3pGKrMkUOOsgOnAS5AzPq2vfECWhz7jU=; b=AoaTD1+uMBv5ljGC95CcH+PUjt
	HN0Us2nknfzEa04qg/l33VuemzBtt0/pjHG6mzUM+u52bHRbuCiOUn5iutNs+6kqeyCOL2bXEe6wE
	hLJ9ISw8Ii4jkoYK6mAt9n8Vp5mJa0oH1YipSTj2ds2Znb5p0Mvds/XiLjmVG50ueNAeIyrJNc581
	uGFTm+kVsoiMIkNEQk+nhyjBBW5QXP4I1PbuIJiNN9Z8Sp6PpL2tXJ4RrGRomG1RNG4duprR1b0eH
	8jsQ/Mj1WjFrIffcMW2eMvAMYAC1BFNVV02Z3ezQ5rT67c0LoISGGoDPbtSbuD8hOwDId/mT6FoiH
	Ce019HtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3q01-00000006lP7-1W16;
	Wed, 01 Oct 2025 06:07:37 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3pzy-00000006lGx-2j6S
	for linux-nvme@lists.infradead.org;
	Wed, 01 Oct 2025 06:07:35 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E94933376F;
	Wed,  1 Oct 2025 06:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759298700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qe55XZTwkbi3pGKrMkUOOsgOnAS5AzPq2vfECWhz7jU=;
	b=kDwcwTah+yo/3AFTGKpHPV4nnpc2k6ARY6LAEtk9kWbR6S56tzb/emQlAObYvtCK7ik6Rf
	glShVuMNU0qoErVOLwPBXqCeLmkoDMIG+ObGp1sREGkwwvFk9PmyoXcJFlPsj5nd8dVWVq
	Q+2VDWt1/nrZ3HJQO3+rrMGCJzmgZno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759298700;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qe55XZTwkbi3pGKrMkUOOsgOnAS5AzPq2vfECWhz7jU=;
	b=WcoEDPnCx++Zdd96cX4MyX2MlsE0xmeWSgnTvG+qFNCzLAeiUmtf0+7UEMPI2xAN7dRpNd
	zqXudMMDqScZ9IDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=w2wG5CeZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8UXpQKFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759298699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qe55XZTwkbi3pGKrMkUOOsgOnAS5AzPq2vfECWhz7jU=;
	b=w2wG5CeZxw9GI9QBmdk0K54OTrvpMOnI91DSBWLPJN2icsgcNcVmLUNbkG46NMmJ/Ubi4V
	2isA04n3EdBlXcd5A+lO17VBN5LrBXaFPvr1ITAIoohvxBiBM/cz5WX57Q/XXRez/mkO6N
	nI4ND9smwKeBkABHIz3ANhjQGEldaHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759298699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qe55XZTwkbi3pGKrMkUOOsgOnAS5AzPq2vfECWhz7jU=;
	b=8UXpQKFFdQyo1aOXEIjoDFlt1I88H7Aa1NCM2zCuasUOJSaI6u4EY8XTm2NcvWtWzt3eag
	9lcHdAI5h67mhwBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B244813A42;
	Wed,  1 Oct 2025 06:04:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hGkKJovE3Gi4BAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 01 Oct 2025 06:04:59 +0000
Date: Wed, 1 Oct 2025 08:04:54 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, kbusch@kernel.org, 
	sagi@grimberg.me, kch@nvidia.com, israelr@nvidia.com
Subject: Re: [PATCH 3/4] nvmet: prevent max_qid changes for discovered
 subsystems
Message-ID: <cdb8b194-c3f2-47f3-8ddc-c35de5655696@flourine.local>
References: <20250924202604.7201-1-mgurtovoy@nvidia.com>
 <20250924202604.7201-4-mgurtovoy@nvidia.com>
 <97291788-f831-469c-b0cd-7fd79678366e@flourine.local>
 <0c96d03b-b98c-4996-8739-e8cd0d6af96a@nvidia.com>
 <bf276b4b-9d1d-458e-84cc-b24969bc0995@flourine.local>
 <8f8d7c9a-02f5-47c0-8f8c-9aae6b969c73@nvidia.com>
 <cf51e862-53db-4fc7-b2c7-bde2ad31e4ec@flourine.local>
 <8cf714c7-a692-4bcf-80f0-780fbc2c27b5@nvidia.com>
 <2715b2ac-0948-4755-803b-7f41768efc6a@flourine.local>
 <d63d991a-0e72-4e94-885f-d94eb810d196@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d63d991a-0e72-4e94-885f-d94eb810d196@nvidia.com>
X-Rspamd-Queue-Id: E94933376F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250930_230734_846286_8A1592E5 
X-CRM114-Status: GOOD (  11.79  )
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

On Sun, Sep 28, 2025 at 02:53:12PM +0300, Max Gurtovoy wrote:
> On 26/09/2025 9:58, Daniel Wagner wrote:
> > > If possible - lets try it also with tcp/rdma transports
> > You are proposing a patch which has never run blktests, as it clearly
> > would regress nvme/048. I don't see myself here to do your work.
> 
> This was not my intention :)

Ah okay, I understood it wrong then :)





> 

