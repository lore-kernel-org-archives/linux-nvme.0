Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA095C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jun 2022 06:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Heqq3z9+wFlet+jCXjSa/S32Fdu4E55e0CiyMZFRSpE=; b=IWoJIzNFRvc7P1p79sCycvNbPe
	M35E+P6MkQRpwkOyDqG3lF2VcRLuu0Euw/jxFXUFPF4NLneGL6VCvojepRaaUw1bP9VvPgl0+1M34
	KT3nGiD/EmP54/LTYqbilgA9AD9gU8yqLP95aqh43lPfo2zhyZkC16r/y0wOmFFDIryH6jr2OPMHz
	kUCs0qmZnXts3KMBbUOWq5nlkzWgabfrBwwWzDkh0x5pGd7E25LcC7v8d2B5PvrrPKaSIeIGhubCG
	woaWGmQ00zRy092/CRflBr4uWFUs/KklBNoflZxFN/1Z102B63tZmIbuIxR57Z06H6kZFDYAoNXjK
	1YNZDYyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3BKZ-00GXpf-7O; Mon, 20 Jun 2022 06:56:15 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3BKW-00GXnV-IU
	for linux-nvme@lists.infradead.org; Mon, 20 Jun 2022 06:56:14 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 45C461F383;
	Mon, 20 Jun 2022 06:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1655708170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Heqq3z9+wFlet+jCXjSa/S32Fdu4E55e0CiyMZFRSpE=;
	b=elCCOKYuO2okNSnVIQdbnib6kk/f7UBRdX8g2TkMeBsGmrpZqEsb1lkHY3EU5sFlzjOxr0
	BU/KWjtEUvcr8BHgn9JoAGjRlRM6oUBtQ0BPNaR1wGqQTM9Tjum3r7K4TpWhaPg7yCq8g4
	QHsoufBVs/Tdr2+ANcey98NF5v0rzuk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1655708170;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Heqq3z9+wFlet+jCXjSa/S32Fdu4E55e0CiyMZFRSpE=;
	b=Tel4cw8RMk0eg+1HQ0GSkniFo+HFvITjGMbTiAQ5mroV+NPIZJC4Ow3oh0EzagV0PghFkb
	gcu892y7BGjo0jCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12982134CA;
	Mon, 20 Jun 2022 06:56:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Mrp9AwoasGKwdwAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 20 Jun 2022 06:56:10 +0000
Message-ID: <2c5928c1-5362-debb-3813-71f6a9887e0e@suse.de>
Date: Mon, 20 Jun 2022 08:56:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 06/10] nvme/040: create authenticated connections
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20220610113324.10294-1-hare@suse.de>
 <20220610113324.10294-7-hare@suse.de>
 <20220614043640.vzu5q3ldq253rpb5@shindev>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220614043640.vzu5q3ldq253rpb5@shindev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220619_235612_800974_E845CD13 
X-CRM114-Status: GOOD (  14.00  )
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

On 6/14/22 06:36, Shinichiro Kawasaki wrote:
> On Jun 10, 2022 / 13:33, Hannes Reinecke wrote:
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   tests/nvme/040     | 81 ++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/nvme/040.out |  7 ++++
>>   2 files changed, 88 insertions(+)
>>   create mode 100644 tests/nvme/040
>>   create mode 100644 tests/nvme/040.out
>>
>> diff --git a/tests/nvme/040 b/tests/nvme/040
>> new file mode 100644
>> index 0000000..ce6157f
>> --- /dev/null
>> +++ b/tests/nvme/040
>> @@ -0,0 +1,81 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
>> +#
>> +# Create authenticated connections
>> +
>> +. tests/nvme/rc
>> +
>> +DESCRIPTION="Create authenticated connections"
>> +QUICK=1
>> +
>> +requires() {
>> +	_nvme_requires
>> +	_have_loop
>> +	_require_nvme_trtype_is_fabrics
>> +	_require_nvme_cli_auth
>> +}
>> +
>> +
>> +test() {
>> +	local port
>> +	local subsys_name="blktests-subsystem-1"
>> +	local hostid="$(uuidgen)"
>> +	local hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
>> +	local file_path="${TMPDIR}/img"
>> +	local hostkey
>> +	local ctrldev
>> +
>> +	echo "Running ${TEST_NAME}"
>> +
>> +	hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
>> +	if [ $? -ne 0 ] ; then
>> +		echo "nvme gen-dhchap-key command missing"
> 
> This message is a bit confusing. _require_nvme_cli_auth in requries() already
> confirmed that nvme gen-dhchap-key command is not missing. I think "nvme
> gen-dhchap-key command failed" is a bit better message here.
> 
Okay, will be fixing it up.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

