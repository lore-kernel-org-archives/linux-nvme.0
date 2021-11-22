Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABD5C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 09:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9wRr487J5ZT+BroaiNX1kQ2/av00RgWfC69OG4fRVoA=; b=KGy0z7ZftCJFIdVLiFo9NOlaNK
	uUGT7ww5eGblLS/ZQ+WwO9Tt2ksmTSuBSO2QYhbH67RqH9dXUzn8Ik4IItjkC5ZnP3UsOij4d+rb8
	TTVE+lcdZ55lkOzO6UXAsFpLApP2/MvDWosVEzQJFwGCQy67j6iBj+HBEBua2zMLvQlqpa7/8CBfJ
	H8MU3MQNS2/LBeIpl8j6B6xgriHs+m6sQ2VgTpoaVfRHEzL/WADkf8Wu3WMLQ7MDlLDJ69Go1xZL3
	/ZBLs4VmeyE6VFiENyxY97r7ifLLNubx+FqjhAwuLOIQbKNnRyfmsuHxj5REx8XboMQuiZLThQRG5
	y8z5MaFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp5db-00FafM-AE; Mon, 22 Nov 2021 09:29:23 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp5T2-00FX2x-RP
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 09:18:30 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7AEB11FD26;
 Mon, 22 Nov 2021 09:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637572707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9wRr487J5ZT+BroaiNX1kQ2/av00RgWfC69OG4fRVoA=;
 b=feNds1DhwvHs5e33ut1VMeryD0hI4KHUmah4rXVYHCv5UhHB9QOQReidvkREK/jufIT8Tr
 x3APr5JpTKNkKCiVnu40EuHVdxtjaxtGPiyIJpiF1V4ny7+lBeAaPyJDYj7TpY9VQL3uDH
 xzLetppJfQsM89kUeiOCHJxp/IYxjaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637572707;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9wRr487J5ZT+BroaiNX1kQ2/av00RgWfC69OG4fRVoA=;
 b=NtvaSWY8dqkoUEOadzHJjYL6M+FMjIEqUebNyg5RhPR7JgiL3n02JgXRY4F2Qpq5C1f5dq
 4mAj05hIH96eWCDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 537FC13B9E;
 Mon, 22 Nov 2021 09:18:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MIDiE2Ngm2GkTwAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 22 Nov 2021 09:18:27 +0000
Subject: Re: [PATCH 4/9] nvme/039: simple test for nvmeof-tcp connection
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org
References: <20211122075524.26207-1-hare@suse.de>
 <20211122075524.26207-5-hare@suse.de>
 <197826e6-273c-6f19-f5cf-44814433976c@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <f5e414cd-c60c-442a-01c5-dfb0c1422b17@suse.de>
Date: Mon, 22 Nov 2021 10:18:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <197826e6-273c-6f19-f5cf-44814433976c@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_011829_076849_F40026BF 
X-CRM114-Status: GOOD (  16.63  )
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

On 11/22/21 9:52 AM, Sagi Grimberg wrote:
> 
> 
> On 11/22/21 9:55 AM, Hannes Reinecke wrote:
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   tests/nvme/039     | 56 ++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/nvme/039.out |  6 +++++
>>   2 files changed, 62 insertions(+)
>>   create mode 100644 tests/nvme/039
>>   create mode 100644 tests/nvme/039.out
>>
>> diff --git a/tests/nvme/039 b/tests/nvme/039
>> new file mode 100644
>> index 0000000..eb015be
>> --- /dev/null
>> +++ b/tests/nvme/039
>> @@ -0,0 +1,56 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
>> +#
>> +# Test nvme over tcp connection
>> +
>> +. tests/nvme/rc
>> +
>> +DESCRIPTION="Create single TCP connection via localhost"
> 
> Why is this test needed?

To establish a baseline that I didn't mess up _normal_ connections when
adding the authentication stuff.
But yeah, I can fold it in with the next test.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)

