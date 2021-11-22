Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BA5C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 09:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bVG/pwuepxg++RIJMeKuF4CdYwjjCy/PQ5BqDr33lok=; b=yHk/ShU53KIxPToYptma7CniW9
	E7Tyo8NMBFEjkBKBgc51ewv6CudyFLTyM3TRuqoDpHoHc83h/J4qfLtwsmfQOB/Z+S/qcrgsv8Vqv
	N2pgn8vk4QuazvS5t6MDPGH4QJz0xQ7rJGgCOb4f6pB+E7HHxEXCTLz1SnB3i7KkER1s5X7p3qtbK
	VpOQ8PpAcf+5qAH0RyVlRf/6adOQ3b0ASWH9poG3mx4b9kSjxyETBsZw5fDHVcw4l0bLVfUGjTKXe
	mX3XnbCfOQoDftIOd9su21L5GPngiu8qcpvDp1KegaDnrMaJEYo0mDs6Kq/dF726BnuoY1ivrPFnZ
	poELBZ1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp5bq-00Fa6J-K8; Mon, 22 Nov 2021 09:27:34 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp5Q6-00FWER-1j
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 09:15:27 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 030011FD4A;
 Mon, 22 Nov 2021 09:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637572524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bVG/pwuepxg++RIJMeKuF4CdYwjjCy/PQ5BqDr33lok=;
 b=N/z60bgMhjeadOeryuQzaPB+q6Pq6fyVW+rrnHs1QdqlolzcbaQpF8NxIojh+DRbJVVhgs
 8hq7Fu/4WnvBWNYQCQ8ecmo6+K4Kb4LGK7syrySp0/aKqB4pmzN2OQu3onTpJOY476EF4E
 rD1bH7GXv4I/dXhxmBACH7xrHSVbxFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637572524;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bVG/pwuepxg++RIJMeKuF4CdYwjjCy/PQ5BqDr33lok=;
 b=G3/Wk9U/aQLzLQThiiFr5Aq1kj34sLalnG96SsY5/Nem8bMXEmctMMMO8jXa9pXcGSj5Br
 cuGL8T1+xQTSsdCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B650113B9E;
 Mon, 22 Nov 2021 09:15:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xztSK6tfm2HiTQAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 22 Nov 2021 09:15:23 +0000
Subject: Re: [PATCH 07/12] nvme: Implement In-Band authentication
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herberg@gondor.apana.org.au>,
 David Miller <davem@davemloft.org>, linux-crypto@vger.kernel.org
References: <20211122074727.25988-1-hare@suse.de>
 <20211122074727.25988-8-hare@suse.de>
 <8f6c144d-0354-2753-ab58-1f5cabcafbdd@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <fe1596bf-9bc8-13b1-eb7a-67cde6bb7dbc@suse.de>
Date: Mon, 22 Nov 2021 10:15:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <8f6c144d-0354-2753-ab58-1f5cabcafbdd@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_011526_277476_2B0A5DC3 
X-CRM114-Status: GOOD (  16.23  )
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

On 11/22/21 9:12 AM, Sagi Grimberg wrote:
> 
>> +int nvme_auth_generate_key(struct nvme_ctrl *ctrl, u8 *secret, bool
>> set_ctrl)
> 
> Maybe instead of set_ctrl introduct struct dhchap_key and pass a pointer
> into that?
> 
>> +{
>> +    u8 *key;
>> +    size_t key_len;
>> +    u8 key_hash;
>> +
>> +    if (!secret)
>> +        return 0;
>> +
>> +    if (sscanf(secret, "DHHC-1:%hhd:%*s:", &key_hash) != 1)
>> +        return -EINVAL;
>> +
>> +    /* Pass in the secret without the 'DHHC-1:XX:' prefix */
>> +    key = nvme_auth_extract_secret(secret + 10, key_hash,
>> +                       &key_len);
>> +    if (IS_ERR(key)) {
>> +        dev_dbg(ctrl->device, "failed to extract key, error %ld\n",
>> +            PTR_ERR(key));
>> +        return PTR_ERR(key);
>> +    }
>> +
>> +    if (set_ctrl) {
>> +        ctrl->dhchap_ctrl_key = key;
>> +        ctrl->dhchap_ctrl_key_len = key_len;
>> +        ctrl->dhchap_ctrl_key_hash = key_hash;
>> +    } else {
>> +        ctrl->dhchap_key = key;
>> +        ctrl->dhchap_key_len = key_len;
>> +        ctrl->dhchap_key_hash = key_hash;
>> +    }
> 
> Then it becomes:
>     dhchap_key->key = key;
>     dhchap_key->len = key_len;
>     dhchap_key->hash = key_hash;

Good point.
Will be folding it in.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)

