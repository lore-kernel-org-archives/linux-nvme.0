Return-Path: <SRS0=NYfD=LN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF8CC2B9F4
	for <linux-nvme@archiver.kernel.org>; Sat, 19 Jun 2021 05:08:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0AAF61284
	for <linux-nvme@archiver.kernel.org>; Sat, 19 Jun 2021 05:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0AAF61284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:From:MIME-Version:In-Reply-To:
	Subject:Cc:To:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=VI3idJbAcmuMCty9X69DsH3rxjE4WBtoEqPVxpDehp8=; b=3MP+6cuT2UMfpe
	Jb+pC/p+WKNndbVolWXi8I3RvissIp3jJqScyTfBeM31hcuIWqtYcnGdDLL0oYw0RZfU2aL/TEek9
	Fk+Kk3xUjYPXXFZqccpZrT7wEzLJ6u9M9QwaC2RYk8uI+LCTABnor9E6QxZ/XT4gvpksOy1QeQ2ZS
	sbaXMlL3/8A1f9FUHHheRk0UolG3jo00B+A4JtACu3gkcfHucGqMKjf+hljKaNgNL9xYWivI0zjHj
	RnV/+iYqrfEePVsFPuhsj5bWxg1kit4wbaQEH0zdJu6DpienkguWvLi11GBhoj/kS9yLhEal5/L81
	bJLsHna9i6tRZLELmYQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1luTDZ-00GMaa-M1; Sat, 19 Jun 2021 05:08:29 +0000
Received: from mail-m176237.qiye.163.com ([59.111.176.237])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1luTDE-00GMZg-J4
 for linux-nvme@lists.infradead.org; Sat, 19 Jun 2021 05:08:10 +0000
DKIM-Signature: a=rsa-sha256;
 b=N+KVXKH0ItmCEuNrfRbD2QhvN4FNw4ADX+itE1yny9zOOoN/XA2/dndrRT6tRH7AFV5mgbwOMS405nJSgYyhQDBV5eXFBtafkL0/W4tvWv2TJHZsTYiDKRSxswKQDYfBrtpogaNdEzfjUBClH9JpPNRi24I/Ufp/Q9qfWZepfog=;
 c=relaxed/relaxed; s=default; d=vivo.com; v=1;
 bh=CEL5scdLJYmWlRUsoHbuMz0Iuackwz4/vIAEsKnDT0g=;
 h=date:mime-version:subject:message-id:from;
Received: from vivo.com (localhost [127.0.0.1])
 by mail-m176237.qiye.163.com (Hmail) with ESMTP id 13562C400C4;
 Sat, 19 Jun 2021 13:01:34 +0800 (CST)
Message-ID: <ABYAKQDNDmr9B7YYOVwFFKqU.3.1624078894067.Hmail.zhouchuangao@vivo.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gZHJpdmVycy9udm1lL2hvc3Q6IFVzZSBrb2JqX3RvX2RldigpIEFQSQ==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 36.152.145.182
In-Reply-To: <20210618141817.GA18781@lst.de>
MIME-Version: 1.0
Received: from zhouchuangao@vivo.com( [36.152.145.182) ] by ajax-webmail (
 [127.0.0.1] ) ; Sat, 19 Jun 2021 13:01:34 +0800 (GMT+08:00)
From: =?UTF-8?B?5ZGo5Lyg6auY?= <zhouchuangao@vivo.com>
Date: Sat, 19 Jun 2021 13:01:34 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
 oVCBIfWUFZGUseSVZKTE1PHUIdHkJDHk5VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
 hKTFVLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1PT0pIQ0lJQ0JIN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
 WUc6OSI6MCo*NT8WCUI5TCIiNC0MPT0wCi5VSFVKTUlPS0xDQ0JPSEtIVTMWGhIXVQETFA4YEw4a
 FRwaFDsNEg0UVRgUFkVZV1kSC1lBWUhNVUpOSVVKT05VSkNJWVdZCAFZQUlPSUw3Bg++
X-HM-Tid: 0a7a22a54403d9afkuws13562c400c4
X-Bad-Reply: In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210618_220808_851051_04A427DD 
X-CRM114-Status: UNSURE (   5.59  )
X-CRM114-Notice: Please train this message.
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


>On Fri, Jun 18, 2021 at 07:10:58AM -0700, zhouchuangao wrote:
>> Use kobj_to_dev() API instead of container_of().
>
>Why?  That just makes the code harder to read.

In my opinion, the kobj_to_dev() interface is provided by the kernel so that
we can get device based on kobj without having to pass more parameters.
I think it's easier to use.

Thansk,
zhouchaungao

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
