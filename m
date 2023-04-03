Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC1CC76196
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 12:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+wwnzUm0RL+jBunj+beTZTOS5ukwZmcA9gkacTpgIIs=; b=N4RrLzHUMq3C8cM7W/JQPwOn3l
	iYOyBvezYeT1+AS+adAHb6/Y5/HME2LhgBWXUMvDrOx66LHV5An4RMW1OS1QsUa9g86I4SBMvzYs7
	a5wX9Jpp7bGY4E35f8Qu+hzX7YJO4xeUzHk5rdKhMy2ayn4j46HT3QJVvY+zdk1AVhYFedRjliwQB
	KtS/QZxY8cbTnRLTiFv0W+basslvSSM9m6LNRV2XrMB0TSrKV6Epz33GQSiF1UYhsq7pkW9YHV1sO
	xxGHSKbru5DJrVV47OvVZVN8F9RpWy3vvg9XToMZg7v8pvMDq9HFXyIPpRH538VPONUbeCSx2Qv27
	RLXlxZ1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjJQ8-00FIiw-2V;
	Mon, 03 Apr 2023 12:36:24 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjJQ5-00FIh9-09
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 12:36:22 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6D3A121CB1;
	Mon,  3 Apr 2023 12:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680525374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+wwnzUm0RL+jBunj+beTZTOS5ukwZmcA9gkacTpgIIs=;
	b=tncoBCiWZbaCC8vo5sK1xWbiIqjFvwKuo7U2h2PKZm6aiTiDTK7NMaMM9A1B/wcgf0+rAQ
	F/L7CuyBxUP4WfQjdDhAXKc+EQf4r3fCJ0hvm3BAYzZLs03f/VD2LPNEfj2//H0uwaz0t3
	+FuebSE6FTv6VHxEruzPEQE5tlr0L48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680525374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+wwnzUm0RL+jBunj+beTZTOS5ukwZmcA9gkacTpgIIs=;
	b=0OxcF6KaZwtztJSIHf4aHP+mjvzfznuQWLhbcXGggC8HLN/JSEOTO/cA0VzXa9k0wGiuoz
	a+UxW6z4AjDjVqCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B4821331A;
	Mon,  3 Apr 2023 12:36:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id xmmdFT7IKmRBUQAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 03 Apr 2023 12:36:14 +0000
Message-ID: <d67d9932-96eb-3548-cf40-b48a6db95739@suse.de>
Date: Mon, 3 Apr 2023 14:36:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-13-hare@suse.de>
 <677f3f9a-872d-27fe-9a21-b41bbe1c44ff@grimberg.me>
 <daf1e19e-119b-3ceb-7808-b74d8b113e05@suse.de>
 <f1bfbb7c-d8df-0386-1048-f141cb6e22bc@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 12/18] nvme-fabrics: parse options 'keyring' and 'tls_key'
In-Reply-To: <f1bfbb7c-d8df-0386-1048-f141cb6e22bc@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_053621_233090_5D7D9D84 
X-CRM114-Status: GOOD (  18.20  )
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

On 4/3/23 14:24, Sagi Grimberg wrote:
>>>> Parse the fabrics options 'keyring' and 'tls_key' and store the
>>>> referenced keys in the options structure.
>>>
>>> Can you explain the reasoning to why a user need to pass a keyring
>>> given that we already set up one?
>>>
>> Choice.
>> With a single keyring we can only have a single identity.
>> But there might be configurations where we want to have different PSKs
>> for the same identity (eg for key rotation).
> 
> How do you expect that rotation would work with this?
> 
The user creates a new keyring, adds the necessary keys to it, and then
either
- updates the keyring for nvmet (via configfs)
or
- reconnects using the new keyring

> How does nvmet handle a non-nvme keyring?
> 
There is a configfs attribute 'param_keyring', allowing you to use a 
different keyring (the nvme one is just the default).

>> With this option we can prepare a new keyring, and use that instead of 
>> the old one.
> 
> On an existing controller?
> 
Sure; when we are updating the keyring and the key id the controller 
will use that after the next reset.
Much like we do for DH-CHAP nowadays.

>> (And it really doesn't add much complexity...)
> 
> I know, it just adds one more argument, and I want to understand if it
> is really needed.

I do agree that the keyring argument would not necessarily required if 
we pass in the key id, but I'll be needing the keyring for secure 
concatenation. And plan is to move DH-HMAC-CHAP over to keyrings, too.

So I'd prefer to keep it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 Nürnberg
Managing Directors: I. Totev, A. Myers, A. McDonald, M. B. Moerman
(HRB 36809, AG Nürnberg)


