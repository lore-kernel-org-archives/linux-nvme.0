Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86198606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VzsfyMoD;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=bzbzE24A
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=TpghNmruX7RKJZPyJTPdaEDTHhGTFAkDhf1hUThjHe8=; b=VzsfyMoDxWbUCN
	sf/tnQvwQJk2j8hRqXBQdSmSvPCbbyxoKWqb3fKQ+D64BiDrKqsRZ3u56ULfOlF426KkKecjSK9kx
	cjyqzdGY9LP18p8ty4TN5YTM24qatpIIkoW/zqaitPW2qq18Z3h94ezUFZoacYOTSiMLscX/MyUJW
	rf5ga9TMxhl2I8Pr++vS1Jl3w37ADihmdf8+ICBPViKmJumR0GYvstxFVFMJ2CYMP6m8bzI8tMBYQ
	zuPCRdiv1GS9GgtDnwkXYWiQbTc1zhDPh2brv0Yhr8swXgYm/g0zRQ5fuaDdJepDQQdS/kap91ntv
	dy45iCMCbPy3Ujtb0ZRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQXNR-00000001pQE-0yE8;
	Mon, 09 Nov 2026 21:58:09 +0000
Received: from 011.lax.mailroute.net ([199.89.1.14])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQXNM-00000001pPO-0Zwb
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 21:58:05 +0000
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNkDW5Tqfz1XM4Tn;
	Mon,  9 Nov 2026 21:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1794261481; x=1796853482; bh=TpghNmruX7RKJZPyJTPdaEDT
	HhGTFAkDhf1hUThjHe8=; b=bzbzE24AcV/hN8OnnF6FGmmBwy5F6NQ/nSpWu5+Q
	eUaDoasAVLWjXOgCHdKD3RdULsiDeYmiYvgY0xEZ/yvFbzkE1IfmDlEKS6rbv00y
	Ux9eCRN2EryiEVKZk6JzlG9majY9mv+Zj5YmAbD1NePiZKUAMjRrOd3XRiSKPaRW
	svM+JdyInNz/wbiIvTChbg8CrMN1qIarkvV5F93c4i9FCaIva0NwR7vkkNqnwV+z
	Z9LGJTJPkCDE6UdcUMVXOuDeRwPpsBqwm8lm0tVhD9wAofaX7CiMYRfmkPpQ9Xab
	0nDW0so0BIfK1uO1ZKcnwECc0s3W49XSBX2KJVUcS55u/A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id RdTNyRgNIGV9; Mon,  9 Nov 2026 21:58:01 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNkDT2rrkz1XM5kt;
	Mon,  9 Nov 2026 21:58:01 +0000 (UTC)
Message-ID: <00124916-2b34-412b-afbb-04b91546478c@acm.org>
Date: Mon, 9 Nov 2026 13:58:00 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/23] nvmet: add context annotation for nvmet_ns::uuid
To: Nilay Shroff <nilay@linux.ibm.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org
References: <20261109033102.982191-25-nilay@linux.ibm.com>
 <20261109033102.982191-36-nilay@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261109033102.982191-36-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_135804_189729_7D23EA37 
X-CRM114-Status: UNSURE (   6.44  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.8 (--)
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/8/26 7:28 PM, Nilay Shroff wrote:
> [ ... ]

This patch breaks compilation in nvmet_ns_alloc() because 
uuid_gen(&ns->uuid)
is called without holding subsys->lock. This is fixed only in patch 12.
Please move patch 12 before patch 11 (or squash them).
In nvmet_ns_device_uuid_show(), please use guard(mutex)(&ns->subsys->lock).

Thanks,

Bart.

