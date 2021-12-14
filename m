Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74F7C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Dec 2021 07:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DIB2bWFWLXCCXmh262gSUyE/fEAgytow9KEN1kzDL8o=; b=zS/bI4434Vi0GN1glbIdk50aOq
	LXPDCCC0Sq1e5n4M6v0ERStzeBEu1MufysgUCPmblmd5HTZkw5z8SjkCSgkfGtF4Xq2wBtV5YfAZ6
	YM9mWzHYJ3tfHgDCKapjx7D6RmTK0vBr6q78dMsAmcBwTd+dlJWaZ/py3n/SppjoF1lPSOfllu4BT
	o2Uc5mM7aMEkjeck3q5rTM6IiOzBqKHbeE/8rjihfCxvSJVbt6W0vT0GbxaIK4McYtrHousIFp3/O
	pcoGgktUWTlIoj9Eg1/MXMoQxku28PYPIo7JMN0z3l19LlxTc6MrJEyhQEXfrEzAHY7g68SPq3j/L
	isCeYKPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mx1w6-00Cngj-I9; Tue, 14 Dec 2021 07:09:18 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mx1w3-00CngJ-Ej
 for linux-nvme@lists.infradead.org; Tue, 14 Dec 2021 07:09:16 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E32CC212B9;
 Tue, 14 Dec 2021 07:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1639465751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DIB2bWFWLXCCXmh262gSUyE/fEAgytow9KEN1kzDL8o=;
 b=kAlnpQIX4g0q16J3OehDACLFpFiLisYY+P+iwIRSN+hT8ZMI21it62Rvmn5PgRtZIUdSUu
 McCHAZwmz5on4r2cVnL5dqC5FdNgczzZMlsnf4xDM4p0A3bOmYy+VOpomyJoQFLeoZM08p
 uJYETcuDqRemiHFdwHVf8qCC4TmBPF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1639465751;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DIB2bWFWLXCCXmh262gSUyE/fEAgytow9KEN1kzDL8o=;
 b=rONwwdoBUidfxDAgH9FuRw/qIwr9IrMj+Th4Mhpk/J5r/WVNTnJ6y4opCXzQdU3BrdAELb
 Mg+qiLtETW1tibCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C29A913CF7;
 Tue, 14 Dec 2021 07:09:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NNigLhdDuGFqbwAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 14 Dec 2021 07:09:11 +0000
Subject: Re: [PATCH 06/10] nvme/039: create authenticated connections
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20211123074940.113390-1-hare@suse.de>
 <20211123074940.113390-7-hare@suse.de>
 <33457fa9-e289-7e0d-c12b-1971b5491703@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <038aadd0-1bc0-632c-8411-50256ed507f0@suse.de>
Date: Tue, 14 Dec 2021 08:09:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <33457fa9-e289-7e0d-c12b-1971b5491703@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_230915_665585_283B64A2 
X-CRM114-Status: GOOD (  20.47  )
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

On 12/13/21 11:55 PM, Chaitanya Kulkarni wrote:
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
> 
> We add following in the patch 4 that is called in requires of this
> testcase, by any chance above check for gen-dhcap-key is duplicate ? :-
> 
> +_require_nvme_cli_auth() {
> +	local hostkey
> +
> +	hostkey="$(nvme gen-dhchap-key -n nvmf-test-subsys 2> /dev/null)"
> +	if [ $? -ne 0 ] ; then
> +		SKIP_REASON="nvme gen-dhchap-key command missing"
> +		return 1
> +	fi
> +	return 0
> +}
> +
> 
You are right, this can be removed.

Will be resubmitting.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

