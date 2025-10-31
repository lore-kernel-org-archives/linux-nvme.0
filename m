Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A570CCF9EE
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 06:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fN9xyt1WcaLwe/hRvXSv1qXuxtgXIaIjxGKTQ+v5KmI=; b=Qn8JfkYBciJ+zXShiHU7PB1YmP
	5Cl86A4MYgk7Qmp50ee6z407VG9lnASx3PIuJtEPa1LV+gQNzmWqAu8hNi/dsPVoHzUqttyAVY1bo
	iIJ+dx7rdPLAO8slgbyX7BQMn4Zsnsn88tzlIKznPjIs+RN95lKScW0q8msqkvfw34n0d0rnLWphp
	oX+kPsv0iv4nnAbNOwzYRu2l89o6EITgYTwOJ/vJRCg/DKH8z3l+8OUK0EKs6pMu4SdMQBu2T2Dqb
	j2ZWPduNLWOlVn6gsnIIGYoASyAsr92ECOwFhkQK9xfAwUi8R8pXxrS9sp7VQ58U01S3BK957ytan
	cplHb+lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEj5F-00000005VC0-44bL;
	Fri, 31 Oct 2025 06:58:01 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEj57-00000005VAy-0WRZ
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 06:57:54 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 751A2229AF;
	Fri, 31 Oct 2025 06:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761893868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fN9xyt1WcaLwe/hRvXSv1qXuxtgXIaIjxGKTQ+v5KmI=;
	b=jjc/Xh0wYExl2S9m6bxGyoWDSr7Slr/X+tbT+M4g0JaBZw0nzr/gMNsnXSJTrepnwUFEQF
	WWtAcXcgnxdgVxpVvOjRUeQEMglOwdTd/OV/WjQyi6nrWLhRGvg34jpZoorUQ5RzVSeQgp
	OsJO6jd8c50sjau+n1ck2gW57ULBgpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761893868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fN9xyt1WcaLwe/hRvXSv1qXuxtgXIaIjxGKTQ+v5KmI=;
	b=vcYL0YiUSXRwA6HvzPkLPdUAS/170c36OoaAHosYAliKCMH9lFHSST6DxJNMKSORb67NR/
	Zic1hjeDcmfwu1Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="jjc/Xh0w";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vcYL0YiU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761893868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fN9xyt1WcaLwe/hRvXSv1qXuxtgXIaIjxGKTQ+v5KmI=;
	b=jjc/Xh0wYExl2S9m6bxGyoWDSr7Slr/X+tbT+M4g0JaBZw0nzr/gMNsnXSJTrepnwUFEQF
	WWtAcXcgnxdgVxpVvOjRUeQEMglOwdTd/OV/WjQyi6nrWLhRGvg34jpZoorUQ5RzVSeQgp
	OsJO6jd8c50sjau+n1ck2gW57ULBgpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761893868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fN9xyt1WcaLwe/hRvXSv1qXuxtgXIaIjxGKTQ+v5KmI=;
	b=vcYL0YiUSXRwA6HvzPkLPdUAS/170c36OoaAHosYAliKCMH9lFHSST6DxJNMKSORb67NR/
	Zic1hjeDcmfwu1Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44BCA13393;
	Fri, 31 Oct 2025 06:57:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2JQpD+xdBGltSQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 31 Oct 2025 06:57:48 +0000
Message-ID: <688b8f5a-8f01-4264-a9eb-f0962cc341f5@suse.de>
Date: Fri, 31 Oct 2025 07:57:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme: fixup nvme auth host/target dependency
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>, kernel test robot <lkp@intel.com>
References: <20251031002655.2999568-1-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251031002655.2999568-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 751A2229AF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,intel.com:email,suse.de:email,suse.de:mid,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251030_235753_398903_3BE3AB6C 
X-CRM114-Status: GOOD (  11.15  )
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

On 10/31/25 01:26, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Converge the enabling of nvme-auth for both host or target into a single
> selection and implementation. The selection must inherit the strongest
> config selection of either target or host, so some Kconfig trickery is
> used to make that happen.
> 
> Cc: Hannes Reinecke <hare@suse.de>
> Fixes: f59ae5c9e356b5e ("nvme: parse dhchap keys during option parsing")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510100105.cibujuUJ-lkp@intel.com/
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v1->v2:
> 
>    Instead of keeping auth support for host and target split, their
>    destiny is converged and so is the implementation.
> 
>   drivers/nvme/common/Kconfig | 18 ++++++++++++++++--
>   drivers/nvme/host/Kconfig   | 10 +++-------
>   drivers/nvme/host/nvme.h    |  9 ---------
>   drivers/nvme/target/Kconfig | 10 +++-------
>   drivers/nvme/target/nvmet.h |  7 -------
>   include/linux/nvme-auth.h   | 11 +++++++++++
>   6 files changed, 33 insertions(+), 32 deletions(-)
> 

Thank you. That's what I had in mind.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

