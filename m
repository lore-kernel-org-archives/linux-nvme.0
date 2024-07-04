Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75839C30653
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jul 2024 07:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N2NQR69WOlf+8o3zD1ijFyw1tkpac0erLtHE1UAumBA=; b=IlvWZpvakTjVpwtIofdG5WB8Af
	IoooPpkP2FmXjcjnMC5/M0d5oyAuWApZ2qFd0tvrJ54bwB1A5D+GlmhMl+V7DsYTMzyhu8z7OBfie
	pzxcoa+MIHkp2/2+TBmF067JcAXhUNAXVDWu/rrLMxAVGRFtv617/tld0LjBwEq0/qxhmY/zF1I+6
	InC6McdXDaKUhVljuP8gSQ96/zF33D++8wY2ru1bsWAOSYdhpWGrqqa0lwMcOc1DAw5Z5lZp1G1fS
	f3U9jqpsvRIO42wd0fSFjotSlhbRvBaNRAk9rKNNorRpjxcXYF8b+NIaYQU+sfHvOZ3gPyezoUsyz
	EgWvwkRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPH1W-0000000CT57-3PUr;
	Thu, 04 Jul 2024 07:36:58 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPH1R-0000000CT3w-3G2B
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jul 2024 07:36:57 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8125021C08;
	Thu,  4 Jul 2024 07:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720078611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N2NQR69WOlf+8o3zD1ijFyw1tkpac0erLtHE1UAumBA=;
	b=ktoiHzo8vCG47SuLjuha6NhGcs5r7QlVR4Rk4h/c3BldOxLM1uoZypP4O15Ai4dpQxAobC
	rEtHdKuDGyfNOVRmXef7pyqZP3X0CFG2T+yJPnUDc3YsWRq3crhzIzoZT1tOyldCJPPYBy
	wKv004Yrx37diPYQr+XcIctLGvqcCX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720078611;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N2NQR69WOlf+8o3zD1ijFyw1tkpac0erLtHE1UAumBA=;
	b=bYZDtrlOJfowSnKv1UVtnC1WdGQP6JDAGGr6ZyiiJYhV+oMd52czH5TRP/WFWiXNDXXy1l
	0dhqVaC3zkH82HDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720078611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N2NQR69WOlf+8o3zD1ijFyw1tkpac0erLtHE1UAumBA=;
	b=ktoiHzo8vCG47SuLjuha6NhGcs5r7QlVR4Rk4h/c3BldOxLM1uoZypP4O15Ai4dpQxAobC
	rEtHdKuDGyfNOVRmXef7pyqZP3X0CFG2T+yJPnUDc3YsWRq3crhzIzoZT1tOyldCJPPYBy
	wKv004Yrx37diPYQr+XcIctLGvqcCX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720078611;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N2NQR69WOlf+8o3zD1ijFyw1tkpac0erLtHE1UAumBA=;
	b=bYZDtrlOJfowSnKv1UVtnC1WdGQP6JDAGGr6ZyiiJYhV+oMd52czH5TRP/WFWiXNDXXy1l
	0dhqVaC3zkH82HDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B51B1369F;
	Thu,  4 Jul 2024 07:36:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kNufDBNRhmZgNwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 04 Jul 2024 07:36:51 +0000
Message-ID: <9de5d83c-4b05-4f69-8ab4-b4aa65e5ec62@suse.de>
Date: Thu, 4 Jul 2024 09:36:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] nvme-tcp: per-controller I/O workqueues
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240703135021.34143-1-hare@kernel.org>
 <20240703135021.34143-2-hare@kernel.org>
 <7e4444d0-f156-439e-9363-4beb86bb6248@grimberg.me>
 <c9f73300-9860-4965-88af-9a7b4d7b0e1b@suse.de>
 <ad15b94b-9414-4ec1-9acf-465a8b190fe5@grimberg.me>
 <ZoWFOnvgWEiKipW6@slm.duckdns.org>
 <aaa404b1-72ac-4b15-8c30-a62ef2216004@grimberg.me>
 <ZoWjxtyjHTC2r285@slm.duckdns.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZoWjxtyjHTC2r285@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240704_003653_987030_EC87AB1D 
X-CRM114-Status: GOOD (  14.28  )
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

On 7/3/24 21:17, Tejun Heo wrote:
> Hello,
> 
> On Wed, Jul 03, 2024 at 10:14:14PM +0300, Sagi Grimberg wrote:
> ...
>> None of these reasons are the claimed reason to use separate workqueues in
>> this patch. The claim is that it is more efficient, i.e. has less overhead.
>>
>> The commit msg is the following:
>> "Implement per-controller I/O workqueues to reduce workqueue contention
>> during I/O."
> 
> Hmm... it's not impossible for the concurrency accounting in pool_workqueues
> to show up if the issue rate is *really* high but I'd be surprised if that
> actually matters given that the backend pool is shared. Maybe I'm missing
> something but I don't see a reason why multiple workqueues would be more
> efficient than a shared one.
> 
Well, I seem to run into the 'really high' issue rate case:

		unbound workqueue		bound workqueue
		single wq	multi wq	single wq	multi wq
4k seq read:	247MiB/s	249MiB/s	263MiB/s	365MiB/s
4k rand read:	294MiB/s	305MiB/s	279MiB/s	307MiB/s
4k seq write:	504MiB/s	499MiB/s	521MiB/s	550MiB/s
4k rand write:	531MiB/s	536MiB/s	476MiB/s	453MiB/s

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


