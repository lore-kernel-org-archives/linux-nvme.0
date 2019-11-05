Return-Path: <SRS0=AJHE=Y5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C48CA9EC7
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 08:13:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DB6A20869
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 08:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oRwV3n/8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="hZ+kRJEA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB6A20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kalray.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=yNvXhoz5o3URd3qkjYlTpxEBo1OePD8TZ/7VM5nfWpY=; b=oRwV3n/8opLRqO0pGbyLyJBxp+
	XN5xvFghivlmtC7RGYOhmVuL+T47dIc8Z47mCMu2G7WFmaLNhwueBDE7eSlLCXUyTsysOeHPG580S
	eO0aGxDY7zWdBTn41PRLWicIu7KxbZw/Ay81Y0BwwKwz5YuwRbdjVN94W+QzSVS2qzmaCA3QUUifG
	N8zwMIDA7u7Hrm5TDBfT3sCeoYhaYX20E3lnZH3DHsk5Bf7lgQlu5Pykozg/TV/hmIwkP/+Y4TSkL
	spwOt+B8z48V5sv8gogqGJXujzGMtI4iiB7KDQpfRqzWWkNkyYLlB3IEb1ErJdoxfuBaJX+QvXwrh
	CoSIILWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iRtxZ-0000HM-NP; Tue, 05 Nov 2019 08:13:05 +0000
Received: from zimbra2.kalray.eu ([92.103.151.219])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iRtxQ-00008I-PZ
 for linux-nvme@lists.infradead.org; Tue, 05 Nov 2019 08:12:58 +0000
Received: from localhost (localhost [127.0.0.1])
 by zimbra2.kalray.eu (Postfix) with ESMTP id 6AFE527E038D;
 Tue,  5 Nov 2019 09:12:55 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1])
 by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id Z6p8VbA1eiBM; Tue,  5 Nov 2019 09:12:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zimbra2.kalray.eu (Postfix) with ESMTP id 2759F27E0F36;
 Tue,  5 Nov 2019 09:12:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 2759F27E0F36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1572941575;
 bh=4Qi1SD8jq8O+ju58FiI+glo0NlSYMdVMwgwpFrUuojM=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=hZ+kRJEA1cgQx0PYYoUUa1FQCoEZ5hXXWbFg9Xr/bGQMybdffl1mkSqaWDrb1RRWA
 YA4GyfhHU5wKxIOJRCBb9ll6k9Gc2VxfAn2Eafz/u1XxwKaQu6M/WgNFmxQqJOH9re
 dNDLdbeSxm6tOlC5fACPQB6OdUsDdqnDx2LFjtDM=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
 by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id kJV8YCK8QgrJ; Tue,  5 Nov 2019 09:12:55 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
 by zimbra2.kalray.eu (Postfix) with ESMTP id 1238E27E038D;
 Tue,  5 Nov 2019 09:12:55 +0100 (CET)
Date: Tue, 5 Nov 2019 09:12:55 +0100 (CET)
From: Marta Rybczynska <mrybczyn@kalray.eu>
To: Keith Busch <keith.busch@intel.com>, 
 linux-nvme <linux-nvme@lists.infradead.org>, 
 Charles Machalow <csm10495@gmail.com>
Message-ID: <1705642973.90381987.1572941575042.JavaMail.zimbra@kalray.eu>
In-Reply-To: <677052906.90381490.1572941359042.JavaMail.zimbra@kalray.eu>
References: <677052906.90381490.1572941359042.JavaMail.zimbra@kalray.eu>
Subject: Re: [PATCH 3/4] nvme-cli: nvme_ioctl.h: update to latest kernel
 version
MIME-Version: 1.0
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF57 (Linux)/8.8.12_GA_3794)
Thread-Topic: nvme-cli: nvme_ioctl.h: update to latest kernel version
Thread-Index: /iOscU9FO9uuMqrBeXqqlLvwDn1xaX+8tXEN
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191105_001257_019686_AD773BC7 
X-CRM114-Status: UNSURE (   3.13  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



----- On 5 Nov, 2019, at 09:09, Marta Rybczynska mrybczyn@kalray.eu wrote:

> The latest version includes 64-bit ioctl() results support. Update the
> header so that we can use this interface.
> 

I send it out for review, but let's wait for the final version of
the patch from Charles to do the actual change.

Marta

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
