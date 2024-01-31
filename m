Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD68C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 07:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z4HlIsuTjaT6ShV/XWd2YqSGY1ibQ0YmFqd6/vwPszQ=; b=XzeErwWbAEVUxm58pwrLAnLhnM
	UiXAgt+/h3Qsbv/ug8D1oxdTMITGh4dGrd+jhQ8l0Emr2vCVN3kS66nUdiB+QSSZLUBrUqEGuOZwh
	GMeTSVfBywhRpdTHwGcrLtsa4mMC81TkG9SY0+pDlMSq32KRCba+QfBvHXwjoNORaif//SMacHpWv
	kdtRMsHc94RNthaY6WuVOvGZhfLdyFMldR25tP4Kr5dO1W4aeGwceo0cHVNG1ASOyJiqvU36CtnYu
	gbkonOkqofUoutBpmybbezzPWzog+DsmNwY30Gb3QYdEY1+c41e03XpPpe1qclt20LunNHyd0HXVZ
	GGsBm8AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV4pd-00000001lD6-1BF6;
	Wed, 31 Jan 2024 07:16:25 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV4pY-00000001l9l-0SDA
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 07:16:23 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5424F1FB61;
	Wed, 31 Jan 2024 07:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706685376;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4HlIsuTjaT6ShV/XWd2YqSGY1ibQ0YmFqd6/vwPszQ=;
	b=Dr0NX+K2Wknc8HgmFJF3WsrkTyljOT0VAhD/if9Gwc6eh1skfoDnd2fNqoti8+OFa38FwW
	F++yDJEwFNzPkX17r3T1CqPb/q6vwya3tKTvpp3ruZwnDEeGdH2XdVDut18txQqCr4yG3g
	59F/vV7RqXHLsM/qAHvc0pwiDu1Qw3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706685376;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4HlIsuTjaT6ShV/XWd2YqSGY1ibQ0YmFqd6/vwPszQ=;
	b=M92LB/4twMJGsx5maaY2j8FfPx3WEVqWrj7763vlJZHtVPWrLGgEYg6whL8WY/k4oSjmxD
	yNkkkd+RgIlsblCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706685376;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4HlIsuTjaT6ShV/XWd2YqSGY1ibQ0YmFqd6/vwPszQ=;
	b=Dr0NX+K2Wknc8HgmFJF3WsrkTyljOT0VAhD/if9Gwc6eh1skfoDnd2fNqoti8+OFa38FwW
	F++yDJEwFNzPkX17r3T1CqPb/q6vwya3tKTvpp3ruZwnDEeGdH2XdVDut18txQqCr4yG3g
	59F/vV7RqXHLsM/qAHvc0pwiDu1Qw3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706685376;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4HlIsuTjaT6ShV/XWd2YqSGY1ibQ0YmFqd6/vwPszQ=;
	b=M92LB/4twMJGsx5maaY2j8FfPx3WEVqWrj7763vlJZHtVPWrLGgEYg6whL8WY/k4oSjmxD
	yNkkkd+RgIlsblCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E743132FA;
	Wed, 31 Jan 2024 07:16:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id mnPhBsDzuWV0CQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 31 Jan 2024 07:16:16 +0000
Date: Wed, 31 Jan 2024 08:15:50 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 3/5] btrfs: zoned: call blkdev_zone_mgmt in nofs scope
Message-ID: <20240131071550.GI31555@twin.jikos.cz>
References: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
 <20240128-zonefs_nofs-v3-3-ae3b7c8def61@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128-zonefs_nofs-v3-3-ae3b7c8def61@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Dr0NX+K2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="M92LB/4t"
X-Spamd-Result: default: False [-1.35 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.34)[90.40%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5424F1FB61
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_231620_321831_D77A0F21 
X-CRM114-Status: GOOD (  10.50  )
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
Reply-To: dsterba@suse.cz
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Jan 28, 2024 at 11:52:18PM -0800, Johannes Thumshirn wrote:
> Add a memalloc_nofs scope around all calls to blkdev_zone_mgmt(). This
> allows us to further get rid of the GFP_NOFS argument for
> blkdev_zone_mgmt().
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: David Sterba <dsterba@suse.com>

