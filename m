Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75886FA3740
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Oct 2022 08:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:MIME-Version:
	Content-Type:Content-Transfer-Encoding:References:In-Reply-To:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=se56kAYYou4UlGliCjEDQ4vmx+Kj3tKdhFsF7SF2r4k=; b=LKezo3WAi7YVNtBRaeWsSv7jYE
	+FM8PusK8KhB6UX1eMpVpuOqQM/uM4Z5fPau35HN7FfmL1nfc5im9TsrYa+xKb9CZ6ZPu1KSx70qv
	tCsKtLxFIK+o0bMiv7Hzsn4VFhlLQXdqg1sqIEx6oGON3cHwHL7ws128VQZec/O3pHi81hEA5A27b
	Nh7k+9nq0a78JOASyvD5BUHXSO9Bgms808YXvHq8usC4EnKd3cPMtxWuEMN52UT8o3L9KOSoyah0F
	pBBfiTKE4VKFZ8Fq14ldr3rxcAKKI7u80gZ71V+4zuyi31qvcBOS+JR3VNXT8i1WokTitqSUPHhFf
	HKCZC6mQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op3nM-00EFpA-Da; Sun, 30 Oct 2022 08:35:52 +0000
Received: from mail.zju.edu.cn ([61.164.42.155] helo=zju.edu.cn)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op3nJ-00EFlu-4K
	for linux-nvme@lists.infradead.org; Sun, 30 Oct 2022 08:35:51 +0000
Received: by ajax-webmail-mail-app4 (Coremail) ; Sun, 30 Oct 2022 16:35:42
 +0800 (GMT+08:00)
X-Originating-IP: [10.14.30.50]
Date: Sun, 30 Oct 2022 16:35:42 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Jinlong Chen" <nickyc975@zju.edu.cn>
To: "Christoph Hellwig" <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, bvanassche@acm.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Subject: Re: Re: [RESEND PATCH v2 3/3] block: hide back
 blk_freeze_queue_start and export its blk-mq alias
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <20221030082130.GA4930@lst.de>
References: <cover.1667107410.git.nickyc975@zju.edu.cn>
 <3f2b51cc7f5c21e49bfa089e594cb203a4015183.1667107410.git.nickyc975@zju.edu.cn>
 <20221030074010.GD4131@lst.de>
 <2671e78e.152908.18427f9be8d.Coremail.nickyc975@zju.edu.cn>
 <20221030082130.GA4930@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2e53c763.15296d.1842808478d.Coremail.nickyc975@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgAnYvxeN15jL6yfBw--.50915W
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgYTB1ZdtcKYKQAEsZ
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221030_013549_495658_23FD609C 
X-CRM114-Status: UNSURE (   3.01  )
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

PiA+IEkgYWdyZWUgdGhhdCB0aGUgZnJlZXppbmcgc3R1ZmYgKG1heWJlIGFsc28gdGhlIHF1aWVz
Y2luZyBzdHVmZikgc2hvdWxkCj4gPiBtb3ZlIG91dCBvZiB0aGUgbXEgbmFtZXNwYWNlLiBJZiBu
b3cgaXMgbm90IHRoZSBwcm9wZXIgdGltZSwgSSdsbCBsZWF2ZQo+ID4gdGhlbSBhbG9uZS4gSSds
bCByZXNlbmQgcGF0Y2ggMSBhbG9uZSB3aXRob3V0IHRoZSBjb21tZW50Lgo+IAo+IFRoZSBxdWll
c2NlIGFjdHVhbGx5IGlzIGVudGlyZWx5IGJsay1tcSBzcGVjaWZpYywgd2hpY2gganVzdCBoYXZl
IHNvbWUKPiBjYXJlbGVzcyBjYWxsZXJzLgoKR290IGl0LCB0aGFuayB5b3UhCgpUaGFua3MhCkpp
bmxvbmcgQ2hlbgo=

