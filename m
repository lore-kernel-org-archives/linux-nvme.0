Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFA6C38A02
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Oct 2022 13:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:MIME-Version:
	Content-Type:Content-Transfer-Encoding:References:In-Reply-To:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W5P2ZbmnV5EqX6YPm2InEY4tBzDQitsd17C0/3HUzps=; b=kbRhDyTc+9PnziRXveZwPNI70U
	ETwVD2As1hnF4QGfZUDiKxAwkTpFQWh4pT77aAMToXspw+A0T1XSlPDbKFUM1V7FiVV6YWJIlU5pG
	2VIZMOxzu/5Pp6KiunbjNacOisOadkfd2KxVz1gF9jKnAUucHtOFyVaF2Vv5kDzdFZRNKRQGuNwiL
	exhbYt+q6CMPmrcm9bQ1E8FQkcXFSRJXkIanEqCKor5KZzWGnRMx/UsVXfywAhVpvKDZ94fMc7VfB
	uv7wZTglxnnGiTXJ4ZJMytbfJhcLE3B17P5AEYB2G7Dd4EPPy55ZFrcbnl5vhrv668UmxiQ2dmXxW
	xc4OI19w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opUTy-00BtYI-Lm; Mon, 31 Oct 2022 13:05:38 +0000
Received: from spam.zju.edu.cn ([61.164.42.155] helo=zju.edu.cn)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opUTv-00BtVh-Qo
	for linux-nvme@lists.infradead.org; Mon, 31 Oct 2022 13:05:37 +0000
Received: by ajax-webmail-mail-app2 (Coremail) ; Mon, 31 Oct 2022 21:05:15
 +0800 (GMT+08:00)
X-Originating-IP: [10.14.30.50]
Date: Mon, 31 Oct 2022 21:05:15 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Jinlong Chen" <nickyc975@zju.edu.cn>
To: "kernel test robot" <yujie.liu@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, axboe@kernel.dk, kbusch@kernel.org, 
	hch@lst.de, sagi@grimberg.me, bvanassche@acm.org, 
	linux-kernel@vger.kernel.org
Subject: Re: Re: [RESEND PATCH v2 3/3] block: hide back
 blk_freeze_queue_start and export its blk-mq alias
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <202210311456.2d2c7899-yujie.liu@intel.com>
References: <202210311456.2d2c7899-yujie.liu@intel.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <e316420.15e91d.1842e256c7e.Coremail.nickyc975@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgCHz1sLyF9jH0BTBw--.53074W
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgIAB1ZdtcLuXwAAsK
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW5Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221031_060536_221304_3954BE45 
X-CRM114-Status: UNSURE (   1.30  )
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

Pgo+IEdyZWV0aW5nLAo+IAo+IEZZSSwgd2Ugbm90aWNlZCBXQVJOSU5HOmF0X2Jsb2NrL2Jsay1t
cS5jOiNibGtfbXFfZnJlZXplX3F1ZXVlIGR1ZSB0byBjb21taXQgKGJ1aWx0IHdpdGggZ2NjLTEx
KToKPgoKU29ycnkgZm9yIHRoZSBkaXN0dXJiYW5jZS4KClRoZSBwYXRjaCBzZXJpZXMgaXMgZGVw
cmVjYXRlZC4gUGxlYXNlIGlnbm9yZSB0aGlzLgoKVGhhbmtzIQpKaW5sb25nIENoZW4=

