Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8038DC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 09:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nb7IPY8piTfg9kVdRBvxGkNqFyroCXlot1cinGaS5vk=; b=vVc9ZzOimXolUlUlU+AXpIli5k
	r8KqFIHxpTyyuGWaF6Efczv3D71Z4k1nM+FoSaifa4E1gLp2IsAure4Sq1U1HVZWjlFAlcP69kZnf
	ocYOU5Z5mUmVZQpBKLzDcgCLFFsuMEPa1LJm7ZrztLMxCdxvaPJ5eYfbYzimxjlQFfsMlAbfbaot3
	tDLPQgLXOP+XhUCmpmSxcGTjLC/ZcGbcUjKMxMq2mKKGIP22Jflr7FRAvYfALUBsSb+x9p0y+NwLV
	T2zgmgmPx9zGH7OPbg+wkmnSbQr/tnOrlckFBtDBjWFxgJODzO0gJOpRVe2T4kUHYym3hS2lYKJi0
	gVfLVEoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp5p9-00FeNe-MZ; Mon, 22 Nov 2021 09:41:20 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp5Wy-00FYKe-Sd
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 09:22:34 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 498081FD26;
 Mon, 22 Nov 2021 09:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637572951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nb7IPY8piTfg9kVdRBvxGkNqFyroCXlot1cinGaS5vk=;
 b=DBFuF5O2Z/TUun1hkIrFscO5Cjs6yiL5UCwzquzdaECzbKxgG8k2xN4nOuZ8qw32opGpnT
 8DwNrIDmwHZ0L2neiisO+jgyIzUzoZUTWVyQgsf8GyocBvc1v32jjQnXi7hqLNNwFJwwLU
 HQuLQ6yJOUEbQuRQic1sSU1CUzxeC0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637572951;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nb7IPY8piTfg9kVdRBvxGkNqFyroCXlot1cinGaS5vk=;
 b=GoQEwYCF7dU/AreUX6RzxAPmlyvfoh1PpKAozy6KdW5eE3jfPU+0wpx67miNedEdJP5L/R
 KPOBHEovA1MzcOCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 29E5813466;
 Mon, 22 Nov 2021 09:22:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ULOtCVdhm2GjUQAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 22 Nov 2021 09:22:31 +0000
Subject: Re: [PATCH 5/9] nvme/040: create an authenticated nvmeof-tcp
 connection
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org
References: <20211122075524.26207-1-hare@suse.de>
 <20211122075524.26207-6-hare@suse.de>
 <6f85d8e0-a930-9ddc-e810-f56bf483a22c@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <48b581fe-8995-8ae7-44a0-03917cb10b52@suse.de>
Date: Mon, 22 Nov 2021 10:22:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <6f85d8e0-a930-9ddc-e810-f56bf483a22c@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_012233_117907_7072780A 
X-CRM114-Status: GOOD (  26.09  )
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

On 11/22/21 9:57 AM, Sagi Grimberg wrote:
> 
> 
> On 11/22/21 9:55 AM, Hannes Reinecke wrote:
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   tests/nvme/040     | 64 ++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/nvme/040.out |  6 +++++
>>   2 files changed, 70 insertions(+)
>>   create mode 100644 tests/nvme/040
>>   create mode 100644 tests/nvme/040.out
>>
>> diff --git a/tests/nvme/040 b/tests/nvme/040
>> new file mode 100644
>> index 0000000..9c2eb07
>> --- /dev/null
>> +++ b/tests/nvme/040
>> @@ -0,0 +1,64 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
>> +#
>> +# Test nvme over tcp authentication
>> +
>> +. tests/nvme/rc
>> +
>> +DESCRIPTION="Create authenticated TCP connection via localhost"
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
>> +    local genctr
>> +    local subsys="blktests-subsystem-"
>> +    local hostid="$(uuidgen)"
>> +    local hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
>> +    local scratch="/tmp/blktest-ns1.img"
>> +    local nvme_trtype="tcp"
> 
> Why is this tcp specific? what prevents this from passing with
> loop/rdma?
> 

Nothing in principle.

> AFAICT the rest of the tests are not tcp specific either, nor
> is inband auth in general...
> 
> I think we should have the tests run with a user-defind nvme_trtype.
> 

If you can tell me how to do that I'll happily make the change.

>> +    local hostkey
>> +
>> +    echo "Running ${TEST_NAME}"
>> +
>> +    hostkey="$(nvme gen-dhchap-key -n ${subsys}1 2> /dev/null)"
>> +    if [ $? -ne 0 ] ; then
>> +        echo "nvme gen-dhchap-key command missing"
>> +        return 1
>> +    fi
> 
> I think that this belongs in nvme/rc
> 
>> +
>> +    _setup_nvmet
>> +
>> +    truncate -s 512M "${scratch}"
>> +
>> +    port="$(_create_nvmet_port "${nvme_trtype}")"
>> +
>> +    _create_nvmet_subsystem "${subsys}1" "${scratch}"
>> +    _add_nvmet_subsys_to_port "${port}" "${subsys}1"
>> +    _create_nvmet_host "${subsys}1" "${hostnqn}"
>> +    _set_nvmet_hostkey "${hostnqn}" "${hostkey}"
> 
> Can you comment that hash/dhgrp are used with their default values.
> 
Sure.

>> +
>> +    nvme connect -t "${nvme_trtype}" -n "${subsys}1" \
>> +         -a "${def_traddr}" -s "${def_trsvcid}" -S "${hostkey}" \
>> +         --hostnqn="${hostnqn}" --hostid="${hostid}"
>> +
>> +    nvme list-subsys
> 
> Why not just look in the connect retcode? why do you need the
> list-subsys output?
> 
Hmm. Possibly I could; just found it more obvious the check if the
namespace shows up in the system as expected.
Reasoning being that it doesn't help if nvme returns no error, but
the namespace doesn't show up.
But I'm open to suggestions.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)

