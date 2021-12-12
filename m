Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B00DC433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Dec 2021 12:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k1FE0MvUuHA/rXNKz5+MSggRCZgWqVV6Da0jUZHSFgY=; b=F6utibWcu4mNzo4K1Xu2RQYTCh
	pse3cn8pKm/fuOAx/QzMHs1b5mPfjx5MlxLAmXVQ13f3foz0VDrLIguoLksJ5Yi5oLpLwiTQXQ1gA
	VVx3M72mtfvu5C8NeXD5UNWMJ3f+NN1TL7HscS1hac6P38ekzOZCXU85FgQS4YhRqZX1oc47cfgfH
	Y4k9BEkAep3AjopvcYahoLo3Uiy/dgpTWXl7PfLJj35ss4obyVMucmsCn0qMMYTqzBKDJkaKSW3QD
	/dANfa3Xgay2Qyx7rndkYDL+bTQNNMksyvyyWYQPXUWpuJ6ROgil/5OAjCqPT4Q4xRBNsE+L2lao3
	D+RXsljw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwO7V-006UNU-7o; Sun, 12 Dec 2021 12:38:25 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwO7R-006UMo-Uw
 for linux-nvme@lists.infradead.org; Sun, 12 Dec 2021 12:38:23 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 61E8721108;
 Sun, 12 Dec 2021 12:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1639312698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k1FE0MvUuHA/rXNKz5+MSggRCZgWqVV6Da0jUZHSFgY=;
 b=DcFFQrHv0yovOac+p64hy8bP4KCupJeXCFQAJ06plP1V3VIDlaaIEVJcajdCdQdozEaNJj
 RvS8gvyO/JVZFNHYykOSdC22A/1rAAhvfE+CIc1o5xX2LoI5JRWGLEstQT1CNHgJJ7nH+7
 kRveTLuDiks9QmkXOV41CD0ug2yNIW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1639312698;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k1FE0MvUuHA/rXNKz5+MSggRCZgWqVV6Da0jUZHSFgY=;
 b=33cuXKNDV/r/4v3KIWoUWdvEISkFsD50eXYClA7I7yLxTCGzepsieH2RSInU+A+X4BMcBh
 AThz901oERP5VdBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C71AC13425;
 Sun, 12 Dec 2021 12:38:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IS2ILznttWHOWQAAMHmgww
 (envelope-from <hare@suse.de>); Sun, 12 Dec 2021 12:38:17 +0000
Subject: Re: [PATCH 09/10] nvme/042: test bi-directional authentication
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20211123074940.113390-1-hare@suse.de>
 <20211123074940.113390-10-hare@suse.de>
 <ffe973a1-1856-e2e7-9695-cb2ce532de3b@grimberg.me>
 <ebae81ae-94d8-6044-1492-cc856a476290@suse.de>
 <17b0e7fa-317a-fbd5-6a04-2a76e3c7f88c@grimberg.me>
 <068a4335-74c8-e7e6-85e0-fed888f4e3fd@suse.de>
 <aa4fe38e-a099-4de5-6993-e71c37040c09@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <44056686-0361-75c4-3523-a80467c66a39@suse.de>
Date: Sun, 12 Dec 2021 13:38:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <aa4fe38e-a099-4de5-6993-e71c37040c09@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211212_043822_203014_44CCC518 
X-CRM114-Status: GOOD (  12.18  )
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

On 12/12/21 10:53 AM, Sagi Grimberg wrote:
> 
>>>>> This test case has a weird behavior. Why isn't _nvme_connect_subsys
>>>>> failing?
>>>>
>>>> Oh, but it is.
>>>> The line 'nvme controller found' is not part of the .out file, hence
>>>> the test will fail.
>>>>
>>>> Call it an obscure feature of blktests :-)
>>>>
>>>> But yeah, I can make it more obvious that this is the failure case.
>>>
>>> Hannes, my question is why isn't nvme connect not failing (i.e.
>>> returning a non-zero status code)?
>>>
>> I guess it does, but we're never actually checking the return value.
>> Let me check.
> 
> I tested it manually, and the connect does not fail, but rather succeeds
> and the controller is removed - which is strange.

Curious. "That shouldn't have happened (tm)".

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

