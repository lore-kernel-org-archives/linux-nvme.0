Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51089ECAAD3
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Aug 2022 09:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IyNZcbNw3x+HqDlBuzflKEvvsa8NH5xBmE8tQFR5GSQ=; b=3ne8dhAZt9eVA+ZKPIuBqTNMUn
	TlxycAUql3g4lUATcqVrRxe/xMtVesHsB6UERYqUT+PVaQtqRex6FPlgg2u7pg4Se9rKyi/rxp+sd
	fcv0sg66NvIF/ieuuMX7kN7aQFbAaEyvTNcUqDZCkTiPrZia+NR+R2Bitxgmbq8bt2LPttHgEoJxp
	fRDzFByMeXScXH2JNzjL3TmZjlI26+fLTv28KzWgs8V8sYv++NtgKdCFB1FUv9kEA/jv83c3KY+Po
	dJm29eudEXG19AsFNtBrrvicEY4ztx8aAgkJybA3zshziIb5pkStn6pk23MdzrT2t70OpbMTOrhgW
	ew3FaiUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTJer-0059fH-Jq; Wed, 31 Aug 2022 09:05:13 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTJep-0059c8-7o
	for linux-nvme@lists.infradead.org; Wed, 31 Aug 2022 09:05:12 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B4B52223F;
	Wed, 31 Aug 2022 09:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1661936706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IyNZcbNw3x+HqDlBuzflKEvvsa8NH5xBmE8tQFR5GSQ=;
	b=Wc4B7eydriI8ZSpMIq0ms0A1NH5LBPgkQOUvkjJNJARXuMSdJQo8evAhw8NcjJ7UqT7l2x
	F4FzDfcGmtJpCTahD+v7bRemkT+UN/LvHP7clkYzBfz04aEEso7qpo9dkd9pfoZqqHBoQf
	HUWgIJK7WUMykhYqwX6vRXEXDjlZmk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1661936706;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IyNZcbNw3x+HqDlBuzflKEvvsa8NH5xBmE8tQFR5GSQ=;
	b=GDp6ZABC8h6Mi1vrcHsSqMcSAdmVXqxXyKc0lSxtsblHGpUBlZKfH9JVGd3RVLia1WKE6F
	3mUul6bVoSmdC+Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E9F31332D;
	Wed, 31 Aug 2022 09:05:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id oxJPB0IkD2OSOwAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 31 Aug 2022 09:05:06 +0000
Date: Wed, 31 Aug 2022 11:05:05 +0200
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <jsmart2021@gmail.com>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v3 0/3] Handle number of queue changes
Message-ID: <20220831090505.fnuaiczzmx65qyoc@carbon.lan>
References: <20220829083856.1850-1-dwagner@suse.de>
 <0ef532ad-819f-0e7b-402f-3ca20831109b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ef532ad-819f-0e7b-402f-3ca20831109b@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220831_020511_491682_6605FCBA 
X-CRM114-Status: GOOD (  14.00  )
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

On Mon, Aug 29, 2022 at 11:44:41AM -0700, James Smart wrote:
> Since you're in the area....
> 
> I recommend adding something to ensure that after a reconnect that if I/O
> queues were present in the prior association, the new controller must return
> support for at least 1 io queue or the reconnect fails and retries. This was
> a bug we hit on a subsystem in FC.

I suppose this is the fix for the problem you describe:

  834d3710a093 ("nvme-fc: reject reconnect if io queue count is reduced to zero")

A test with v4 gives this

 nvmet: adding nsid 1 to subsystem blktests-subsystem-1
 nvmet_tcp: enabling port 0 (127.0.0.1:4420)
 nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:.
 nvme nvme1: creating 8 I/O queues.
 nvme nvme1: mapped 8/0/0 default/read/poll queues.
 nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420
 nvmet: remove subystem from port
 nvme nvme1: failed to send request -32
 nvme nvme1: failed nvme_keep_alive_end_io error=4
 nvme nvme1: starting error recovery
 nvme nvme1: Reconnecting in 10 seconds...
 nvmet: set qid_max to 0
 nvmet_tcp: enabling port 0 (127.0.0.1:4420)
 nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:.
 nvme nvme1: creating 1 I/O queues.
 nvmet: invalid queue id (1)
 nvme nvme1: Connect Invalid SQE Parameter, qid 1
 nvme nvme1: failed to connect queue: 1 ret=16770
 nvme nvme1: Failed reconnect attempt 1
 nvme nvme1: Reconnecting in 10 seconds...
 nvmet: remove subsystem from port
 nvme nvme1: failed to connect socket: -111
 nvme nvme1: Failed reconnect attempt 2
 nvme nvme1: Reconnecting in 10 seconds...
 nvmet: set qid_max to 2
 nvmet_tcp: enabling port 0 (127.0.0.1:4420)
 nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:.
 nvme nvme1: creating 2 I/O queues.
 nvme nvme1: mapped 2/0/0 default/read/poll queues.
 nvme nvme1: Successfully reconnected (3 attempt)

It looks like the host is able to recover correctly even though the IO
queue count is 0.

