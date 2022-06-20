Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F29CC43334
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jun 2022 06:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IPDfH2PDIE9vh/cdg1EWL5yLhLGCayiCvSUhkiA3Wco=; b=LXMF62Ws8PsokV/rYEk1/aiERL
	u+HqY94tbFctWR8w2Nzf+Jk1mcEEg4umZXpCnxNNWFd3dKhZ86DMc4MXRMPBOqtkNOclLdBYC3PJd
	PkkSMDk+CB4CZPjdK7dFzw7b4QkN/2BSZNCNKMIxrUU714QraJF9mgTjATpiIwzLdRxmj5efWoYuP
	UGlFizfKY83MOzihMb22zg3uYKL+q0PWhkXrw6QMCbqDiEVlEguePllteaYb00GRINku4FMN4y9uU
	rFsqGjemCYwoFK2xQeqfoP/++Sx/w+S3bS+vl/U+Ix8C+8cdhnpzK89e/ZOHA3ZEBPpZGHDBZKwSc
	iAttSDcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3BL0-00GY1X-50; Mon, 20 Jun 2022 06:56:42 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3BKx-00GXzk-M7
	for linux-nvme@lists.infradead.org; Mon, 20 Jun 2022 06:56:41 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 702191F383;
	Mon, 20 Jun 2022 06:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1655708198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IPDfH2PDIE9vh/cdg1EWL5yLhLGCayiCvSUhkiA3Wco=;
	b=b9gDmEdsHUIDAlSNEbhGymbedC4Qeivtj54z3W7H3hZUZn7u8SXDKDKdPy8iYWV/qGcXFC
	Qx5ZNy0H5TcNdNKewOdn1gB+fhUfhaUHUDofjHBwikMDOayRD0PSPUndNWCBzBYszuEIuZ
	Hk1Q4ur7EvHM5/KGjC5ITe7m4LNiVAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1655708198;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IPDfH2PDIE9vh/cdg1EWL5yLhLGCayiCvSUhkiA3Wco=;
	b=BqfSS3/E8QfP6xtSchP1Kp+tGnlzI2qBIfmPQvHrfA+aEyP2MU2navU+7suM9Vq8X/d0NI
	iJNJCgVj02YmpvAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CAAE134CA;
	Mon, 20 Jun 2022 06:56:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id MNRQMyMasGLddwAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 20 Jun 2022 06:56:35 +0000
Message-ID: <7c1c31ae-e91f-95c9-b78a-9e1eb94a35ad@suse.de>
Date: Mon, 20 Jun 2022 08:56:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 07/10] nvme/041: test dhchap key types for authenticated
 connections
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20220610113324.10294-1-hare@suse.de>
 <20220610113324.10294-8-hare@suse.de>
 <20220614044318.q3v4pnsahbxig5ty@shindev>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220614044318.q3v4pnsahbxig5ty@shindev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220619_235639_929415_C31C1351 
X-CRM114-Status: GOOD (  12.54  )
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

On 6/14/22 06:43, Shinichiro Kawasaki wrote:
> On Jun 10, 2022 / 13:33, Hannes Reinecke wrote:
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   tests/nvme/041     | 95 ++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/nvme/041.out | 16 ++++++++
>>   2 files changed, 111 insertions(+)
>>   create mode 100644 tests/nvme/041
>>   create mode 100644 tests/nvme/041.out
>>
>> diff --git a/tests/nvme/041 b/tests/nvme/041
>> new file mode 100644
>> index 0000000..2ded9c9
>> --- /dev/null
>> +++ b/tests/nvme/041
>> @@ -0,0 +1,95 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
>> +#
>> +# Test dhchap key types for authenticated connections
>> +
>> +. tests/nvme/rc
>> +
>> +DESCRIPTION="Test dhchap key types for authenticated connections"
>> +QUICK=1
>> +
>> +requires() {
>> +	_nvme_requires
>> +	_have loop
> 
> _have_loop?   '_' is missing before loop.
> 
Correct, will be fixing it up.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

