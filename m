Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0C9C47DDF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jan 2024 15:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+TNxNSzp1WEagRtBVGv/aF71XG+4G8HcGl0DsseuFHM=; b=qPON2XbbYoHVGAabg5dB5HZ5Pk
	Pm0DPw8OUI4jcR3QGVCOPyqZa9hMXp0tKYzUwQBI9l1YlAr1+mSAsAnpm94NVo9q5T3GIStlu6t3F
	RnREvKbMORdKB/nd8HqdJt0hNMxkECyARLGgwqDl9P6+yRCiz/kPyzXqHqHvHvoz+smWA5K2Jr3uX
	t4ylA2GnOIU0aRidj/Ue7A9wOX2T/u6uDBgNJYnaOccDh6oLoKBVNCTW13YA/9BcfBXJBgg3UBYn2
	ez/ANgjxy6C1FbJWPPLMawg45aqjFffmo1hxE6+a05H8geaYXJ/x9f6AIpEr/BzTwdKJIJa8wyi1j
	MydGcJYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTOCC-00000004XMp-30Vn;
	Fri, 26 Jan 2024 15:32:44 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTOC8-00000004XLM-05bY
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jan 2024 15:32:42 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4BB0321E57;
	Fri, 26 Jan 2024 15:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706283157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+TNxNSzp1WEagRtBVGv/aF71XG+4G8HcGl0DsseuFHM=;
	b=0drT4lGQpvUt4WK4ysownZegDpPOo0EItQQiy7kujasgmnALjjABa1cvwq4df5VJfsKQGo
	fnzT/a2fOWb2JZ8xCAB4Kdw3NzIbY9bN04vK9KvX+ba3L2Ps280dTIm4cjbjjnYf0s/lLJ
	Qhs0h1k645BLVUo5q12aDoyR5opbbFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706283157;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+TNxNSzp1WEagRtBVGv/aF71XG+4G8HcGl0DsseuFHM=;
	b=xTF+SVWxa/MomdsUmzub+0wTDk7HMztkde+0t6Ucyhe+NQgmTzT05KIoIPAGiOznJStQwc
	kG2/3xzjWvh0FNCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706283157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+TNxNSzp1WEagRtBVGv/aF71XG+4G8HcGl0DsseuFHM=;
	b=0drT4lGQpvUt4WK4ysownZegDpPOo0EItQQiy7kujasgmnALjjABa1cvwq4df5VJfsKQGo
	fnzT/a2fOWb2JZ8xCAB4Kdw3NzIbY9bN04vK9KvX+ba3L2Ps280dTIm4cjbjjnYf0s/lLJ
	Qhs0h1k645BLVUo5q12aDoyR5opbbFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706283157;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+TNxNSzp1WEagRtBVGv/aF71XG+4G8HcGl0DsseuFHM=;
	b=xTF+SVWxa/MomdsUmzub+0wTDk7HMztkde+0t6Ucyhe+NQgmTzT05KIoIPAGiOznJStQwc
	kG2/3xzjWvh0FNCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DF1F134C3;
	Fri, 26 Jan 2024 15:32:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xfbCCZXQs2WxBgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 26 Jan 2024 15:32:37 +0000
Date: Fri, 26 Jan 2024 16:32:36 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 08/16] nvmet-fc: untangle cross refcounting objects
Message-ID: <oj5l4uvhmp4hmapvzysq7lkstqcu3mnwq2kp366pipmqlhujam@zylmuxdo5ili>
References: <20231218153105.12717-1-dwagner@suse.de>
 <20231218153105.12717-9-dwagner@suse.de>
 <20231219051648.GA32634@lst.de>
 <l3etc7ia7mx7fc6ko764amf56xrink2vyv3kdirzcuzwfls2nz@wy66e6t4oxbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <l3etc7ia7mx7fc6ko764amf56xrink2vyv3kdirzcuzwfls2nz@wy66e6t4oxbl>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0drT4lGQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xTF+SVWx
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4BB0321E57
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240126_073240_253546_0FB2C12C 
X-CRM114-Status: GOOD (  25.94  )
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

On Thu, Dec 21, 2023 at 10:17:30AM +0100, Daniel Wagner wrote:
> On Tue, Dec 19, 2023 at 06:16:48AM +0100, Christoph Hellwig wrote:
> > On Mon, Dec 18, 2023 at 04:30:56PM +0100, Daniel Wagner wrote:
> > > The live time of the queues are strictly bound to the lifetime of an
> > 
> > > +	struct nvmet_fc_tgt_queue	*_queues[NVMET_NR_QUEUES + 1];
> > >  	struct nvmet_fc_tgt_queue __rcu	*queues[NVMET_NR_QUEUES + 1];
> > 
> > For magic prefixes we use __, not _ in Linux.  But having two arrays
> > of queues right next to each other, once with rcu annotation and one
> > not rings a bit far warning bell to me.  Why do we have both?  When
> > are we supposed to use either?  Why is FC different from rest?
> 
> This is my attempt to solve the problem that after NULLing the rcu
> pointer and wait for an RCU graceperiod I still need to cleanup the
> queues. Thus I need to keep hold on the queue pointers a bit longer.
> Indeed not so elegant.
> 
> I'm sure there is a better way to do it, I just didn't figure it out
> when I wrote this part. Any tips are highly welcomed how to solve this
> puzzle.

Looking at this code again, I don't think we need use RCU for the queues
pointers at all. The association is already under RCU and thus the
queues pointers don't need additional RCUing. We either can lookup the
association or not and the queue pointer's lifetime is under kref rules.
So with this in mind the lookup would be:

	rcu_read_lock();
	list_for_each_entry_rcu(assoc, &tgtport->assoc_list, a_list) {
		if (association_id == assoc->association_id) {
			queue = assoc->queues[qid];
			if (queue &&
			    (!atomic_read(&queue->connected) ||
			     !nvmet_fc_tgt_q_get(queue)))
				queue = NULL;
			rcu_read_unlock();
			return queue;
		}
	}
	rcu_read_unlock();
	return NULL;

No need for more complexity :)

