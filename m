Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAEFC38A02
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Oct 2022 03:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:MIME-Version:
	Content-Type:Content-Transfer-Encoding:References:In-Reply-To:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OzEb/+X+D1I6yijecKpKXPpUFscRKpDNha4nU1+hhd0=; b=kRMv0p8cS78Q4sXaMjq/6RtFFN
	xA23RUlEKLvXTTMUAE8KKo0kM5RURPNUK8vKFE+p5qg/EVTRKn4UWK/CKwwT1u7DoOmVqwWSHSYOd
	jeU4qGRhYuNAOoPP9NNv1Wg0RMizL/O+BgysNEfM5ol8tOWiAoAjb5taZMTXQLtQk7eI2MhDrtudt
	bsw+o0dIn543v3nKmgjZrxpT6dUVww9TznUhGV2Isi7qIJ0cC6yeYudRTXf+ES5zu15d3zy2VynCS
	ODiLzz+BGjDRlFjbeW3MTMNwHaapRBiuPru+6lG4dtvuogmfh4NkIT0oBsXfH61ZGUC0nv1niYnHz
	M1+3jaPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooyoz-00Bpqy-CW; Sun, 30 Oct 2022 03:17:13 +0000
Received: from mail.zju.edu.cn ([61.164.42.155] helo=zju.edu.cn)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooyov-00BppO-Oz
	for linux-nvme@lists.infradead.org; Sun, 30 Oct 2022 03:17:11 +0000
Received: by ajax-webmail-mail-app2 (Coremail) ; Sun, 30 Oct 2022 11:17:01
 +0800 (GMT+08:00)
X-Originating-IP: [10.192.32.139]
Date: Sun, 30 Oct 2022 11:17:01 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Jinlong Chen" <nickyc975@zju.edu.cn>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc: bvanassche@acm.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 0/3] queue freezing improvement and cleanups
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <cover.1667098953.git.nickyc975@zju.edu.cn>
References: <cover.1667098953.git.nickyc975@zju.edu.cn>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <79bc5c7e.1598db.18426e48610.Coremail.nickyc975@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgCHSrCt7F1jDA9LBw--.12310W
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgUTB1ZdtcKOnAAEs5
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW5Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221029_201710_123427_35203324 
X-CRM114-Status: UNSURE (   0.77  )
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

SGkhCgpUaGUgaW1wcm92ZW1lbnRzIG9mIHRoZSBkZXNjcmlwdGlvbnMgYXJlIHN1Z2dlc3RlZCBi
eSBCYXJ0IFZhbiBBc3NjaGUgPGJ2YW5hc3NjaGVAYWNtLm9yZz4uIFNvcnJ5IGZvciB0aGUgbWlz
c2luZy4KClRoYW5rcyEKSmlubG9uZyBDaGVuCg==

