Return-Path: <SRS0=3Z9O=BT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D268C433E0
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Aug 2020 15:33:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E1B52068F
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Aug 2020 15:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="soPNmMGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1B52068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bQm2xXRyj+FSWDXi51YchfdXMKKbgMusLIWIGCLbfLE=; b=soPNmMGthCjMrT84kjJttn27h
	iQ8nXltiXsmg8sljm3cI2wBSPgKgY1fOhvfba7Mf4dDFb6dRG7wvN2iXPxK7Fuf+xWXPpKyDuMcKf
	Awz6AT79aW+RYM+88+jj7TediBxxeYmTLFs4Vw0yLB+220CKOwSCmK5c6ubXPycQ+SKhVWokSEhxo
	kt+gss4b/kKonSwV8U/YAJd5EywP+K8aCL5gGHrIWI7NXi8uD9pJXlpq1kyixH4rCpbSUTLtwNb8A
	jgUJhmNkHpb1T3tH/8UeMkTL723aSodz7P+CxPIlO7j3fYXLZYJfNN7oZbd/RehDkL3zT7OcxWhaV
	W3MI3L7Nw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k4nJj-0005yp-94; Sun, 09 Aug 2020 15:32:59 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226]
 helo=SJSMAIL01.us.kioxia.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k4nJf-0005yB-5u
 for linux-nvme@lists.infradead.org; Sun, 09 Aug 2020 15:32:57 +0000
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sun, 9 Aug 2020 08:32:45 -0700
Received: from SJSMAIL01.us.kioxia.com ([::1]) by SJSMAIL01.us.kioxia.com
 ([fe80::2c17:bc91:18b9:c598%3]) with mapi id 15.01.1779.004; Sun, 9 Aug 2020
 08:32:45 -0700
From: Victor Gladkov <Victor.Gladkov@kioxia.com>
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: RE: [PATCH v7] nvme-fabrics: reject I/O to offline device
Thread-Topic: [PATCH v7] nvme-fabrics: reject I/O to offline device
Thread-Index: AdZVNtfQwLqufTQARFyP/r4WNKASYABPsl96AOTmf4ABqzo0AANp/vvg
Date: Sun, 9 Aug 2020 15:32:45 +0000
Message-ID: <45d34d7927354b6393859048c257cb86@kioxia.com>
References: <168ed5d66eae49ac8b445478b1bb362d@kioxia.com>
 <ca82af03-0cf7-bb71-cf55-caf88c278dfa@broadcom.com>
 <fee0ecca-3d31-a04f-af7c-7a3aada9d6fe@grimberg.me>
 <20200714110435.GF16178@lst.de>
 <52eec097-606d-1e2c-edc3-81b60807ad5c@grimberg.me>
In-Reply-To: <52eec097-606d-1e2c-edc3-81b60807ad5c@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.93.66.127]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200809_113255_369503_D0E7BD99 
X-CRM114-Status: GOOD (  11.68  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 James Smart <james.smart@broadcom.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Ewan D.
 Milne" <emilne@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/8/2020 8:07 AM, Victor Gladkov wrote:
> Commands get stuck while Host NVMe controller (TCP or RDMA) is in
> reconnect state. NVMe controller enters into reconnect state when it
> loses connection with the target. It tries to reconnect every 10
> seconds (default) until successful reconnection or until reconnect
> time-out is reached. The default reconnect time out is 10 minutes.
>
> To fix this long delay due to the default timeout we introduce new
> session parameter "fast_io_fail_tmo". The timeout is measured in
> seconds from the controller reconnect, any command beyond that
> timeout is rejected. The new parameter value may be passed during
> 'connect'.
> The default value of 0 means no timeout (similar to current behavior).

I'd like to remind you that this improvement is pending for commit.
Pay attention, please.

Regards,
Victor.
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
