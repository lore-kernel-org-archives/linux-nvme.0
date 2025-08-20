Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7431CCA0EFA
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Aug 2025 09:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jxxe0jL4GSsatgngtd4oCt0YK/m9IMTmQVcIp/M3WOc=; b=asNNb7YUSG1WZsn6oPJ6s2A3iM
	4LMFlM2qatYTOUQSzT6AZS1YLt8yll01j4TKNLKMNQWO5ARrnHO+0TOd98w8nCgAK2IKTWtxVASKQ
	SiNkLn5/8WzIBHHx4Q0K92cNSGIFf4ux8+HkJdjiZqntZY8woLl+Y+AdEDnFaeoX4Mpl5FbfxQJl6
	m10Cs8m9NrpFtJzvvC8yIbxA/Iw9xC0u2kWKFCc4Nd4NJERUJh7tq3llnel3Qzfel+r7FZrMO0mKb
	YKn86p7Hw7btlFSBbbnDJkFqeBccM8QJ/0NrWCvT0pT6lUsEvOkFX5j1cQBp0WjroaMZqpzEQgILW
	2LFZ9wXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoeyn-0000000CtKr-3chJ;
	Wed, 20 Aug 2025 09:19:37 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoeIr-0000000Cle1-1yqz
	for linux-nvme@lists.infradead.org;
	Wed, 20 Aug 2025 08:36:18 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D3B5D1F847;
	Wed, 20 Aug 2025 08:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755678976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jxxe0jL4GSsatgngtd4oCt0YK/m9IMTmQVcIp/M3WOc=;
	b=jLmeR4LknOBFDdAY0/VWe9vb9Ar61mkL4W13icouM7JfVax0Bt4FOYhISb/skymkN1RoZd
	wow/ioM1mp78CiZ0lToVs6y0BmvaQntd+NBc/xiTpAcDrJGaJlzIZqs8kkRtqmbii8qsy9
	L35FkPCPIxWq0wY6qNEYWbMOHU8dmqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755678976;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jxxe0jL4GSsatgngtd4oCt0YK/m9IMTmQVcIp/M3WOc=;
	b=YppakVYXiOCPh9k+oWGP0EAKhWr3IP61paGeth7Llr1Jd1azjpDxHKqmwwTzlddSDrRn+r
	uyxsUZaBRsJJjpAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jrDGbTOn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qdgs10Xi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755678975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jxxe0jL4GSsatgngtd4oCt0YK/m9IMTmQVcIp/M3WOc=;
	b=jrDGbTOn4dQBYa2P903GkheMekDqMFbDil6uI9HYMP6RZ8nJBGu8iStQa3BBlBq+cUktMX
	RxQyhPqFuhYVQ0rsZ1V/b57b/1aLJ3B+Asl13ISzaqlkUy+vUgmuRvyh+a7Ypo5ZLRROX4
	OJxdajD+l65EdgQ7pwuJ6vM38cIQiRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755678975;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jxxe0jL4GSsatgngtd4oCt0YK/m9IMTmQVcIp/M3WOc=;
	b=qdgs10Xicq4ujiCtGRRAl16wLrsLihrsQfEjxlg41NqLQS6Kpuwvx0traUY0gebWxfrSI7
	/S+ksOB7OrJ8vPBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C60EB1368B;
	Wed, 20 Aug 2025 08:36:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sO5eL/+IpWihbQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 20 Aug 2025 08:36:15 +0000
Date: Wed, 20 Aug 2025 10:36:15 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	james.smart@broadcom.com, Maurizio Lombardi <mlombard@redhat.com>, 
	Ewan Milne <emilne@redhat.com>
Subject: Re: [bug report] blktests nvme/fc nvme/057 triggered kernel panic
Message-ID: <01a710c5-c559-4d4a-afa6-c9d542ea964a@flourine.local>
References: <CAHj4cs9U48Xjd-ZShsP6GjZFyp7_Sp7i2gFdT-Btfvpouu4akQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs9U48Xjd-ZShsP6GjZFyp7_Sp7i2gFdT-Btfvpouu4akQ@mail.gmail.com>
X-Rspamd-Queue-Id: D3B5D1F847
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_013617_660603_AF6A32F4 
X-CRM114-Status: GOOD (  11.99  )
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

On Wed, Aug 20, 2025 at 04:20:40PM +0800, Yi Zhang wrote:
> My recent blktests testing triggered the kernel panic issue with
> kernel 6.17.0-rc2.
> Please help check it and let me know if you need any info/testing for
> it, thanks.
> 
> [1] reproducer
> stress blktests nvme/fc nvme/057

I will look into it. I've got a similar bug report from our internal QA
which I have debugged but not fixed yet.

The async handling code is not able to handle more than one in-flight
command (__nvmet_fc_send_ls_req). I was able to trigger the bug by
running nvme/044 for the FC transport in a tight loop.

This might be related here, as it seems to happen when disconnecting
from the target, similar to the stacktrace I see with nvme/044.

