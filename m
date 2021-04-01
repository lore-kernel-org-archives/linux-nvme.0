Return-Path: <SRS0=sXsN=I6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0928C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 02:05:51 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49DF361004
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 02:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49DF361004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HfJWfCu7knYSNB3M1Q4c9fBh/WmbLCEahtXzeepg7dg=; b=YZ0D4DU8WRoF2cUCiJhIvibWG
	E2e4uIEYLJJ/cBPWvOc2T8InYmxLsUhiP6CjRp2I8skw5FFAKO5NzaKFwknmWPRAnhnt7rfHrftH1
	Sbwvemp2qXqSRfV2FK3CAKnUE5cJuaVKXIRqFg+wlbfJW/Z+hOBsIz4rR5fMe7YUVjRpmm7Uh1wYH
	R8MDdQk/Od4ewuS9+1g8ymnrPhKBgESF5PPpUgmF0rFd4mDGgclYGeNiuWAIY46Xf/fyXfgKtASXK
	Ecr3ZATRKZRV16MuaLw8beR+9Oo+653/xnlyXstrwldUcKLiwKRMpNAKqd3lefTaZznJ4hhyMJBEp
	sTsXBqPKw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRmiG-008BUp-Mm; Thu, 01 Apr 2021 02:05:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRmiC-008BSz-OP
 for linux-nvme@lists.infradead.org; Thu, 01 Apr 2021 02:05:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617242730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2FAhoIqigBZ/82IURJIPE2tNAHFV2QV0PJ7JAv7Zjaw=;
 b=M7UNPH3GxwjkWi49bPwJj7juv3Fb78EvEr7AqRrFOXVXuwT6PbPVYdcGklesolKH9OPr1e
 sCemrux49S/H4WCnsRuO36VXwiqvlKbQbDPTNt+M3TG3+J60d4Hd/HaXXPncW9gCMdsnHL
 wTc1E9QozdnevBP4+npb6Ufhp+jYU8k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-4yI5mHtrNnCOkZwo4DmHfw-1; Wed, 31 Mar 2021 22:05:25 -0400
X-MC-Unique: 4yI5mHtrNnCOkZwo4DmHfw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8648801817;
 Thu,  1 Apr 2021 02:05:24 +0000 (UTC)
Received: from [10.72.12.75] (ovpn-12-75.pek2.redhat.com [10.72.12.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D7A15D9CC;
 Thu,  1 Apr 2021 02:05:20 +0000 (UTC)
Subject: Re: [bisected] bfq regression on latest linux-block/for-next
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: linux-block <linux-block@vger.kernel.org>,
 "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <1366443410.1203736.1617240454513.JavaMail.zimbra@redhat.com>
 <DM6PR04MB4972E4D2857500F644758516867B9@DM6PR04MB4972.namprd04.prod.outlook.com>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <11b824c1-f2d2-db35-c072-d81ef348ede7@redhat.com>
Date: Thu, 1 Apr 2021 10:05:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB4972E4D2857500F644758516867B9@DM6PR04MB4972.namprd04.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210401_030533_246335_15158FA7 
X-CRM114-Status: GOOD (  16.57  )
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

CgpPbiA0LzEvMjEgOTo1NSBBTSwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOgo+IFlpLAo+Cj4g
T24gMy8zMS8yMSAxODoyOCwgWWkgWmhhbmcgd3JvdGU6Cj4+IEhpCj4+IFdlIHJlcHJvZHVjZWQg
dGhpcyBiZnEgcmVncmVzc2lvblszXSBvbiBwcGM2NGxlIHdpdGggYmxrdGVzdHNbMl0gb24gdGhl
IGxhdGVzdCBsaW51eC1ibG9jay9mb3ItbmV4dCBicmFuY2gsIHNlZW1zIGl0IHdhcyBpbnRyb2R1
Y2VkIHdpdGggWzFdIGZyb20gbXkgYmlzZWN0aW5nLCBwbHMgaGVscCBjaGVjayBpdC4gTGV0IG1l
IGtub3cgaWYgeW91IG5lZWQgYW55IHRlc3RpbmcgZm9yIGl0LCB0aGFua3MuCj4+Cj4+IFsxXQo+
PiBjb21taXQgNDMwYTY3ZjlkNjE2OWE3YjNlMzI4YmNlYjJlZjk1NDJlNDE1M2M3YyAoSEVBRCwg
cmVmcy9iaXNlY3QvYmFkKQo+PiBBdXRob3I6IFBhb2xvIFZhbGVudGUgPHBhb2xvLnZhbGVudGVA
bGluYXJvLm9yZz4KPj4gRGF0ZTogICBUaHUgTWFyIDQgMTg6NDY6MjcgMjAyMSArMDEwMAo+Pgo+
PiAgICAgIGJsb2NrLCBiZnE6IG1lcmdlIGJ1cnN0cyBvZiBuZXdseS1jcmVhdGVkIHF1ZXVlcwo+
Pgo+PiBbMl0gYmxrdGVzdHM6IG52bWVfdHJ0eXBlPXRjcCAuL2NoZWNrIG52bWUvMDExCj4+Cj4+
Cj4gKyBsaW51eC1udm1lCj4KPiBQbGVhc2UgYWRkIGxpbnV4LW52bWUgbWFpbGluZyBsaXN0IGZy
b20gbmV4dCB0aW1lIGZvciBibGt0ZXN0cwo+IG52bWVjYXRlZ29yeSB0bwo+IGdldCBiZXR0ZXIg
cmVzcG9uc2UuCj4KVGhhbmtzIGZvciByZW1pbmRlciwgaGVyZSBpcyBhbm90aGVyIGxvZyBmcm9t
IHg4Nl82NDoKaHR0cHM6Ly9hcnItY2tpLXByb2QtZGF0YXdhcmVob3VzZS1wdWJsaWMuczMuYW1h
em9uYXdzLmNvbS9kYXRhd2FyZWhvdXNlLXB1YmxpYy8yMDIxLzAzLzMxLzYyNzkzOC9idWlsZF94
ODZfNjRfcmVkaGF0JTNBMTEzNTcyNi90ZXN0cy85Nzg4ODg0X3g4Nl82NF8yX2NvbnNvbGUubG9n
CgpbMTg3ODYuNTY2MTQxXSBydW4gYmxrdGVzdHMgbnZtZS8wMTEgYXQgMjAyMS0wMy0zMSAwNTox
NDo0OQpbMTg3ODYuNjI4MTMwXSBudm1ldDogYWRkaW5nIG5zaWQgMSB0byBzdWJzeXN0ZW0gYmxr
dGVzdHMtc3Vic3lzdGVtLTEKWzE4Nzg2LjY2NTU0M10gbnZtZXRfdGNwOiBlbmFibGluZyBwb3J0
IDAgKDEyNy4wLjAuMTo0NDIwKQpbMTg3ODYuNjk5MjMwXSBudm1ldDogY3JlYXRpbmcgY29udHJv
bGxlciAxIGZvciBzdWJzeXN0ZW0gCmJsa3Rlc3RzLXN1YnN5c3RlbS0xIGZvciBOUU4gCm5xbi4y
MDE0LTA4Lm9yZy5udm1leHByZXNzOnV1aWQ6ZWZiNmI4YTUyMGQ3NGQ2YzgxOTNiNGNkZmNmNGVk
MjcuClsxODc4Ni43NjgxOTZdIG52bWUgbnZtZTA6IGNyZWF0aW5nIDMyIEkvTyBxdWV1ZXMuClsx
ODc4Ni43OTQ4OTBdIG52bWUgbnZtZTA6IG1hcHBlZCAzMi8wLzAgZGVmYXVsdC9yZWFkL3BvbGwg
cXVldWVzLgpbMTg3ODYuODM4MDk5XSBudm1lIG52bWUwOiBuZXcgY3RybDogTlFOICJibGt0ZXN0
cy1zdWJzeXN0ZW0tMSIsIGFkZHIgCjEyNy4wLjAuMTo0NDIwClstLSBNQVJLIC0tIFdlZCBNYXIg
MzEgMDk6MTU6MDAgMjAyMV0KWzE4ODA1LjQ2MTY3Nl0gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBd
LS0tLS0tLS0tLS0tClsxODgwNS40ODYzMTNdIGtlcm5lbCBCVUcgYXQgbW0vc2x1Yi5jOjMxNCEK
WzE4ODA1LjUwNjA0NF0gaW52YWxpZCBvcGNvZGU6IDAwMDAgWyMxXSBTTVAgUFRJClsxODgwNS41
MjgxMDRdIENQVTogMzEgUElEOiAzMjIgQ29tbToga3dvcmtlci8zMToxSCBUYWludGVkOiBHwqDC
oMKgwqDCoMKgwqDCoMKgIApJwqDCoMKgwqDCoMKgIDUuMTIuMC1yYzUgIzEKWzE4ODA1LjU3MDMw
N10gSGFyZHdhcmUgbmFtZTogSFAgUHJvTGlhbnQgREwzODBlIEdlbjgsIEJJT1MgUDczIDA4LzIw
LzIwMTIKWzE4ODA1LjYwNDczNV0gV29ya3F1ZXVlOiBudm1ldF90Y3Bfd3EgbnZtZXRfdGNwX2lv
X3dvcmsgW252bWV0X3RjcF0KWzE4ODA1LjYzNTY3MV0gUklQOiAwMDEwOmttZW1fY2FjaGVfZnJl
ZSsweDQwZC8weDQ0MApbMTg4MDUuNjYwOTA1XSBDb2RlOiAwMCAwMCAwMCBlOSAxYyBmZiBmZiBm
ZiA0YyA4YiAwYyAyNCA0OCA4YiA0YyAyNCAwOCAKNDggODkgZGEgNDggODkgZWUgNDEgYjggMDEg
MDAgMDAgMDAgNGMgODkgZjcgZTggOTggYzUgZmYgZmYgZTkgYzAgZmQgZmYgCmZmIDwwZj4gMGIg
NDggYzcgYzYgNzggYzQgM2MgOTAgNGMgODkgZmYgZTggYTIgNjggZmEgZmYgMGYgMGIgNDggOGIg
MDUKWzE4ODA1Ljc1NTczNV0gUlNQOiAwMDE4OmZmZmZhZTEwMDIzZWJhNjggRUZMQUdTOiAwMDAx
MDA0NgpbMTg4MDUuNzgzMTU1XSBSQVg6IGZmZmY5MDk5OTFjNGU3NjAgUkJYOiBmZmZmOTA5OTkx
YzRlNzYwIFJDWDogCmZmZmY5MDk5OTFjNGU4NzgKWzE4ODA1LjgxOTAxNl0gUkRYOiAwMDAwMDAw
MDAwMDAwOGM0IFJTSTogMDAwMDAwMDAwMDAwMDAwMCBSREk6IApmZmZmOTA5OTkxYzRlNzYwClsx
ODgwNS44NTU4NThdIFJCUDogZmZmZmY3ZGQ0OTQ3MTMwMCBSMDg6IGZmZmY5MDk5ODY4OGJhNDgg
UjA5OiAKZmZmZmFlMTAwMjNlYmFiYgpbMTg4MDUuODkxNzUwXSBSMTA6IGZmZmY5MDk5OTFjNGU3
NjAgUjExOiAwMDAwMDAwMDAwMDAxMDAwIFIxMjogCmZmZmY5MDk5OTFjNGU3NjAKWzE4ODA1Ljkz
MDcyMV0gUjEzOiAwMDAwMDAwMDAwMDAwMDAwIFIxNDogZmZmZjkwOTg0NGViOTMwMCBSMTU6IApm
ZmZmZjdkZDQ5NDcxMzAwClsxODgwNS45Njk5MDNdIEZTOsKgIDAwMDAwMDAwMDAwMDAwMDAoMDAw
MCkgR1M6ZmZmZjkwOWI3NzdjMDAwMCgwMDAwKSAKa25sR1M6MDAwMDAwMDAwMDAwMDAwMApbMTg4
MDYuMDExMjc4XSBDUzrCoCAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1
MDAzMwpbMTg4MDYuMDQxMDE4XSBDUjI6IDAwMDA1NTg4M2QyZWIwMTggQ1IzOiAwMDAwMDAwMjU1
YjdjMDAxIENSNDogCjAwMDAwMDAwMDAwNjA2ZTAKWzE4ODA2LjA3NzE0M10gQ2FsbCBUcmFjZToK
WzE4ODA2LjA5MDc0OF3CoCA/IGJmcV9wdXRfcXVldWUrMHgxNTYvMHgyODAKWzE4ODA2LjExMDMw
Ml3CoCBiZnFfcHV0X3F1ZXVlKzB4MTU2LzB4MjgwClsxODgwNi4xMjkxNDddwqAgYmZxX2luc2Vy
dF9yZXF1ZXN0cysweDE4Mi8weDE2MTAKWzE4ODA2LjE1MzQ3OF3CoCA/IGlvbWFwX2FwcGx5KzB4
ZjEvMHgyYjAKWzE4ODA2LjE3MTU2Ml3CoCBibGtfbXFfc2NoZWRfaW5zZXJ0X3JlcXVlc3RzKzB4
NWQvMHhlMApbMTg4MDYuMTk1OTc2XcKgIGJsa19tcV9mbHVzaF9wbHVnX2xpc3QrMHhmMC8weDE3
MApbMTg4MDYuMjE5NjA5XcKgIGJsa19maW5pc2hfcGx1ZysweDM2LzB4NTAKWzE4ODA2LjIzODE4
Nl3CoCBfX2lvbWFwX2Rpb19ydysweDNmZi8weDRjMApbMTg4MDYuMjU3NjA3XcKgIGlvbWFwX2Rp
b19ydysweGEvMHgzMApbMTg4MDYuMjc1NjYxXcKgIHhmc19maWxlX2Rpb193cml0ZV9hbGlnbmVk
KzB4ODYvMHgxMTAgW3hmc10KWzE4ODA2LjMwMjQwMl3CoCA/IHhmc19maWxlX2J1ZmZlcmVkX3dy
aXRlKzB4MjgwLzB4MjgwIFt4ZnNdClsxODgwNi4zMjk4MDNdwqAgeGZzX2ZpbGVfd3JpdGVfaXRl
cisweGM4LzB4MTEwIFt4ZnNdClsxODgwNi4zNTQ0MjZdwqAgbnZtZXRfZmlsZV9zdWJtaXRfYnZl
YysweGMzLzB4MTAwIFtudm1ldF0KWzE4ODA2LjM4MDIwMV3CoCBudm1ldF9maWxlX2V4ZWN1dGVf
aW8rMHgxZjgvMHgyNDAgW252bWV0XQpbMTg4MDYuNDA3MzEyXcKgIG52bWV0X3RjcF9pb193b3Jr
KzB4YmQzLzB4YzE1IFtudm1ldF90Y3BdClsxODgwNi40MzQ1MDVdwqAgPyBzd2l0Y2hfbW1faXJx
c19vZmYrMHg1OC8weDQzMApbMTg4MDYuNDU2NDg1XcKgID8gX19zd2l0Y2hfdG9fYXNtKzB4NDIv
MHg3MApbMTg4MDYuNDc2OTA4XcKgID8gX19zd2l0Y2hfdG8rMHg3Yi8weDQ1MApbMTg4MDYuNDk0
OTA5XcKgIHByb2Nlc3Nfb25lX3dvcmsrMHgxZWMvMHgzODAKWzE4ODA2LjUxNjUzNF3CoCB3b3Jr
ZXJfdGhyZWFkKzB4NTMvMHgzZTAKWzE4ODA2LjUzNTk4Nl3CoCA/IHByb2Nlc3Nfb25lX3dvcmsr
MHgzODAvMHgzODAKWzE4ODA2LjU1NjY5Nl3CoCBrdGhyZWFkKzB4MTFiLzB4MTQwClsxODgwNi41
NzMxOTFdwqAgPyBfX2t0aHJlYWRfYmluZF9tYXNrKzB4NjAvMHg2MApbMTg4MDYuNTk2MDQ4XcKg
IHJldF9mcm9tX2ZvcmsrMHgyMi8weDMwClsxODgwNi42MTM3ODhdIE1vZHVsZXMgbGlua2VkIGlu
OiBudm1lX3RjcCBudm1lX2ZhYnJpY3MgbnZtZXRfdGNwIG52bWV0IApudm1lIG52bWVfY29yZSBt
ZDQgY21hYyBubHNfdXRmOCBjaWZzIGxpYmFyYzQgbGliZGVzIGxvb3AgCnJwY3NlY19nc3Nfa3Ji
NSBuZnN2NCBkbnNfcmVzb2x2ZXIgbmZzIGZzY2FjaGUgbmZzZCBhdXRoX3JwY2dzcyBuZnNfYWNs
IApsb2NrZCBncmFjZSBuZnNfc3NjIGRtX2xvZ193cml0ZXMgZG1fZmxha2V5IHJma2lsbCBzdW5y
cGMgaVRDT193ZHQgCmludGVsX3JhcGxfbXNyIGludGVsX3BtY19ieHQgaVRDT192ZW5kb3Jfc3Vw
cG9ydCBpbnRlbF9yYXBsX2NvbW1vbiAKc2JfZWRhYyB4ODZfcGtnX3RlbXBfdGhlcm1hbCBpbnRl
bF9wb3dlcmNsYW1wIGNvcmV0ZW1wIGt2bV9pbnRlbCBrdm0gCmlycWJ5cGFzcyByYXBsIGludGVs
X2NzdGF0ZSBpbnRlbF91bmNvcmUgcGNzcGtyIGlwbWlfc3NpZiBscGNfaWNoIAphY3BpX2lwbWkg
aHBpbG8gaXBtaV9zaSBocHdkdCBpcG1pX2RldmludGYgaW9hdGRtYSBpZ2IgaXBtaV9tc2doYW5k
bGVyIAphY3BpX3Bvd2VyX21ldGVyIGRjYSBmdXNlIHpyYW0gaXBfdGFibGVzIHhmcyBjcmN0MTBk
aWZfcGNsbXVsIApjcmMzMl9wY2xtdWwgbWdhZzIwMCBjcmMzMmNfaW50ZWwgZHJtX2ttc19oZWxw
ZXIgZ2hhc2hfY2xtdWxuaV9pbnRlbCBjZWMgCnNlcmlvX3JhdyBkcm0gaTJjX2FsZ29fYml0IFts
YXN0IHVubG9hZGVkOiBudm1ldF0KWzE4ODA2LjkzNzI5MV0gLS0tWyBlbmQgdHJhY2UgZTE0MDlj
YWVlNzkyN2FmOCBdLS0tCj4KPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LW52bWUK
