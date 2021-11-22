Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983ABC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 12:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mhjGihZL/F9/iriXQWAv5ScoB6p4wsMQuI0zvwjvMh8=; b=daAxMEYP1oA7+POkn3uT/kxL/2
	PxVQWQaEQoL3u0k/RwPIrRldsgi1sqbRH+g4F4laHCIEPwVwsVNEoM0pFwQ8aW5yrkB8l1Uoo9tKU
	Gt9t4qvP3ZyEq3wYQPQ8xeVlsROYga6cHRaCkU9F5snz0t6VsMYSPZUafVfOCXzAvTBS4RhjaQG5H
	5yVzfEAt/Wb4OO6zeYO68S6Uuoep2k2LnZ2qcXPXXFq4ugKhaKdfx9c23jZSt+H8TQf+lRGuZocPy
	M9mioXYk95UN9srf5RlNHrwqmwhwMOXg8E7chr+puj1DSdIYMn1/sueTNzgGH920tMrSmt8wH/Fn3
	xLnYeBDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp86N-00GFWb-7s; Mon, 22 Nov 2021 12:07:15 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp7dk-00G5jP-5m
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 11:37:41 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 30E8A218EE;
 Mon, 22 Nov 2021 11:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637581058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mhjGihZL/F9/iriXQWAv5ScoB6p4wsMQuI0zvwjvMh8=;
 b=sWz/TKIUjyzAdAeiks5RKh+EqxD5Qx1M1njSp9VtBjko5bdTX3DSN1qrLsxxBihS0XUNks
 YeOZIRxQ4Phi2tVZHpgYRNfkGkIUQgZW6jSf9K7qmaYhDUZrJzIJr+DvOpbSlVBs6EOT/c
 MoADAhbuhz+2FMOslE+eSYwOaAoF13s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637581058;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mhjGihZL/F9/iriXQWAv5ScoB6p4wsMQuI0zvwjvMh8=;
 b=2tl1MfIgFwsU/LnrLyHrFAr9539oFhLkO1O3Mf1LE/nWw6I0Cjrr4p7OKMxmY9dlXG8XeZ
 8W4KD2USBzmCxBAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C96113C97;
 Mon, 22 Nov 2021 11:37:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bCe3AAKBm2EGHgAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 22 Nov 2021 11:37:38 +0000
Subject: Re: [PATCHv6 00/12] nvme: In-band authentication support
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herberg@gondor.apana.org.au>,
 David Miller <davem@davemloft.org>, linux-crypto@vger.kernel.org
References: <20211122074727.25988-1-hare@suse.de>
 <14b025bc-746f-ea73-a325-7805c4b46c28@grimberg.me>
 <8e0909ad-f431-2600-7b68-d86d014fc9ec@suse.de>
 <8ba377cc-5c33-7cba-456e-bfc890f1ad88@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <ff0acc79-40d7-8247-6f80-e1c6f635df3f@suse.de>
Date: Mon, 22 Nov 2021 12:37:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <8ba377cc-5c33-7cba-456e-bfc890f1ad88@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_033740_412566_A9E5FC2C 
X-CRM114-Status: GOOD (  19.84  )
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

On 11/22/21 12:32 PM, Sagi Grimberg wrote:
> 
>>>> Hi all,
>>>>
>>>> recent updates to the NVMe spec have added definitions for in-band
>>>> authentication, and seeing that it provides some real benefit
>>>> especially for NVMe-TCP here's an attempt to implement it.
>>>>
>>>> Tricky bit here is that the specification orients itself on TLS 1.3,
>>>> but supports only the FFDHE groups. Which of course the kernel doesn't
>>>> support. I've been able to come up with a patch for this, but as this
>>>> is my first attempt to fix anything in the crypto area I would invite
>>>> people more familiar with these matters to have a look.
>>>>
>>>> Also note that this is just for in-band authentication. Secure
>>>> concatenation (ie starting TLS with the negotiated parameters) is not
>>>> implemented; one would need to update the kernel TLS implementation
>>>> for this, which at this time is beyond scope.
>>>>
>>>> As usual, comments and reviews are welcome.
>>>>
>>>> Changes to v5:
>>>> - Unify nvme_auth_generate_key()
>>>> - Unify nvme_auth_extract_key()
>>>
>>> You mean nvme_auth_extract_secret() ?
>>>
>> Yes.
>>
>>>> - Include reviews from Sagi
>>>
>>> What about the bug fix folded in?
>>
>> Yeah, and that, to
>> Forgot to mention it.
> 
> It is not the code that you shared in the other thread right?
> 
Yes, it is.
It has been folded into v6.
And test 043 has been updated to check for this issue.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)

