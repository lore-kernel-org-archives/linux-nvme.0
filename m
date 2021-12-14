Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297A9C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Dec 2021 07:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pRhGcQtOPUEAPoGcfbhrAz+QfKOXHksxkmNWYi2AqWw=; b=VVORs+KMtmHvlGX2Pgx6/MTbxg
	SntnD8/MHhkqUxKTphNdrkt8vtSnDT7Uy4j5gg7sLdhmKxWKozJmTtx2YD3JpG4TDrNhl3TQbGP7s
	FfmuC9lPjzA1PFyt3zRtM2IR+6BYEJ5cH+Hc35hWp2hYnnzZ1L6/ZLzaZE7Ff4olTXDe3QZi/V75j
	vvelwpAU/yCwU0mCrRYOABl5PaIXm4bxIRcQkPMeEEoZCOm/nRR3zZ3EM7LMQodNKhaXk+jKVBYm7
	B21TNiustciMqO6dVMs3i6IrF8mEI8kT5wm17Qi7K0+8TyXMEAFrF7IlyfFm+pVDfGKYAwwwxK4BQ
	uO12fl5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mx238-00CoKO-M8; Tue, 14 Dec 2021 07:16:34 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mx235-00CoJd-Hn
 for linux-nvme@lists.infradead.org; Tue, 14 Dec 2021 07:16:33 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 93DD81F3C3;
 Tue, 14 Dec 2021 07:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1639466189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pRhGcQtOPUEAPoGcfbhrAz+QfKOXHksxkmNWYi2AqWw=;
 b=HJvKGwPtAEulPjjktwp3zrxt1Wg6+BKEpjsnHM9SXkrFYnIyJtlp9xLCgcnm1L7wnwS05i
 jAJMdwu2Cg4KKs5MWjlWe/pT0Yw7lAZbG4Z+54Ums+AoeohxZHzMwgQe3KA0GDWSatwKhX
 uoZrI4KpA7nldEC48Xz6jaoZ+sHUxAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1639466189;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pRhGcQtOPUEAPoGcfbhrAz+QfKOXHksxkmNWYi2AqWw=;
 b=uCkSpq1oyf/DvlqzZVYKYuSX/rushPxS3wntGLTlkUx2LzidTaO4WOIUpvGjRdaZUQ2Seu
 8lr51IU6ygbaXbDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A37E13CF7;
 Tue, 14 Dec 2021 07:16:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nlAHCM1EuGFFcgAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 14 Dec 2021 07:16:29 +0000
Subject: Re: [PATCH 06/10] nvme/039: create authenticated connections
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20211123074940.113390-1-hare@suse.de>
 <20211123074940.113390-7-hare@suse.de>
 <d3556c79-d105-b4cb-a84d-a1b7aff8c4b0@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <3e86b6c3-d261-aa07-2e77-20e29880213e@suse.de>
Date: Tue, 14 Dec 2021 08:16:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <d3556c79-d105-b4cb-a84d-a1b7aff8c4b0@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_231631_760740_8A2BBE17 
X-CRM114-Status: GOOD (  19.85  )
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

On 12/14/21 12:01 AM, Chaitanya Kulkarni wrote:
> On 11/22/21 11:49 PM, Hannes Reinecke wrote:
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>    tests/nvme/039     | 83 ++++++++++++++++++++++++++++++++++++++++++++++
>>    tests/nvme/039.out |  7 ++++
>>    2 files changed, 90 insertions(+)
>>    create mode 100644 tests/nvme/039
>>    create mode 100644 tests/nvme/039.out
>>
>> diff --git a/tests/nvme/039 b/tests/nvme/039
>> new file mode 100644
>> index 0000000..4fbe7de
>> --- /dev/null
>> +++ b/tests/nvme/039
>> @@ -0,0 +1,83 @@
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
>> +	_have_modules loop
>> +	_require_nvme_trtype_is_fabrics
>> +	_require_nvme_cli_auth
>> +}
>> +
>> +
>> +test() {
>> +	local port
>> +	local subsys="blktests-subsystem-1"
>> +	local hostid="$(uuidgen)"
>> +	local hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
>> +	local scratch="/tmp/blktest-ns1.img"
>> +	local hostkey
>> +	local ctrldev
>> +
>> +	echo "Running ${TEST_NAME}"
>> +
>> +	hostkey="$(nvme gen-dhchap-key -n ${subsys} 2> /dev/null)"
>> +	if [ $? -ne 0 ] ; then
>> +		echo "nvme gen-dhchap-key command missing"
>> +		return 1
>> +	fi
>> +
>> +	_setup_nvmet
>> +
>> +	truncate -s 512M "${scratch}"
>> +
>> +	port="$(_create_nvmet_port "${nvme_trtype}")"
>> +
>> +	_create_nvmet_subsystem "${subsys}" "${scratch}"
>> +	_add_nvmet_subsys_to_port "${port}" "${subsys}"
>> +	_create_nvmet_host "${subsys}" "${hostnqn}" "${hostkey}"
>> +
> 
> Starting from _setup_nvmet() to _create_nvmet_host() seems to be
> duplicated in most of the cases (39/40/41/42/43).
> 
> Let's avoid the code duplication by creating a helper in nvme/rc ?
> 
I deliberately did not create a single helper here, as I'm not a fan of 
functions with thousands of arguments (we would need at least 5 
arguments here).
And also it allows you to expand that by creating two ports to the same 
subsystem etc.

So I'd rather keep it that way.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

