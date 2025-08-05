Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D66C87FCB
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Aug 2025 07:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KLnXqj9evrozI6tURuf6Jmr/yO+xfZXLPjqAoe6pFL8=; b=PHN2FZmIh4L3fqvjZ4OG0OF1GQ
	mB0BnFsKbDryVDjAdNCDLpUry5EMBWHvuxVk5sTiDhdlDPUsVIoLEKOKQmdARW1jTXkBjb0ZWiJ0h
	D639I+sj71t2LCugR9peNaWHoB0m4Oq0ai9i0+8WDPmL3ypIGzLbs4Qb2HiDxroZGf207/W3p4Yzs
	zErwSPRNqDZYDeU0RhSUJASyKV2OF83gTtYrPGZ53yEwVmcGLMpyf6HX0/mQVBHM8EfZVMSnl0pQJ
	LObQqTiPDFPCGq1x8AtZUK6Gq+ZN0QQXXrlPQ+03dXhzh1q7yFfg5LVNaLk1xKHTEgNe1CYuOJpe0
	YfVHNQzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujC2K-0000000C0yY-0jFc;
	Tue, 05 Aug 2025 07:24:40 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujC2G-0000000C0y8-2Wvr
	for linux-nvme@lists.infradead.org;
	Tue, 05 Aug 2025 07:24:38 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0FA7E1F38C;
	Tue,  5 Aug 2025 07:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754378675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KLnXqj9evrozI6tURuf6Jmr/yO+xfZXLPjqAoe6pFL8=;
	b=uRvt3cAdRQlWk77r/jsH8udOUj/ZHNlzOLUvseTGEUBnCpPKXlUl4P7pjX9SX5ckEp+NHT
	qXtK102Csfo/XeaOwMX45WO2O3B4Q82oCLU9Rq75DPPvgSLul2jVRVKeyWmokiG73672Ze
	I25tHGG82T5LQRu8HCysTLwF1iBdfnI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754378675;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KLnXqj9evrozI6tURuf6Jmr/yO+xfZXLPjqAoe6pFL8=;
	b=GXy3dQ5Ga7JLh4rzedXU92ukEsEAeRM0je3cFIek5zJ/wuUSpYr91RWvzNEZrhuHqIgEKt
	wf40TrqbklgX6lDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754378675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KLnXqj9evrozI6tURuf6Jmr/yO+xfZXLPjqAoe6pFL8=;
	b=uRvt3cAdRQlWk77r/jsH8udOUj/ZHNlzOLUvseTGEUBnCpPKXlUl4P7pjX9SX5ckEp+NHT
	qXtK102Csfo/XeaOwMX45WO2O3B4Q82oCLU9Rq75DPPvgSLul2jVRVKeyWmokiG73672Ze
	I25tHGG82T5LQRu8HCysTLwF1iBdfnI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754378675;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KLnXqj9evrozI6tURuf6Jmr/yO+xfZXLPjqAoe6pFL8=;
	b=GXy3dQ5Ga7JLh4rzedXU92ukEsEAeRM0je3cFIek5zJ/wuUSpYr91RWvzNEZrhuHqIgEKt
	wf40TrqbklgX6lDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F259A13A55;
	Tue,  5 Aug 2025 07:24:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rlm4OrKxkWiTIgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 05 Aug 2025 07:24:34 +0000
Date: Tue, 5 Aug 2025 09:24:34 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hare@suse.de, kbusch@kernel.org, 
	gjoyce@ibm.com
Subject: Re: [PATCH 2/2] nvme: extend show-topology command to add support
 for multipath
Message-ID: <5e0e3c9d-f813-41d7-83b1-6aaa2e3e5138@flourine.local>
References: <20250704135001.292763-1-nilay@linux.ibm.com>
 <20250704135001.292763-3-nilay@linux.ibm.com>
 <91e8e0de-70a7-484d-af9f-f06645011ae6@flourine.local>
 <7fb98f70-cbf8-4ae2-bd72-cebf3d4c21f7@linux.ibm.com>
 <22bc2185-04d0-4edb-848a-43e5bb99ed25@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22bc2185-04d0-4edb-848a-43e5bb99ed25@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250805_002436_842044_51FCBA0C 
X-CRM114-Status: GOOD (  12.80  )
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

Sorry, I forgot about to reply.

On Tue, Aug 05, 2025 at 10:31:35AM +0530, Nilay Shroff wrote:
> > Example verbose output:
> > 
> > $ nvme show-topology --verbose -r multipath
> > 
> > nvme-subsys2 - NQN=nvmet_subsystem
> >                hostnqn=nqn.2014-08.org.nvmexpress:uuid:12b49f6e-0276-4746-b10c-56815b7e6dc2
> >                iopolicy=numa
> >                model=Linux
> >                serial=d5dc1170f62100d47204
> >                firmware=6.16.0-r
> >                type=nvm
> > 
> > <head-node> <namespace>   <path>    <ana-state>  <numa-list>  <queue-depth>   <ctrl>  <state>  <transport>    <address>                  
> >     |          |             |           |           |            |              |       |          |             |
> > nvme2n1        1          nvme2c2n1   optimized     1,2           0            nvme2   live        tcp        traddr=127.0.0.2,trsvcid=4460,src_addr=127.0.0.1 
> > nvme2n1        1          nvme2c3n1   optimized     3,4           0            nvme3   live        tcp        traddr=127.0.0.3,trsvcid=4460,src_addr=127.0.0.1
> > 
> > What do you think?

Personally, I did like the previous annotation layout, probably because
I am looking way to often the ftrace output. Though, I'd say it would be
better to stick with the existing table layout, instead adding something
completely new (nvme list, nvme list -v, etc).

Maybe introducing a bit of common code for printing these tables could
make it also a bit more streamlined, just as an idea.

Thanks,
Daniel

