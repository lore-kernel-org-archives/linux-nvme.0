Return-Path: <SRS0=itK/=OY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EC0C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Oct 2021 15:58:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28B866139F
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Oct 2021 15:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 28B866139F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qr4FmCiNUxvG5OpDm2wFaedl6R1KI3I+Q5yNct/lAW0=; b=bBkCo4SzhIIuTM
	n0L2ojMYtX9/pTRQl3m9s2CjAyH7eS3eB0ve1NSQ76G5QCSJWt6fPrnip7nNddhdXvBwMYNN1EAO3
	EAIt1FwfZCHuw9wCJaRQtTyJ01nllOIDI/rLW7HzMaU4z10tb2Ys9qm0+2NDe1N6vqK5Jw6jB62V5
	KS5l4Oxv0AU1oy9lgJpwyv3sLLBM3/q56+Kd17aLC6B8xv7D+8zcCDrt+QEN2F6YwHt74XbBzLGpQ
	625zyuaV7gcljbpBS7YVqBVS5aDw72NgP3Pt2Nt4Wk1qiSW8h/oEvHAsOKGZzKx3QMQbqoUA/QNCf
	zMT7aj6pgS3rKAS8IGkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mXQLQ-006z4A-IP; Mon, 04 Oct 2021 15:57:36 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226]
 helo=SJSMAIL01.us.kioxia.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mXQLO-006z3H-1N
 for linux-nvme@lists.infradead.org; Mon, 04 Oct 2021 15:57:35 +0000
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 4 Oct 2021 08:57:29 -0700
Received: from SJSMAIL01.us.kioxia.com ([fe80::8495:a8b4:1ae7:317]) by
 SJSMAIL01.us.kioxia.com ([fe80::8495:a8b4:1ae7:317%3]) with mapi id
 15.01.2176.014; Mon, 4 Oct 2021 08:57:29 -0700
From: Aviv Heller <Aviv.Heller@kioxia.com>
To: Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH 1/1] nvme: check for Identify CNS 06h opcode support
Thread-Topic: [PATCH 1/1] nvme: check for Identify CNS 06h opcode support
Thread-Index: Ade189kmm1qAylIDQbO/kw/1rkVxvQAW64wAALnGpSA=
Date: Mon, 4 Oct 2021 15:57:29 +0000
Message-ID: <7eea661115f14feda5adc30272aeb948@kioxia.com>
References: <5721a04a493e4f7fb87f2899d08391ef@kioxia.com>
 <20210930160432.GA407610@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20210930160432.GA407610@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.93.66.148]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211004_085734_098165_A51B1D2C 
X-CRM114-Status: GOOD (  13.38  )
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

Thanks for your feedback.

> There's no requirement that a controller report a particular version in order
> to implement a TP, though. It's perfectly valid for a controller that reports
> version 1.4 may implement this feature. We just don't have a way to konw if
> a controller implements this CNS (TPAR 4135 aims to fix that), so we just try it
> and look for success.

That's good to know. I didn't notice that this CNS is defined in a TP.

> The driver doesn't care if the controller doesn't support this identification. If
> the controller doesn't support it, we should get an Invalid Field status. The
> driver will carry on as before, so it should be harmless. What problem is this
> actually fixing?

It was noticed when we got an invalid CNS error print from our NVMeoF target.
We then thought that if support could be tested, avoiding issuing the command
is the right way to go.

This is not the case, though.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
