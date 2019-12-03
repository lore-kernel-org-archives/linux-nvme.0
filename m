Return-Path: <SRS0=ysN4=ZZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71551C432C0
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2019 08:51:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0F4A20659
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2019 08:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BeBuAb9T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="HghVNqiy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F4A20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:MIME-Version:Subject:
	References:In-Reply-To:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Jot/3gIrX0XJW9/Ngq7W8UaVJysryNVD0pYeM9Hu6g4=; b=BeBuAb9T8Q15NN
	MfLJwN4sCfYRhf/oEMLsUUkieoW+z3ViGxFMAWoNIflw7xgYanr809vcjyhY+ocS95n/fZFVBiYGC
	QMdj7BwDrlGc3qAElXOl8IMxlAqx/Nm3GUZBakmJglZxO1KPDR7ROt2bIQVWKKpTC/2D29C9QtaFq
	AiKGSksNVr+Pcns5ZfGr3q1FEVqwuWIa9XtrTUzrX0IB0RkqeZY8/9CeSJ/mbQ4mv4oL0zkea0PKu
	FNx0Xgk8OYFLZjwvXAzryiMPl5yHwFiMNlYXBoVWo934hvX2vn5N0QNy1RDSwLotzaD2LG0sPhWSc
	AwSYrhM5X0/8cM0wtq1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ic3uM-0001FH-Kf; Tue, 03 Dec 2019 08:51:46 +0000
Received: from forward500j.mail.yandex.net ([5.45.198.250])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ic3uI-0001Ef-Px
 for linux-nvme@lists.infradead.org; Tue, 03 Dec 2019 08:51:45 +0000
Received: from mxback22o.mail.yandex.net (mxback22o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::73])
 by forward500j.mail.yandex.net (Yandex) with ESMTP id D5D2E11C0E9F
 for <linux-nvme@lists.infradead.org>; Tue,  3 Dec 2019 11:51:36 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxback22o.mail.yandex.net (mxback/Yandex) with ESMTP id d275wXsQjr-pa7S5cit;
 Tue, 03 Dec 2019 11:51:36 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1575363096; bh=aH8COMyT39halqjuZHpq7VAZf2SlLaKlLoiNX/Fs56c=;
 h=Message-Id:Subject:In-Reply-To:Date:References:To:From;
 b=HghVNqiydP9fveiiDBtswW0sGz968nVBs4BpQNGPYwy5PzxH4d9KRx6cBMBzaCxDt
 ooBO3ZiIMN579YNewknKGAmxU11nxPWOaTnDHgk5fLsH6biLvszdHEEc91ty6o+lEG
 v1vRqoZjm0+Ye+6Pcd2k4WbwEKbc4CKDdmL89oF0=
Authentication-Results: mxback22o.mail.yandex.net;
 dkim=pass header.i=@yandex.ru
Received: by myt3-605d5ea4bc20.qloud-c.yandex.net with HTTP;
 Tue, 03 Dec 2019 11:51:36 +0300
From: Talker Alex <alextalker@yandex.ru>
Envelope-From: alextalker@yandex.ru
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
In-Reply-To: <BYAPR04MB5749D5699EB15878C41F4BA386430@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <92087051575042507@sas2-7fadb031fd9b.qloud-c.yandex.net>
 <114736651575042639@vla4-d1c3bcedfacb.qloud-c.yandex.net>
 <BYAPR04MB5749D5699EB15878C41F4BA386430@BYAPR04MB5749.namprd04.prod.outlook.com>
Subject: Re: NVMeoF driver & Reservations
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Tue, 03 Dec 2019 11:51:36 +0300
Message-Id: <11467571575363096@myt3-605d5ea4bc20.qloud-c.yandex.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191203_005143_208179_A350E796 
X-CRM114-Status: UNSURE (   6.99  )
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> But if you have a legit scenario or a
> use-case I'll be happy to work on this.

I think in SCSI subsystems this support is usually made to pass-by Microsoft Windows Server Failover Clustering requirements.
Regarding the use-case I think this is as usual an effort to create
a lock mechanism in order to synchronize access to the same device without an additional layer on client side.

I don't know whether NVMeoF works on Windows at all by now, haven't checked yet.
Anyway, I'd like to see your code if you published it anywhere.
Unlikely with SCSI, NVMe Reservations seems to be easier to implement with dedicated HostNQN identifier,
digging through the specification conditions.

------------------
Best regards,
Alex

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
