Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F323FEB64DC
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jul 2023 12:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hh75Xtg21Y4Z6Rzl0m4HS5IINkMvhdG7+SAKrK62NUg=; b=G4K1QfKk3RlBqISwslqv6Nr1i7
	5X4X7OJ2oVuljQCEkqRD1UqCQdvfGoUtAc1uhM1fsmLf0W55blQXc02Qi/3QAX3IRQP9Goc6DPnqr
	UtqeYovpYf+Rg5CzMr1jgJP0p99fOE6l3NvKbjrUiRl3zP4uepGeq6pdoLOW0bB85hn09n3+JoXCR
	cSoFTuib7Dc5UlqNImiYd0vsHWY1Fc7HFAXCg9MOaesB8F0ku66QWte8c4Rb0dU1q8kqhf98p5Xq6
	v0nXyyh/ISoK3ybbi5DSeICtSingxpKaV0db3VPUCYuhjbSE8OmTT5QIu5DDqdKHR/aUPl8gz6e7Y
	iafuIwiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGIR2-00AS0P-38;
	Mon, 03 Jul 2023 12:13:40 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGIR0-00ARzR-1Q
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jul 2023 12:13:39 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 32E5A1FDF0;
	Mon,  3 Jul 2023 12:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688386415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hh75Xtg21Y4Z6Rzl0m4HS5IINkMvhdG7+SAKrK62NUg=;
	b=yVElWMNrg+EmUIfx103qAx8p6vnUkZ8jHetoo0TsylKahgt6w23eIqXQbUJO/qi9vl8S67
	c6PYiT7zx6xVJRsViysp0NTWhHvAmH9X9GDy2KuMM/zK9xWR7jBsSkrPfoTOdNEypNQew6
	HoAzhFflazr6smuh4uNEgFesUJvSFeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688386415;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hh75Xtg21Y4Z6Rzl0m4HS5IINkMvhdG7+SAKrK62NUg=;
	b=7Nf2aGENXY16rL9WI6per+ItO4Vnv3z/POp4G3Oc58WDzT2hhm2DRkc4DfaUGTd8+odean
	zmVo07bbvcIDhfCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16FDC13276;
	Mon,  3 Jul 2023 12:13:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id VIdVBW+7omQSbwAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 03 Jul 2023 12:13:35 +0000
Message-ID: <bf72459d-c2e0-27d2-ad96-89a010f64408@suse.de>
Date: Mon, 3 Jul 2023 14:13:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv6 0/5] net/tls: fixes for NVMe-over-TLS
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20230703090444.38734-1-hare@suse.de>
 <8fbfa483-caed-870f-68ed-40855feb601f@grimberg.me>
 <e1165086-fd99-ff43-4bca-d39dd1e46cf1@suse.de>
In-Reply-To: <e1165086-fd99-ff43-4bca-d39dd1e46cf1@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_051338_623146_57182A4C 
X-CRM114-Status: GOOD (  15.09  )
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

On 7/3/23 12:20, Hannes Reinecke wrote:
> On 7/3/23 12:08, Sagi Grimberg wrote:
>>
>>
>> On 7/3/23 12:04, Hannes Reinecke wrote:
>>> Hi all,
>>>
>>> here are some small fixes to get NVMe-over-TLS up and running.
>>> The first three are just minor modifications to have MSG_EOR handled
>>> for TLS (and adding a test for it), but the last two implement the
>>> ->read_sock() callback for tls_sw and that, I guess, could do with
>>> some reviews.
>>> It does work with my NVMe-TLS test harness, but what do I know :-)
>>
>> Hannes, have you tested nvme/tls with the MSG_SPLICE_PAGES series from
>> david?
> 
> Yes. This patchset has been tested on top of current linus' HEAD, which 
> includes the MSG_SPLICE_PAGES series (hence the absence of patch hunks 
> for ->sendpage() and friends).
> 
Well, of course, spoke too soon.
'discover' and 'connect' works, but when I'm trying to transfer data
(eg by doing a 'mkfs.xfs') the whole thing crashes horribly in
sock_sendmsg() as it's trying to access invalid pages :-(

Debugging to find out if it's my or Davids fault.

Cheers,

Hannes


