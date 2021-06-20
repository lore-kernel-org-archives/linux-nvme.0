Return-Path: <SRS0=wCte=LO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4803C48BDF
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Jun 2021 17:28:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B4D0608FC
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Jun 2021 17:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4D0608FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YUvNZ3dRJCQUSOuGqyTcRsJ5jkn22cFbFqY6LYQtF3E=; b=Cb5XXyXaJrKCAw
	mVYsmFpST2NqfdM+GbhDBJgJAETYNE3henV8tsdRt0CLSme+ERFYiY9RlM3MZSCKg060MweNTo/sn
	ue1boqu+QmYXYtktdRNDw5GmBm+WBfZr+MMFUMZmIZMZR2cr2+Uq4ePS2Gu+mklAZ0GTylaGZ5BgG
	kMCq0hEZX7zUn+S4XKXZqgkWt3tQ8/6n8+Cw+xJEnGQhmYELYJbdGNyFGeQqF+KlWu6wgTzIlPBVc
	abXVGyziLPv3n1zdlksMW+OPjoLhHE7Tw2RiS+WDjB2Q5Kyc4uknFruKZLHj8iZaH8knk9ZV/9Nt8
	U/QfcCzrZTDFSRduZrLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lv1Eu-001N0A-DG; Sun, 20 Jun 2021 17:28:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lv1Ej-001Mzn-QQ
 for linux-nvme@lists.infradead.org; Sun, 20 Jun 2021 17:27:59 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 844D361078;
 Sun, 20 Jun 2021 17:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624210077;
 bh=UbCQeaZa/L2lRzOnKsDDfsxAGl5phqY488Y8n18gIso=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PAGL7vZcF+ozh1JU4/6Kf7MGp2Jn+3pfZSTjIhB8xpU28mdtoQ2H3Ui5Qz5MfV4Sl
 Md6TpZZt5ccWWhlPPJvdzV/IZGoI10EslufO6222s9QB5ycwOkcN7EoyHKvG8dI+PW
 ONFnC+P8IYZAsGxm5FHxvdX8foVFqXamiKU1m5OHmD51VbJ4yCPO5rixHW42CJrJ0s
 mVe8RD+5DN0wJgVLSVzNX0GMMB3A5Z1H/IJ6FQU3asTbN41r6UznmqQVQsGCJ5sTG9
 w4ChlWVccq36Ib4qB25fBLMyDFguAvDFdgUiytU0JkEQHeXZJDg5d5twnuYGxBr53N
 ONlyXWoENrlRQ==
Date: Sun, 20 Jun 2021 10:27:54 -0700
From: Keith Busch <kbusch@kernel.org>
To: =?utf-8?B?5ZGo5Lyg6auY?= <zhouchuangao@vivo.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] drivers/nvme/host: Use kobj_to_dev() API
Message-ID: <20210620172754.GB1137891@dhcp-10-100-145-180.wdc.com>
References: <20210618141817.GA18781@lst.de>
 <ABYAKQDNDmr9B7YYOVwFFKqU.3.1624078894067.Hmail.zhouchuangao@vivo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ABYAKQDNDmr9B7YYOVwFFKqU.3.1624078894067.Hmail.zhouchuangao@vivo.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210620_102757_919507_106F262A 
X-CRM114-Status: GOOD (  11.01  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gU2F0LCBKdW4gMTksIDIwMjEgYXQgMDE6MDE6MzRQTSArMDgwMCwg5ZGo5Lyg6auYIHdyb3Rl
Ogo+ID5PbiBGcmksIEp1biAxOCwgMjAyMSBhdCAwNzoxMDo1OEFNIC0wNzAwLCB6aG91Y2h1YW5n
YW8gd3JvdGU6Cj4gPj4gVXNlIGtvYmpfdG9fZGV2KCkgQVBJIGluc3RlYWQgb2YgY29udGFpbmVy
X29mKCkuCj4gPgo+ID5XaHk/ICBUaGF0IGp1c3QgbWFrZXMgdGhlIGNvZGUgaGFyZGVyIHRvIHJl
YWQuCj4gCj4gSW4gbXkgb3BpbmlvbiwgdGhlIGtvYmpfdG9fZGV2KCkgaW50ZXJmYWNlIGlzIHBy
b3ZpZGVkIGJ5IHRoZSBrZXJuZWwgc28gdGhhdAo+IHdlIGNhbiBnZXQgZGV2aWNlIGJhc2VkIG9u
IGtvYmogd2l0aG91dCBoYXZpbmcgdG8gcGFzcyBtb3JlIHBhcmFtZXRlcnMuCj4gSSB0aGluayBp
dCdzIGVhc2llciB0byB1c2UuCgpUaGlzIHNhbWUgcGF0Y2ggaGFzIGJlZW4gcHJvcG9zZWQgYW5k
IHJlamVjdGVkIG51bWVyb3VzIHRpbWVzLiBEbyB3ZQpuZWVkIHRvIHBsYWNlIGEgY29tbWVudCBp
biB0aGUgY29kZSB0byBwcmV2ZW50IGZ1dHVyZSByZXF1ZXN0cz8KCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL3BpcGVybWFpbC9saW51eC1udm1lLzIwMjEtTWFyY2gvMDIzMzE2Lmh0bWwKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LW52bWUvMjAyMS1GZWJydWFy
eS8wMjMwNjAuaHRtbApodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGludXgt
bnZtZS8yMDIwLVNlcHRlbWJlci8wMTk0NjIuaHRtbAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZt
ZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtbnZtZQo=
