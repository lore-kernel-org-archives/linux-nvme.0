Return-Path: <SRS0=Iz8v=EI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59899C00A89
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2020 15:45:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F339D22275
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2020 15:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2TxW5k6U";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpQoxJwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F339D22275
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jlicI7ZXQcrVMhJLdpvPYL49lHfKlylvbhb0Lt2B9xE=; b=2TxW5k6UgqA0KjDTHon1/u4pM
	zbR1gXYZQHli4bfslgrSohXhfGR2Aw4AzeMterLD8tk7AJddCZceunw4OxQSXVL2MvDUdl6kwQsPe
	RyUWQ4hnFWCyj5Le8k244ppSRm33e61rv5bVNbFkKlbC7qRULurFkFqz0GI2sUvf7BdAwvBWpvyDc
	JlOGEcxrmlR6tvZ+jzcX8PlVIbjJwdjluy1hBCfkCmQENgyJo6V0XhgJ5ijVkHUIIFWbYw46Svno8
	+7n8QE3Cw8qtMm/wvT2geD+P0Mev3xTF+kzJqpPF9igbvuD0ebGuwP1R0XviimRYOvxY1/eU4Vrcz
	iiH8eAepw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kZc0u-0003lQ-81; Mon, 02 Nov 2020 15:44:56 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kZc0s-0003kd-VS
 for linux-nvme@lists.infradead.org; Mon, 02 Nov 2020 15:44:55 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DADE722275;
 Mon,  2 Nov 2020 15:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604331893;
 bh=8rEKR7fOW5uabQi7uw+C2UTt4Ld+cqI5rwCfQynFMcY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OpQoxJwm73vouKoP45vBD1VStPAi+CyeCPU0dL4RqxXspZoBq9V3cBuZqj5uhZn4j
 gSrfjs96iqxoj2rTtuaP6MuOVDHWJ9CeAQ5R0MQYm95fy1O0KVJNPh9TdV9I88LsoS
 CxswXKUhKWC0bWsndwHNCvWVcBmBIzPlUuRU9CwA=
Date: Mon, 2 Nov 2020 07:44:50 -0800
From: Keith Busch <kbusch@kernel.org>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Subject: Re: [PATCH V2] nvme: report capacity 0 for non supported ZNS SSDs
Message-ID: <20201102154450.GA1970293@dhcp-10-100-145-180.wdc.com>
References: <20201102132214.22164-1-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201102132214.22164-1-javier.gonz@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201102_104455_093843_52086014 
X-CRM114-Status: GOOD (  11.47  )
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
Cc: axboe@kernel.dk, Niklas.Cassel@wdc.com, sagi@grimberg.me,
 joshi.k@samsung.com, k.jensen@samsung.com, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>, hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBOb3YgMDIsIDIwMjAgYXQgMDI6MjI6MTRQTSArMDEwMCwgSmF2aWVyIEdvbnrDoWxl
eiB3cm90ZToKPiBDaGFuZ2VzIHNpbmNlIFYxOgo+ICAgIC0gQXBwbHkgZmVlZGJhY2sgZnJvbSBO
aWtsYXM6Cj4gCS0gVXNlIElTX0VOQUJMRUQoKSBmb3IgY2hlY2tpbmcgY29uZmlnIG9wdGlvbgoK
WW91ciB2MSB3YXMgY29ycmVjdC4gVXNpbmcgSVNfRU5CQUxFRCgpIGF0dGVtcHRzIHRvIHVzZSBh
biB1bmRlZmluZWQKc3ltYm9sIHdoZW4gdGhlIENPTkZJRyBpcyBub3QgZW5hYmxlZDoKCiAgZHJp
dmVycy9udm1lL2hvc3QvY29yZS5jOiBJbiBmdW5jdGlvbiDigJhudm1lX3VwZGF0ZV9kaXNrX2lu
Zm/igJk6CiAgZHJpdmVycy9udm1lL2hvc3QvY29yZS5jOjIwNTY6NDU6IGVycm9yOiDigJhzdHJ1
Y3QgbnZtZV9uc+KAmSBoYXMgbm8gbWVtYmVyIG5hbWVkIOKAmHpvbmVkX25zX3N1cHDigJkKICAg
MjA1NiB8ICBpZiAoSVNfRU5BQkxFRChDT05GSUdfQkxLX0RFVl9aT05FRCkgJiYgIW5zLT56b25l
ZF9uc19zdXBwKQogICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBefgoKVGhhdCBzYWlkLCBJIGRvbid0IG1pbmQgdGhlIGNvbmNlcHQsIHRob3VnaCBJ
IHJlY2FsbCBDaHJpc3RvcGggaGFkCmNvbmNlcm5zIGFib3V0IHRoZSBleGlzdGluZyAwLWNhcGFj
aXR5IG5hbWVzcGFjZSB1c2VkIGZvciBpbnZhbGlkCmZvcm1hdHMsIHNvIEknZCBsaWtlIHRvIGhl
YXIgbW9yZSBvbiB0aGF0IGlmIGhlIGhhcyBzb21lIHNwYXJlIHRpbWUgdG8KY29tbWVudC4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUg
bWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
