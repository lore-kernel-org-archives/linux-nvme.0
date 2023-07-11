Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27856EB64DC
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 10:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2N8XZ5kQ9s6Jq1Bw2Rm3Se7A9aKRwPFoHDGqHejlXH0=; b=HDBRh6MD19O0VLmqB3ch2FaYOI
	dc8EWDyljc/2znjnCmoqQbQ/21MeD8ROSrfSoJIuBpzNZL0TwvpoHo4zG8pjGTgmi7p5IS6eEowOH
	tvkJGRDebmpM+tReQ+lDDGWSXyWudWHegTTGrhThVrBNe+gFLwVdXWSLi1QLjSz3yZypFdqqc5Ib/
	95qzVK22uunZnF/M0bn5QPYo69C0Qg8/K+lluyUr7wqN8drY6EIYPvuIhojEZO8B8AfRJ0E/pf+8l
	DDYYilnRnu2qhvVNADfbKO0IQGpHHFIqgHONv1g8zINwx4ZYp4lD6PaHYeQLC4HjTGgkX6mb5N/S5
	KOfEslbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJAeS-00EcW3-0F;
	Tue, 11 Jul 2023 10:31:24 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJAeO-00EcUf-2u
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 10:31:22 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D83991FF97;
	Tue, 11 Jul 2023 10:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1689071476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2N8XZ5kQ9s6Jq1Bw2Rm3Se7A9aKRwPFoHDGqHejlXH0=;
	b=I5ZONSp/U4JFytgoI1kucpLH0adVLoUFLgTZ6MXXC6E40bQqjZgGlY2xL+e57brfFa+71c
	ZexnY2r08UQer/a6oBkOwPC9hpVlInd8wwsSGCVJKNPjg43fc10kJJSvs4IxdMKhvJE0Da
	4k049UT2C2t4EpCuzlv8oXoaV7HOnK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689071476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2N8XZ5kQ9s6Jq1Bw2Rm3Se7A9aKRwPFoHDGqHejlXH0=;
	b=Vc32gg25endAzWZIT9w2NwNEBk00JnuzbLGJEZLWcK38sSxykxZlQ2Jfh6Bcww06GlgzJp
	cjC4EGnAE1SWBRCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CDE791391C;
	Tue, 11 Jul 2023 10:31:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id xRbnMXQvrWSnewAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 11 Jul 2023 10:31:16 +0000
Message-ID: <a50ee71b-8ee9-7636-917d-694eb2a482b4@suse.de>
Date: Tue, 11 Jul 2023 12:31:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: nvme-tls and TCP window full
To: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <f10a9e4a-b545-429d-803e-c1d63a084afe@suse.de>
 <49422387-5ea3-af84-3f94-076c94748fff@grimberg.me>
 <ed5b22c6-d862-8706-fc2e-5306ed1eaad2@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ed5b22c6-d862-8706-fc2e-5306ed1eaad2@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_033121_101672_CC565044 
X-CRM114-Status: UNSURE (   9.99  )
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

On 7/11/23 11:28, Sagi Grimberg wrote:
> Hey Hannes,
> 
> Any progress on this one?
> 
Oh well; slow going.
After some length debugging I found that the read_sock() implementation 
wasn't exactly up to scratch (it would read each byte individually, 
instead of each skb individually ... D'oh).
But even with that fixed I'm still seeing I/O stalls due to window full:

[85639.669120] nvme nvme0: queue 2: C2H data cid 0x4d offset 0 len 4096
[85639.669885] nvme nvme0: queue 2: PDU Data cid 0x4d offset 29 len 4120 
rem 4096
[85639.670809] nvme nvme0: queue 2: RSP cid 0x4d status 0
[85639.671449] nvme nvme0: queue 2: pdu 24 data 0 consumed 4144 result 0
[85639.674928] nvme nvme0: queue 2: skb 00000000bee9b76d len 8262 offset 
5 len 8240
[85639.676474] nvme nvme0: queue 2: C2H data cid 0x4e offset 0 len 8192
[85639.678013] nvme nvme0: queue 2: PDU Data cid 0x4e offset 29 len 8216 
rem 8192
[85639.679810] nvme nvme0: queue 2: RSP cid 0x4e status 0
[85639.681247] nvme nvme0: queue 2: pdu 24 data 0 consumed 8240 result 0
[85639.690985] nvme nvme0: queue 2: skb 00000000bee9b76d len 16406 
offset 5 len 16384
[85639.692321] nvme nvme0: queue 2: C2H data cid 0x4f offset 0 len 126976
[85639.694012] nvme nvme0: queue 2: PDU Data cid 0x4f offset 29 len 
16360 rem 126976
[85639.695882] nvme nvme0: queue 2: pdu 0 data 110616 consumed 16384 
result 0
[85639.697667] nvme nvme0: queue 2: skb 00000000bee9b76d len 16406 
offset 5 len 16384
[85639.699339] nvme nvme0: queue 2: PDU Data cid 0x4f offset 5 len 16384 
rem 110616
[85639.701122] nvme nvme0: queue 2: pdu 0 data 94232 consumed 16384 result 0
[85639.702831] nvme nvme0: queue 2: skb 00000000bee9b76d len 16406 
offset 5 len 16384
[85639.704918] nvme nvme0: queue 2: PDU Data cid 0x4f offset 5 len 16384 
rem 94232
[85639.706759] nvme nvme0: queue 2: pdu 0 data 77848 consumed 16384 result 0
[85639.708367] nvme nvme0: queue 2: skb 00000000bee9b76d len 16406 
offset 5 len 16384
[85639.711219] nvme nvme0: queue 2: PDU Data cid 0x4f offset 5 len 16384 
rem 77848
[85639.712108] nvme nvme0: queue 2: pdu 0 data 61464 consumed 16384 result 0
[85639.714182] nvme nvme0: queue 2: skb 00000000bee9b76d len 16406 
offset 5 len 16384
[85639.715107] nvme nvme0: queue 2: PDU Data cid 0x4f offset 5 len 16384 
rem 61464
[85639.715989] nvme nvme0: queue 2: pdu 0 data 45080 consumed 16384 result 0
[85671.510572] nvme nvme0: queue 2: timeout cid 0x4f type 4 opcode 0x2 
(Read)

(These are just client-side logs).
Which looks to me as if we're waiting for the server to continue sending
PDU data frames, only these never arrive.
So really I wonder whether it's not rather an issue on the server side. 
Maybe the server doesn't retire skbs (or not all of them), causing the 
TCP window to shrink.
That, of course, is wild guessing, as I have no idea if and how calls to 
'consume_skb' reflect back to the TCP window size.

Investigation continues.

Cheers,

Hannes


