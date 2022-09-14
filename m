Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA2FECAAD3
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Sep 2022 09:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bokhvs7sX8fh8AVbSCmXbrCGvBqK7KW80w2nfKTLhrs=; b=ENzVDqCD4/1Kg+XJOchisxrrTh
	YHkx0x9ZbYIF3VwcUJH83CeEDrrhQJNfGeJh1DBxdkGNbl68HXybsKDH4zeBxDjlhMoXYq8gc3f7m
	AzedOsIUUJLA4GB1QIejLIIA0auGPziu7KI9Aho/z0Gk+Hr6RVPhfVWx82pOkhmWLE/NusbGC+Uth
	QRPNnm6zsEMwjqtHmS77ETTT4KwIn7K5mdfvExQWi2c277VidiPg4wFqmupqs5bGSJge64KXM8KvO
	psrTuU+hGeWFCb8e8JmDqBU1a951SDXwb5Jlgla9MspRvzZS2wYFVdehSusNCB9KLKD6YtzCAZxb5
	OEhH9oug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYOZ2-00E6tB-6H; Wed, 14 Sep 2022 09:20:12 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYOFc-00DmvI-C9
	for linux-nvme@lists.infradead.org; Wed, 14 Sep 2022 09:00:10 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8C16D5CD4D;
	Wed, 14 Sep 2022 09:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1663146004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bokhvs7sX8fh8AVbSCmXbrCGvBqK7KW80w2nfKTLhrs=;
	b=ZBuSfVi8EOcgWgj/6Ysob+atu3CpNG2Qo14ItKyy7X4EMBNEDCZGMH8+v0RVjL8eyUnmVQ
	Qfq2w64gpZigLB8sbzTTP4/TM4VR2H44/gjojgS3fyId1P7L99pNrWCaJQpARg2IbmQhZN
	J8qDyVoCipSfWuCcCqEpVaxXr8CUJGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1663146004;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bokhvs7sX8fh8AVbSCmXbrCGvBqK7KW80w2nfKTLhrs=;
	b=1PpqbsazDr6CsJjx6MVyc98M/G2hQsb7zSW4Mt7xBXU0kT6qDrAOoospC1+MxmudOiWV+x
	DbWkhd6he2cMvcBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FDF713494;
	Wed, 14 Sep 2022 09:00:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id P9YwHxSYIWMqHQAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 14 Sep 2022 09:00:04 +0000
Date: Wed, 14 Sep 2022 11:00:03 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests v3] nvme/046: test queue count changes on
 reconnect
Message-ID: <20220914090003.jbc5xmtfxjjssuz3@carbon.lan>
References: <20220913065758.134668-1-dwagner@suse.de>
 <20220913105743.gw2gczryymhy6x5o@shindev>
 <20220913114210.gceoxlpffhaekpk7@carbon.lan>
 <20220913171049.kgim57lu5rqb7j3g@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913171049.kgim57lu5rqb7j3g@carbon.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220914_020008_626474_9F027282 
X-CRM114-Status: GOOD (  16.61  )
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

On Tue, Sep 13, 2022 at 07:10:49PM +0200, Daniel Wagner wrote:
> On Tue, Sep 13, 2022 at 01:42:11PM +0200, Daniel Wagner wrote:
> > On Tue, Sep 13, 2022 at 10:57:44AM +0000, Shinichiro Kawasaki wrote:
> > > FYI, each blktests test case can define DMESG_FILTER not to fail with specific
> > > keywords in dmesg. Test cases meta/011 and block/028 are reference use
> > > cases.
> > 
> > Ah okay, let me look into it.
> 
> So I made the state read function a bit more robust (test if state file
> exists) and the it turns out this made rdma happy(??) but tcp is still
> breaking.

s/tcp/fc/

On closer inspection I see following sequence for fc:

[399664.863585] nvmet: connect request for invalid subsystem blktests-subsystem-1!
[399664.863704] nvme nvme0: Connect Invalid Data Parameter, subsysnqn "blktests-subsystem-1"
[399664.863758] nvme nvme0: NVME-FC{0}: reset: Reconnect attempt failed (16770)
[399664.863784] nvme nvme0: NVME-FC{0}: reconnect failure
[399664.863837] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"

When the host tries to reconnect to a non existing controller (the test
called _remove_nvmet_subsystem_from_port()) the target returns 0x4182
(NVME_SC_DNR|NVME_SC_READ_ONLY(?)). So arguably fc behaves correct by
stopping the reconnects. tcp and rdma just ignore the DNR.

If we agree that the fc behavior is the right one, then the nvmet code
needs to be changed so that when the qid_max attribute changes it forces
a reconnect. The trick with calling _remove_nvmet_subsystem_from_port()
to force a reconnect is not working. And tcp/rdma needs to honor the
DNR.

Daniel

