Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99588C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 09:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wl4PS7sJ5Ed4pBftjGwF/ZfMMiUi4fJqEocfskHGhhw=; b=Lf4a5U4vc8Sg0ap5yld4XCSb8v
	OFDiqG4zD2K/AdWJfhxoJuNTJegTGVBwbinvC2iQmTRPCgP17mYAmNuGrZ9NHXXTnKWOcdI01w94+
	E+1APHA0GnbHr76siBuZPIErj4STjRAb/MTbndE5muYtrHFZa2us+Y+0mKu9Jr32dIibk+UdJDCbW
	jlKJchC6VxuRcPMl9UwnuijXV7A4AWtpkbUZ6pTzcaDKi8xROGzK4UeCm9N4uhlA5TkRnvGrY7AuP
	J9lqg+DV6iyBXWlwi/5p/EUJXb9Sb+eRiKYEzboJYXuW5TcFavPCk2MNNG84yCNbr3ToYnW4QmEe7
	/wpMD6OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp5rG-00Fetx-6Q; Mon, 22 Nov 2021 09:43:30 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp5a5-00FZNW-8L
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 09:25:46 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EC9E81FD5A;
 Mon, 22 Nov 2021 09:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637573143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wl4PS7sJ5Ed4pBftjGwF/ZfMMiUi4fJqEocfskHGhhw=;
 b=slcNqYEVaj4gE5e9Oi+BzdywclcgJLCkLKUBJR4Tr3WbXMdZDxF0WGRfn7T1nG5HDHoFw4
 PcF4sbdew3LQN4TSDzAcvf/p5fD0V/unpGhSaCQfhoiH4b8Kr8Uafr5CE5yuRkIfERMVyJ
 VqK1OHDB8L8RYMp7w+ga2DIIBfgHRIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637573143;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wl4PS7sJ5Ed4pBftjGwF/ZfMMiUi4fJqEocfskHGhhw=;
 b=LkX+Qr126wmtFQLN2EZBzsbpKN1vc4bQ/pQPyBpCAWCUBpmeW9w7JQRX6E2tUXVdrVWZxW
 rxHwLNdj2JWiZUCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9FC7A13C23;
 Mon, 22 Nov 2021 09:25:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MzJvJhdim2GJUwAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 22 Nov 2021 09:25:43 +0000
Subject: Re: [PATCH 6/9] nvme/041: test different key types
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org
References: <20211122075524.26207-1-hare@suse.de>
 <20211122075524.26207-7-hare@suse.de>
 <96c61139-5206-dad1-6157-d8dab1f314c1@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <ff74b9cd-04a1-bc37-14f2-dd40823fa73c@suse.de>
Date: Mon, 22 Nov 2021 10:25:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <96c61139-5206-dad1-6157-d8dab1f314c1@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_012545_492984_2ED3FD55 
X-CRM114-Status: GOOD (  16.74  )
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

On 11/22/21 9:58 AM, Sagi Grimberg wrote:
> 
> 
> On 11/22/21 9:55 AM, Hannes Reinecke wrote:
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   tests/nvme/041     | 102 +++++++++++++++++++++++++++++++++++++++++++++
>>   tests/nvme/041.out |  36 ++++++++++++++++
>>   2 files changed, 138 insertions(+)
>>   create mode 100644 tests/nvme/041
>>   create mode 100644 tests/nvme/041.out
>>
>> diff --git a/tests/nvme/041 b/tests/nvme/041
>> new file mode 100644
>> index 0000000..8fc4ab9
>> --- /dev/null
>> +++ b/tests/nvme/041
>> @@ -0,0 +1,102 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
>> +#
>> +# Test nvme over tcp dhchap keys
>> +
>> +. tests/nvme/rc
>> +
>> +DESCRIPTION="Test dhchap keys for authenticated TCP connection via
>> localhost"
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
>> +
>> +    echo "Running ${TEST_NAME}"
>> +
>> +    hostkey="$(nvme gen-dhchap-key -n ${subsys}1 2> /dev/null)"
>> +    if [ $? -ne 0 ] ; then
>> +        echo "nvme gen-dhchap-key command missing"
>> +        return 1
>> +    fi
> 
> Don't we want to test different secret formats?

We do.
But this is just a check if the nvme cli contains functionality for
generating keys in the first place.

Maybe we should make this a requirement (like
_requre_nvme_trtype_is_fabrics).

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)

