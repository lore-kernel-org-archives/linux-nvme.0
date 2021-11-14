Return-Path: <SRS0=Lvqr=QB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1CCC433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Nov 2021 13:50:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC63F6112E
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Nov 2021 13:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EC63F6112E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vlgkek4UD7NHDB4OLcJH95TvwDUpoiwD2aU37tt5GXU=; b=WnR5YS1xkRNyPFxR9Macl+oNRq
	kO4T0aYkMkLJv9qGS8zXz/KptcjmI9eAggx17VIpiE2DnAlO90rJJNKs+m43tOZoSD9vGtfdQ7ALt
	KshUnSPIkRHSlSa1S5emtE+CAwZf/WBTp04InaF6rWopzgsmvUjrNI/xU7k0HuFHneCOcQnVvOZUg
	nh722LY134CS6Bp4O01eLOzTl73Bl6aALnN0FHBi5rsldCf9inVYVVQxpb0utHs0YahgWupGt621+
	1pjxc2R3VVImnMn3MAw0WpfqSHV7Xrpymb6dQcG9cFFcJ0ZAAUWf84E2FO2wrPAPJNq9Gr8ZH83Wm
	cSb0MmzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmFu3-00Dije-R1; Sun, 14 Nov 2021 13:50:39 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmFu0-00Diiw-8Z
 for linux-nvme@lists.infradead.org; Sun, 14 Nov 2021 13:50:37 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 027CD1FD50;
 Sun, 14 Nov 2021 13:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636897835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vlgkek4UD7NHDB4OLcJH95TvwDUpoiwD2aU37tt5GXU=;
 b=Ar3c1WF5c4GwdlPOX0xVqSwVOqsskn7FiWhhLFwWXQR3v8mn0PKEUUnr+rV/uD+/gk7yCB
 XAAGXzb0E+Dfo5MvO2X8sZjdeVtbc9CvtbNq6uvuujJmKgllzkUZYtmjS/AAmsOBhiEMUT
 0c90PI7NmgAy2AghpIbI/v25qN4pUgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636897835;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vlgkek4UD7NHDB4OLcJH95TvwDUpoiwD2aU37tt5GXU=;
 b=D1baD2+VmuXId+1CiJyEGj4tZuwBRGTI1l5yCeTeVgHbPjzAjzlVpITIXtTEyGCATOTFVp
 zhAEpGeyqzAhZ8Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C4DAE13AAE;
 Sun, 14 Nov 2021 13:50:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cWSXLioUkWGAWAAAMHmgww
 (envelope-from <hare@suse.de>); Sun, 14 Nov 2021 13:50:34 +0000
Subject: Re: [PATCH 1/6] nvmeof-tcp/001: simple test for nvmeof-tcp connection
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org
References: <20211112144510.98523-1-hare@suse.de>
 <20211112144510.98523-2-hare@suse.de>
 <de1a1ff4-0c1a-6642-9d94-30b3d1cb0406@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <6a8fd808-8a92-3215-597e-7e094e753a9a@suse.de>
Date: Sun, 14 Nov 2021 14:50:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <de1a1ff4-0c1a-6642-9d94-30b3d1cb0406@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211114_055036_485682_BB59AD7E 
X-CRM114-Status: GOOD (  20.33  )
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

On 11/14/21 11:31 AM, Sagi Grimberg wrote:
> 
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   tests/nvmeof-tcp/001     |  55 +++++++
>>   tests/nvmeof-tcp/001.out |   6 +
>>   tests/nvmeof-tcp/rc      | 347 +++++++++++++++++++++++++++++++++++++++
> 
> Why another directory? why nvmeof-tcp? what prevents inband-auth
> to be tested with loop/rdma?
> 
Technically, nothing.
But as I'll be looking into tcp in-band _encryption_ as the next step I 
found it logical to have a disinct directory.
Especially as I still fail to see the actual use-case for using in-band 
authentication _without_ encryption.

We could rename it to nvmeof-auth, though.

Especially as there's the nvmeof-mp precedent, which also has a separate 
directory.

>>   3 files changed, 408 insertions(+)
>>   create mode 100644 tests/nvmeof-tcp/001
>>   create mode 100644 tests/nvmeof-tcp/001.out
>>   create mode 100644 tests/nvmeof-tcp/rc
>>
>> diff --git a/tests/nvmeof-tcp/001 b/tests/nvmeof-tcp/001
>> new file mode 100644
>> index 0000000..39f4108
>> --- /dev/null
>> +++ b/tests/nvmeof-tcp/001
>> @@ -0,0 +1,55 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
>> +#
>> +# Test nvme over tcp connection
>> +
>> +. tests/nvmeof-tcp/rc
>> +
>> +DESCRIPTION="Create single TCP connection via localhost"
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
>> +
>> +    echo "Running ${TEST_NAME}"
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
>> +
>> +    nvme connect -t "${nvme_trtype}" -n "${subsys}1" \
>> +         -a "${def_traddr}" -s "${def_trsvcid}" \
>> +         --hostnqn="${hostnqn}" --hostid="${hostid}"
>> +
>> +    nvme list-subsys
>> +
>> +    nvme disconnect -n "${subsys}1"
>> +
>> +    _remove_nvmet_subsystem_from_port "${port}" "${subsys}1"
>> +    _remove_nvmet_subsystem "${subsys}1"
>> +
>> +    _remove_nvmet_port "${port}"
>> +
>> +    rm ${scratch}
>> +
>> +    echo "Test complete"
>> +}
>> diff --git a/tests/nvmeof-tcp/001.out b/tests/nvmeof-tcp/001.out
>> new file mode 100644
>> index 0000000..1eae834
>> --- /dev/null
>> +++ b/tests/nvmeof-tcp/001.out
>> @@ -0,0 +1,6 @@
>> +Running nvmeof-tcp/001
>> +nvme-subsys0 - NQN=blktests-subsystem-1
>> +\
>> + +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
>> +NQN:blktests-subsystem-1 disconnected 1 controller(s)
>> +Test complete
>> diff --git a/tests/nvmeof-tcp/rc b/tests/nvmeof-tcp/rc
>> new file mode 100644
>> index 0000000..9ae0899
>> --- /dev/null
>> +++ b/tests/nvmeof-tcp/rc
>> @@ -0,0 +1,347 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2018 Johannes Thumshirn
>> +#
>> +# Test specific to NVMe devices
> 
> Isn't this just a copy of nvme/rc?

Essentially, yes.
And I'd be happy to merge them, like having a common nvme rc
file to be used for all nvme related tests.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

