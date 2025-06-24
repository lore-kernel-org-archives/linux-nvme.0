Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BCDC71157
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jun 2025 14:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tSMn2/kK/Xcem1NaWVKA/XCYh1v74ybfbdrQQ7Q7zPI=; b=j3+2urIUz4VS1b5p0JGUfN7v19
	3e5AvoioI1VPo0/i+IsYV/cLdrEbYGIE1Ue1ouQUkeQUY6OPKnBoqbok482ZAV/7vnieF3zYkP7M9
	e6AIkOAM4+uN9Yvh0eBoQVVJ8aAOsg0y34ztp4mH9KvBrYllKmyNXWyyNG0anYa0VIVUbHLwHOmme
	5xBZhXdQaViXoTYNplSsS3ZkkPRUHROl52DOG3BMafcbgfLgScw2XG6f3Q2wU3fBb8uTIt5AyIqU+
	12H6QoIkK9/oa+zT9KjWcr7Td+AnA6NjuUOMkObFuw1MdhDj5zC2ncE6FkBtwI+MHV64//evqf5a5
	LSazM45Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU4PZ-00000005r2L-40hN;
	Tue, 24 Jun 2025 14:14:09 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU3v9-00000005kaL-2RLl
	for linux-nvme@lists.infradead.org;
	Tue, 24 Jun 2025 13:42:45 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9321721114;
	Tue, 24 Jun 2025 13:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750772560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tSMn2/kK/Xcem1NaWVKA/XCYh1v74ybfbdrQQ7Q7zPI=;
	b=ACaUDE82Ln2DTxIO53SAqDhI7yT1oLGbaa+CRfM24shoR2IAMbT17UXwbOfK2EzkWzwaVc
	ngEgZkKwz3DQHs95QRL7DL3F5f8Y+FX8KPP5ZTFLOO6gs1b69DkdGaq1Vwn8WPhKTY5Tt+
	RNd1viZaHepEHdE1wCOuhPVlsLvGieg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750772560;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tSMn2/kK/Xcem1NaWVKA/XCYh1v74ybfbdrQQ7Q7zPI=;
	b=b1O1RMZKyW38ITMQd23zRPzSABHCphg1TQBSiHKt3gsjB4HapCMwr9jL34TmW2i7JYtHI5
	D+qe9nRB2dO/zhBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ACaUDE82;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=b1O1RMZK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750772560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tSMn2/kK/Xcem1NaWVKA/XCYh1v74ybfbdrQQ7Q7zPI=;
	b=ACaUDE82Ln2DTxIO53SAqDhI7yT1oLGbaa+CRfM24shoR2IAMbT17UXwbOfK2EzkWzwaVc
	ngEgZkKwz3DQHs95QRL7DL3F5f8Y+FX8KPP5ZTFLOO6gs1b69DkdGaq1Vwn8WPhKTY5Tt+
	RNd1viZaHepEHdE1wCOuhPVlsLvGieg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750772560;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tSMn2/kK/Xcem1NaWVKA/XCYh1v74ybfbdrQQ7Q7zPI=;
	b=b1O1RMZKyW38ITMQd23zRPzSABHCphg1TQBSiHKt3gsjB4HapCMwr9jL34TmW2i7JYtHI5
	D+qe9nRB2dO/zhBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7725A13751;
	Tue, 24 Jun 2025 13:42:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o1axGlCrWmjQbgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 24 Jun 2025 13:42:40 +0000
Date: Tue, 24 Jun 2025 15:42:39 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org, 
	sagi@grimberg.me, hare@suse.de, axboe@kernel.dk, shinichiro.kawasaki@wdc.com, 
	gjoyce@ibm.com
Subject: Re: [PATCH 1/1] nvme: correctly account for namespace head reference
 counter
Message-ID: <d8ee4292-e213-46f2-8605-70ab7d90592c@flourine.local>
References: <20250620080257.27993-1-nilay@linux.ibm.com>
 <e0da70ca-ba39-4511-ab77-ca8b3a6a6c39@flourine.local>
 <c7abfd6f-f96e-480b-be18-b509a235aa36@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7abfd6f-f96e-480b-be18-b509a235aa36@linux.ibm.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9321721114
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250624_064243_774927_8F5F5DF8 
X-CRM114-Status: GOOD (  12.03  )
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

On Tue, Jun 24, 2025 at 07:00:39PM +0530, Nilay Shroff wrote:
> > Could the put moved in front of 'goto out_unlink_ns'?
> 
> I believe you would want to move the second nvme_put_ns_head()
> above as the first statement under out_unlink_ns label as shown
> below:
> 
> out_unlink_ns:
> 	nvme_put_ns_head(ns->head);
> 	mutex_lock(&ctrl->subsys->lock);
> 	list_del_rcu(&ns->siblings);
> 	if (list_empty(&ns->head->list)) {
> 		list_del_init(&ns->head->entry);
>                 last_path = true;
>         }
> 	mutex_unlock(&ctrl->subsys->lock);
>         if (last_path)
>                 nvme_put_ns_head(ns->head);
> 
> If that's the case, and this is indeed the last reference to ns->head,
> then nvme_put_ns_head() could potentially free the ns->head object. 
> If that happens, any access to ns->head afterward — such as ns->head->list
> — would result in a use-after-free and potentially trigger a kernel oops,
> correct?

Ah sorry brainfarth, you are right.

