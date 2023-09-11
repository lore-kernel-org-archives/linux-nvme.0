Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF11EE7FF4
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Sep 2023 12:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s5rMGM6Sk7+ypNL4iTYsBOZWgsFDohdDhMTFVQxzcWo=; b=jDMjDLJQFfr8RsBpLR5izg5XpG
	P5X6uqDWvpMrKG1zdhF4wR7MInZ1EDJEM1dtmdl5duGEOdGtlzm6xHenJk3c9HujVpn9Kv+wHiUWy
	uwfouJGLzQXBeJB6l00HJIeE9zP9thWPW+ggLGiUy7iYrvtO8Kbqs/pvq8EIDLairDbb/XNlgkA2/
	aefza4qVGs7ftvGfHkJJVh4cxVN+r+HnaCLFSp80UPwSG/7lnZcp7aQni66le0eKo/Y+/rGjDgZ52
	IPY3yzepICduI8R+HPEyks9QWOtJRNKIeUdGJo71zZwwTXPsGADmH3MfWfzkPN2BASS1rgobBOw5N
	JiMKZJNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qffpo-000T5B-2F;
	Mon, 11 Sep 2023 12:16:08 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qffpm-000T3g-10
	for linux-nvme@lists.infradead.org;
	Mon, 11 Sep 2023 12:16:07 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A45941F8A6;
	Mon, 11 Sep 2023 12:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694434563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s5rMGM6Sk7+ypNL4iTYsBOZWgsFDohdDhMTFVQxzcWo=;
	b=0u04b+E7qACQFXxagzsblEUC5xk9SywAyco4Ksj2NE/5Q0ldsd0PbsYIDc1sNb0VrcGVoU
	NIOj3ZP8hBWkuKMoP6kgby+x1cfZ/yBde1EOu4WAqROKlAFqqySG7l/rmpxEqQf8iDh7t2
	iYq2ZiRp7BtcAG628qSsHC2BnDVRcYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694434563;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s5rMGM6Sk7+ypNL4iTYsBOZWgsFDohdDhMTFVQxzcWo=;
	b=BADAqw6WcfCczVQWIpygYROfPRjvG2dh0eMuRWGX8zFJDpalsIzlPy1bSwA8XGV5Jpp83N
	/a8jjsZopubXxmAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97606139CC;
	Mon, 11 Sep 2023 12:16:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Rp/hJAMF/2SABAAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 11 Sep 2023 12:16:03 +0000
Date: Mon, 11 Sep 2023 14:16:39 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Yi Zhang <yi.zhang@redhat.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] tests/nvme/031: fix connecting faiure
Message-ID: <ndeue7dj4w4w26tndeya2imsct3s4c2ay2a7zpylfvahizn44t@taagv26xb3ha>
References: <20230907034423.3928010-1-yi.zhang@redhat.com>
 <nrfuja62qetxqxzwxuxhjve2u4r4reofcpo43zmg6qbbhjjqkp@ratsu2kubymb>
 <kflpcc7u4wksuuo27gcrjxwsqr277b3phpnbbbjkdaniycmttn@f6t4dadmvqih>
 <swd5rjag3soiz5b6fkktk5vncfjtb4wemrbtl4fwkpcx6uodg7@5wnw5gf6luz6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <swd5rjag3soiz5b6fkktk5vncfjtb4wemrbtl4fwkpcx6uodg7@5wnw5gf6luz6>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_051606_502083_9E87DA6D 
X-CRM114-Status: GOOD (  14.65  )
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

On Mon, Sep 11, 2023 at 11:00:17AM +0000, Shinichiro Kawasaki wrote:
> > nvmf_wait_for_state "${def_subsysnqn}" "live"
> > nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
> > 
> > We could make this a bit more generic and move it into the connect
> > helper. What do you think?
> 
> This nvme state file check looks a bit complicated, but looks more robust than
> "nvme connect" command exit status check. Do you think that "nvme connect" can
> fail even when "nvme connect" command returns good status? If so, your approach
> will be the way to choose.

Currently, 'nvme connect' is a synchronous call for tcp/rdma but not for
fc. 'nvme connect' for tcp/rdma will report an error if something is
wrong but not for fc, because it always return successfully.

The nvme/005 is exposing the behavior differences between the
transports. My long time goal is to address and make all transport
behave the same way (unification of the state machines). But as it
currently stands fc would need someting like this to make sure we are
not blindly reporting success just because the 'nvme connect' call is
successful.

This type of check would make the test suite more robust and better in
detecting errors.

