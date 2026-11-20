Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256E3606A6F6
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 19:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mRbpW7hY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=U9gRtsTUMVPtmFehDHVSwkvtxQ+EsTSo46abZRFq+Ic=; b=mRbpW7hYi6ucQS
	kz82a0+77KP5SujdL5tCtq7JudHABHUOeLZp9Hh3+Il5ICiFmpQtpb0eBrG96rzb78hITDLZXk4Rz
	ej/7I1AEz6UNVFyQJFbcXhuoiH6L1N2JFnmL1/Oyl6uPtPfWH4/PG8/2CyuO8nrwTL0itvM/W/G38
	zt+2KLKceLK+c9rRueBRfi/T52ohQbkSGytHu3iJKPcwJJ1GxsvhKeX98eOsh9Nr0kM5Qe73stTE6
	I9UutWgzVanizl0UE4vzRCAZamSuTkE+5VdUgpeB3dYk4SFNxhzwM7tesTsnhwwvO8LJGkaA7tyX5
	kKMIu8WFxAtqqrcJrWAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUUhW-0000000G8vu-0eg7;
	Fri, 20 Nov 2026 19:55:17 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUUh5-0000000G8lp-1BZD
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 19:54:48 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AKEfbKT4076606
	for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 11:54:46 -0800
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4j2bb2p536-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 11:54:46 -0800 (PST)
Received: from twshared24494.03.snb2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 20 Nov 2026 19:54:40 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id 797982F4934DE;
	Fri, 20 Nov 2026 11:54:24 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <shao.mingyin@zte.com.cn>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <justin.tee@broadcom.com>, <nareshgottumukkala83@gmail.com>,
        <paul.ely@broadcom.com>
In-Reply-To: <20261115012809000VXL8NL9lZ4gQEKv-NNqUP@zte.com.cn>
References: <20261115012809000VXL8NL9lZ4gQEKv-NNqUP@zte.com.cn>
Subject: Re: [PATCH] nvme-fc: initialize I/O queues added during reconnect
Message-ID: <179520446449.200156.4138844829580902457.b4-ty@kernel.org>
Date: Fri, 20 Nov 2026 11:54:24 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Authority-Analysis: v=2.4 cv=KqnYSmWN c=1 sm=1 tr=0 ts=6b00a586 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=1RTuLK3dAAAA:8 a=VwQbUJbxAAAA:8 a=eF1Gjh7KCRU0b0vJ23oA:9 a=QEXdDO2ut3YA:10
 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3OSBTYWx0ZWRfX+zAgXygdxIjv
 t407Yyxgp60MQz7v81aB5RrqLQSn9sqlJyGmzk1AU3G+6b6adDumpPjH1lMPGCyxTsGVEsZW+w9
 AMrtk12Cle4c12VR53UpVzuuW/xFudAbKpMXGf8e50U0D9rUS3fwA83IWtqkOU/P6VZEHqP4YZt
 OmdV7zEcXHO/fZIZP1evuo2Vzt3+t0HMbjZJsMj43IReaEmzhl2IyNHAs+9PJqkABxgvg0KppHp
 DCSwIaGuCJPPZigdoaMUNcReMbhWyIZS8b+nqIB5phf6mVJrxLX5x5tcV9+nxtv9NtNj8ItUL0B
 sz/w+yP8Gcpj/NwwZ4kS/K5gyiuetl8q+9pyjXS2KzOuHU3RYqWkGhbp9JlaAjboTeL5RACfO2P
 vzdHcrB0Tk7M5PViFAXwPl0dAsTBKFH3OU3P/W2jKOk6zUyoJJjPdqIb9etH0aneEmVK7EMvozc
 oN+gB67w6CUMqDDSqDw==
X-Proofpoint-ORIG-GUID: A6q_8Hh7KAMccIFgjinQwP6799ndwcjG
X-Proofpoint-GUID: A6q_8Hh7KAMccIFgjinQwP6799ndwcjG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3OSBTYWx0ZWRfX3UlyE9bbtpyb
 wQjOeShjoG1sUvxSVkrANij70Zv5Qa8m4dvC1m4gQ8/aExTdJ60VaRxxIXTENE/K4oIQIvAqEZT
 Yfn66kFSRZc+cMjn3v9+DltrpWzhPrM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_115447_472596_E933E6FE 
X-CRM114-Status: UNSURE (   6.85  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.2 (-)
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
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 15 Nov 2026 01:28:09 +0800 (CST), shao.mingyin@zte.com.cn wrote:
> nvme_fc_alloc_ctrl() initializes only the admin queue and leaves the
> other nvme_fc_queue entries zeroed.  The initial connect path calls
> nvme_fc_init_io_queues() before creating the tag set, but reconnects go
> through nvme_fc_recreate_io_queues(), which does not initialize the
> queues it adds when the controller grants more I/O queues than the
> previous connection.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/1] nvme-fc: initialize I/O queues added during reconnect
      commit: 828408399e142ab52298317f478646dd61071aac
--
Keith Busch <kbusch@kernel.org>


