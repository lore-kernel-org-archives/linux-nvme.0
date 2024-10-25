Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FCCD1039E
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2024 15:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VnIj2rIz2qyoWaYq7tut8kPRpXTW+HmsLhop0Po1rSo=; b=Oo2Uxem/qJVM5yxAtFyvNzkPpf
	YgnL+A5EPaDsJthpCUmepdSSj75i5QcDD96ujzJkBOx1dR0XIldDAKMACW9j12L5MjGHo0YM3KSwD
	U212rn8CMGQT052xf+7OeqMXqKfKJnWjhh4/74n/842VXbMnEC1SlNuKHQUwEa+m2B9Z0zX6yPgkJ
	4bLVtAGbhSvJPethFmfnqAbSoflHuW3W6ge5FScqchPCiwrb9XYBaop7pwRL76LcqBuqusA94Yr0P
	Xp/2UA3ZCIp3jbmrBL7UUJEYd79jbTkBxR5URfvPstH12PdGhDop+T5XycDgnz1N5T/3a04beFaAe
	Gi3D/7pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Md5-00000004KFM-3sxf;
	Fri, 25 Oct 2024 15:53:35 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Mcr-00000004KDL-3nwJ
	for linux-nvme@lists.infradead.org;
	Fri, 25 Oct 2024 15:53:34 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 83D0B1FB87;
	Fri, 25 Oct 2024 15:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729871599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VnIj2rIz2qyoWaYq7tut8kPRpXTW+HmsLhop0Po1rSo=;
	b=RtZK/1nrtPuWoJ19J3XzACT/QjP4ac62WBWnQW1mZGhWZXEpKgQBtdXIyMfNgzB+0R4Oah
	2Aui/egHZzSc7Mbul0EWfEBrom3m+aqdYtHRjM9hOYGn3UhmYwxh8WkcJMM3fSb4LaGGsd
	jDV+lafqzdheBkten2Gn+9+XDpfJ9tY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729871599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VnIj2rIz2qyoWaYq7tut8kPRpXTW+HmsLhop0Po1rSo=;
	b=Tk4v9Cv3MyGzxgATcB7NODXAm+Y0JlDdb7+wEmBNQ2JmqJIF2TGhNJHej/145Rfw0+msbM
	wAr/wvsmmjb0ZjDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="RtZK/1nr";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Tk4v9Cv3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729871599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VnIj2rIz2qyoWaYq7tut8kPRpXTW+HmsLhop0Po1rSo=;
	b=RtZK/1nrtPuWoJ19J3XzACT/QjP4ac62WBWnQW1mZGhWZXEpKgQBtdXIyMfNgzB+0R4Oah
	2Aui/egHZzSc7Mbul0EWfEBrom3m+aqdYtHRjM9hOYGn3UhmYwxh8WkcJMM3fSb4LaGGsd
	jDV+lafqzdheBkten2Gn+9+XDpfJ9tY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729871599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VnIj2rIz2qyoWaYq7tut8kPRpXTW+HmsLhop0Po1rSo=;
	b=Tk4v9Cv3MyGzxgATcB7NODXAm+Y0JlDdb7+wEmBNQ2JmqJIF2TGhNJHej/145Rfw0+msbM
	wAr/wvsmmjb0ZjDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 673A2132D3;
	Fri, 25 Oct 2024 15:53:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XfTEFu++G2f7dQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 25 Oct 2024 15:53:19 +0000
Date: Fri, 25 Oct 2024 17:53:18 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 14/15] common/nvme, nvme/{016,017,052}: improve
 _create_nvmet_ns()
Message-ID: <4c00c4c4-c22e-43e1-a7cd-f0958d65272f@flourine.local>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
 <20241024010025.2216242-15-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024010025.2216242-15-shinichiro.kawasaki@wdc.com>
X-Rspamd-Queue-Id: 83D0B1FB87
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_085322_122295_1831E5E8 
X-CRM114-Status: UNSURE (   9.93  )
X-CRM114-Notice: Please train this message.
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

On Thu, Oct 24, 2024 at 10:00:24AM GMT, Shin'ichiro Kawasaki wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Add --grpid option to pass ANA group id. If no UUID is passed the kernel
> will generate a UUID, so return the UUID to allow the caller to identify
> the generated namespace. Allow to call _create_nvmet_ns() without
> --subsysnqn option by using def_subsysnqn as its default value.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> [Shin'ichiro: rebased on the commit e3fe06e and resolved conflicts]
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

