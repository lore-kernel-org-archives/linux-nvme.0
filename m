Return-Path: <SRS0=KsQz=E6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EDDC2D0E4
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2020 18:39:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7711B206D8
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2020 18:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oTnHQjbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7711B206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZDPt3iMH37KgT6SVjNbgkinzLWnbhaJjPEc5SX/2VZs=; b=oTnHQjbdrq1IYXX++9UlO+XUg
	3+n29yODCDHdXCPQLqj0YWlQSNu+sD43OvNV14pnnbdAjFyUiD1HrVdRyH4crrJmzD2g5jHvYliqN
	i2BpaUlKI0B/dnEwSTDq9m8JJIxTfS4/z8Zj4yhXjg75lIJ3JF/l+xofDBp66NcMpGIOb13wwdRIz
	IRJxUEOSngQwnmI1XUmbmsbHQ/y1BgQcMslRr6y+Qglass1IKUw12SENlza/kpBqKm6/cNIaTPv6T
	muWPOlGk+XEcngVDTBbjEGsliaCcF+2rmHYy2CArTUgRSD1J3sV3UH7HNu1O0qfbH+drpxqfOCzaK
	3CyAiH/kw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khdE3-0001x7-Cb; Tue, 24 Nov 2020 18:39:39 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226]
 helo=SJSMAIL01.us.kioxia.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khdE1-0001wj-3t
 for linux-nvme@lists.infradead.org; Tue, 24 Nov 2020 18:39:38 +0000
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 24 Nov 2020 10:39:35 -0800
Received: from SJSMAIL01.us.kioxia.com ([fe80::f5d9:1f19:c784:d6e9]) by
 SJSMAIL01.us.kioxia.com ([fe80::f5d9:1f19:c784:d6e9%4]) with mapi id
 15.01.1779.007; Tue, 24 Nov 2020 10:39:35 -0800
From: Victor Gladkov <Victor.Gladkov@kioxia.com>
To: Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH v10] nvme-fabrics: reject I/O to offline device
Thread-Topic: [PATCH v10] nvme-fabrics: reject I/O to offline device
Thread-Index: Ada+Txj1s7x0Gid4QEafY+ZisCrKCAEYxJQAAAhhzmA=
Date: Tue, 24 Nov 2020 18:39:35 +0000
Message-ID: <11bd8ee6d66f4a65a95bc7081073fc60@kioxia.com>
References: <95f582e9dcd648a9930e85b397d39898@kioxia.com>
 <20201124143554.GA3046@lst.de>
In-Reply-To: <20201124143554.GA3046@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.93.66.127]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201124_133937_199454_2F205E7A 
X-CRM114-Status: UNSURE (   8.83  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 "Ewan D. Milne" <emilne@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> From: Christoph Hellwig [mailto:hch@lst.de]
> 
> I tried to apply this, but first it didn't apply as it expected to be indented
> differently from how it is in nvme-5.11.  After fixing this up the commit
> message didn't show up as it isn't placed correctly in this mail, and the code did
> not compile because nvme_stop_failfast_work and nvme_start_failfast_work
> do not actually exist.  Can you please resend against nvme-5.11?

Redesigned and resend.
https://lists.infradead.org/pipermail/linux-nvme/2020-November/021131.html
 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
