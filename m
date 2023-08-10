Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFACC001B0
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 07:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N7JKMe9xp9xaMjAHWLnHmv599LdaPXO4nHKxMhK/P7s=; b=pWzmzffxWUKiFGuhpOpcgrvR9E
	YcHgj3Aqi2fJJbtARMDLrifCQ8HjV8FbnA2+A7yhFvCI1nsmWurao0SGMKzz4OrdWzN/3uG/6gWVy
	yYbZDCx2SzGe2kORqNvaHyLymBh2gy/jTn1nIw6c4/W+ukSjcH9Ac3mNX9ko5dD59Bf7pPSt+gdYQ
	h+Cr9AmYVVZKxdjwgo+mkR92iz61CIxtajPweDiADqOVun13Plz4JTAEOLnGXWAvoABg8lb3Uetvc
	ELbFUgFJAxxz4rgcSsBuANkUK5o4oswX8g+h2fneo9RZ5H+1ueqGZUN+CDxftyjvKZd5eTMgrw6pA
	iwq7RJiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTznB-006ixa-2t;
	Thu, 10 Aug 2023 07:09:09 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTzn8-006iwq-1B
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 07:09:07 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3964D1F74D;
	Thu, 10 Aug 2023 07:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691651343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N7JKMe9xp9xaMjAHWLnHmv599LdaPXO4nHKxMhK/P7s=;
	b=sNKMwq6B52xolPkEspKtL5Ln8HTvTlXfGEdUcDvnH73vNyAtksDGocrc5MmTXjMBVRju0V
	u7crGgAJ0BKE/a+hxnd0gQSev8hmT7S7vd06BuFpMU4W+sLgV3zLQ9dHqbJNUpLP3tZCh5
	e1cNbHdhMWUmpG3gLonzI86T8n8HXQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691651343;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N7JKMe9xp9xaMjAHWLnHmv599LdaPXO4nHKxMhK/P7s=;
	b=i+/qk58Cyvd37mMvz+WOZFyDlZsYDk8vcP8kPlIU6GDL3iTN9l+HPi921NNtjFbVHeiLqE
	Bq0kbi3qK2Ijg/CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1AB27138E0;
	Thu, 10 Aug 2023 07:09:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id cZeNBA+N1GSCPwAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 10 Aug 2023 07:09:03 +0000
Message-ID: <2b202cb8-7543-1c2b-4d5c-bbe4822c9e68@suse.de>
Date: Thu, 10 Aug 2023 09:09:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 15/16] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230808165354.123499-1-hare@suse.de>
 <20230808165354.123499-16-hare@suse.de>
 <e28dffb6-66bd-2724-6c9d-f06e5da75aeb@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <e28dffb6-66bd-2724-6c9d-f06e5da75aeb@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_000906_543214_8D606F0E 
X-CRM114-Status: GOOD (  13.30  )
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

On 8/9/23 12:51, Sagi Grimberg wrote:
> 
> 
> On 8/8/23 19:53, Hannes Reinecke wrote:
>> Add functions to start the TLS handshake upcall when
>> the TCP TSAS sectype is set to 'tls1.3' and add a config
>> option NVME_TARGET_TCP_TLS.
>> And move the 'state' lock to an irq-safe lock as the 'done'
>> callback from the TLS handshake will be running in interrupt
>> context.
> 
> Really.. that is surprising. Can you describe how exactly?
> 
Ho-hum. Yes, I can, and it seems to be related to my test setup.
I'm running nvme and nvmet over the loopback interface, and with that
nvme_tcp_stop_queue() induces a softirq triggering a socket state change
on the target.
Which means that nvmet_tcp_schedule_release_queue() is called from 
softirq, triggering the spin_lock warning.
Probably warrants a separate patch, though.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


