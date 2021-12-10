Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39794C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Dec 2021 12:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fj3GdK+8LWUMW5B6Z1iKwYCcHXg1XtvaxaHBYc5uJOA=; b=Gtt7BaOK7n2TpzuhthAB4P49Fo
	+Y0FZHgsd1gQGH8akJgFbJ1lk6oGgrhD4d9RVjj61ohmaxzofFSiMiqmUKWIaP/36bbpDQqQqiXs7
	1uouOIqxqSGMWRLiopZ/SndsZ1IEmMPEN2agOBZBLny4FNOG1vICJA0WPvhA3MTCFilvb4Kvisz11
	3BOxtMIgiFJyc7hzK3bQpmq8uz8/jH0rDzzZk2cn8tWLc8Jg3rrivtUvf+a43Ud9VQrSZSUt2yLYV
	UK+E62kpIIUt6q9hjVqkf4Hj/JXfpj8FuENRopBlvz4IYvraUctPdLZgAg6IGerRbCFAQzMg+Ow+l
	kmAY2T4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mvefh-001mQm-GI; Fri, 10 Dec 2021 12:06:41 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvefe-001mQ4-33
 for linux-nvme@lists.infradead.org; Fri, 10 Dec 2021 12:06:40 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 916CC1F387
 for <linux-nvme@lists.infradead.org>; Fri, 10 Dec 2021 12:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1639137994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fj3GdK+8LWUMW5B6Z1iKwYCcHXg1XtvaxaHBYc5uJOA=;
 b=IHcK1HgrKbc591Z3fC8HyCCRR/r9AX5IJNn4v+uDXujjkjE2mX/jWdiktxwYJtgIOO2uVK
 8cnm/TLKVDa6vuBywXvsOcVue+nEXYOUaAzcQA8enoBBNz6kd5xJcJrv02pzFs42I2qN3J
 mj3KPopmzGcOzu2KZAkzx2t4dgrtaqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1639137994;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fj3GdK+8LWUMW5B6Z1iKwYCcHXg1XtvaxaHBYc5uJOA=;
 b=robA9/Q457kguAyUHtBVxvhen5o0C2YfJNgPbbUg0Ls66h5no0rbt4P60tLYaEFFoIy4/F
 gI9smG0TzAVkhRBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7CAE713E02
 for <linux-nvme@lists.infradead.org>; Fri, 10 Dec 2021 12:06:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XiIOHspCs2EUfgAAMHmgww
 (envelope-from <hare@suse.de>)
 for <linux-nvme@lists.infradead.org>; Fri, 10 Dec 2021 12:06:34 +0000
Subject: Re: [PATCH 09/10] nvme/042: test bi-directional authentication
To: linux-nvme@lists.infradead.org
References: <20211123074940.113390-1-hare@suse.de>
 <20211123074940.113390-10-hare@suse.de>
 <ffe973a1-1856-e2e7-9695-cb2ce532de3b@grimberg.me>
 <ebae81ae-94d8-6044-1492-cc856a476290@suse.de>
 <17b0e7fa-317a-fbd5-6a04-2a76e3c7f88c@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <068a4335-74c8-e7e6-85e0-fed888f4e3fd@suse.de>
Date: Fri, 10 Dec 2021 13:06:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <17b0e7fa-317a-fbd5-6a04-2a76e3c7f88c@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211210_040638_324343_2119C751 
X-CRM114-Status: GOOD (  16.79  )
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

On 12/8/21 2:09 PM, Sagi Grimberg wrote:
> 
> 
> On 11/28/21 7:34 PM, Hannes Reinecke wrote:
>> On 11/28/21 2:36 PM, Sagi Grimberg wrote:
>>>
>>>
>>> On 11/23/21 9:49 AM, Hannes Reinecke wrote:
>>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>>> ---
>>>>   tests/nvme/042     | 107
>>>> +++++++++++++++++++++++++++++++++++++++++++++
>>>>   tests/nvme/042.out |   8 ++++
>>>>   2 files changed, 115 insertions(+)
>>>>   create mode 100644 tests/nvme/042
>>>>   create mode 100644 tests/nvme/042.out
>>>>
>>>> diff --git a/tests/nvme/042 b/tests/nvme/042
>>>> new file mode 100644
>>>> index 0000000..f3954b4
>>>> --- /dev/null
>>>> +++ b/tests/nvme/042
>>>> @@ -0,0 +1,107 @@
>>>> +#!/bin/bash
>>>> +# SPDX-License-Identifier: GPL-3.0+
>>>> +# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
>>>> +#
>>>> +# Test bi-directional authentication
>>>> +
>>>> +. tests/nvme/rc
>>>> +
>>>> +DESCRIPTION="Test bi-directional authentication"
>>>> +QUICK=1
>>>> +
>>>> +requires() {
>>>> +    _nvme_requires
>>>> +    _have_modules loop
>>>> +    _require_nvme_trtype_is_fabrics
>>>> +}
>>>> +
>>>> +
>>>> +test() {
>>>> +    local port
>>>> +    local subsys="blktests-subsystem-1"
>>>> +    local hostid="$(uuidgen)"
>>>> +    local hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
>>>> +    local scratch="/tmp/blktest-ns1.img"
>>>> +    local hostkey
>>>> +    local ctrlkey
>>>> +    local ctrldev
>>>> +
>>>> +    echo "Running ${TEST_NAME}"
>>>> +
>>>> +    hostkey="$(nvme gen-dhchap-key -n ${subsys} 2> /dev/null)"
>>>> +    if [ $? -ne 0 ] ; then
>>>> +        echo "nvme gen-dhchap-key command missing"
>>>> +        return 1
>>>> +    fi
>>>> +
>>>> +    ctrlkey="$(nvme gen-dhchap-key -n ${subsys} 2> /dev/null)"
>>>> +    if [ $? -ne 0 ] ; then
>>>> +        echo "nvme gen-dhchap-key command missing"
>>>> +        return 1
>>>> +    fi
>>>> +
>>>> +    _setup_nvmet
>>>> +
>>>> +    truncate -s 512M "${scratch}"
>>>> +
>>>> +    port="$(_create_nvmet_port "${nvme_trtype}")"
>>>> +
>>>> +    _create_nvmet_subsystem "${subsys}" "${scratch}"
>>>> +    _add_nvmet_subsys_to_port "${port}" "${subsys}"
>>>> +    _create_nvmet_host "${subsys}" "${hostnqn}" "${hostkey}"
>>>> "${ctrlkey}"
>>>> +
>>>> +    _set_nvmet_dhgroup "${hostnqn}" "ffdhe2048"
>>>> +
>>>> +    # Step 1: Connect with host authentication only
>>>> +    echo "Test host authentication"
>>>> +    _nvme_connect_subsys "${nvme_trtype}" "${subsys}" \
>>>> +                 "${def_traddr}" "${def_trsvcid}" \
>>>> +                 "${hostnqn}" "${hostid}" \
>>>> +                 "${hostkey}"
>>>> +
>>>> +    ctrldev=$(_find_nvme_dev "${subsys}")
>>>> +    if [ -z "$ctrldev" ] ; then
>>>> +        echo "nvme controller not found"
>>>> +    fi
>>>> +
>>>> +    _nvme_disconnect_subsys "${subsys}"
>>>> +
>>>> +    # Step 2: Connect with host authentication
>>>> +    # and invalid ctrl authentication
>>>> +    echo "Test host authentication and invalid ctrl authentication"
>>>> +    _nvme_connect_subsys "${nvme_trtype}" "${subsys}" \
>>>> +                 "${def_traddr}" "${def_trsvcid}" \
>>>> +                 "${hostnqn}" "${hostid}" \
>>>> +                 "${hostkey}" "${hostkey}"
>>>> +    ctrldev=$(_find_nvme_dev "${subsys}1")
>>>> +    if [ -n "${ctrldev}" ] ; then
>>>> +        echo "nvme controller found!"
>>>> +        _nvme_disconnect_subsys "${ctrldev}"
>>>> +    fi
>>>
>>> This test case has a weird behavior. Why isn't _nvme_connect_subsys
>>> failing?
>>
>> Oh, but it is.
>> The line 'nvme controller found' is not part of the .out file, hence
>> the test will fail.
>>
>> Call it an obscure feature of blktests :-)
>>
>> But yeah, I can make it more obvious that this is the failure case.
> 
> Hannes, my question is why isn't nvme connect not failing (i.e.
> returning a non-zero status code)?
> 
I guess it does, but we're never actually checking the return value.
Let me check.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

