Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFF5C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2026 13:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e3n83e4GxYLFJJ9psDMIG4SEJZxb4rCLRfNQK55qefs=; b=KWBjv87saaUzF1VhVNqCdOgVPo
	qoTe5GJjV8GJD3njGrDsvlBSqdKClpjgjhtBObuw6bKsncjHPv/vWlure0smXDifL8OyotTHfwxtj
	QV50rSRmda3/TvfgYnzQjO5pl+v3fFPTuR9BqKIcRuNQKh0S8cHrzCzz+4yrQUwGhnFDKsj1y4uQH
	m4uW+tXMz0PQvPdcznUaWoo3iLERLcT4ADG5ajg+kemxepQTse6+bM/cxcRXSWRuQXU/c4YTaOzOy
	2S1nmSIo79VX3hbprmvP3mXUIR8RfQnHrxrEN9C+KfPQBcd8ycEPIk6Q7YjR5nIOOOpfL81sBb7D6
	V/UwAcpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfHXo-00000004Wn0-0xUd;
	Thu, 02 Jul 2026 13:33:32 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfHXl-00000004WmT-26qf
	for linux-nvme@lists.infradead.org;
	Thu, 02 Jul 2026 13:33:31 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7AD2B74205;
	Thu,  2 Jul 2026 13:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782999206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e3n83e4GxYLFJJ9psDMIG4SEJZxb4rCLRfNQK55qefs=;
	b=rE8Z00Zj7be4bgROmTZqfpuwuSJO1Bt7v0K5OU/oW6ohVNn6/F5Kt8wIeHHPhd12fnvLwG
	sapm9SBhwpSOxiI7fAc7HQFbXP810yiUvYiSKfDu/WmHMbg4GLx12TNpXlk3753yID70BF
	Sxa3AHoOxiUgLY0AzDVxS6s016D/0bA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782999206;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e3n83e4GxYLFJJ9psDMIG4SEJZxb4rCLRfNQK55qefs=;
	b=eWQ2XCyi0IRKJD2QIQEW5OrHosDdRfNDQBwI86Hd2T3SabrrKkOrMhYXEQmQxqhB68/vTe
	dqcNKhoi/gHT/hAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782999205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e3n83e4GxYLFJJ9psDMIG4SEJZxb4rCLRfNQK55qefs=;
	b=mnXbkzOvQc/Qtzs3ikIanm39kZZ9b4H9OLKDUBRkTu6Dmy+SOT8ul37RPcC/bNLHcehbbo
	J39GyTJhUhSXosjzVnoNlNM6qxumWSzHuKfxsqse5PtV3MMmGEgPFOyYMPqUYKocHiyFju
	XBsueelXBMyANUOUsMvg1Q+1Vgzo7ak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782999205;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e3n83e4GxYLFJJ9psDMIG4SEJZxb4rCLRfNQK55qefs=;
	b=eEQ7GW8k83YqYqbGj7gUqELXu8em+Yp8nATubKhrm5rDf0miSe3mUmues5tti/njfqS7xG
	XyxQcPSdOnYxNfBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61773779AA;
	Thu,  2 Jul 2026 13:33:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uQMVFqVoRmpwdwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 02 Jul 2026 13:33:25 +0000
Date: Thu, 2 Jul 2026 15:33:24 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	John Garry <john.g.garry@oracle.com>, Nilay Shroff <nilay@linux.ibm.com>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, xlpang@linux.alibaba.com, 
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH 2/3] nvmet: add ABI documentation for target configfs
 interfaces
Message-ID: <9b41ed73-9539-4e6d-bdc1-bdde4652e715@flourine.local>
References: <20260702034845.3066876-1-kanie@linux.alibaba.com>
 <20260702034845.3066876-3-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702034845.3066876-3-kanie@linux.alibaba.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_063329_687407_11F18B8A 
X-CRM114-Status: GOOD (  10.31  )
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

On Thu, Jul 02, 2026 at 11:48:44AM +0800, Guixin Liu wrote:
> Add Documentation/ABI/testing/configfs-nvmet documenting all NVMe

As far I am aware, nvmet is actually also used in production systems.
Thus it's not just an testing API I think.

Thanks for doing this!

BTW, I agree with Hannes, grouping them together makes it easier to
consume. Obviously they can still be sorted by time withing a group if
this makes sense.

Cheers,
Daniel

