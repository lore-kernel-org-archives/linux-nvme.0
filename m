Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4C4C433E6
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 11:13:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DB0623A3B
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 11:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB0623A3B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jF6P2L5Zk7C4T8ZZZGcK4PWOtAyBI9TzHKav1ow1rbA=; b=dJwRvfXjSb3FpH88w4bLJYEDe
	a8pTGWeljiLB2lHUm4UEmhbT08cHvLubt0UJLTznnWDGKat+HUZp017QnigE315HVkZTEPbnqLObU
	ob1kp4rSIY8L98yx8AFaroP2I5Pc4506PhA3Kxoni2MuCwu9nn+YnociJazcUqAvS82AXQ31cJZuQ
	JvPAAkIAv0TLYPWNBKMZfz14YOIDI2uXG1nY9DnuPwRKMe9n8QUif+mlsTTC7C4f0m5Vs40H/NPYd
	/VVtKwrDgnnP+MN9dvauezut1opcZvN/aO/CLUHTJd3ot+t/5jUrGD7/YxPgDtyMdyt36nxgcPdtm
	j4Zyrr89g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l00Ym-0006Nr-C7; Thu, 14 Jan 2021 11:13:00 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l00Yj-0006N6-7r
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 11:12:58 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 94BC0AA6F;
 Thu, 14 Jan 2021 11:12:54 +0000 (UTC)
Subject: Re: [PATCH 1/1] nvme: update enumerations for status codes
To: Max Gurtovoy <mgurtovoy@nvidia.com>, oren@nvidia.com,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, kbusch@kernel.org,
 hch@lst.de, chaitanya.kulkarni@wdc.com
References: <20210104125947.160984-1-mgurtovoy@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a6251b7c-e2aa-7967-2e20-2983905818a8@suse.de>
Date: Thu, 14 Jan 2021 12:12:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210104125947.160984-1-mgurtovoy@nvidia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_061257_410310_E493A41E 
X-CRM114-Status: GOOD (  18.75  )
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
Cc: israelr@nvidia.com, nitzanc@nvidia.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMS80LzIxIDE6NTkgUE0sIE1heCBHdXJ0b3ZveSB3cm90ZToKPiBBbGwgdGhlIHVwZGF0ZXMg
YXJlIG1lbnRpb25lZCBpbiB0aGUgcmF0aWZpZWQgTlZNZSAxLjQgc3BlYy4KPiAKPiBTaWduZWQt
b2ZmLWJ5OiBNYXggR3VydG92b3kgPG1ndXJ0b3ZveUBudmlkaWEuY29tPgo+IC0tLQo+ICAgaW5j
bHVkZS9saW51eC9udm1lLmggfCAyNCArKysrKysrKysrKysrKysrKysrKy0tLS0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L252bWUuaCBiL2luY2x1ZGUvbGludXgvbnZtZS5oCj4gaW5kZXgg
ZDkyNTM1OTk3Njg3Li4xYzljMzRiZTgxOTQgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC9u
dm1lLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L252bWUuaAo+IEBAIC0xNDY3LDIwICsxNDY3LDI5
IEBAIGVudW0gewo+ICAgCU5WTUVfU0NfU0dMX0lOVkFMSURfREFUQQk9IDB4ZiwKPiAgIAlOVk1F
X1NDX1NHTF9JTlZBTElEX01FVEFEQVRBCT0gMHgxMCwKPiAgIAlOVk1FX1NDX1NHTF9JTlZBTElE
X1RZUEUJPSAweDExLAo+IC0KPiArCU5WTUVfU0NfQ01CX0lOVkFMSURfVVNFCQk9IDB4MTIsCj4g
KwlOVk1FX1NDX1BSUF9JTlZBTElEX09GRlNFVAk9IDB4MTMsCj4gKwlOVk1FX1NDX0FUT01JQ19X
VV9FWENFRURFRAk9IDB4MTQsCj4gKwlOVk1FX1NDX09QX0RFTklFRAkJPSAweDE1LAo+ICAgCU5W
TUVfU0NfU0dMX0lOVkFMSURfT0ZGU0VUCT0gMHgxNiwKPiAtCU5WTUVfU0NfU0dMX0lOVkFMSURf
U1VCVFlQRQk9IDB4MTcsCj4gLQo+ICsJTlZNRV9TQ19SRVNFUlZFRAkJPSAweDE3LAo+ICsJTlZN
RV9TQ19IT1NUX0lEX0lOQ09OU0lTVAk9IDB4MTgsCj4gKwlOVk1FX1NDX0tBX1RJTUVPVVRfRVhQ
SVJFRAk9IDB4MTksCj4gKwlOVk1FX1NDX0tBX1RJTUVPVVRfSU5WQUxJRAk9IDB4MUEsCj4gKwlO
Vk1FX1NDX0FCT1JURURfUFJFRU1QVF9BQk9SVAk9IDB4MUIsCj4gICAJTlZNRV9TQ19TQU5JVEla
RV9GQUlMRUQJCT0gMHgxQywKPiAgIAlOVk1FX1NDX1NBTklUSVpFX0lOX1BST0dSRVNTCT0gMHgx
RCwKPiAtCj4gKwlOVk1FX1NDX1NHTF9JTlZBTElEX0dSQU5VTEFSSVRZCT0gMHgxRSwKPiArCU5W
TUVfU0NfQ01EX05PVF9TVVBfQ01CX1FVRVVFCT0gMHgxRiwKPiAgIAlOVk1FX1NDX05TX1dSSVRF
X1BST1RFQ1RFRAk9IDB4MjAsCj4gICAJTlZNRV9TQ19DTURfSU5URVJSVVBURUQJCT0gMHgyMSwK
PiArCU5WTUVfU0NfVFJBTlNJRU5UX1RSX0VSUgk9IDB4MjIsCj4gICAKPiAgIAlOVk1FX1NDX0xC
QV9SQU5HRQkJPSAweDgwLAo+ICAgCU5WTUVfU0NfQ0FQX0VYQ0VFREVECQk9IDB4ODEsCj4gICAJ
TlZNRV9TQ19OU19OT1RfUkVBRFkJCT0gMHg4MiwKPiAgIAlOVk1FX1NDX1JFU0VSVkFUSU9OX0NP
TkZMSUNUCT0gMHg4MywKPiArCU5WTUVfU0NfRk9STUFUX0lOX1BST0dSRVNTCT0gMHg4NCwKPiAg
IAo+ICAgCS8qCj4gICAJICogQ29tbWFuZCBTcGVjaWZpYyBTdGF0dXM6Cj4gQEAgLTE1MTMsOCAr
MTUyMiwxNSBAQCBlbnVtIHsKPiAgIAlOVk1FX1NDX05TX05PVF9BVFRBQ0hFRAkJPSAweDExYSwK
PiAgIAlOVk1FX1NDX1RISU5fUFJPVl9OT1RfU1VQUAk9IDB4MTFiLAo+ICAgCU5WTUVfU0NfQ1RS
TF9MSVNUX0lOVkFMSUQJPSAweDExYywKPiArCU5WTUVfU0NfU0VMVF9URVNUX0lOX1BST0dSRVNT
CT0gMHgxMWQsCj4gICAJTlZNRV9TQ19CUF9XUklURV9QUk9ISUJJVEVECT0gMHgxMWUsCj4gKwlO
Vk1FX1NDX0NUUkxfSURfSU5WQUxJRAkJPSAweDExZiwKPiArCU5WTUVfU0NfU0VDX0NUUkxfU1RB
VEVfSU5WQUxJRAk9IDB4MTIwLAo+ICsJTlZNRV9TQ19DVFJMX1JFU19OVU1fSU5WQUxJRAk9IDB4
MTIxLAo+ICsJTlZNRV9TQ19SRVNfSURfSU5WQUxJRAkJPSAweDEyMiwKPiAgIAlOVk1FX1NDX1BN
Ul9TQU5fUFJPSElCSVRFRAk9IDB4MTIzLAo+ICsJTlZNRV9TQ19BTkFfR1JPVVBfSURfSU5WQUxJ
RAk9IDB4MTI0LAo+ICsJTlZNRV9TQ19BTkFfQVRUQUNIX0ZBSUxFRAk9IDB4MTI1LAo+ICAgCj4g
ICAJLyoKPiAgIAkgKiBJL08gQ29tbWFuZCBTZXQgU3BlY2lmaWMgLSBOVk0gY29tbWFuZHM6Cj4g
ClJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KCkNoZWVycywKCkhh
bm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFn
ZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5
IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4g
NSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bD
vGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtbnZtZQo=
