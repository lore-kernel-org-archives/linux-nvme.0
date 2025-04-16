Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52B4C369BD
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Apr 2025 12:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HWj6JTdASeWQHaA+9GTxsyBFog3/7N3ZQNvJzRT3EAs=; b=F9Y49djq2Tfl+VxAkaeruFinvc
	5A90q85kz99mpGPpv1ZDCdFxDwQ1k1UhOgB0LUu9MaINKnmfXMf5Ac3rJHNjYnDB43JgHNoMoUmHn
	mdwqO/p/c7PEYkjEZ9Pm01SmGbo2YMsOJGR5JE7BIRHRAxVZ+7/ZVIlzII8i5BqSRpe4nWXxq2bOO
	sWIGb3/yE1/5LXYmOi13SlqOL0x3+J2uQr2eubo5lpbPSuOGqraXFh4I1uoR+Q3VpbuMQADGKZHww
	0NOWs8pCCAZYUuorEV52Ejh/Jxpi6sGBCqtye+jhuoKj1wo39qQ8N2EYQ+40tP9QgHp7a67MLFZQn
	ngbgOLOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u51v2-00000009WK2-1vnP;
	Wed, 16 Apr 2025 12:31:08 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u51qX-00000009VPW-3uA2
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 12:26:31 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 586131F461;
	Wed, 16 Apr 2025 12:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744806388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HWj6JTdASeWQHaA+9GTxsyBFog3/7N3ZQNvJzRT3EAs=;
	b=avzqWaoYg1m97bvEnKsDtA7e0/50oJ00tDS1MRxg5LlhOHwoGM5BJOuQX53muCHoNv5z+x
	haWn8F/u2bPUAFJhHDPaqDguId3QVyMh1qI51laS+mbaP+vX6NL0fLzylFQDveugHbVknH
	n76ZfHKfCBPee0cVeh18Y24ffxxr380=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744806388;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HWj6JTdASeWQHaA+9GTxsyBFog3/7N3ZQNvJzRT3EAs=;
	b=feRXZkRBd+MzI+Iy57Xd6sAQfqzD7JiWbYpol2hElYRKXEVqnuvjQKujrE6LYL3B9jsFwE
	03UNe5x7ZjCfRoBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744806388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HWj6JTdASeWQHaA+9GTxsyBFog3/7N3ZQNvJzRT3EAs=;
	b=avzqWaoYg1m97bvEnKsDtA7e0/50oJ00tDS1MRxg5LlhOHwoGM5BJOuQX53muCHoNv5z+x
	haWn8F/u2bPUAFJhHDPaqDguId3QVyMh1qI51laS+mbaP+vX6NL0fLzylFQDveugHbVknH
	n76ZfHKfCBPee0cVeh18Y24ffxxr380=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744806388;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HWj6JTdASeWQHaA+9GTxsyBFog3/7N3ZQNvJzRT3EAs=;
	b=feRXZkRBd+MzI+Iy57Xd6sAQfqzD7JiWbYpol2hElYRKXEVqnuvjQKujrE6LYL3B9jsFwE
	03UNe5x7ZjCfRoBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49F9F139A1;
	Wed, 16 Apr 2025 12:26:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jOJlEfSh/2dTKAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 16 Apr 2025 12:26:28 +0000
Date: Wed, 16 Apr 2025 14:26:23 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, bluca@debian.org, Hannes Reinecke <hare@suse.de>, 
	Keith Busch <kbusch@kernel.org>
Subject: Re: nvme-cli connect regression
Message-ID: <d7737471-8b06-4a78-af2a-6d8e3fb8ba38@flourine.local>
References: <b0904029-2ffd-4ea9-a8b7-bf7d4182ea29@flourine.local>
 <6b081163-2b00-4de9-85c1-7bc72909f90c@grimberg.me>
 <066cb0d9-95b1-49ac-92b4-43a212d0a7fa@flourine.local>
 <076c96a5-f399-457f-9ef1-491d81e0d8fb@grimberg.me>
 <CADUfDZo8mRaaT3RhXXGJiXmkkgUmY6+=O8cEPp2rE-U-LMupKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZo8mRaaT3RhXXGJiXmkkgUmY6+=O8cEPp2rE-U-LMupKg@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250416_052630_119674_0561557A 
X-CRM114-Status: GOOD (  13.50  )
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

On Tue, Apr 15, 2025 at 02:26:40PM -0700, Caleb Sander Mateos wrote:
> On Tue, Apr 15, 2025 at 2:14 PM Sagi Grimberg <sagi@grimberg.me> wrote:
> > Its not great that we now get sporadic EINTR errors. I am wandering what
> > is triggering this?
> >
> > Caleb, did you see this?
> 
> Yes, I did see it. I don't understand where EINTR could come from
> aside from the userspace process receiving a signal while waiting for
> the ICResp (or hitting the 10 second timeout waiting to receive the
> PDU). I don't understand how the switch to MSG_WAITALL would affect
> this. A tcpdump might be helpful to understand whether the controller
> is actually sending the full ICResp timely.

I think I can reproduce it. I have two connections and do a

   while nvme read ....; do yes; done

and block one of the connections, when the error handler kicks in the id
ns command fails with EINTR.

