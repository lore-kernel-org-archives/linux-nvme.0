Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F40ECAAD8
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 12:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:MIME-Version:
	Content-Type:Content-Transfer-Encoding:References:In-Reply-To:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kQufjHwQVx2kafpHl2tj8EypAtvdy3HqfKUId4Yzq3s=; b=hKZ0mc6SPT9BwRLNoW+JMM+rdQ
	/tMVyhTgRBY0q51j6yh+EA4t2ovdeZQ3HAJvSJn4EqC4wIlh25o7oQOHgO8LRKDBtVlljrMlhYvi7
	NJqTsM6Dp2cmXoyhPjs+wfnMYioHqSEkcp6RknnUI5LwdmmXh0dkjS1XAQB4o8OloNRBOZJgLmE4Y
	gs8QjTJtZKjoqia8uRVN9egnWqEMP9fj0PFH+tl5WqF4lQ5MggsvOtg2uHHB1tzszidFFLRkMzdA/
	42yhBlTuICSA9E5/tuIk3xnz65vClC/rzHvUbNT7so5XO6SdPyfRgyO9k0DqFYqGakKYMMHBTLQQH
	uJWLPYIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oacq9-003tQb-MD; Tue, 20 Sep 2022 12:59:05 +0000
Received: from m1564.mail.126.com ([220.181.15.64])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oacp1-003sXy-4Q
	for linux-nvme@lists.infradead.org; Tue, 20 Sep 2022 12:57:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=kSy0c
	vQv6k5hXvK54cnTkn2sV4zdeOA0F/1b8O+WA7Y=; b=ZJBtJrlsCLWjhcTuPKJz9
	dDXfSNoevtmeBAtm+aR2/IVvyTlLTxSictp/nGv0sN2bBCLsMYt+G3zJngxIzTX3
	jse59nw96Au0IAzJQkC113WoGm+QkRYAKSB8uMBNW5lOx7y1iLRfZEee7Zq7s3zK
	wkKFZrMOe6o/DjgmnI6f18=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr64
 (Coremail) ; Tue, 20 Sep 2022 20:54:10 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date: Tue, 20 Sep 2022 20:54:10 +0800 (CST)
From: "Liang He" <windhl@126.com>
To: "James Smart" <jsmart2021@gmail.com>
Cc: james.smart@broadcom.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	linux-nvme@lists.infradead.org
Subject: Re:Re: [PATCH] nvmet-fc: Fix potential Use-after-free bug in
 nvmet_fc_delete_target_queue()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <35339637-846a-2c7d-d414-fa05527a8cf6@gmail.com>
References: <20220916082953.4095940-1-windhl@126.com>
 <5c965e81.13d6.183536d5bba.Coremail.windhl@126.com>
 <35339637-846a-2c7d-d414-fa05527a8cf6@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <71e21f4.78db.1835af68bbc.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: QMqowACntnLztylj2O1zAA--.3261W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizhiCF18RP2yDRgACsZ
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_055755_670652_6D93892F 
X-CRM114-Status: UNSURE (   6.00  )
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

CkF0IDIwMjItMDktMjAgMDE6NTc6MDUsICJKYW1lcyBTbWFydCIgPGpzbWFydDIwMjFAZ21haWwu
Y29tPiB3cm90ZToKPk9uIDkvMTgvMjAyMiA2OjQ2IFBNLCBMaWFuZyBIZSB3cm90ZToKPj4+Cj4+
PiAJCWtmcmVlKGRlZmVyZmNwKTsKPj4+Cj4+PiAtCQlzcGluX2xvY2tfaXJxc2F2ZSgmcXVldWUt
PnFsb2NrLCBmbGFncyk7Cj4+PiArCQlzcGluX2xvY2tfaXJxc2F2ZShxX2xvY2ssIGZsYWdzKTsK
Pj4+IAl9Cj4+PiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcXVldWUtPnFsb2NrLCBmbGFncyk7
Cj4+Pgo+Pj4gLS0gCj4+PiAyLjI1LjEKPj4gCj4+IFNvcnJ5LCBteSBwYXRjaCBpcyB0b3RhbGx5
IHdyb25nIGFzIHRoZSAncWxvY2snIGlzIGVtYmVkZWQgaW50byBxdWV1ZS4KPj4gU28gaWYgcXVl
dWUgaXMgZnJlZWQsIHRoZSAncWxvY2snIHdpbGwgYWxzbyBiZSBmcmVlZC4KPj4gCj4+IE5vdywg
d2UgY2FuIG9ubHkgaG9wZSB0aGUgJ252bWV0X2ZjX3RndF9xX3B1dCcgaW4gbGluIDk0MSB3aWxs
IG5ldmVyIHJlYWxseSBmcmVlIHRoZSAncXVldWUnLgo+Cj5EaWQgeW91IGFjdHVhbGx5IHNlZSB0
aGF0IG9jY3VyIChsaW5lIDk0MSBmcmVlZCB0aGUgcXVldWUpID8KPgo+LS0gamFtZXMKCkhpLCBK
YW1lcywKCkkgYWN0dWFsbHkgaGF2ZSBub3Qgc2VlbiB0aGlzIGFzIEkgdXNlIHN0YXRpYyBtZXRo
b2QgdG8gZGV0ZWN0IGl0LgoKV2hpbGUgdGhlcmUgd2lsbCBiZSBubyBVQUYgaW4gY3VycmVudCB2
ZXJzaW9uLCBJIHRoaW5rIHdlIHNob3VsZCBub3QgdXNlIHRoZSAKcmVmZXJlbmNlIGFmdGVyIHdl
IHB1dCBpdCwgcmlnaHQ/CgpMaWFuZwo=

