Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0D1C636CD
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Feb 2023 13:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mn5f4j6BahdgkDb8PgGWG6CT3Jo1naq6qwTTEH7pZ6k=; b=rXoInW0c0J1x4apVPxRXHkW3B1
	G3zvD6HjL5160x6lE7+r3Gs1xT1Bd6lp+xsi0cpWYORJJmQVl5BzOPY+UpcywXNwEHiG9UGJEDhfi
	40vAq1n2kOWnJV0r1UG13JkmrzOZfyWmaLI3W6+IrhCDkppfWfAhP+v6wlU4y2M4QIB579UnlBHwv
	5ukfwLELVpM84hxJSKfLr8YPbdnDefDea4pEdo75ycVC+yYIaoUTqvseZKhkEQ0b2NvClHAulI1Ex
	nqWTmK1vUc1M+shHkb3SE732G7NiOTyxB78VKll0hViEISldajEJr9J2kyQfRMJbYeYohHqhOtvTZ
	qhQLkWFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNDaF-00C9S1-JY; Wed, 01 Feb 2023 13:55:31 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNDa9-00C9Qs-Pp
	for linux-nvme@lists.infradead.org; Wed, 01 Feb 2023 13:55:30 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 06F47202EA;
	Wed,  1 Feb 2023 13:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675259721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mn5f4j6BahdgkDb8PgGWG6CT3Jo1naq6qwTTEH7pZ6k=;
	b=KmdzsYKi6qJNGEpl0htEuwEwVjQgDrSVrXBu2pu/JuecWp20303m5O2dPfkTsFXolvI6mx
	u+Kf5eKagducMoJ/LUJ3iQRRUVj/5BfGryKZpg/8hSgLjKWUXXZcAlnnRNcZsAC8XwzU1X
	Yicg7siuaI9tjtgez8GbyqAHADtO4eE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675259721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mn5f4j6BahdgkDb8PgGWG6CT3Jo1naq6qwTTEH7pZ6k=;
	b=CROTj3PkRQgKKyYiznYKGdc9PEdxvqXbGipvISFR9aUwn9pJ1nMEIQvzALVTB/Mf3Q1ey6
	A7fg6MoOGRMilkAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F110B1348C;
	Wed,  1 Feb 2023 13:55:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id bLB1Okhv2mNkZQAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 01 Feb 2023 13:55:20 +0000
Message-ID: <cd86edbb-d507-2bf5-393e-03b154a01ee0@suse.de>
Date: Wed, 1 Feb 2023 14:55:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] nvme: retry commands if DNR bit is not set
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20230201115001.57321-1-hare@suse.de>
 <20230201130920.GA30589@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230201130920.GA30589@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230201_055526_013152_AE5C7CDD 
X-CRM114-Status: GOOD (  17.88  )
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

On 2/1/23 14:09, Christoph Hellwig wrote:
> On Wed, Feb 01, 2023 at 12:50:01PM +0100, Hannes Reinecke wrote:
>> Add a 'retry' argument to __nvme_submit_sync_cmd() to instruct
>> the function to not set the FAILFAST_DRIVER bit for the command,
>> causing it to be retried in nvme_decide_disposition() if the DNR
>> bit is not set in the command result.
>> And modify the authentication code to allow for retries.
> 
> This is missing the why.  And maybe we can find a better interace than
> a magic bool flag.

The 'why' is that commands submitted internally (via 
nvme_submit_sync_cmd() and friends are typically normal NVMe commands, 
and as such should be subjected to the normal 'DNR' evaluation rules.
This has been an issue with the authentication protocol commands in 
particular, but I've got reports that the 'connect' command itself might 
also be affected.

Of course we can discuss the interface; personally I found the flag not 
a bad idea...

Cheers,

Hannes




