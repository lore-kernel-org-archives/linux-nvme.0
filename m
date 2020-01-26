Return-Path: <SRS0=KthH=3P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCB4C35240
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jan 2020 10:06:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589802075D
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jan 2020 10:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i8EjMc2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589802075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=FxKiuIo5lXabdzkEAba7O5pj6uqXI9mwjw8Xmgtx/5A=; b=i8EjMc2nl+F+q5
	OKhSH22G4ZCG9yOGPSODlcRkEB+uatbw2zpOYQWJP4M3UR7shbECznJRgYeFCMlZO9BkX0iFjXsAE
	kgIEt6M9P6dPebBk7ZFCbPIYmG9oiEZeo2G0fngVXEoGtP4lbNsPat40C1W/Zu8LYV2osu34JaCTA
	vlbYq0GNeoXcx+Umbfk133VdNTCIHHFEBz78mi/yBQKb3fKUKRT20AMTHwGlqb5VVthzi4J+UyK7b
	Qep5FLQMwJuLmhDxI2Qq6Gb717CYSAxdwl77PyLxcQaWf8QXy0LsPk2i3AMMzl2hG3mJxonbI0+5q
	X5FNz9mfe7pzXbodaj3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iveoK-0006Gq-Tm; Sun, 26 Jan 2020 10:06:32 +0000
Received: from ip-12-0-68-226-us.kioxia.com ([12.0.68.226]
 helo=SJSMAIL01.us.kioxia.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iveoG-0006G7-TC
 for linux-nvme@lists.infradead.org; Sun, 26 Jan 2020 10:06:31 +0000
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sun, 26 Jan 2020 02:06:20 -0800
Received: from SJSMAIL01.us.kioxia.com ([fe80::f818:a7db:64f:17a4]) by
 SJSMAIL01.us.kioxia.com ([fe80::f818:a7db:64f:17a4%3]) with mapi id
 15.01.1779.004; Sun, 26 Jan 2020 02:06:20 -0800
From: Victor Gladkov <Victor.Gladkov@kioxia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH v2] nvme-fabrics: reject I/O to offline device
Thread-Topic: [PATCH v2] nvme-fabrics: reject I/O to offline device
Thread-Index: AdXAws2i7K3jkb2QTo+39ruHWzRzNwF3KTYAAUUtNIACHthsIA==
Date: Sun, 26 Jan 2020 10:06:20 +0000
Message-ID: <8b8454b9b2d44efab22df15af9df0a21@kioxia.com>
References: <49c2e737f21b4c2795de71c8d8d578ee@kioxia.com>
 <98e76717-1e98-92e1-0d07-d2dac4bd1d76@broadcom.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.93.66.127]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200126_020628_942548_72C7B896 
X-CRM114-Status: UNSURE (   4.79  )
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
Cc: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/15/2020 5:43 PM, Victor Gladkov wrote:
> 1. Added multipath support for this patch.
> 2. Small refactoring (according to the review)

Anyone have any comments on the latest proposed patch?

Regards,
Victor
_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
