Return-Path: <SRS0=8cAR=IF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6D6C433DB
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Mar 2021 15:00:41 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3E7064FF0
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Mar 2021 15:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E7064FF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tTs184vAeYBWu/yW1M3Agx6onHJsxeasHBdT7oRXWjQ=; b=PBq5GgNaLJfPW/DvO3pHq1tcs
	3OvBN32+ZGzwQIOrqzyl0qB6KkP9kdm8C0kkXwxyiIhOhs8lmpLKoRYhB4YHkrXAPQ4o9APYbt3p4
	dQCISXat+D5psoblnsm5yqG8vzDd2R27flokmQd6n4rwlZL36A+W/cWSLd/Y0NacZlg9IsZbeBglz
	o7NTgttTKBBKOAmNiyESqW/CukCmovfNTwqSyJd9h5CK01CjKQlPbeGDYo9uG5/mRiRb+kxhYgkc3
	FCpQ3YaJAXvNSV12v5K2+cwTBgIU/+5jGlnknvOVD1kOt2BxVCPzkl1yjFFK1aGu+WaQr1I99JB7f
	UPKkNgxnw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIutQ-00AZXO-Gp; Sun, 07 Mar 2021 15:00:28 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIutK-00AZTj-4h
 for linux-nvme@lists.infradead.org; Sun, 07 Mar 2021 15:00:24 +0000
Received: by mail-ed1-x531.google.com with SMTP id bd6so10825010edb.10
 for <linux-nvme@lists.infradead.org>; Sun, 07 Mar 2021 07:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=tK3D7yjk9Hj3Ps1I1v43ujhrrVGQwWkl1RCv5uCMAHQ=;
 b=bspNffffsnVhQBnQUMPaI3cCZPkTCXb8hcB8RzDjVP63YK3mGqzCyDUipFuNESZ0BT
 zyDh6f7zz94zKDq0qTRFj+U7Gx25X22u3VXi70IXEMWFC/joRDQzDkuGE/yFHTF5LK0G
 rUlSBB34D6ZuIbfCQmR9Rb7/GB6oBCQNTO+CfoVC4cgNL8U/icP9/4VUrxXuAP8YWySp
 d2DSRR69g5ztE7ENaM4Itdydc1SyxER823J2+9sFP9tmY+CdrRB7IRrjm8JKhHaWs0tK
 3CnF5/G5IB6C0ESLTZSu8RPDMYOnG7m93ItlIJ8NAHQak6UVkJim3FppzoVNpNM/bNB2
 VwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=tK3D7yjk9Hj3Ps1I1v43ujhrrVGQwWkl1RCv5uCMAHQ=;
 b=Hn8gh3ln+9vGFOfNCgRPSbKa4bNxK3arspBrZJD14yHj6KFcmLYS4OUFU5eHs6mQcb
 dQqNdZ/Y+5BdzHKaQP7utUzJJq9P6z9WAYsQXHqa4Ceb5De2sMHhAeJMiRCwYVC6Teyg
 hIUspzEQafz3HdYf/EiMOkBffej/4v/88QOj+58nf6ISlOp9E26znOFBHrI3aqugzm+/
 DCHKzqhAfs3Ys19tYIJ/2/FJLtO+MzfQ8FEP56s3VkWRdZCebI8kKXtL0Qjt+dC7IY5l
 dawyYUhEuneOqe+z6JF2GQo7WVefhkp7uV3jkvs4BHMa0KvgvhLybZ0LBdiOsAbjhiTZ
 8Lgg==
X-Gm-Message-State: AOAM532EswbzC139f1x7x9cT+6+c9Pl5DCS42Tiy4zhH2Z3553BlwLXI
 wvxBMAUE2TtXHctpku5EI8o=
X-Google-Smtp-Source: ABdhPJzI0+1FOr6rWPD9DIJ0k7fn0QFArC8QJEQ6604yTyFxtXl0WI89GnWCXXOpg5b058I8maQwoA==
X-Received: by 2002:a05:6402:c0f:: with SMTP id
 co15mr17775180edb.373.1615129217591; 
 Sun, 07 Mar 2021 07:00:17 -0800 (PST)
Received: from [192.168.1.2] (host-87-242-23-58.prtelecom.hu. [87.242.23.58])
 by smtp.gmail.com with ESMTPSA id
 m7sm5209000ejk.52.2021.03.07.07.00.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Mar 2021 07:00:16 -0800 (PST)
Subject: Re: [PATCH AUTOSEL 5.11 09/12] nvme-pci: mark Kingston SKC2000 as not
 supporting the deepest power state
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210307135746.967418-1-sashal@kernel.org>
 <20210307135746.967418-9-sashal@kernel.org>
From: =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@gmail.com>
Message-ID: <6333d353-25c2-2cd3-e0c8-0dd39e31bfcd@gmail.com>
Date: Sun, 7 Mar 2021 16:00:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210307135746.967418-9-sashal@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210307_150022_368650_F5C76174 
X-CRM114-Status: GOOD (  20.80  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGksCgoyMDIxLiAwMy4gMDcuIDE0OjU3IGtlbHRlesOpc3NlbCwgU2FzaGEgTGV2aW4gw61ydGE6
Cj4gRnJvbTogWm9sdMOhbiBCw7ZzesO2cm3DqW55aSA8emJvc3pvckBnbWFpbC5jb20+Cj4KPiBb
IFVwc3RyZWFtIGNvbW1pdCBkYzIyYzFjMDU4YjVjNGZlOTY3YTIwNTg5ZTM2ZjAyOWVlNDJhNzA2
IF0KPgo+IE15IDJUQiBTS0MyMDAwIHNob3dlZCB0aGUgZXhhY3Qgc2FtZSBzeW1wdG9tcyB0aGF0
IHdlcmUgcHJvdmlkZWQKPiBpbiA1MzhlNGE4YzU3ICgibnZtZS1wY2k6IGF2b2lkIHRoZSBkZWVw
ZXN0IHNsZWVwIHN0YXRlIG9uCj4gS2luZ3N0b24gQTIwMDAgU1NEcyIpLCBpLmUuIGEgY29tcGxl
dGUgTlZNRSBsb2NrdXAgdGhhdCBuZWVkZWQKPiBjb2xkIGJvb3QgdG8gZ2V0IGl0IGJhY2suCj4K
PiBBY2NvcmRpbmcgdG8gc29tZSBzb3VyY2VzLCB0aGUgQTIwMDAgaXMgc2ltcGx5IGEgcmViYWRn
ZWQKPiBTS0MyMDAwIHdpdGggYSBzbGlnaHRseSBvcHRpbWl6ZWQgZmlybXdhcmUuCj4KPiBBZGRp
bmcgdGhlIFNLQzIwMDAgUENJIElEIHRvIHRoZSBxdWlyayBsaXN0IHdpdGggdGhlIHNhbWUgd29y
a2Fyb3VuZAo+IGFzIHRoZSBBMjAwMCBtYWRlIG15IGxhcHRvcCBzdXJ2aXZlIGEgNSBob3VycyBs
b25nIFlvY3RvIGJvb3RzdHJhcAo+IGJ1aWxkZmVzdCB3aGljaCByZWxpYWJseSB0cmlnZ2VyZWQg
dGhlIFNTRCBsb2NrdXAgcHJldmlvdXNseS4KPgo+IFNpZ25lZC1vZmYtYnk6IFpvbHTDoW4gQsO2
c3rDtnJtw6lueWkgPHpib3N6b3JAZ21haWwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9w
aCBIZWxsd2lnIDxoY2hAbHN0LmRlPgo+IFNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxzYXNo
YWxAa2VybmVsLm9yZz4KClRoYW5rcyBmb3IgcGlja2luZyBpdCB1cCBmb3Igc3RhYmxlLgoKTWF5
IEkgc3VnZ2VzdCB0byBpbmNsdWRlIGl0IGluIDUuMTAueCBhcyB3ZWxsPwpPcmlnaW5hbGx5IHRo
aXMgcGF0Y2ggd2FzIHRlc3RlZCBvbiA1LjEwLjE3LgoKQmVzdCByZWdhcmRzLApab2x0w6FuIELD
tnN6w7ZybcOpbnlpCgo+IC0tLQo+ICAgZHJpdmVycy9udm1lL2hvc3QvcGNpLmMgfCAyICsrCj4g
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9udm1lL2hvc3QvcGNpLmMgYi9kcml2ZXJzL252bWUvaG9zdC9wY2kuYwo+IGluZGV4IDdhMzhk
NzY0YjQ4Ni4uMTRjNWI1MjQwMGVmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3Bj
aS5jCj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMKPiBAQCAtMzI2Miw2ICszMjYyLDgg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkIG52bWVfaWRfdGFibGVbXSA9IHsK
PiAgIAkJLmRyaXZlcl9kYXRhID0gTlZNRV9RVUlSS19ESVNBQkxFX1dSSVRFX1pFUk9FUywgfSwK
PiAgIAl7IFBDSV9ERVZJQ0UoMHgxZDk3LCAweDIyNjMpLCAgIC8qIFNQQ0MgKi8KPiAgIAkJLmRy
aXZlcl9kYXRhID0gTlZNRV9RVUlSS19ESVNBQkxFX1dSSVRFX1pFUk9FUywgfSwKPiArCXsgUENJ
X0RFVklDRSgweDI2NDYsIDB4MjI2MiksICAgLyogS0lOR1NUT04gU0tDMjAwMCBOVk1lIFNTRCAq
Lwo+ICsJCS5kcml2ZXJfZGF0YSA9IE5WTUVfUVVJUktfTk9fREVFUEVTVF9QUywgfSwKPiAgIAl7
IFBDSV9ERVZJQ0UoMHgyNjQ2LCAweDIyNjMpLCAgIC8qIEtJTkdTVE9OIEEyMDAwIE5WTWUgU1NE
ICAqLwo+ICAgCQkuZHJpdmVyX2RhdGEgPSBOVk1FX1FVSVJLX05PX0RFRVBFU1RfUFMsIH0sCj4g
ICAJeyBQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURfQVBQTEUsIDB4MjAwMSksCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5n
IGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
