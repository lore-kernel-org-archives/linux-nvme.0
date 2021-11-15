Return-Path: <SRS0=a356=QC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACE3C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 11:35:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 437FE61C15
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 11:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 437FE61C15
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cfm/br8ciSB/Blss6XeRkivoaPgXuyBzMKbznPf98+E=; b=O6GgpNEdDOAKVSRnQacKsCjFSN
	iBCHCB2xCParwHWdWXxqA+N+UK+uOPYx1N8vj/sWJFgKKcX2BLqiQLPufKXXIu89mxjV2NeHSWyon
	rR+zQlISQ5gF9dKIJGG88PNFVljEAtwpRtkJYE5/iWyS6MfmbsqPrked1WvS9FFaliQEw+1YsVRJo
	Cic3DhTVBVdacKc9rGZ682rAOz4qc8qQFpJca1g/fLQdYYJuc0s51nD25ndZkf4zKKee7QtCwHQn8
	07pzMqiUZ1tT9D0N9Ll/THe0VF3rKh28hJ8o+3JMnU2yX1uoxS6dFLoVY/7K5kfO9YBX5//qMbJLq
	gBszwA3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmaGJ-00FOzm-D5; Mon, 15 Nov 2021 11:34:59 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmaG2-00FOsv-Tg
 for linux-nvme@lists.infradead.org; Mon, 15 Nov 2021 11:34:44 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 950EB1FD66;
 Mon, 15 Nov 2021 11:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636976081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cfm/br8ciSB/Blss6XeRkivoaPgXuyBzMKbznPf98+E=;
 b=KbnRlZ7uZdY4J6zJn+7jMzhwTH/rb+Y95SFS4yz6psTFlPbHtxc5pSS2Dfx+P+naIoHv22
 qPTobTcTjHPonsT0eyk4VnfhN7LXRCJ3lCEHdbrB3s67sUKLazGMyd0NxOzBa1hTY2GbDY
 39STV97u6g45vQNzu3GA/HHkoktGhIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636976081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cfm/br8ciSB/Blss6XeRkivoaPgXuyBzMKbznPf98+E=;
 b=FQSPQg67rOCjqwwfFMPh7qE54sNiRj0LJdagPwsGnPxPCFRJSF/ULYQb0D8N6W86O75MXG
 v0cnI7TM6uao8HCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82F8A13DF2;
 Mon, 15 Nov 2021 11:34:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id U6O0H9FFkmGpSQAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 15 Nov 2021 11:34:41 +0000
Subject: Re: [PATCHv5 00/12] nvme: In-band authentication support
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 David Miller <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20211112125928.97318-1-hare@suse.de>
 <74db7c77-7cbf-4bc9-1c80-e7c42acaea64@grimberg.me>
 <f67ca46e-f421-33f7-da8b-ff6e47acf8c2@suse.de>
 <8553266f-005c-f947-4737-2108cb7062d1@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a7363853-05af-9d7f-4d6f-b02ec756ce6b@suse.de>
Date: Mon, 15 Nov 2021 12:34:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <8553266f-005c-f947-4737-2108cb7062d1@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211115_033443_132007_4E5EE26B 
X-CRM114-Status: GOOD (  21.04  )
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

On 11/15/21 11:20 AM, Sagi Grimberg wrote:
> 
>>>> Changes to v4:
>>>> - Validate against blktest suite
>>>
>>> Nice! thanks hannes, this is going to be very useful moving
>>> forward.
>>>
>> Oh, definitely. The number of issue these tests found...
> 
> Great, good that this was useful for you.
> 
>>>> - Fixup base64 decoding
>>>
>>> What was fixed up there?
>>>
>> The padding character '=' wasn't handled correctly on decoding (the
>> character itself was skipped, by the 'bits' value wasn't increased,
>> leading to a spurious error in decoding an any key longer than 32 bit
>> not being accepted.
> 
> I see.
> 
>>>> - Transform secret with correct hmac algorithm
>>>
>>> Is that what I reported last time? Can you perhaps
>>> point me to the exact patch that fixes this?
>>
>> Well, no, not really; the patch itself got squashed in the main patches.
>> But problem here was that the key transformation from section 8.13.5.7
>> had been using the hash algorithm from the initial challenge, not the
>> one specified in the key itself.
>> This lead to decoding errors when using a key with a different length
>> than the hash algorithm.
> 
> That is exactly what I reported, changing the key length leads to
> authentication errors.

Right-o. So it should be sorted then.

BTW, I've created a pull request for nvme-cli
(https://github.com/linux-nvme/nvme-cli/pull/1237)
to add a new command-line option 'dump-config'; can you check if that's
what you had in mind or whether it needs to be improved further?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

