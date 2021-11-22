Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A21C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 09:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HNS43EaDh3HbfPmUfOE2oSRQ8Od4xL8KbjNUAAI46pg=; b=d3uYtjT4p17yyOpuQerNjSjPkB
	AeuctwoGjKFymlHCeL7LormL3xknIxxH/uw5ZkuyRSVO4hjXYq07MvQR9WSY06idqlHClp7BDUip9
	ROeU22wjdrUcUEhRsNSC3KykxoOiJ5IiVGii6N69ZamCG6ZY4Ccwmi7rHZTSzVvvaI+b69cp7Ijk0
	hrQ5QVBW3BH+j7LM/v+gPSPavTymbkM9gLzazdRlZXJmQTuLW9HLKbvdxTx4aJxiMJ1oEBgli04B5
	zkpaoQ0nnpVA2M+sOQ5AR/jLWBk3mPr0TYyZSybHhe+946Zu/WBnGvifoDx/mcXVlnk3b5CnCC4UK
	NQ37qv3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp5qE-00Fedo-8R; Mon, 22 Nov 2021 09:42:26 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp5YR-00FYq9-ER
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 09:24:05 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1AB0A218CE;
 Mon, 22 Nov 2021 09:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637573042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HNS43EaDh3HbfPmUfOE2oSRQ8Od4xL8KbjNUAAI46pg=;
 b=rf6T1QQwKOgFbHLhnC2pegpKELIhj5bzExjrQTLhoo8V7NVrikob9RG9ams6lV3fScgggs
 zG369pSNoQQslVwqcxKyGyJWUzknggo72WwE3U/887xE3WKXS/j8OtJ3Y76R19p9Uq4rhK
 QBCFdtu/tM81paeYcM65BdyePSyjlMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637573042;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HNS43EaDh3HbfPmUfOE2oSRQ8Od4xL8KbjNUAAI46pg=;
 b=CWJ2wRgLDDJIjQFoBK/pC4CV6s3VbYN08fsdFi2rOybLUKvEfbRpJHy2vfGjo15Uy3RCNz
 K2O8AXAjyHhRzoCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB94713466;
 Mon, 22 Nov 2021 09:24:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id U0ntNbFhm2GBUgAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 22 Nov 2021 09:24:01 +0000
Subject: Re: [PATCH 3/9] nvme/rc: add functions for in-band authentication
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org
References: <20211122075524.26207-1-hare@suse.de>
 <20211122075524.26207-4-hare@suse.de>
 <a4e3d91a-f618-8bff-0218-1396274bf1fd@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <c1064814-3f5a-e80e-f1f1-0f72a1053d43@suse.de>
Date: Mon, 22 Nov 2021 10:24:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <a4e3d91a-f618-8bff-0218-1396274bf1fd@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_012403_735609_8AEAE727 
X-CRM114-Status: GOOD (  18.67  )
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

On 11/22/21 9:52 AM, Sagi Grimberg wrote:
> 
> 
> On 11/22/21 9:55 AM, Hannes Reinecke wrote:
>> Add functions to enable in-band authentication.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   tests/nvme/rc | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 54 insertions(+)
>>
>> diff --git a/tests/nvme/rc b/tests/nvme/rc
>> index aa223df..7d05e4a 100644
>> --- a/tests/nvme/rc
>> +++ b/tests/nvme/rc
>> @@ -247,6 +247,17 @@ _create_nvmet_subsystem() {
>>       _create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
>>   }
>>   +_create_nvmet_host() {
>> +    local nvmet_subsystem="$1"
>> +    local nvmet_hostnqn="$2"
>> +    local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
>> +
>> +    mkdir "${NVMET_CFS}/hosts/${nvmet_hostnqn}"
>> +    echo 0 > "${cfs_path}/attr_allow_any_host"
>> +    ln -s "${NVMET_CFS}/hosts/${nvmet_hostnqn}" \
>> +       "${cfs_path}/allowed_hosts/${nvmet_hostnqn}"
>> +}
> 
> I'd say that perhaps we can add optional parameters for
> host key,hash,dhgrp so that simple tests can just add
> a host with these params set?

That's what I had initially, but then moved away from it seeing that
I'll have to have these functions anyway.

But sure, can do that ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)

