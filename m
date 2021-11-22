Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E697CC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 10:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YIoBjTVtFZfNe2YwkbXkuFOkKZJ9231UhGiXr3JPWgw=; b=UCG2D4MQi9ieiXdlB8DGHEOMFa
	i5bIle6MEMD3/6IjeiJEZxCT83l2yOsP/sPX1nVH/f2Y+BHBTpKMa/VHASQELGQZJ7ferpPrbNcr/
	jqREHtgN1Zy2rjQ341j+QjAW7i6N1VWJEafG4rC4osy59rD7rG7VxCymfJm0Zx6Dvn1ljCnFHPM0w
	ajit6kBrGZiv8nOuh0L6GxJcABfKcRPjOJbsXYSppNZ5oMMltgdMtDnSLen4t88Wki5e6Wid1Q7oj
	9zPGEv4NYeDwoRuaWWR1lzxDfjaUewFwUuTVe7EAuma8Fj5l1jqBl0I9+vTgQL6s+qeOt6a2BXCmu
	2f0BuJqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp69V-00FkNC-JM; Mon, 22 Nov 2021 10:02:21 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp5oc-00FeFL-Hv
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 09:40:48 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 33A43212BA;
 Mon, 22 Nov 2021 09:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637574045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YIoBjTVtFZfNe2YwkbXkuFOkKZJ9231UhGiXr3JPWgw=;
 b=Uq1Vo2gpNLuP8WSk2uiMGjV9LNBkkJX9j2fwK5RuWlO5naQ2tI+zFdeUmnIzluksp2T7qu
 vc5OkcI6kYU7YSNzB+cCfoeEAMRBt64E7nMhfb3q+al/Q+RUBgb1YpLhVDNl1OXmnKtuC8
 qbnEUa/LR3UnL6EHhNn2CanQ+ljylY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637574045;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YIoBjTVtFZfNe2YwkbXkuFOkKZJ9231UhGiXr3JPWgw=;
 b=5ArB2wCjE1bZPtsrShtaEP9kMmrTNSrE7ztvzv6ccD7LAUBy81QDqoIZazO7oxGb8RLhQM
 2YCc3yAYIUOmztBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0EDBE13C23;
 Mon, 22 Nov 2021 09:40:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aYGGAJ1lm2GmWwAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 22 Nov 2021 09:40:45 +0000
Subject: Re: [PATCH 9/9] nvme/044: test re-authentication
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org
References: <20211122075524.26207-1-hare@suse.de>
 <20211122075524.26207-10-hare@suse.de>
 <2bdd14e4-ac97-c21b-6ecf-f7ea6c4b215a@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <faa1a812-8bde-c498-63bc-94fb22e94a2d@suse.de>
Date: Mon, 22 Nov 2021 10:40:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <2bdd14e4-ac97-c21b-6ecf-f7ea6c4b215a@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_014046_795909_B3539D84 
X-CRM114-Status: GOOD (  22.57  )
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

On 11/22/21 10:02 AM, Sagi Grimberg wrote:
> 
> 
> On 11/22/21 9:55 AM, Hannes Reinecke wrote:
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   tests/nvme/044     | 116 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/nvme/044.out |  22 +++++++++
>>   2 files changed, 138 insertions(+)
>>   create mode 100644 tests/nvme/044
>>   create mode 100644 tests/nvme/044.out
>>
>> diff --git a/tests/nvme/044 b/tests/nvme/044
>> new file mode 100644
>> index 0000000..e3a1e94
>> --- /dev/null
>> +++ b/tests/nvme/044
>> @@ -0,0 +1,116 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
>> +#
>> +# Test nvme over tcp re-authentication
>> +
>> +. tests/nvme/rc
>> +
>> +DESCRIPTION="Test re-authentication for TCP connection via localhost"
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
>> +    local hostkey
>> +    local ctrlkey
>> +
>> +    echo "Running ${TEST_NAME}"
>> +
>> +    hostkey="$(nvme gen-dhchap-key -n ${subsys}1 2> /dev/null)"
>> +    if [ $? -ne 0 ] ; then
>> +        echo "nvme gen-dhchap-key command missing"
>> +        return 1
>> +    fi
>> +
>> +    ctrlkey="$(nvme gen-dhchap-key -n ${subsys}1 2> /dev/null)"
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
>> +    _create_nvmet_subsystem "${subsys}1" "${scratch}"
>> +    _add_nvmet_subsys_to_port "${port}" "${subsys}1"
>> +    _create_nvmet_host "${subsys}1" "${hostnqn}"
>> +
>> +    _set_nvmet_dhgroup "${hostnqn}" "ffdhe2048"
>> +    _set_nvmet_hostkey "${hostnqn}" "${hostkey}"
>> +    _set_nvmet_ctrlkey "${hostnqn}" "${ctrlkey}"
>> +
>> +    nvme connect -t "${nvme_trtype}" -n "${subsys}1" \
>> +         -a "${def_traddr}" -s "${def_trsvcid}" \
>> +         -S "${hostkey}" -C "${ctrlkey}" \
>> +         --hostnqn="${hostnqn}" --hostid="${hostid}"
>> +
>> +    nvme list-subsys
>> +
>> +    ctrl=$(_find_nvme_dev "${subsys}1")
>> +
>> +    echo "Re-authenticate with original host key"
>> +
>> +    echo "${hostkey}" > /sys/class/nvme/${ctrl}/dhchap_secret
>> +
>> +    echo "Renew host key on the controller"
>> +
>> +    new_hostkey="$(nvme gen-dhchap-key -n ${subsys}1 2> /dev/null)"
>> +
>> +    _set_nvmet_hostkey "${hostnqn}" "${new_hostkey}"
>> +
>> +    echo "Re-authenticate with new host key"
>> +
>> +    echo "${new_hostkey}" > /sys/class/nvme/${ctrl}/dhchap_secret
>> +
>> +    nvme list-subsys
>> +
>> +    echo "Renew ctrl key on the controller"
>> +
>> +    new_ctrlkey="$(nvme gen-dhchap-key -n ${subsys}1 2> /dev/null)"
>> +
>> +    _set_nvmet_ctrlkey "${hostnqn}" "${new_ctrlkey}"
>> +
>> +    echo "Re-authenticate with new ctrl key"
>> +
>> +    echo "${new_ctrlkey}" > /sys/class/nvme/${ctrl}/dhchap_ctrl_secret
>> +
>> +    nvme list-subsys
>> +
>> +    echo "Change DH group to ffdhe8192"
>> +
>> +    _set_nvmet_dhgroup "${hostnqn}" "ffdhe8192"
>> +
>> +    echo "Re-authenticate with changed DH group"
>> +    echo "${new_hostkey}" > /sys/class/nvme/${ctrl}/dhchap_secret
>> +
>> +    nvme list-subsys
> 
> Here you may want to compare the lists, but why not to a local
> variable?
> 
Actually, I don't need as the list is stored in the output file; if the
lists are different we'll have a diff to the output file and the test
will fail.

But yeah, I see your point.

> If you insist of printing, how about introducing a
> generic filter helper to filter-out the transport from list-subsys?

See my comment to the previous tests.
If it's sufficient to check the return code from nvme connect we can go
with that.
Or checking for the namespace device node like I did in 43.

Lemme see.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)

