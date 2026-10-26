Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89E0606A320
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 02:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0qhgz1U/;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gNquqo07
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=x8G9NAHAN/iG81NzTGNya1i5l97RmX3Sb/0CKN1G458=; b=0qhgz1U/BqgIcQ
	YudL92PYax/nrID2aqS6bsQke1jpQUQCTZoT8zITrx6VFYwNEmzm+qhwW4yjlOHgRDDEqdFVvrz2W
	NaA8H5NowmXXt2mvTGeZ/en02vAEbUUOLWUJfy9VEdD6nWg7eLplRm8DelpiMIktH4DH78U4tz35k
	lcCEleZMRe/NitJUumfLimIuSQdiy898H/cU1B0RSooAisNLUby8A1LsgAnWSM3ul3df6I+UTXAvY
	4mSEHJjbwYJOXcuEiNfcTxPQ6auf5+NM7oT87GTEK57dq+ucwLm4CB2d365jSATOEAKgePzJgS2q6
	iyIcCQqSEtHvnSjdhcgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLA9J-00000001b71-0C3G;
	Mon, 26 Oct 2026 02:09:21 +0000
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLA9G-00000001b6Z-0rLF
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 02:09:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792980553; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=x8G9NAHAN/iG81NzTGNya1i5l97RmX3Sb/0CKN1G458=;
	b=gNquqo07V2Q4pM+nfkhk9FqJY6M/d7Bfqwiq2MHGRYh196Ft83/yHONwsP2xbu1Pcb6AR3y0WNFACDM4gCp9OEI2izhUaFPMtX58Lpumzw5pObU487Ajl9bsZHv5/6dBV9w+nkzqtJBaCN40lL+1nKJpJGN7qyMCRBfyqo09cWQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XDRPjQS_1792980548;
Received: from 30.178.69.120(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDRPjQS_1792980548 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 26 Oct 2026 10:09:09 +0800
Message-ID: <50def86f-d791-4207-8058-5129ee4ccc93@linux.alibaba.com>
Date: Mon, 26 Oct 2026 10:09:07 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] nvme: document the service-time iopolicy sysfs
 attributes
To: Martin George <martinus.gpy@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
 Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261023070243.2495522-1-kanie@linux.alibaba.com>
 <20261023070243.2495522-4-kanie@linux.alibaba.com>
 <ec1327b1fcad832c065db8aad1b987ff6437cc2f.camel@gmail.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <ec1327b1fcad832c065db8aad1b987ff6437cc2f.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261025_190918_416812_4C6840BB 
X-CRM114-Status: GOOD (  10.25  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/10/24 18:37, Martin George 写道:
> On Fri, 2026-10-23 at 15:02 +0800, Guixin Liu wrote:
>>  		Shows or sets the multipath I/O path selection
>> policy for
>>  		this subsystem. Accepted values: "numa", "round-
>> robin",
>> -		"queue-depth". Changing the policy clears all
>> current path
>> -		selections. Only available when
>> CONFIG_NVME_MULTIPATH is
>> -		enabled.
>> +		"queue-depth", "service-time". Changing the policy
>> clears
>> +		all current path selections. Only available when
>> +		CONFIG_NVME_MULTIPATH is enabled.
>>  
>>  What:		/sys/class/nvme-subsystem/nvme-subsysX/subsystype
>>  Date:		September 2021
> Same nit as before. Looks like only the iopolicy documentation is
> updated above with the new 'service-time' policy, but not the
> iopolicies documentation. Have you drafted these patches against the
> latest nvme-7.4 branch itself?
>
> -Martin
Sorry, my bad, I didn't understand your true meaning before, I will
rebase my branch to nvme-7.4, and add an another patch for iopolicies.

Best Regards,
Guixin Liu


