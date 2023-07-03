Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A60FEB64DD
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jul 2023 10:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pYbDQTr7JXNGP7jzRXCrBeOE4JiYLSrz8vehK49e4RE=; b=30dSWxVyYrY7010D8pYZRYsG4y
	ycinSHAUpq52xW9wNYGBy5o5W9PvtpTY9pUh+ljBT0HwW4rYH9J3qFzRk7RAsI8ChF/ryMf9Cpja2
	lSfZq/JkgQkEXD7Eu0qGEdaynacA1r91pMBY9uXvEm+PE5dm79LD681HofaFLfOdITZlj6B5s3DqC
	NJMbrCWniwIf/K1bkN5NFzRqWITAFsHi0BKr47EqBePs3OudmpQg2YQspJ5MpvL8ecEAgIUXXr1NY
	MyWyJHINMXaXtBgyskqNkkcX96DKF3RuGR6JMmg+dlfH2mJWbhnBy/PRujQAm+BuYmiHiRMuhhx4Y
	TWQWURPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGGfy-00A98j-1W;
	Mon, 03 Jul 2023 10:20:58 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGGfv-00A95D-3C
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jul 2023 10:20:57 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B9D731FD77;
	Mon,  3 Jul 2023 10:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688379652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pYbDQTr7JXNGP7jzRXCrBeOE4JiYLSrz8vehK49e4RE=;
	b=s2Rb/gh5n9uYAqETsf9WTciIL0Z/Q4tMTEAe0E6nBtSQ6PhfEzoIKImiXIVogI0qwrCpjB
	OVqUqenCCaoZiR7Q5ZeWioxUbFB0jYkIJwZDIC1EiQxN4uj5sHGEZJXBlG571ITGjJMgx/
	SsajuKNF/2uj+DwmN8e/M4agRMykbfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688379652;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pYbDQTr7JXNGP7jzRXCrBeOE4JiYLSrz8vehK49e4RE=;
	b=DJWSPBsS5DccRxvXwdrUEJvpomC4IZfsjBSX1bD7Waylqi6fex5OLsIhh/kcIfi0bKBL3s
	NPWv1/9Q6xyN4BDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A3844138FC;
	Mon,  3 Jul 2023 10:20:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id tYR0JwShomQ3MAAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 03 Jul 2023 10:20:52 +0000
Message-ID: <e1165086-fd99-ff43-4bca-d39dd1e46cf1@suse.de>
Date: Mon, 3 Jul 2023 12:20:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv6 0/5] net/tls: fixes for NVMe-over-TLS
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20230703090444.38734-1-hare@suse.de>
 <8fbfa483-caed-870f-68ed-40855feb601f@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <8fbfa483-caed-870f-68ed-40855feb601f@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_032056_199279_A8C10414 
X-CRM114-Status: GOOD (  13.87  )
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

On 7/3/23 12:08, Sagi Grimberg wrote:
> 
> 
> On 7/3/23 12:04, Hannes Reinecke wrote:
>> Hi all,
>>
>> here are some small fixes to get NVMe-over-TLS up and running.
>> The first three are just minor modifications to have MSG_EOR handled
>> for TLS (and adding a test for it), but the last two implement the
>> ->read_sock() callback for tls_sw and that, I guess, could do with
>> some reviews.
>> It does work with my NVMe-TLS test harness, but what do I know :-)
> 
> Hannes, have you tested nvme/tls with the MSG_SPLICE_PAGES series from
> david?

Yes. This patchset has been tested on top of current linus' HEAD, which 
includes the MSG_SPLICE_PAGES series (hence the absence of patch hunks 
for ->sendpage() and friends).

Cheers,

Hannes


