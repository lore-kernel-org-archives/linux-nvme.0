Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D1FFA3744
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Oct 2022 08:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:MIME-Version:
	Content-Type:Content-Transfer-Encoding:References:In-Reply-To:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J/pDm9y/l9QUytF0IzzXyqPPAw+hmEX4PJO3u0h8oRc=; b=3GztaZwS20T7RAewjbcjX3rxeq
	6UH04OoFHrvagfOJgYq6bxRejQ0WeNH8PYa6exzfm3+ljzU5QwIu5AXWLGEQW8oNivx7VKVe/5a5b
	ud4YR1nR8LC0fPFwPhYAnPVVQYok3GWf6ohKuNZ3eQi+TkMaFv7DAHLnpFWMU6iOQ3Iwvv8B4z1qq
	2Nxm34y4hNvFDLhsNHV7r7ifAiSU8mje0e4hSzGIEPVjTg6zWDJZ44soBnis/eSIYkBdtyo7aShcf
	giIF2IC1JAgu+pV1PdPIu75R0bhCfHTbHiiHiAZdA+5VKPU4Yn0rafICQ9bMtoY8has9KWxKkW3HB
	tXQJpXuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op3Y8-00E7kQ-8J; Sun, 30 Oct 2022 08:20:08 +0000
Received: from spam.zju.edu.cn ([61.164.42.155] helo=zju.edu.cn)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op3Y4-00E7eQ-GT
	for linux-nvme@lists.infradead.org; Sun, 30 Oct 2022 08:20:06 +0000
Received: by ajax-webmail-mail-app4 (Coremail) ; Sun, 30 Oct 2022 16:19:49
 +0800 (GMT+08:00)
X-Originating-IP: [10.14.30.50]
Date: Sun, 30 Oct 2022 16:19:49 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Jinlong Chen" <nickyc975@zju.edu.cn>
To: "Christoph Hellwig" <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, bvanassche@acm.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Subject: Re: [RESEND PATCH v2 3/3] block: hide back blk_freeze_queue_start
 and export its blk-mq alias
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <20221030074010.GD4131@lst.de>
References: <cover.1667107410.git.nickyc975@zju.edu.cn>
 <3f2b51cc7f5c21e49bfa089e594cb203a4015183.1667107410.git.nickyc975@zju.edu.cn>
 <20221030074010.GD4131@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2671e78e.152908.18427f9be8d.Coremail.nickyc975@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgBXXP2lM15jsZ+fBw--.49559W
X-CM-SenderInfo: qssqjiaqqzq6lmxovvfxof0/1tbiAgYTB1ZdtcKYKQAAsd
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221030_012004_877506_D5569904 
X-CRM114-Status: UNSURE (   7.46  )
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

PiBPbiBTdW4sIE9jdCAzMCwgMjAyMiBhdCAwMToyNjo0NlBNICswODAwLCBKaW5sb25nIENoZW4g
d3JvdGU6Cj4gPiBibGtfZnJlZXplX3F1ZXVlX3N0YXJ0IGlzIHVzZWQgaW50ZXJuYWxseSBmb3Ig
dW5pdmVyc2FsIHF1ZXVlIGRyYWluaW5nIGFuZAo+ID4gZXh0ZXJuYWxseSBmb3IgYmxrLW1xIHNw
ZWNpZmljIHF1ZXVlIGZyZWV6aW5nLiBLZWVwIHRoZSBub24tYmxrLW1xIG5hbWUKPiA+IHByaXZh
dGUgYW5kIGV4cG9ydCBhIGJsay1tcSBhbGlhcyB0byB1c2Vycy4KPiAKPiBJIHJlYWxseSBkb24n
dCBzZWUgdGhlIHBvaW50IGhlcmUuICBFdmVudHVhbGx5IGFsbCBvZiB0aGUgZnJlZXppbmcKPiBz
aG91bGQgbW92ZSBvdXQgb2YgdGhlIG1xIG5hbWVzcGFjZS4gIEJ1dCB0aGF0IGdpdmVuIHRoYXQg
d2UgaGF2ZQo+IGFjdHVhbCB0ZWNobmljYWwgd29yayBwZW5kaW5nIGhlcmUgSSdkIHN1Z2dlc3Qg
dG8ganVzdCBsZWF2ZSBpdCBhbG9uZQo+IGZvciBub3csIGFuZCBqdXN0IHJlc3BpbiBhIHZlcnNp
b24gb2YgcGF0Y2ggMSB3aXRob3V0IHRoZSBwb2ludGxlc3MKPiBjb21tZW50LgoKSSBhZ3JlZSB0
aGF0IHRoZSBmcmVlemluZyBzdHVmZiAobWF5YmUgYWxzbyB0aGUgcXVpZXNjaW5nIHN0dWZmKSBz
aG91bGQKbW92ZSBvdXQgb2YgdGhlIG1xIG5hbWVzcGFjZS4gSWYgbm93IGlzIG5vdCB0aGUgcHJv
cGVyIHRpbWUsIEknbGwgbGVhdmUKdGhlbSBhbG9uZS4gSSdsbCByZXNlbmQgcGF0Y2ggMSBhbG9u
ZSB3aXRob3V0IHRoZSBjb21tZW50LgoKVGhhbmtzIQpKaW5sb25nIENoZW4K

