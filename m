Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB63C27C53
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Jun 2024 07:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2M0pbYzp/+9jLX6wx8JxZUgDMrmgAaeAyAKANTN8+VI=; b=yx3YSdQ16/Z5+4Q1DQJrKcXxfI
	bb5FexDdS8fti9zG0vIH1Y9A0ZFF2F+3Z24+zgnUDr0F5tTgXTLCy9xPI6xA7lzWI5f0QpKACmo6L
	7+Q9KwZVJMxvgqaTIwuEOd5XUIfE8jkraJ465ao13/NWsOErvuPwE09NYYEXXuiLuAT5/eu+fgKA+
	WlrMxk40il7b3jaBPR3VsA9IofUzyURpHjJQ2KglY5Ymz6FipNDW2nWB6JyMHISTNXBswcU0Ftlzf
	I9MM0A1SWtqazGXOMYKPuT5Y9LlKEaANE9r+u28WPLjjXnLBw/ojYPjsxNloe+VmhQHFyYqtP+OFy
	V5aK9tKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFU5F-0000000Cx5U-08Q7;
	Fri, 07 Jun 2024 07:32:21 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFSuq-0000000Cesy-3r09
	for linux-nvme@bombadil.infradead.org;
	Fri, 07 Jun 2024 06:17:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=2M0pbYzp/+9jLX6wx8JxZUgDMrmgAaeAyAKANTN8+VI=; b=LyRTPNMzOGRenscgT7l0YeP73N
	pHBlmUPXvUdcqsEp9Ss9R/ykGgzdytv/kixJjwvzVnNqiIwf5Qe16wjohxyn+QaS6y6rSFXKLEyiH
	Gp2yiI7Z57kpT1vtzljnIcFmOrK2vGnY+CPMsze4/WBaTWsyB5lanwLw/4wIpRNaBdiAVM5NN1IHi
	l7ZKohRS68feG1zxAI6i7IV0pAzCcDJBUtB91ff1ebbBMOd2nXEiMnLzDeniZkVWyC88k3FF6qX+7
	Jt8X+WG1gQrKgSOj2IvOng9Mz2YCj44rHDYG5mx+ob1N1pEnek8ocjwVnt4M3EMt5w8Gh4wXLo5RL
	X/o91zvA==;
Received: from smtp-out1.suse.de ([195.135.223.130])
	by casper.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFSun-00000004ZW9-3f6O
	for linux-nvme@lists.infradead.org;
	Fri, 07 Jun 2024 06:17:31 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9E01C21B47;
	Fri,  7 Jun 2024 06:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717741044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2M0pbYzp/+9jLX6wx8JxZUgDMrmgAaeAyAKANTN8+VI=;
	b=ChTKROGSugOIdi/A8FXVQ0Q+Ny/xo/6XTpUATgDVGcIOxw238u7K6maRU3BVJDaulZBAez
	kpZQGf3CAZivdqI6Tw8LOS36w/PXrc9npbEfc5CEjpb+omRCj7xH+ATb2vQB8SAFmTD5Hv
	5rpKC1CfJ5rKYdBwKVo40CtMfs7ysBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717741044;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2M0pbYzp/+9jLX6wx8JxZUgDMrmgAaeAyAKANTN8+VI=;
	b=NEpozFE/lCV2gDmmG9+zTlcPSWKqmzXJJUIYBbPd1IJeSAi0d4g89y3PND6+rmFAkWJCtd
	wq6rDbscTYprtZDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ChTKROGS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="NEpozFE/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717741044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2M0pbYzp/+9jLX6wx8JxZUgDMrmgAaeAyAKANTN8+VI=;
	b=ChTKROGSugOIdi/A8FXVQ0Q+Ny/xo/6XTpUATgDVGcIOxw238u7K6maRU3BVJDaulZBAez
	kpZQGf3CAZivdqI6Tw8LOS36w/PXrc9npbEfc5CEjpb+omRCj7xH+ATb2vQB8SAFmTD5Hv
	5rpKC1CfJ5rKYdBwKVo40CtMfs7ysBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717741044;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2M0pbYzp/+9jLX6wx8JxZUgDMrmgAaeAyAKANTN8+VI=;
	b=NEpozFE/lCV2gDmmG9+zTlcPSWKqmzXJJUIYBbPd1IJeSAi0d4g89y3PND6+rmFAkWJCtd
	wq6rDbscTYprtZDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA958133F3;
	Fri,  7 Jun 2024 06:17:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EDcfK/OlYmZEYAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 07 Jun 2024 06:17:23 +0000
Message-ID: <42862fed-2045-4a06-936b-d844187dca90@suse.de>
Date: Fri, 7 Jun 2024 08:17:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] block: use kstrtoul in flag_store
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20240607055912.3586772-1-hch@lst.de>
 <20240607055912.3586772-8-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240607055912.3586772-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9E01C21B47
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,lst.de:email,nvidia.com:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_071729_962327_FB4B9058 
X-CRM114-Status: GOOD (  11.09  )
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

On 6/7/24 07:59, Christoph Hellwig wrote:
> Use the text to integer helper that has error handling and doesn't modify
> the input pointer.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   block/blk-integrity.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


