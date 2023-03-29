Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDE9C6FD18
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 15:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PC83zyI2MkiTdocQjSJCPagzOohj9//XCpX2Mc2SR7s=; b=WSxBkqXTB0ApMdonmVAluo6sXI
	+Aiq3ewXhTk2rqYrMUzl1+EgrwbaJ4k9BYHvCYVL+cY6bXAmXooE+r1kB54wGT5kNMnka8Gg5fRME
	lSGDcjQWch+Y/tIbpN5TSjPQy/VcsTY3lnNIbs+kOffMbU2/jg0WdJlPHZV4uQ/8LuD4RWe7YkKnH
	O7sEe2daCC6kuawAA9E4NR3LmIpDC1ngSKpNShs2MzrwTC9dwA8uhia7Qbp4/d6B/9dDhBwDlW3cn
	sm9iGD+0yW+fGC1i8ahpPV/jh1KE42Fnr4mLrCzYWeS9aR2OHP4ndV6l1UUjSDAQiT2jBzgFCDZS0
	GxVP4wQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phXfC-000lr4-0g;
	Wed, 29 Mar 2023 15:24:38 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phXf9-000lqC-1y
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 15:24:37 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CA2021FE01;
	Wed, 29 Mar 2023 15:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680103465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PC83zyI2MkiTdocQjSJCPagzOohj9//XCpX2Mc2SR7s=;
	b=zE9qbYxXiCR3yfYjvgdagddwRCw91K8ZNCTP64ttwLJuOeCUwqsFlJo/+S9kJiigOcyvp3
	R66G1BH//XBgVjnvkHRTGKa39DvV8cwegbyT9IBxBvuS3Za/J5DOn0HTHy2ZA1rcIyrFRz
	YsY7EUb/uiRE+ESLXRyahevnnAhRRno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680103465;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PC83zyI2MkiTdocQjSJCPagzOohj9//XCpX2Mc2SR7s=;
	b=b7zCcl3/2fpCw1prWjZNAfMXmBTswLDl8IDiEelBs6nk3MvK1JNzR67On2BZx/gmxC63r7
	J2WSguhcIaN4a+CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 430F6139D3;
	Wed, 29 Mar 2023 15:24:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id l/lyDilYJGQLVQAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 29 Mar 2023 15:24:25 +0000
Message-ID: <8fab4f74-cd27-3838-a4f9-6e5b3705d527@suse.de>
Date: Wed, 29 Mar 2023 17:24:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 01/18] nvme-keyring: register '.nvme' keyring and add
 CONFIG_NVME_TLS
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-2-hare@suse.de>
 <56ab2e76-1d5e-0002-cf23-6c7e9b82d233@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <56ab2e76-1d5e-0002-cf23-6c7e9b82d233@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_082435_802151_14216CD5 
X-CRM114-Status: GOOD (  17.34  )
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

On 3/29/23 16:49, Sagi Grimberg wrote:
> 
>> Register a '.nvme' keyring to hold keys for TLS and DH-HMAC-CHAP and
>> add a new config option NVME_TLS to enable support for NVMe-TCP/TLS.
>> We need a separate keyring for NVMe as the configuration is done
>> via individual commands (eg for configfs), and the usual per-session
>> or per-process keyrings can't be used.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/nvme/common/Kconfig   |  9 +++++++++
>>   drivers/nvme/common/Makefile  |  1 +
>>   drivers/nvme/common/keyring.c | 36 +++++++++++++++++++++++++++++++++++
>>   drivers/nvme/host/core.c      | 19 +++++++++++++++---
>>   include/linux/nvme-keyring.h  | 12 ++++++++++++
>>   5 files changed, 74 insertions(+), 3 deletions(-)
>>   create mode 100644 drivers/nvme/common/keyring.c
>>   create mode 100644 include/linux/nvme-keyring.h
>>
>> diff --git a/drivers/nvme/common/Kconfig b/drivers/nvme/common/Kconfig
>> index 4514f44362dd..b6fff16da1fb 100644
>> --- a/drivers/nvme/common/Kconfig
>> +++ b/drivers/nvme/common/Kconfig
>> @@ -2,3 +2,12 @@
>>   config NVME_COMMON
>>          tristate
>> +
>> +config NVME_TLS
>> +    bool "NVMe/TCP TLS encryption support"
>> +    depends on NVME_COMMON
> 
> depends on TLS as well? Or maybe select would be more appropriate?
> 
I would argue 'depends', as we cannot use the standard 
session/process/thread keyrings, as they'll vanish after the initial 
'connect', and then there's no keyring to lookup keys for subsection 
reconnects.

>> +    select KEYS
>> +    help
>> +      Enables TLS encryption for NVMe/TCP using the netlink handshake 
>> API.
>> +
>> +      If unsure, say N.
> 
> Would it not make sense to default it to y?

Yeah.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


