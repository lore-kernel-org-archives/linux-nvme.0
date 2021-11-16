Return-Path: <SRS0=wlVn=QD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C65C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 10:23:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03A161AA2
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 10:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D03A161AA2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C6vc1pqiJTa400b8j7/ol2JdQMZnjyWLCaw6z9FjbcY=; b=MHth/SbP7EX23ZbCbqOQO48Cmv
	OYF8eoVYkLJwddx/0sNiCcVM+T/sIFG4gEOLoPxLmjBQlr8pJLNWwOULH360Ymlx4jgJTJzUev/mk
	7O4ir4LkdSZUdNUBziuIEGafKTj/SPPYYgAZBFkceQjU6vGIdX2TwWAhmhONmDNvwXWgXAqQ28fv0
	u93GYMgaXH6sFHnSFuKsP4IM2Fb+G+PCQtOCN5VNrly5dYvmh0qwe7TYKwv6dVlbl9d4me8mBHXHx
	asEadorQDMYLAZjmuDrbl6+TZ8sH6eow1qgTQsyoWG/8Vj8cAA3nfH2l3dfc1LFZq7hOgyL5kvRp7
	poNvf2wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmvd3-001AiY-W4; Tue, 16 Nov 2021 10:23:54 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmvcx-001Ahd-R9
 for linux-nvme@lists.infradead.org; Tue, 16 Nov 2021 10:23:49 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 49810218CE;
 Tue, 16 Nov 2021 10:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637058226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C6vc1pqiJTa400b8j7/ol2JdQMZnjyWLCaw6z9FjbcY=;
 b=ACoAvPykN3W3fo2L9A90u/j+cpfdTAJQ4NEkSeh0LOEAJzMdqoWK1N8Ffbuz7NHFVPpQGX
 whARcZIZMm5hr+HJHXCteFAfrQsTRyszl93fb1IWYQuLr+/78OkLYeplutEHXi7FPfCqF2
 y+2z36Kam5n2zmlVwNc3+6+G3hwsH6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637058226;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C6vc1pqiJTa400b8j7/ol2JdQMZnjyWLCaw6z9FjbcY=;
 b=Ej2xlWgnfiustAX4RgB86Yk+VpuJ6xG4NAUC+2Q1XuICJKAHbJNxr2E7mlzIQSa9rzR4pI
 yETaX+HEzzSlsQDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A41913BA1;
 Tue, 16 Nov 2021 10:23:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id W5XZCbKGk2HOJgAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 16 Nov 2021 10:23:46 +0000
Subject: Re: [PATCHv5 00/12] nvme: In-band authentication support
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 David Miller <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20211112125928.97318-1-hare@suse.de>
 <74db7c77-7cbf-4bc9-1c80-e7c42acaea64@grimberg.me>
 <f67ca46e-f421-33f7-da8b-ff6e47acf8c2@suse.de>
 <8553266f-005c-f947-4737-2108cb7062d1@grimberg.me>
 <a7363853-05af-9d7f-4d6f-b02ec756ce6b@suse.de>
 <50095ec8-3825-efa5-98bb-76b0f0fdc21e@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <31088486-0134-0dad-b052-32fd3ce2d1cf@suse.de>
Date: Tue, 16 Nov 2021 11:23:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <50095ec8-3825-efa5-98bb-76b0f0fdc21e@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211116_022348_054796_9AAE3718 
X-CRM114-Status: GOOD (  18.34  )
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

On 11/16/21 11:18 AM, Sagi Grimberg wrote:
> 
>>>>>> - Transform secret with correct hmac algorithm
>>>>>
>>>>> Is that what I reported last time? Can you perhaps
>>>>> point me to the exact patch that fixes this?
>>>>
>>>> Well, no, not really; the patch itself got squashed in the main
>>>> patches.
>>>> But problem here was that the key transformation from section 8.13.5.7
>>>> had been using the hash algorithm from the initial challenge, not the
>>>> one specified in the key itself.
>>>> This lead to decoding errors when using a key with a different length
>>>> than the hash algorithm.
>>>
>>> That is exactly what I reported, changing the key length leads to
>>> authentication errors.
>>
>> Right-o. So it should be sorted then.
> 
> Hannes, was the issue on the host side or the controller side?
> 
The issue was actually on the host side.

> I'm a little lost into what was the actual fix...

The basic fix was this:

@@ -927,13 +944,17 @@ static int nvme_auth_dhchap_host_response(struct
nvme_ctrl
 *ctrl,

        if (!chap->host_response) {
                chap->host_response =
nvme_auth_transform_key(ctrl->dhchap_key,
-                                       ctrl->dhchap_key_len, chap->hash_id,
+                                       ctrl->dhchap_key_len,
+                                       ctrl->dhchap_key_hash,
                                        ctrl->opts->host->nqn);
                if (IS_ERR(chap->host_response)) {
                        ret = PTR_ERR(chap->host_response);
                        chap->host_response = NULL;
                        return ret;
                }


(minus the linebreaks, of course).
'chap->hash_id' is the hash selected by the initial negotiation, which
is wrong as we should have used the hash function selected by the key
itself.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

