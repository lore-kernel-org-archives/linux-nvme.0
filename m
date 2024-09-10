Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A27AECE564
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Sep 2024 07:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FS19rj/aA09rFJRzEFgoWweCccAGFfFv5fmPwD84/98=; b=l3cfPIOxTHG4uvU5UI5Wj2MXqm
	2rzDW2De7b+ZLNes4yx0gdDgQjAIgZNuTAN5OniCTj26RZBN54y1HJAkxGuB/bcmLoLuqzE2pNNrA
	LcATJzJU+GjUpA+rAXJkcrwQXwsZSmrGPHJOMs6H2Bt8LOBAJH+XVL6/pr+p1BEUNtUFmyw3R9F7Z
	PNjoSWJQD5wn8TBj3zMPSd98uj5Mp+eYvCy9Rj8ss6naGG1YKY4Qeh/n2RiIw2sYHno+ws0Xbn1qc
	m1A+dBX+OfpSZTmaziWfk/AbFY9a8+zLRns1GLxu3KMB5brL2cs/dhSsEzjsRY9lL6ZO59xIUaWJM
	4LfaFcVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snvIG-00000004b3l-2rhE;
	Tue, 10 Sep 2024 07:28:08 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snvIC-00000004b2H-2ddy
	for linux-nvme@lists.infradead.org;
	Tue, 10 Sep 2024 07:28:07 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BEEE6219FB;
	Tue, 10 Sep 2024 07:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725953281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FS19rj/aA09rFJRzEFgoWweCccAGFfFv5fmPwD84/98=;
	b=j0yaxKUQ+KEu7FXcSkoUXww080dk5TGCM3a3wqYB43ShgkLlhp27OWgpbdTFCsBUKc6d9t
	i7sncC4SNbOKqCuzyBsYhM3Z0x4uYr1s/d1Tw306Xt+1m7HCNa+ymBBiyZIIHUfSW1BuUo
	tpclknqqJ7x7LdweSUnwEN7AyhJ1fG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725953281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FS19rj/aA09rFJRzEFgoWweCccAGFfFv5fmPwD84/98=;
	b=JiYL8/CjBIGcBWktUmHLbJ6i5fuNKm5sTAQgkgFMXEVz1+tTYrjG44rQDeT5RY+xXpYFue
	2ApHRckQ1LmUU0Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725953281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FS19rj/aA09rFJRzEFgoWweCccAGFfFv5fmPwD84/98=;
	b=j0yaxKUQ+KEu7FXcSkoUXww080dk5TGCM3a3wqYB43ShgkLlhp27OWgpbdTFCsBUKc6d9t
	i7sncC4SNbOKqCuzyBsYhM3Z0x4uYr1s/d1Tw306Xt+1m7HCNa+ymBBiyZIIHUfSW1BuUo
	tpclknqqJ7x7LdweSUnwEN7AyhJ1fG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725953281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FS19rj/aA09rFJRzEFgoWweCccAGFfFv5fmPwD84/98=;
	b=JiYL8/CjBIGcBWktUmHLbJ6i5fuNKm5sTAQgkgFMXEVz1+tTYrjG44rQDeT5RY+xXpYFue
	2ApHRckQ1LmUU0Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A505F13A3A;
	Tue, 10 Sep 2024 07:28:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SCLZJQH132ZyJgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 10 Sep 2024 07:28:01 +0000
Date: Tue, 10 Sep 2024 09:28:00 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org, 
	sagi@grimberg.me, axboe@fb.com, gjoyce@linux.ibm.com
Subject: Re: [PATCHv3 RFC 1/1] nvme-multipath: Add sysfs attributes for
 showing multipath info
Message-ID: <c9f2be83-e3a1-4d5f-b2c8-f91684927d63@flourine.local>
References: <20240903135228.283820-1-nilay@linux.ibm.com>
 <20240903135228.283820-2-nilay@linux.ibm.com>
 <e9f36c3a-e2c6-4d95-89c8-40e8b9b3594c@flourine.local>
 <1cf163d0-9406-4605-a16e-56f75170e12b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cf163d0-9406-4605-a16e-56f75170e12b@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_002804_843205_7E404CD6 
X-CRM114-Status: GOOD (  10.66  )
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

On Tue, Sep 10, 2024 at 12:14:08PM GMT, Nilay Shroff wrote:
> >> +		if (ns == current_ns)
> >> +			node_set(node, numa_nodes);
> > 
> > And if ns matches current_ns can't you break the loop?
> I think no. Here we map each numa node preferred for a namespace path.
> So for instance, if the current_ns (nvmeXcYnZ) path  is preferred for I/O 
> workload running on numa nodes i and j then we accordingly set the
> respective node values (i and j) in the nodemask (numa_nodes) which is a 
> bitmap.

Okay, got it.

Thanks,
Daniel

