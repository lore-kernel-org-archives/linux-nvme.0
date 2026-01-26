Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FD5D1950F
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jan 2026 19:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L0UW6hrzAJav4BEvDCb4gbxi00lWcyoTcmwxw8Bcxic=; b=Xhks8GhFtWg4HluwT6DjAYrmZy
	rcQ/gHHJKBpebUbe5dVFkAiRJ+69xiMWlYNS07XK/tqxofyltbIDsSQveiMjLTydqf28S/7JGAj0Q
	OZouG0sjQaFiwy+9o8me8enTwE/7cuk5JSFqjTWuMnmumP7IHoq99qH1CfA5hlkxG0/sp/oPeRGY9
	Mx2tFDDv61P8OGUlALNkVlobIil1L/RT7ZdDtaLRD+e6qzz9tKQ0/4EuLKQ0bZKkxhJP0jMQg77FJ
	pLd94yL1qFbJNc6twbVnxRYiB2TPZo1biIoIBcaUzMbQRXHd5m7HCb2rd7xRahPmqDr49EZEnsedZ
	J8oPY17A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkS1F-0000000D80y-44j0;
	Mon, 26 Jan 2026 19:13:01 +0000
Received: from 013.lax.mailroute.net ([199.89.1.16])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkS1B-0000000D80Z-1yQA
	for linux-nvme@lists.infradead.org;
	Mon, 26 Jan 2026 19:12:58 +0000
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4f0J8S1wxMzlh1Sr;
	Mon, 26 Jan 2026 19:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1769454774; x=1772046775; bh=L0UW6hrzAJav4BEvDCb4gbxi
	00lWcyoTcmwxw8Bcxic=; b=x9resg0iOiWbYn2mxnm98i5bEHONSybLK2oB8a1T
	SRjspSI2/X14fh0ao0snL5N/804jAse8Ve37KaTm2oNi8/TZ9pqll+JI+eQ8xISH
	H4YFcmJu6nAk9I1557/n1Gw/XPps2rQwqPjKa+jo8wLLImUZedhihq8msSfYQggT
	4wOOO50kyXKMpbU0zfLUa/MrYFd/GxH3CkfC7C/QZ4+lPXSzLtGRiaT+55lfrvjs
	cZr1jdoOvB5O0z9p3Jmjpw2eJ/6VYsk2GIWz6UZTNnC0ItyhAu8ep3PrUzBP4ZdQ
	/uC3RJfhmeC4Qbw7vRGbJPUeTCpN88sFWw+ny8PIsmf33g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id kdWDbU6Uevu5; Mon, 26 Jan 2026 19:12:54 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4f0J8P4wn3zlh1SG;
	Mon, 26 Jan 2026 19:12:53 +0000 (UTC)
Message-ID: <5273400e-5cf8-4d70-a85d-accfb2977d8e@acm.org>
Date: Mon, 26 Jan 2026 11:12:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Block storage copy offloading
To: Viacheslav Dubeyko <slava@dubeyko.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, Jaegeuk Kim <jaegeuk@kernel.org>
References: <0cfe6fe2-3865-4dc2-92a7-74b1240f7b63@acm.org>
 <eab078c99e17e45632c6b35e2fe1145e9459ff2f.camel@dubeyko.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <eab078c99e17e45632c6b35e2fe1145e9459ff2f.camel@dubeyko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260126_111257_606557_CD66D1BA 
X-CRM114-Status: UNSURE (   9.25  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/26/26 10:18 AM, Viacheslav Dubeyko wrote:
> I am not completely sure that copy offloading to the storage device can
> reduce energy consumption. The storage device needs to spend energy for
> executing this operation, anyway. Do you have any numbers that can
> prove your point?

Yes, we have measurements that prove this point but unfortunately the
vendor that collected this data does not allow us to publish that data.

Reducing energy consumption matters for mobile devices. There are other
applications for copy offloading, e.g. in data centers and in enterprise
applications. I don't think that these other users care as much about
reducing energy consumption as we do.

> Which file system have you considered as working model of your approach?
Every LFS for zoned storage has to perform garbage collection, isn't it?
I think that we can discuss copy offloading without having to discuss
filesystem implementation details.

Thanks,

Bart.


