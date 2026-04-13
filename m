Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B1FEBFD17
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Apr 2026 08:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SpSOZrK4AC6jCo2ioIQuAqCTsDs0yBnOwMj3yp5Ur60=; b=e0j+Yxo0eLk6t7+y7Wws1LwVUV
	vha3/qH7dt/0h4NQutXRKRUtWfSqLqclsSJ86rJ/YoA4oU5PS73ssZoCtJiFTnBm6Ji0F1tkCn1aN
	YaUdNaMmIb90YcmQ+AVEQeFs14Ryvjr1W40BJfHCBHPW1VgAbO+18CQr1kwpRlytgl39v5imevCHF
	s7WFsHkkKrtGT4NJT9gcuuBLP3sW9utcFvkHHhvdaP0R11p9D6ffoomNbMpWJsFLCqgIu/YBdHwAA
	HrRSiFesK01419ivxW9L4JF81VNf/6j9/SSLhxFT3uWvxGMleT67Ku6840/4/rolYAe09WcWq+uTl
	YsrA/7sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCCqe-0000000FI2t-2r5T;
	Mon, 13 Apr 2026 08:40:48 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCCqc-0000000FI2Z-2GLO
	for linux-nvme@lists.infradead.org;
	Mon, 13 Apr 2026 08:40:47 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B33D05BDC1;
	Mon, 13 Apr 2026 08:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776069644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SpSOZrK4AC6jCo2ioIQuAqCTsDs0yBnOwMj3yp5Ur60=;
	b=F1JDwZVs9cRLEV8GkI6XoH3anaTDP0HpFsuo7HfF1Yv3A/ZLDu9CGhcuqqdo8nbRCIblje
	CH1EHF8GuHc5bqeG4XNrBtXIZDb9BF2IGFdlAe/gAYHCxVVz0h0LfVUDC1O1lenUymxl8o
	5/7FNdf5VKynsN0by0Rd5/9IVUucB1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776069644;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SpSOZrK4AC6jCo2ioIQuAqCTsDs0yBnOwMj3yp5Ur60=;
	b=PU3cp8Pickxj0iOOUsG1DQ7X4KGOotMIpcUqBVBvYH0BOQQeitGv6No5b1xtSn2a59VPzW
	anEB4YnLDyQo5qDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776069644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SpSOZrK4AC6jCo2ioIQuAqCTsDs0yBnOwMj3yp5Ur60=;
	b=F1JDwZVs9cRLEV8GkI6XoH3anaTDP0HpFsuo7HfF1Yv3A/ZLDu9CGhcuqqdo8nbRCIblje
	CH1EHF8GuHc5bqeG4XNrBtXIZDb9BF2IGFdlAe/gAYHCxVVz0h0LfVUDC1O1lenUymxl8o
	5/7FNdf5VKynsN0by0Rd5/9IVUucB1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776069644;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SpSOZrK4AC6jCo2ioIQuAqCTsDs0yBnOwMj3yp5Ur60=;
	b=PU3cp8Pickxj0iOOUsG1DQ7X4KGOotMIpcUqBVBvYH0BOQQeitGv6No5b1xtSn2a59VPzW
	anEB4YnLDyQo5qDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A9B74ADC8;
	Mon, 13 Apr 2026 08:40:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wi9/GAys3Gl1HAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Apr 2026 08:40:44 +0000
Message-ID: <207e1c3e-2a99-4085-81c0-7853f3d09f78@suse.de>
Date: Mon, 13 Apr 2026 10:40:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvme: fix handling of tls alerts
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Paul Moses <p@1g4.org>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: "security@kernel.org" <security@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "okorniev@redhat.com" <okorniev@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <Ozwl9wDbyugg3Ytnr80omDUS6JPqCHgq_k8gkqtMIP2KbHBMt6CYRRMk6LKGOTNPwtj_wNimbH0mZiAe8-9zcRmS_UgArtcI6poZ1PZjMoU=@1g4.org>
 <2026041239-engross-edition-66eb@gregkh>
 <N8h5xrK8_cznpQNTzRIDl6Ofz_nN1Hvl1DVSXnL9rSR6zHyQGIPDKEDURE7uf2PgGOCe2jTRcEiamFmAzw-xhQPCBdbPoUu_BelZ8Mrzmg0=@1g4.org>
 <84c3b656-9406-4869-9214-aff1ee0f1607@nvidia.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <84c3b656-9406-4869-9214-aff1ee0f1607@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260413_014046_748021_12D29F1C 
X-CRM114-Status: UNSURE (   5.76  )
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

On 4/13/26 01:42, Chaitanya Kulkarni wrote:
>    (+linux-nvme)
> 

This should have been address by the patchset '[PATCH v2 0/4] address 
tls_alert_recv usage by NFS and NvME' from Olga.
I _thought_ it had been merged already, but seems that it didn't.
Olga?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

