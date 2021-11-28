Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D2AC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Nov 2021 17:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w4p7RwAC4eNW0Qn1j+DlqulOZ35kcQvBA6FKy205fec=; b=LNiuW+Wyyikvs5FRawnidSjNPv
	Vp14b1wT6jyF0o7gJ0IFLnnFKCHAg31BPNSZMPxqU/IUw7sy4XdcqK/XsZHEevwj4hCmOiW0cKEUm
	S6wWf6vTpJ6/Z+J5nnARZ7fgpWLh9YrcyP24By8rgDWSYZnls/SUaRmOMeKPUzLu0M3qjUq/jB+gh
	T1NLVclTRPwE6537ssn5+mO4yBQtYLOAE4FIYmLszV66ml+3D5JrrrZ/Ve79U4qsQdfhsuNd648U2
	I2pjBeQ8ap0HamUUHn1o4scnLDChJZRoABUJ7nqthYNQBierSgXCbtDqwWPAoAJ7GNFDm1CdRa626
	1sqn5SzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mrO4t-00GLXT-CK; Sun, 28 Nov 2021 17:35:03 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrO4q-00GLWZ-6K
 for linux-nvme@lists.infradead.org; Sun, 28 Nov 2021 17:35:01 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F1C2D1FCA1;
 Sun, 28 Nov 2021 17:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1638120896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4p7RwAC4eNW0Qn1j+DlqulOZ35kcQvBA6FKy205fec=;
 b=gyfw+hkWZ4MiHOc6A3eclywEgUtPODcNEvKTGYS+Q6F/SnuEqLp5IytfSFWj43fjhLdiGj
 eFcLLCJ8sa/JyRC4cH9pz7VTDLsh5tlPO2LVX8mZk9196p5hGIo5TsvbgLcVrfWfRSLPdr
 ywVi4dUQV9hWLnTniPQaOfG+WUcV0G4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1638120896;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4p7RwAC4eNW0Qn1j+DlqulOZ35kcQvBA6FKy205fec=;
 b=7ZZmNheKOm7LKmCTrCXHPlLnClDu8AwhVWdUMCl0qna4acgpUwG1TpxXXtIVyknhhUs8RQ
 L70GhkyTmkv1TBBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1DA4133D1;
 Sun, 28 Nov 2021 17:34:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aB9KMsC9o2G1OwAAMHmgww
 (envelope-from <hare@suse.de>); Sun, 28 Nov 2021 17:34:56 +0000
Subject: Re: [PATCH 09/10] nvme/042: test bi-directional authentication
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org
References: <20211123074940.113390-1-hare@suse.de>
 <20211123074940.113390-10-hare@suse.de>
 <ffe973a1-1856-e2e7-9695-cb2ce532de3b@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <ebae81ae-94d8-6044-1492-cc856a476290@suse.de>
Date: Sun, 28 Nov 2021 18:34:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <ffe973a1-1856-e2e7-9695-cb2ce532de3b@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211128_093500_410940_363A69F8 
X-CRM114-Status: GOOD (  18.23  )
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

On 11/28/21 2:36 PM, Sagi Grimberg wrote:
> 
> 
> On 11/23/21 9:49 AM, Hannes Reinecke wrote:
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   tests/nvme/042     | 107 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/nvme/042.out |   8 ++++
>>   2 files changed, 115 insertions(+)
>>   create mode 100644 tests/nvme/042
>>   create mode 100644 tests/nvme/042.out
>>
>> diff --git a/tests/nvme/042 b/tests/nvme/042
>> new file mode 100644
>> index 0000000..f3954b4
>> --- /dev/null
>> +++ b/tests/nvme/042
>> @@ -0,0 +1,107 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
>> +#
>> +# Test bi-directional authentication
>> +
>> +. tests/nvme/rc
>> +
>> +DESCRIPTION="Test bi-directional authentication"
>> +QUICK=1
>> +
>> +requires() {
>> +    _nvme_requires
>> +    _have_modules loop
>> +    _require_nvme_trtype_is_fabrics
>> +}
>> +
>> +
>> +test() {
>> +    local port
>> +    local subsys="blktests-subsystem-1"
>> +    local hostid="$(uuidgen)"
>> +    local hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
>> +    local scratch="/tmp/blktest-ns1.img"
>> +    local hostkey
>> +    local ctrlkey
>> +    local ctrldev
>> +
>> +    echo "Running ${TEST_NAME}"
>> +
>> +    hostkey="$(nvme gen-dhchap-key -n ${subsys} 2> /dev/null)"
>> +    if [ $? -ne 0 ] ; then
>> +        echo "nvme gen-dhchap-key command missing"
>> +        return 1
>> +    fi
>> +
>> +    ctrlkey="$(nvme gen-dhchap-key -n ${subsys} 2> /dev/null)"
>> +    if [ $? -ne 0 ] ; then
>> +        echo "nvme gen-dhchap-key command missing"
>> +        return 1
>> +    fi
>> +
>> +    _setup_nvmet
>> +
>> +    truncate -s 512M "${scratch}"
>> +
>> +    port="$(_create_nvmet_port "${nvme_trtype}")"
>> +
>> +    _create_nvmet_subsystem "${subsys}" "${scratch}"
>> +    _add_nvmet_subsys_to_port "${port}" "${subsys}"
>> +    _create_nvmet_host "${subsys}" "${hostnqn}" "${hostkey}" 
>> "${ctrlkey}"
>> +
>> +    _set_nvmet_dhgroup "${hostnqn}" "ffdhe2048"
>> +
>> +    # Step 1: Connect with host authentication only
>> +    echo "Test host authentication"
>> +    _nvme_connect_subsys "${nvme_trtype}" "${subsys}" \
>> +                 "${def_traddr}" "${def_trsvcid}" \
>> +                 "${hostnqn}" "${hostid}" \
>> +                 "${hostkey}"
>> +
>> +    ctrldev=$(_find_nvme_dev "${subsys}")
>> +    if [ -z "$ctrldev" ] ; then
>> +        echo "nvme controller not found"
>> +    fi
>> +
>> +    _nvme_disconnect_subsys "${subsys}"
>> +
>> +    # Step 2: Connect with host authentication
>> +    # and invalid ctrl authentication
>> +    echo "Test host authentication and invalid ctrl authentication"
>> +    _nvme_connect_subsys "${nvme_trtype}" "${subsys}" \
>> +                 "${def_traddr}" "${def_trsvcid}" \
>> +                 "${hostnqn}" "${hostid}" \
>> +                 "${hostkey}" "${hostkey}"
>> +    ctrldev=$(_find_nvme_dev "${subsys}1")
>> +    if [ -n "${ctrldev}" ] ; then
>> +        echo "nvme controller found!"
>> +        _nvme_disconnect_subsys "${ctrldev}"
>> +    fi
> 
> This test case has a weird behavior. Why isn't _nvme_connect_subsys
> failing?

Oh, but it is.
The line 'nvme controller found' is not part of the .out file, hence the 
test will fail.

Call it an obscure feature of blktests :-)

But yeah, I can make it more obvious that this is the failure case.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

