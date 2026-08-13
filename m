Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B74C5CFCF
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2026 02:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	References:Cc:To:Message-Id:Date:Content-Type:In-Reply-To:Mime-Version:From:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=seXgAn3sH3Fkdwlv432haocsdFRPRpWbAPfwROYC82Y=; b=fUoX8cngUq5EMho+EFbwU5+wBK
	4R9CoctMkKAOaApcyROwnw4d9o1TFfGE9lZopBCxJ8a3PjLYg8m5y5WT+jfNuBxhFxYPlv3zM0aAP
	9hHzZxYL85AhwGM1HKt5H0B0WyVG98LKuKBOENbyLt8oP775Y0iaa+BU67WvyuDsU+xt0VscxcHTw
	nhQgEasbXLm9xzBCTSiXIExcj/tAMVlzZNCVbp9O5hXTtusqTuKsKgHYySIcB/p33VW4cGiLOfgw7
	OvHuE+L96nFsoYqzgFW1jTBW8Ihf/vc4Hyq+kiaI7vhKGx2UcXjbaFCpMBBzCodETUqCjhiv/z7V5
	t08qAh4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuKuq-0000000HGIU-2FSO;
	Thu, 13 Aug 2026 02:11:32 +0000
Received: from va-1-111.ptr.blmpb.com ([209.127.230.111])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuKun-0000000HGHk-1z3g
	for linux-nvme@lists.infradead.org;
	Thu, 13 Aug 2026 02:11:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1786587083; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=seXgAn3sH3Fkdwlv432haocsdFRPRpWbAPfwROYC82Y=;
 b=XqtvAvaOl5QE4G3x6KuHnZOQXMr44dLbhclPBwqOp051Tq/00+Z80rOZFGF7CU9jKjy1Kq
 eJLVS6s65Um+Df4Buay6zEHPiejjvwRT9ozbL32ER1x7gl3IQN1etf9XbwpCOSsdHLJnVt
 SHvY3rcJBI0dVKvSivh2hg3h0FMV7DI7dZOBs+sobKday5BlJKp/0doxIIjuD6Tw/GUBYg
 SFV6Ok1wJOU0Bd60uyV8r1YQKdyJoDfaPJOrit0TUE3PvZS+b4ffmX3yPITj6UklJwGIDw
 tqtHfD8dVCFTag7QKyR6SXpws1zn0UNqNrfW4zxK+WsmgNI15iUsf6tmrzXKpQ==
Subject: Re: [RESEND RFC PATCH v2] nvme-pci: add adaptive interrupt polling
From: "changfengnan" <changfengnan@bytedance.com>
Mime-Version: 1.0
In-Reply-To: <anuGRKqdCFG9381L@kbusch-mbp>
X-Lms-Return-Path: <lba+16a7d27c9+1490ff+lists.infradead.org+changfengnan@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 10:11:19 +0800
Message-Id: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.0698c0c0.7344.4eb9.96f0.08703e79ece6@bytedance.com>
To: "Keith Busch" <kbusch@kernel.org>
Cc: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>, 
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	"Guzebing" <guzebing@bytedance.com>
References: <20260806031058.40176-1-changfengnan@bytedance.com> <ano6o6i4Yr2JfMgu@kbusch-mbp> <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.9f189e7a.e65a.4eb9.b86b.c83b70bebfb9@bytedance.com>
	<anuGRKqdCFG9381L@kbusch-mbp>
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_191129_579234_83AAE1A6 
X-CRM114-Status: GOOD (  17.84  )
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


> From: "Keith Busch"<kbusch@kernel.org>
> Date:=C2=A0 Wed, Aug 12, 2026, 04:30
> Subject:=C2=A0 Re: [RESEND RFC PATCH v2] nvme-pci: add adaptive interrupt=
 polling
> To: "changfengnan"<changfengnan@bytedance.com>
> Cc: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@list=
s.infradead.org>, <linux-kernel@vger.kernel.org>, "Guzebing"<guzebing@byted=
ance.com>
> On Tue, Aug 11, 2026 at 10:32:35AM +0800, changfengnan wrote:
> > The code looks much cleaner when using dim, I'll see if I can replace t=
he
> > sample-and-poll logic I wrote myself with the dim library.=C2=A0
> > I ran a quick test on the POC patch and didn't see any performance
> > improvements; in fact, there were quite a few regressions. Maybe some
> > parameters need to be adjusted.
>=C2=A0
> Yeah, I'm just now testing mid-tier devices and it's also performing a
> bit worse for high throughput workloads. But I hadn't really tried to
> tune the settings here, and maybe my criteria is all wrong. I was mainly
> trying to see if we can utilize the dim library before honing in on the
> right implementation details.

I tried modifying the original approach to use DIM, but the results were
consistently poor. Using the original approach, my current optimization
has managed to keep 4K random read backoff within 2% (tested on 10
different drive models), but when using DIM, the backoff rate is 10=E2=80=
=9315%.
I believe there are several reasons for this:
1. The core of NVMe adaptive polling is determining when polling is more
efficient, but DIM cannot answer this question. Although=C2=A0 irq and poll=
 can
be disguised as a DIM profile, this is essentially just borrowing the DIM
framework=E2=80=94the core decision-making still requires writing your own =
baseline,
thresholds, backoff, and re-baseline, so the code complexity and volume
haven=E2=80=99t actually decreased.=C2=A0
2. The DIM state machine is relatively heavy, which reduces performance
gains under I/O-intensive workloads.

So I tend to avoid using DIM. Please correct me if I'm wrong.

>=C2=A0

