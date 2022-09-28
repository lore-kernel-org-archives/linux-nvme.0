Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB59C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 09:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hppIXI6gKJMPFVR5oWvMVE5USBA2TY6DTGJGJpMGwz0=; b=pu27eeSqtjTcMib7JBOnzCo7Hh
	rcyHqHj7h/rzphYjA4REvhC6g54/tzEnJWXKgt90tJ8sRPI712K72Nq6uwzY5w5uljeca7r7kA1Mg
	InVaTE/as3VA0ZzjkLfybYj3jAbT9/jDKa58MVFhC+z8SdS5Nxwbe6OURqWR7Mt4FQTPyzoDRnyRX
	v9xjMwi6fXsGfYkQhwPbdiAdgK3917i4sFWkIf5U7HT/moIXBa5aWZeVvWMeqhZzO2Y5zKqd1uFZD
	mxDr6Z7EpABV/VF8cRAoaNMBSs4hbEt9OxbY7y5n41V65zeaz7qLRU7qri3FN3YCPsa26BXtWDDVD
	l6sX3frA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odSxw-00F42b-H9; Wed, 28 Sep 2022 09:02:52 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odSxt-00F40N-Va
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 09:02:51 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A1C811F937;
	Wed, 28 Sep 2022 09:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1664355764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hppIXI6gKJMPFVR5oWvMVE5USBA2TY6DTGJGJpMGwz0=;
	b=GjMKiJz4X7s8HLX1btVUVHcipTQz2oBE2E7SxDAyiFAlPWHDoE7oATjV1Jp2P1/s/p2nu2
	IeqHOwvVtQuPKvyXtU4d2DHVSVKfkyqx7uUF6hPq1dtUBayksG06Ivyv+bBIHBKz0p+Vng
	9SZNKdZY+fU5Ke6xCZRfCHsBL1M2ZzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1664355764;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hppIXI6gKJMPFVR5oWvMVE5USBA2TY6DTGJGJpMGwz0=;
	b=rT/ouM/T8LM6Y4stkuXoYeQ2rJHd+KhVu2+mVkT0MyCHnFYNYJKGQfLecI3TSxl+A8I6fV
	QrWU6k/fvchLoBDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 92AE413A84;
	Wed, 28 Sep 2022 09:02:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id vgrDI7QNNGM0YwAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 28 Sep 2022 09:02:44 +0000
Date: Wed, 28 Sep 2022 11:02:43 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, hare@suse.de,
	Frederick.Knight@netapp.com
Subject: Re: [PATCH v2] nvmet: force reconnect when number of queue changes
Message-ID: <20220928090243.c4ctbj2frydwsfav@carbon.lan>
References: <20220927143157.3659-1-dwagner@suse.de>
 <d151b0c1-d28e-faeb-03d4-ed28b9768ee2@grimberg.me>
 <20220928074850.h6rwvwgz2oje3ebg@carbon.lan>
 <f1909450-1435-9661-056f-b955d6089ca7@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1909450-1435-9661-056f-b955d6089ca7@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_020250_188200_DF78692B 
X-CRM114-Status: GOOD (  38.34  )
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

On Wed, Sep 28, 2022 at 11:31:43AM +0300, Sagi Grimberg wrote:
> 
> > > > In order to be able to test queue number changes we need to make sure
> > > > that the host reconnects.
> > > > 
> > > > The initial idea was to disable and re-enable the ports and have the
> > > > host to wait until the KATO timer expires and enter error
> > > > recovery. But in this scenario the host could see DNR for a connection
> > > > attempt which results in the host dropping the connection completely.
> > > > 
> > > > We can force to reconnect the host by deleting all controllers
> > > > connected to subsystem, which results the host observing a failing
> > > > command and tries to reconnect.
> > > 
> > > This looks like a change that attempts to fix a host issue from the
> > > target side... Why do we want to do that?
> > 
> > It's not a host issue at all. The scenario I'd like to test a when
> > target changes this property while the host is connected (e.g. software
> > updated -> new configuration). I haven't found a way to signal the host
> > to reset/reconnect from the target. Hannes suggested to delete all
> > controllers from the given subsystem which will trigger the recovery
> > process on the host on the next request. This makes this test work.
> 
> But that is exactly like doing:
> - remove subsystem from port
> - apply q count change
> - link subsystem to port
> 
> Your problem is that the target returns an error code that makes the
> host to never reconnect. That is a host behavior, and that behavior is
> different from each transport used.

Yes, I try to avoid to trigger the DNR.

> This is why I'm not clear on weather this is the right place to
> address this issue.
> 
> I personally do not understand why a DNR completion makes the host
> choose to not reconnect. DNR means "do not retry" for the command
> itself (which the host adheres to), and it does not have any meaning to
> a reset/reconnect logic.

I am just the messenger: Besides Hannes' objection in the last mail
thread, I got this private reply from Fred Knight:

   Do Not Retry (DNR): If set to ‘1’, indicates that if the same command is
   re-submitted to any controller in the NVM subsystem, then that
   re-submitted command is expected to fail. If cleared to ‘0’, indicates
   that the same command may succeed if retried. If a command is aborted
   due to time limited error recovery (refer to the Error Recovery section
   in the NVM Command Set Specification), this bit should be cleared to
   ‘0’. If the SCT and SC fields are cleared to 0h, then this bit should be
   cleared to ‘0’.a

   It simply makes NO SENSE to retry that command. If the device wants the
   host to retry, then it will clear DNR=0.

> In my mind, a possible use-case is that a subsystem can be un-exported
> from a port for maintenance reasons, and rely on the host to
> periodically attempt to reconnect, and this is exactly what your test is
> doing.

Yes and that's the indented test case. The number of queue change is on
top of this scenario. It's a combined test case.

> > Though if you have a better idea how to signal the host to reconfigure
> > itself, I am glad to work on it.
> 
> I think we should first agree on what the host should/shoudn't do and
> make the logic consistent between all transports. Then we can talk about
> how to write a test for your test case.

Fair enough. This here was just my cheesy attempt to get things
moving.

