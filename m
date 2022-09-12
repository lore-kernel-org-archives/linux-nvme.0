Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B35C6FA83
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Sep 2022 14:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K2U5yWai5Z9iDk3S5uqrDdDks71FuQSLKWyycAu3oik=; b=qfWElQAuB6XvyUvxyTfWdEw0AH
	BzN4x3QoXuoF2CTueb0dCB4pNdqqnA7H+0PiYWjsm62aCR4Wk3jW/Ove9wM3KJZObCXSnXAsZ/d7o
	OiseDCzVxoJ65DcrVv3fw9MLZdPAgoNdM0S/CBJqZWe9g+GURzzVhrWDyr0XH1SIWh3TXgpJH04Q+
	N6vCtCpBbxy38VEafWBRJSd89xRa2pzPwF9C+fDKvWdbXuHb7Zk/byQ9myc/f7GOIMlmV1tSklCWG
	wu3yN+rF0Lw36fCZMtvz5DMzZE5MA9rH6IFyaSeXjrB0yJ7/hiJicfmUlRde8G+AGh/HjwXboljzl
	dlYsQueQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXkdT-00Alf5-Ly; Mon, 12 Sep 2022 14:42:07 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXkdQ-00Alcg-8G
	for linux-nvme@lists.infradead.org; Mon, 12 Sep 2022 14:42:05 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2E2871F8C9;
	Mon, 12 Sep 2022 14:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1662993722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K2U5yWai5Z9iDk3S5uqrDdDks71FuQSLKWyycAu3oik=;
	b=GOOMXTv+nq4hqk4L/B6fBTAu4lH0YHK6bPjmTNwx8BapUiZcfZv/HFwNZYT0ztinVA3zNw
	5YfHCoXG0qH5qtByhOnWeROzduFMjufytrrIrgu/lIEaLY3S+tvyJuzu0tP2CIRcfk6R7e
	j+5PTX6n+cdnrnKQ2HhiPt/AnfCB7dA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1662993722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K2U5yWai5Z9iDk3S5uqrDdDks71FuQSLKWyycAu3oik=;
	b=PidaixMwVt/RiLFfNCpO4y6v9K/6xKAmeyvj9JvCq/7qwk1t+66nepfUxNOP9k+WbFNkWj
	YEd2uwIxVA6bmaDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1FBC5139C8;
	Mon, 12 Sep 2022 14:42:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 2K6zBzpFH2NvTQAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 12 Sep 2022 14:42:02 +0000
Date: Mon, 12 Sep 2022 16:42:01 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Martin Belanger <nitram_67@hotmail.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH libnvme 3/1] fabrics: add notify_rediscover parameter
Message-ID: <20220912144201.dadx54vj2ntjljyy@carbon.lan>
References: <20220907142411.101950-1-sagi@grimberg.me>
 <20220907142411.101950-4-sagi@grimberg.me>
 <20220909065846.b7fu53pvyvp6qtpp@carbon.lan>
 <51243855-b026-3dd5-163f-572d2ba43543@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51243855-b026-3dd5-163f-572d2ba43543@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220912_074204_495926_6418D05A 
X-CRM114-Status: GOOD (  19.14  )
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

On Mon, Sep 12, 2022 at 03:33:15PM +0300, Sagi Grimberg wrote:
> 
> > > @@ -481,6 +482,8 @@ static int build_options(nvme_host_t h, nvme_ctrl_t c, char **argstr)
> > >   	    (hostid && add_argument(argstr, "hostid", hostid)) ||
> > >   	    (discover && !discovery_nqn &&
> > >   	     add_bool_argument(argstr, "discovery", true)) ||
> > > +	     add_bool_argument(argstr, "notify_rediscover",
> > > +			       cfg->notify_rediscover) ||
> > 
> > If notify_rediscover is not supported by the kernel, wouldn't this end
> > up with an EINVAL when we try to connect? I thought we need to make this
> > conditional.
> 
> The check is done by the callers, which check support for it. If it
> is not supported and still passed, its a bug in the caller.

Okay.

Another thing I was wondering if we might run into a problem with
dependencies on the library via the kernel feature support. But I think
we should be safe and if not, another reason for a 2.x release :)

