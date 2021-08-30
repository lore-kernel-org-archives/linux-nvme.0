Return-Path: <SRS0=Glcz=NV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA563C432BE
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 11:28:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 746426112D
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 11:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 746426112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hE9PKNk/aaPYnnE3sdRr4BMJYDQWZZYqXKdz7876tFM=; b=z1WoetGgFjqUUY
	JG5bdlxrQNqkqa2VZ3ZBG3TpRm2ZDr6b3IdD9iKpdQupmUcKEddRPwwCl5A+5zv9EjywOiGzkpoSv
	yzaHik2c0SECZ5FJV3+TIJRZxCcNFeHML9nFHJm3VFROHpG5caNWqMt9Tlx8tzLs4hMBgujLbhlWM
	Wuxk6iYnWH4xajQYF5F3eK6vqdm77wsGYzhY1fhtdU435owTpR/p1Rdsq5qUbdwMW0Aum2zSHEyO6
	KFkCXyXvy9d8NMADt2fj6dkh1MIhWye58AlfPOR/ql42mq2KTvx/4FvbHUVpOS9w5N+PMt4+Sxklo
	X0NnDGo7y004+zybFB6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mKfSj-00H54E-C1; Mon, 30 Aug 2021 11:28:25 +0000
Received: from mo-csw1516.securemx.jp ([210.130.202.155]
 helo=mo-csw.securemx.jp)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mKfSg-00H538-21
 for linux-nvme@lists.infradead.org; Mon, 30 Aug 2021 11:28:23 +0000
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 17UBRuHu019131;
 Mon, 30 Aug 2021 20:27:56 +0900
X-Iguazu-Qid: 34trwupu8dwZ27DK8v
X-Iguazu-QSIG: v=2; s=0; t=1630322875; q=34trwupu8dwZ27DK8v;
 m=Qh63Ydy69o7sFik6daHdLCKTBHdXvgCnmFxbQcz1DSw=
Received: from CNN1EMTA03.test.kioxia.com ([202.248.33.144])
 by relay.securemx.jp (mx-mr1511) id 17UBRsMq007060;
 Mon, 30 Aug 2021 20:27:54 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
 by CNN1EMTA03.test.kioxia.com (Postfix) with ESMTP id 9C15C31B1F;
 Mon, 30 Aug 2021 20:27:54 +0900 (JST)
Received: from CNN1ESTR03.kioxia.com (localhost [127.0.0.1])
 by Switcher-Post_Send (Postfix) with ESMTP id 5D8011907AD216;
 Mon, 30 Aug 2021 20:25:21 +0900 (JST)
Received: from localhost [127.0.0.1] 
 by CNN1ESTR03.kioxia.com with ESMTP id 0002WAAAAAA023A0;
 Mon, 30 Aug 2021 20:25:21 +0900
Received: from CNN1EXMB02.r1.kioxia.com (CNN1EXMB02.r1.kioxia.com
 [10.232.20.151])
 by Switcher-Pre_Send (Postfix) with ESMTP id 52836A0347643;
 Mon, 30 Aug 2021 20:25:21 +0900 (JST)
Received: from CNN1EXMB02.r1.kioxia.com (10.232.20.151) by
 CNN1EXMB02.r1.kioxia.com (10.232.20.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 30 Aug 2021 20:27:54 +0900
Received: from CNN1EXMB02.r1.kioxia.com ([10.13.100.21]) by
 CNN1EXMB02.r1.kioxia.com ([10.13.100.21]) with mapi id 15.01.2242.010; Mon,
 30 Aug 2021 20:27:54 +0900
From: sasaki tatsuya <tatsuya6.sasaki@kioxia.com>
To: Hannes Reinecke <hare@suse.de>, "hch@lst.de" <hch@lst.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] nvme: update keep alive interval when kato is modified
Thread-Topic: [PATCH v2] nvme: update keep alive interval when kato is modified
Thread-Index: AdeYqq0GYCdtylBoR8GOhZA2v9EjoAAmJkqAAA6WO4ABBL/jkA==
Date: Mon, 30 Aug 2021 11:27:53 +0000
Message-ID: <4ffa643335a9467ba586450f8820c54a@kioxia.com>
References: <526a1a756d6c4643b15b1b305cc32817@kioxia.com>
 <20210825085345.GA31419@lst.de>
 <2fc5b98a-b397-3be1-1957-986e8b6aa732@suse.de>
In-Reply-To: <2fc5b98a-b397-3be1-1957-986e8b6aa732@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.211.33.106]
MIME-Version: 1.0
X-CrossPremisesHeadersFilteredBySendConnector: CNN1EXMB02.r1.kioxia.com
X-OrganizationHeadersPreserved: CNN1EXMB02.r1.kioxia.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210830_042822_350922_51EF37EC 
X-CRM114-Status: GOOD (  12.77  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> On 8/25/21 10:53 AM, hch@lst.de wrote:
> > Any reason we can't just call this from nvme_passthru_end instead
> > of inventing a new API?  Right now the nvmet passthrough code never
> > uses the underlying keep alive code, so it doesn't make a difference,
> > but I expect we'll need more handling for passthrough commands like
> > this, and we might also grow more users (e.g. the io_uring based
> > passthrough).
> >
> Yeah, we'll need that anyway if and when hostid becomes settable.

Thanks for your comments. To call nvme_update_keep_alive from
nvme_passthru_end, I think nvme_passthru_end needs an argument of
a pointer to nvme_command. I will try to call it from nvme_passthru_end.
Please correct me, if I am misunderstanding what you mean.

Thanks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
