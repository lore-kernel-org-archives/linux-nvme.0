Return-Path: <SRS0=I4H8=LP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672BBC4743C
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 10:18:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C549611BD
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 10:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C549611BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=pPzEPkNQjM7kKHonqPNvFRv53x5RAPem7oJVV4gtS30=; b=GjGYCXRhsoJfqEZyIwF6AO9e/Q
	EduepVXUsY+x9QBBPxDFW5rRekM3aEHO1SlEZwqtrHWxcd2qGUo7oOA+o0EQwEhDcQYjDz6VbJAMI
	pPOhZknPH5fz4KQL0q6j/soc5wkKrCFARiEHoTAJfUTF8E57DWfLnAkvnD/RtQlFZbsbfduf8TElJ
	+d5LyZbRZmYT0GTOQhNDwFASbnALV6/2QMZO2DYf/qStyqRfZWrdFsk3iGCUnJFFWHcAN6OY6hxa/
	exAFUQd5vvq/rBfTQn3vjLp6E6g1Me/pX9uwae3MWXbJRj5q9hM/9ytaTubprWAZPuU+CWn1EMzHX
	KeapPu5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvH0o-0034Mj-6W; Mon, 21 Jun 2021 10:18:38 +0000
Received: from mout.kundenserver.de ([212.227.126.134])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvH0l-0034Kk-G9
 for linux-nvme@lists.infradead.org; Mon, 21 Jun 2021 10:18:37 +0000
Received: from [192.168.1.155] ([95.118.106.223]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MKKIZ-1lhjOg32gp-00LjdJ; Mon, 21 Jun 2021 12:18:17 +0200
Subject: Re: [PATCH] drivers/nvme/host: Use kobj_to_dev() API
To: Christoph Hellwig <hch@lst.de>, zhouchuangao <zhouchuangao@vivo.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <1624025458-56465-1-git-send-email-zhouchuangao@vivo.com>
 <20210618141817.GA18781@lst.de>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <fd15a968-3d75-ba22-b0b0-4ed4d2a66372@metux.net>
Date: Mon, 21 Jun 2021 12:18:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210618141817.GA18781@lst.de>
Content-Language: tl
X-Provags-ID: V03:K1:rnCQHJ4P3jPjEp+FPv2c+6ZrOb0YN2+ZVhSqLJgY6e76gRvpjJL
 sjIS8QrTWo+3stOtTgPsGVR6Y9jq9d5PlufWYhvkzdyqQ/tIz4XsDelUq92T7O6NozhWKcD
 rN2BTP5V9R+533WRcIH+yoLlf/E4PC85XE1eOx9HKyjSofGvmSmsQgfa0BHPAyPikZyCm7w
 yo04NAOAy8IHu/7VNvU2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FBmQwYU7PMA=:0sIW8ZRkWQ7m2wGPiKqs/J
 HKjG5Vr/D1ITsvGBImNzWN4EZ9BjQV7wElx1Pl3Itfsu2J1TKaWaSqcoXgf5IRamQy0Hf3b/f
 ORAVQlRVwOVgKSKiVcWc/mNXFWjBUB267ar/MY+NaNZTpMcVwy/087U9ACwU7DZq3IbfT52yt
 ihuH7uBR7CacmYO09CekGmw/coKqVeHXduni5HtzYMWM2d53hLZvzLuCKDW6B+NUGm8QAON+c
 xXORtgcEXLu8ADTSQ8vflGsLaoOhywFfE01Ay06xw7EnoslBah68ZrJEPrmyICocOHeaviF8g
 UNOJJNKCmRodbwe58JMSTT5KgTAUyoKMMxCCsPAlsKYk+wo5J1A/HU5sUODlGn3jZUopexjsI
 JLN7xG0TMsfPHmsROqBSMwSPcwwfmj5g46TZP/M8MODyQVHR3L8N1vfuRPZvJXBLkSGtAIyhg
 Vf0QbEWAcGkujjqOsqcz85VYki9bLnXyq4xRir6djokDwSLZjF/wOPTHfDvuyWrWelwfcphUL
 v3FvcQzyGYhAIPsE3LT9m8=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210621_031835_867830_7CA8D941 
X-CRM114-Status: GOOD (  10.26  )
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

T24gMTguMDYuMjEgMTY6MTgsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IE9uIEZyaSwgSnVu
IDE4LCAyMDIxIGF0IDA3OjEwOjU4QU0gLTA3MDAsIHpob3VjaHVhbmdhbyB3cm90ZToKPj4gVXNl
IGtvYmpfdG9fZGV2KCkgQVBJIGluc3RlYWQgb2YgY29udGFpbmVyX29mKCkuCj4gCj4gV2h5PyAg
VGhhdCBqdXN0IG1ha2VzIHRoZSBjb2RlIGhhcmRlciB0byByZWFkLgoKV2h5IHNvID8gV2h5IHRv
IHdlIGhhdmUga29ial90b19kZXYoKSBhdCBhbGwgPwpEbyB5b3Ugc3VnZ2VzdCwgd2Ugc2hhbGwg
Z2V0IHJpZCBvZiBpdCAoYW5kIGFsbCBzaW1pbGFyIG9uZXMpID8KCi0tbXR4CgotLSAKLS0tCkhp
bndlaXM6IHVudmVyc2NobMO8c3NlbHRlIEUtTWFpbHMga8O2bm5lbiBsZWljaHQgYWJnZWjDtnJ0
IHVuZCBtYW5pcHVsaWVydAp3ZXJkZW4gISBGw7xyIGVpbmUgdmVydHJhdWxpY2hlIEtvbW11bmlr
YXRpb24gc2VuZGVuIFNpZSBiaXR0ZSBpaHJlbgpHUEcvUEdQLVNjaGzDvHNzZWwgenUuCi0tLQpF
bnJpY28gV2VpZ2VsdCwgbWV0dXggSVQgY29uc3VsdApGcmVlIHNvZnR3YXJlIGFuZCBMaW51eCBl
bWJlZGRlZCBlbmdpbmVlcmluZwppbmZvQG1ldHV4Lm5ldCAtLSArNDktMTUxLTI3NTY1Mjg3Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1l
IG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
