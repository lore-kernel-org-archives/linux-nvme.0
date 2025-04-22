Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34530C369C2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 18:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EgS7NBGOE/aws2pFM5uQ1GMt7Pa1egKB63uUf8n8U6U=; b=FkRpWoHO03jPhBrc/dvqZa/kE0
	Rhk0IuubUvn6C4IBX/zOQOQhTjoXZVPdYDgN05UdOd+yJm/6ce5BA5ZqkoDifFWt/mSZE75tVxgNG
	KvK6dRYNBtYLHpaGFjXOfDve/NJMB8PF+PIDbijzDnHoewDAcGgsBW7QktTitCXK6TtZmqmVXNudb
	meXh1PwhYmATuGeeUnkpLj/Grro230FIXA471MMpQ0i/TCBDK8t0Uo/2rmRkBM48KKc4nv3BupO6l
	W+c822P4jwvEoFNRTXkrHLZ7Wfks7alhgmpSO8xR89AX6zI6IL+1LsPsUKNh6ikOY4XgLwElQ5Id2
	JWW+uuHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7IUy-00000008C6P-2HPL;
	Tue, 22 Apr 2025 18:37:36 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7HLZ-000000081Cj-1zqB
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 17:23:50 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CAB102118B;
	Tue, 22 Apr 2025 17:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745342627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EgS7NBGOE/aws2pFM5uQ1GMt7Pa1egKB63uUf8n8U6U=;
	b=mLQVQ/+/6rkdW6Yu2VENue/I5YTXeEVhRRPwA8kI/kl4sgdyiH86Lnx2DUDx1GyVmRMLgd
	uKfhSFlOzYTDwKc0iDVJ3LrnBpufLgZNIVZJuK1v2uIq0PCcjnEkbnIoAPP0NjY7JyWFug
	oPqSxGy/NGc/rMgEfkQKAXepdivz5UY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745342627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EgS7NBGOE/aws2pFM5uQ1GMt7Pa1egKB63uUf8n8U6U=;
	b=e/4ZitHsDtxujMOzbzyMbz1ibGm1KZShHqlK/uqxQiW0BQFNgJ9SylVPFxur/9a2YDiVr6
	x4XOBK11/XpN77DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745342627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EgS7NBGOE/aws2pFM5uQ1GMt7Pa1egKB63uUf8n8U6U=;
	b=mLQVQ/+/6rkdW6Yu2VENue/I5YTXeEVhRRPwA8kI/kl4sgdyiH86Lnx2DUDx1GyVmRMLgd
	uKfhSFlOzYTDwKc0iDVJ3LrnBpufLgZNIVZJuK1v2uIq0PCcjnEkbnIoAPP0NjY7JyWFug
	oPqSxGy/NGc/rMgEfkQKAXepdivz5UY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745342627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EgS7NBGOE/aws2pFM5uQ1GMt7Pa1egKB63uUf8n8U6U=;
	b=e/4ZitHsDtxujMOzbzyMbz1ibGm1KZShHqlK/uqxQiW0BQFNgJ9SylVPFxur/9a2YDiVr6
	x4XOBK11/XpN77DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE598139D5;
	Tue, 22 Apr 2025 17:23:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v8UtKKPQB2jlAgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 22 Apr 2025 17:23:47 +0000
Date: Tue, 22 Apr 2025 19:23:42 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	hare@kernel.org, kbusch@kernel.org, gjoyce@ibm.com
Subject: Re: [PATCHv2 2/4] tree: add queue-depth attribute for nvme path
 object
Message-ID: <ad838a6d-6180-4c00-85b2-448393689478@flourine.local>
References: <20250417135951.239447-1-nilay@linux.ibm.com>
 <20250417135951.239447-3-nilay@linux.ibm.com>
 <0e70314a-3c08-40ab-ac53-e9fb7e379f44@suse.de>
 <20e5b90b-3c2c-4be8-8119-b14fab733a5a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20e5b90b-3c2c-4be8-8119-b14fab733a5a@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_102349_660253_20B188D1 
X-CRM114-Status: GOOD (  11.94  )
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

On Tue, Apr 22, 2025 at 08:02:49PM +0530, Nilay Shroff wrote:
> > As discussed: saving the 'queue_depth' attribute is a bad idea, as it
> > changes frequently.
> > I'd rather read the attribute value from sysfs whenever
> > 'nvme_path_get_queue_depth' is called, and use the tree structure only
> > to hold the pathname.
> > 
> Yes correct, but I thought we discussed about implementing non-cached
> version of API in libnvme 2.x. So I implemented cached version of 
> queue_depth API. Daniel can you confirm? 

I was under the impression that we agreed on the default being
non-cached. As it doesn't really make sense to have a cached anyway.

