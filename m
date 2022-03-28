Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3733CC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Mar 2022 12:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kCe0fNojkaMmxPPxBa7tOPcA5Xi4J4pPTV4uRD1q6oI=; b=ob25Y4BYPIegolDQEAW1V52M9x
	phWJetgGQHhL0u6AQPL9C03EqkJT3DASOsofNtmCSa/ZcYkCNbVru11cJY78zsiZRyCrvayhpPOCt
	F+UoLLzyWpk8q81EU1U0WW6s/SCm+vfpYiiV1DwMosoiWhZrIZd2xZ/3zBj63ONNo63oCv6pTRgaa
	oxqZEP378Ejs3Dp8JsjwajpSabHHbyXywD5RlqUQzZgjiOwqOhy3Y2oc5jedY4/JIsCRN9ensnSy4
	DuGwms36imk/u64IVLndODMnZzT8lRZYpfGmoXexYpc4VsKuVmB56CSp3MuPP9I8p0vdeyt/Dqfa0
	w8Sm6t7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nYo5K-008UFI-Nf; Mon, 28 Mar 2022 12:02:58 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nYo5H-008UDr-Fx
 for linux-nvme@lists.infradead.org; Mon, 28 Mar 2022 12:02:56 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A8D6F1F37E;
 Mon, 28 Mar 2022 12:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648468973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kCe0fNojkaMmxPPxBa7tOPcA5Xi4J4pPTV4uRD1q6oI=;
 b=vPg7w4XK93teXVe5CaNF8tnKPtHeC9Q6Vod/C4orvW2tXyGkZg8dagROZrFhDdfaN6uISK
 J9j7lofAi6Q1yjEbtMYJ/7r094ORtTXV41gNR5DdRhBE2C8vRY1izS8cIb/D4n9XN42/CZ
 uO0CwFPflou4vc8Jmq8JyCFKr6MosuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648468973;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kCe0fNojkaMmxPPxBa7tOPcA5Xi4J4pPTV4uRD1q6oI=;
 b=KP0iEOsn2Y28UMmrC7MMp+hVbLzOqCLNQPyCR3q76WnpvEeRTM4G955TJJiDS2sWp7mres
 +BDUU/EkiBjDURBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9356A13B08;
 Mon, 28 Mar 2022 12:02:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SLNZIe2jQWKYbwAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 28 Mar 2022 12:02:53 +0000
Message-ID: <2d19643d-763a-8010-d36d-22c04adf63ef@suse.de>
Date: Mon, 28 Mar 2022 14:02:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 09/10] nvme/042: test bi-directional authentication
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20211123074940.113390-1-hare@suse.de>
 <20211123074940.113390-10-hare@suse.de>
 <ffe973a1-1856-e2e7-9695-cb2ce532de3b@grimberg.me>
 <ebae81ae-94d8-6044-1492-cc856a476290@suse.de>
 <17b0e7fa-317a-fbd5-6a04-2a76e3c7f88c@grimberg.me>
 <068a4335-74c8-e7e6-85e0-fed888f4e3fd@suse.de>
 <aa4fe38e-a099-4de5-6993-e71c37040c09@grimberg.me>
 <44056686-0361-75c4-3523-a80467c66a39@suse.de>
 <887219b3-9909-e100-262a-4d112de3916e@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <887219b3-9909-e100-262a-4d112de3916e@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220328_050255_730599_C1231ED1 
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

On 3/28/22 13:20, Sagi Grimberg wrote:
> 
>>>>>>> This test case has a weird behavior. Why isn't _nvme_connect_subsys
>>>>>>> failing?
>>>>>>
>>>>>> Oh, but it is.
>>>>>> The line 'nvme controller found' is not part of the .out file, hence
>>>>>> the test will fail.
>>>>>>
>>>>>> Call it an obscure feature of blktests :-)
>>>>>>
>>>>>> But yeah, I can make it more obvious that this is the failure case.
>>>>>
>>>>> Hannes, my question is why isn't nvme connect not failing (i.e.
>>>>> returning a non-zero status code)?
>>>>>
>>>> I guess it does, but we're never actually checking the return value.
>>>> Let me check.
>>>
>>> I tested it manually, and the connect does not fail, but rather succeeds
>>> and the controller is removed - which is strange.
>>
>> Curious. "That shouldn't have happened (tm)".
> 
> Hannes, before I take v10 to a test drive, did you fix this particular
> issue?

Now that you mention it: Not sure. Will be checking.

Cheers,

Hannes

