Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440C0C61D92
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Nov 2023 14:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RhBfgyl7harlTZ14QB/vIsLncY3WiYEbzkvbWNDC1ww=; b=Yr9u4MHQi5pico/B3wI/FX41Mp
	dlnJHwvnCJuUXwGMbxDk6PFoag3MGoXprBNrF9AQMQjMq5tsk/fx5UKrKPO60NMWHPD5a0ZL6R989
	e3F/fyQp7MYnX4wcBEWtl/uV5w6P9upazwnG9cDso98/byKwL4YHv+RE3EraXQXB/mDse8k3dcHtl
	bhZetHBaY/3nq54Lj4I9qAX5UYbCVTukctvS+I3D4x5BlnFwBoVTxWQ5kbe9qH3vPF0krQXHzpqB/
	18X86C8VIL4zc+MWn0NuoJu1rG7SGGJ+P8geWh8vGo+FQIeh+jGmPmu9VCSqwqmdeX4QQ2FMyBXFo
	g3P8NUoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5Rww-00H3OD-2c;
	Tue, 21 Nov 2023 14:42:02 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5Rwu-00H3Lh-0B
	for linux-nvme@lists.infradead.org;
	Tue, 21 Nov 2023 14:42:01 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 98FDD2189A;
	Tue, 21 Nov 2023 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1700577713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RhBfgyl7harlTZ14QB/vIsLncY3WiYEbzkvbWNDC1ww=;
	b=mmzDrSgiV1Jm1rc/wvwsz1bUERlZdUmaH8TEtFUijrA9BzZiBSpYuP6GLuOm013AWLTlVL
	cdkp0rC6/3X2SI4VFdafRul1iN6pzGe1y634D5f4uKruSyeu5F4hPyT+MBXbmGRRTxrkvD
	NbDrhlj+KeU+v8MtkBTWi4F0HqBoNVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1700577713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RhBfgyl7harlTZ14QB/vIsLncY3WiYEbzkvbWNDC1ww=;
	b=dOcFI0M6roiPqXYa1J7OJ8XNnE3sCeOLx1IQ1yqoLwpVNO0Mug//gDcxMlyrKQ0SpheaLq
	141GryJfnYwv36CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 75875138E3;
	Tue, 21 Nov 2023 14:41:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id bPXlG7HBXGUwWwAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 21 Nov 2023 14:41:53 +0000
Message-ID: <87313f89-cdd5-4511-87c3-816f545c4e60@suse.de>
Date: Tue, 21 Nov 2023 15:41:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: move nvme_stop_keep_alive() back to original
 position
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20231121080103.23355-1-hare@suse.de>
 <be1195e3-2fca-4d68-8222-45f97a72a349@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <be1195e3-2fca-4d68-8222-45f97a72a349@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 CLAM_VIRUS_FAIL(0.00)[failed to scan and retransmits exceed];
	 BAYES_HAM(-3.00)[100.00%];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231121_064200_262723_F16F0551 
X-CRM114-Status: GOOD (  12.31  )
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

On 11/21/23 10:23, Sagi Grimberg wrote:
> 
>> Stopping keep-alive not only stops the keep-alive workqueue,
>> but also needs to be synchronized with I/O termination as we
>> must not send a keep-alive command after all I/O had been
>> terminated.
>> So to avoid any regressions move the call to stop_keep_alive()
>> back to its original position and ensure that keep-alive is
>> correctly stopped failing to setup the admin queue.
>>
>> Fixes: 4733b65d82bd ("nvme: start keep-alive after admin queue setup")
> 
> It should be folded in I guess. I suggest to either suggest an
> alternative phrasing of the patch or resend an alternative patch
> set.
> 
Well, the original patch has already been merged to the nvme-6.7 tree,
so I've attached the 'Fixes' tag.
But let me know how you'd like to play it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


