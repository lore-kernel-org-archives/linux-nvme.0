Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E37C5478C
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 02:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BoL5jmKtVR7u5l8CO4w0qoRdlvm3BVZvcZqSbJdyanw=; b=2+tTYMQMajCfd0nIZm0IfybtsQ
	uAEHFPDygLbwOoXp3M5sJkpfvQOS+iuZVA6c5zb7qDCupf+FLIKHOk3TRv4ZFr3LUSA7OHFmNU53j
	+0JgRXjPgRMqWGMxOZHyfT/8OccWN7rsj+n+eIehBjPqBKIKv6sFAorMQ/lgFHn76fx4xUYz8beBt
	L8k3VT/Yk+U0ae1pFD2ONaNC6x81d5FjA+NUmtVtv7Ia8fXkW9g/CvtXMX+szNVr1ltx7T22GMVgp
	qB2MAuUQ+8vot7Qvp9avGcN9ZVNWDPdGBG2OA+sFdHPqNX1Fe9uNt1+YqmQ/83CvGKh07UCv//mIm
	eZf4dPtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf9cP-00000007hkr-0yx9;
	Wed, 28 Feb 2024 02:24:25 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf9cN-00000007hjq-161q
	for linux-nvme@lists.infradead.org;
	Wed, 28 Feb 2024 02:24:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709087060; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BoL5jmKtVR7u5l8CO4w0qoRdlvm3BVZvcZqSbJdyanw=;
	b=TgN8yyiz4PkOygxhgTQUIdw6/upiSk7HyuVvzmkNr1t+YwWPgE913X3KssbY1qtIY4UckNNZtp2jwk5n8Ujj3RyRkInrEUM0DVbV0A8QtvI3aYH59eSShaNu6WnjAWgTPyh6DzreL7EzoBr2hb+t5DDF985KZDjU+uxC7hhnnuc=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W1O7y5C_1709087005;
Received: from 30.178.83.72(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W1O7y5C_1709087005)
          by smtp.aliyun-inc.com;
          Wed, 28 Feb 2024 10:24:19 +0800
Message-ID: <da0ef60e-88b4-4856-a5a5-787aa0e30d5f@linux.alibaba.com>
Date: Wed, 28 Feb 2024 10:24:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] nvmet: add some commands tracing
Content-Language: en-GB
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 linux-nvme@lists.infradead.org
References: <20240227085408.130161-1-kanie@linux.alibaba.com>
 <Zd4P4xru8zcFUlBb@kbusch-mbp>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <Zd4P4xru8zcFUlBb@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_182423_466342_25F2F97B 
X-CRM114-Status: UNSURE (   8.43  )
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


在 2024/2/28 00:37, Keith Busch 写道:
> On Tue, Feb 27, 2024 at 04:54:05PM +0800, Guixin Liu wrote:
>> Hi all,
>> 	This series of patches adds tracing support for ZNS commands and
>> authentication commands to the NVMe target module, as well as updates the
>> tracing of DSM commands to be more readable.
> Patches 2 and 3 seem fine. I don't care for patch 1 since that makes it
> impossible to see if anyone is sending unusual attributes.

The patch 1 will be removed in v2.

Best Regards,

Guixin Liu


