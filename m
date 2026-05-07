Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAA2CD343F
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2026 16:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J++FokmvTHlkt8kgpzhLvjbpu0hcW1fUQ8lTexarFwg=; b=QMftvm3Z0Mog4G/kB/JYq6FzZQ
	NYYZ/ODf872LRinMf3NlPlBia193lPDQ8cbjZSDCCUI4xglIuO646JUCyeETNkrMpetR3j5PsZccz
	hO9PIH3P6E0PcDi7MZ+nozGEGyYljunC5jxrV2kU1BvYTA2+1hOfUGdq9thdTfyb9c3+P3YnR+bmi
	IqJfpE42A1XE+ehDj57ObdlkVsvZvW7Djro7vIi85A5kciZMCdyG1CEaGI52XotdSyPZt1VpFONwr
	Flu8AH9QtNXNEuSu/qR255JbLgPG/5jCuBN+4d9uhw5r92KmFOjV2eJY2shE1qOegcTG6ZpQtmP8I
	ouTGp4xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wL1aC-00000004KV9-2dZK;
	Thu, 07 May 2026 16:28:16 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wL1aA-00000004KUc-1fRC
	for linux-nvme@lists.infradead.org;
	Thu, 07 May 2026 16:28:15 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5B0FF5C67C;
	Thu,  7 May 2026 16:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778171292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J++FokmvTHlkt8kgpzhLvjbpu0hcW1fUQ8lTexarFwg=;
	b=prF84qenKa5PjjXpSpYpf0ijRbefSmI0S2qJ6uy5NOuI29rldvpBiQLvDIz5h2IEYcNbvu
	9RPyMqrxnLMekzfCOK6N4+GVB+r3Pywh8oG6TsyA854Ue2Po37kCr9RYKQskFHsDjTp3ej
	U0HEKA895MlPLBkhQ4WODgxTPHGcvV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778171292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J++FokmvTHlkt8kgpzhLvjbpu0hcW1fUQ8lTexarFwg=;
	b=jcsemDO+zMNjwrJMh+NpQHPV7YCZkn6IlPCvJA4Ak9yBXdqK51jPpYhljIWlN65CfBYnd9
	UIFidN+zv5f0NVDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=prF84qen;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jcsemDO+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778171292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J++FokmvTHlkt8kgpzhLvjbpu0hcW1fUQ8lTexarFwg=;
	b=prF84qenKa5PjjXpSpYpf0ijRbefSmI0S2qJ6uy5NOuI29rldvpBiQLvDIz5h2IEYcNbvu
	9RPyMqrxnLMekzfCOK6N4+GVB+r3Pywh8oG6TsyA854Ue2Po37kCr9RYKQskFHsDjTp3ej
	U0HEKA895MlPLBkhQ4WODgxTPHGcvV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778171292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J++FokmvTHlkt8kgpzhLvjbpu0hcW1fUQ8lTexarFwg=;
	b=jcsemDO+zMNjwrJMh+NpQHPV7YCZkn6IlPCvJA4Ak9yBXdqK51jPpYhljIWlN65CfBYnd9
	UIFidN+zv5f0NVDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F57E593A7;
	Thu,  7 May 2026 16:28:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +9rvBZy9/GlSLgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 07 May 2026 16:28:12 +0000
Message-ID: <4eedc5eb-4e13-44d8-99ad-145494ff1156@suse.de>
Date: Thu, 7 May 2026 18:28:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] nvme-cli: add nvme top command for real-time
 monitoring
Content-Language: en-US
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: hare@suse.com, kbusch@kernel.org, hch@lst.de, gjoyce@linux.ibm.com,
 wenxiong@linux.ibm.com, linux-nvme@lists.infradead.org
References: <20260430105234.1172446-1-nilay@linux.ibm.com>
From: Daniel Wagner <dwagner@suse.de>
In-Reply-To: <20260430105234.1172446-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5B0FF5C67C
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260507_092814_597066_CC68E2E9 
X-CRM114-Status: UNSURE (   5.98  )
X-CRM114-Notice: Please train this message.
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

Hi Nilay,


On 4/30/26 12:52 PM, Nilay Shroff wrote:
> As usual feedback, comments, and suggestions are welcome!

I've uploaded the series to github to run the CI builds and also asked 
the LLM of the day to review it. There are a bunch of valid points it 
brought up:

https://github.com/linux-nvme/nvme-cli/pull/3333

Could you look into it and update the series accordingly?

And as discussed during LSFMM I'll apply it then and we improve/fix 
stuff from there in the tree.

Thanks,
Daniel


