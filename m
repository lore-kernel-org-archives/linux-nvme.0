Return-Path: <SRS0=DDko=AE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B397C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 23:20:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 398602078E
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 23:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L/iDFX46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 398602078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Z00xToe7yjdUgktPyuPqT1AV0GadYb+BiLPNEuevUzE=; b=L/iDFX46OIiL87GsQBDQSTzAZ
	xAP1TcHaMrk2AV2irnGjmsZb2GMse9BZpkj5m6vxGdb0DvIQKvf9JAVL5x1nLLCOq0pvYLqDELGof
	8ICkm7g2X5aWLvQgiJ0cyRdPw0EQ2qTiF5N1VpXzH3uqYsMH7r7km3FjQAZTB3N7oY/TkcrtQAkk7
	MXXQgz8gSeUT2jiDba06QyZXJKfuDzuwOo1jJgJldsIKUNT5nZt8CJ1jVYbNILOABbqSe5yCc4g1S
	pOvb7qnRGwaaRYrCj4slmowBGSK8/EVBkh4todyN8UPu7JPo07wQnVOF2bgDNOKK609Gl3DG7/EYi
	qvPxfmauw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnsDk-0000iV-UJ; Tue, 23 Jun 2020 23:20:52 +0000
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnsDi-0000iF-2W
 for linux-nvme@lists.infradead.org; Tue, 23 Jun 2020 23:20:51 +0000
Received: by mail-pf1-f194.google.com with SMTP id d66so158072pfd.6
 for <linux-nvme@lists.infradead.org>; Tue, 23 Jun 2020 16:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OqXkQ4Twvc1EPv01H29N9//f6s8wcZ8KXM2PMqYzUEA=;
 b=OvVpJLiEO/KC+MaZcF4wkrZ4Bg6G68RPV5QN7TcDNJ9Biei9NAL8OtKmt9HVWjaO6r
 nHsjrf82Z14BKffh1JqmA+P2sKx2SNmQX+YOLL4zcaMb9HLuKQIdN36AW3gTFF+8lSb8
 Qqrp5QFosdGGOdWUiRVVfTFxBiVEHBkkeJFBKrgwFp8yQX2Ln7ZC4ZWGoNMx+IYAKJoO
 rW7sFQrvSjqjyLtvVWz/tooEEM75mZpGlno1fEQ0fdnVxRvY415O9ilpqJ4SN/7Xm2gt
 LsBIky6OEwPFo0YmPThrAbmS/Ixxz7y6qL85iGA5iPRemJp4wI3tbb1xOah/yukS+bXk
 ClDQ==
X-Gm-Message-State: AOAM5330p+tO3KpoLeos/LXZB81ztOKwzr7Z8JZCf2k8PgUqGfoWOyI4
 12zoNI1f+3RqDadDVuYBQQ8=
X-Google-Smtp-Source: ABdhPJwINS/umzo+fDugYGIdrS0In/qd/5CJL8VHmSddGJVYi9huohVi75DPxdOsPGbkCNjU6dnTlg==
X-Received: by 2002:a63:ef4e:: with SMTP id c14mr11936936pgk.259.1592954448897; 
 Tue, 23 Jun 2020 16:20:48 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:acd7:a900:b9f:8b8b?
 ([2601:647:4802:9070:acd7:a900:b9f:8b8b])
 by smtp.gmail.com with ESMTPSA id x8sm3843548pff.54.2020.06.23.16.20.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 16:20:48 -0700 (PDT)
Subject: Re: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set support
To: Niklas Cassel <Niklas.Cassel@wdc.com>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-4-kbusch@kernel.org>
 <69e8e88c-097b-368d-58f4-85d11110386d@grimberg.me>
 <20200623112551.GB117742@localhost.localdomain>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9c710c06-5be7-5aff-d919-883e19dfaa44@grimberg.me>
Date: Tue, 23 Jun 2020 16:20:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623112551.GB117742@localhost.localdomain>
Content-Language: en-US
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Daniel Wagner <dwagner@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
 "hch@lst.de" <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiA2LzIzLzIwIDQ6MjUgQU0sIE5pa2xhcyBDYXNzZWwgd3JvdGU6Cj4gT24gVHVlLCBKdW4g
MjMsIDIwMjAgYXQgMDE6NTM6NDdBTSAtMDcwMCwgU2FnaSBHcmltYmVyZyB3cm90ZToKPj4KPj4K
Pj4gT24gNi8yMi8yMCA5OjI1IEFNLCBLZWl0aCBCdXNjaCB3cm90ZToKPj4+IEZyb206IE5pa2xh
cyBDYXNzZWwgPG5pa2xhcy5jYXNzZWxAd2RjLmNvbT4KPj4+Cj4+PiBJbXBsZW1lbnRzIHN1cHBv
cnQgZm9yIHRoZSBJL08gQ29tbWFuZCBTZXRzIGNvbW1hbmQgc2V0LiBUaGUgY29tbWFuZCBzZXQK
Pj4+IGludHJvZHVjZXMgYSBtZXRob2QgdG8gZW51bWVyYXRlIG11bHRpcGxlIGNvbW1hbmQgc2V0
cyBwZXIgbmFtZXNwYWNlLiBJZgo+Pj4gdGhlIGNvbW1hbmQgc2V0IGlzIGV4cG9zZWQsIHRoaXMg
bWV0aG9kIGZvciBlbnVtZXJhdGlvbiB3aWxsIGJlIHVzZWQKPj4+IGluc3RlYWQgb2YgdGhlIHRy
YWRpdGlvbmFsIG1ldGhvZCB0aGF0IHVzZXMgdGhlIENDLkNTUyByZWdpc3RlciBjb21tYW5kCj4+
PiBzZXQgcmVnaXN0ZXIgZm9yIGNvbW1hbmQgc2V0IGlkZW50aWZpY2F0aW9uLgo+Pj4KPj4+IEZv
ciBuYW1lc3BhY2VzIHdoZXJlIHRoZSBDb21tYW5kIFNldCBJZGVudGlmaWVyIGlzIG5vdCBzdXBw
b3J0ZWQgb3IKPj4+IHJlY29nbml6ZWQsIHRoZSBzcGVjaWZpYyBuYW1lc3BhY2Ugd2lsbCBub3Qg
YmUgY3JlYXRlZC4KPj4+Cj4+PiBSZXZpZXdlZC1ieTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVy
LmdvbnpAc2Ftc3VuZy5jb20+Cj4+PiBSZXZpZXdlZC1ieTogTWFydGluIEsuIFBldGVyc2VuIDxt
YXJ0aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbT4KPj4+IFJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVt
c2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPgo+Pj4gUmV2aWV3ZWQtYnk6IE1hdGlh
cyBCasO4cmxpbmcgPG1hdGlhcy5iam9ybGluZ0B3ZGMuY29tPgo+Pj4gUmV2aWV3ZWQtYnk6IERh
bmllbCBXYWduZXIgPGR3YWduZXJAc3VzZS5kZT4KPj4+IFNpZ25lZC1vZmYtYnk6IE5pa2xhcyBD
YXNzZWwgPG5pa2xhcy5jYXNzZWxAd2RjLmNvbT4KPj4+IC0tLQo+Pj4gICAgZHJpdmVycy9udm1l
L2hvc3QvY29yZS5jIHwgNDggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LQo+Pj4gICAgZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oIHwgIDEgKwo+Pj4gICAgaW5jbHVkZS9s
aW51eC9udm1lLmggICAgIHwgMTkgKysrKysrKysrKysrKystLQo+Pj4gICAgMyBmaWxlcyBjaGFu
Z2VkLCA1OCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4+
PiBpbmRleCA5NDkxZGJjZmU4MWEuLjQ1YTNjYjVhMzViZCAxMDA2NDQKPj4+IC0tLSBhL2RyaXZl
cnMvbnZtZS9ob3N0L2NvcmUuYwo+Pj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4+
PiBAQCAtMTA1Niw4ICsxMDU2LDEzIEBAIHN0YXRpYyBpbnQgbnZtZV9pZGVudGlmeV9jdHJsKHN0
cnVjdCBudm1lX2N0cmwgKmRldiwgc3RydWN0IG52bWVfaWRfY3RybCAqKmlkKQo+Pj4gICAgCXJl
dHVybiBlcnJvcjsKPj4+ICAgIH0KPj4+ICtzdGF0aWMgYm9vbCBudm1lX211bHRpX2NzcyhzdHJ1
Y3QgbnZtZV9jdHJsICpjdHJsKQo+Pj4gK3sKPj4+ICsJcmV0dXJuIChjdHJsLT5jdHJsX2NvbmZp
ZyAmIE5WTUVfQ0NfQ1NTX01BU0spID09IE5WTUVfQ0NfQ1NTX0NTSTsKPj4+ICt9Cj4+PiArCj4+
PiAgICBzdGF0aWMgaW50IG52bWVfcHJvY2Vzc19uc19kZXNjKHN0cnVjdCBudm1lX2N0cmwgKmN0
cmwsIHN0cnVjdCBudm1lX25zX2lkcyAqaWRzLAo+Pj4gLQkJc3RydWN0IG52bWVfbnNfaWRfZGVz
YyAqY3VyKQo+Pj4gKwkJc3RydWN0IG52bWVfbnNfaWRfZGVzYyAqY3VyLCBib29sICpjc2lfc2Vl
bikKPj4+ICAgIHsKPj4+ICAgIAljb25zdCBjaGFyICp3YXJuX3N0ciA9ICJjdHJsIHJldHVybmVk
IGJvZ3VzIGxlbmd0aDoiOwo+Pj4gICAgCXZvaWQgKmRhdGEgPSBjdXI7Cj4+PiBAQCAtMTA4Nyw2
ICsxMDkyLDE1IEBAIHN0YXRpYyBpbnQgbnZtZV9wcm9jZXNzX25zX2Rlc2Moc3RydWN0IG52bWVf
Y3RybCAqY3RybCwgc3RydWN0IG52bWVfbnNfaWRzICppZHMsCj4+PiAgICAJCX0KPj4+ICAgIAkJ
dXVpZF9jb3B5KCZpZHMtPnV1aWQsIGRhdGEgKyBzaXplb2YoKmN1cikpOwo+Pj4gICAgCQlyZXR1
cm4gTlZNRV9OSURUX1VVSURfTEVOOwo+Pj4gKwljYXNlIE5WTUVfTklEVF9DU0k6Cj4+PiArCQlp
ZiAoY3VyLT5uaWRsICE9IE5WTUVfTklEVF9DU0lfTEVOKSB7Cj4+PiArCQkJZGV2X3dhcm4oY3Ry
bC0+ZGV2aWNlLCAiJXMgJWQgZm9yIE5WTUVfTklEVF9DU0lcbiIsCj4+PiArCQkJCSB3YXJuX3N0
ciwgY3VyLT5uaWRsKTsKPj4+ICsJCQlyZXR1cm4gLTE7Cj4+PiArCQl9Cj4+PiArCQltZW1jcHko
Jmlkcy0+Y3NpLCBkYXRhICsgc2l6ZW9mKCpjdXIpLCBOVk1FX05JRFRfQ1NJX0xFTik7Cj4+PiAr
CQkqY3NpX3NlZW4gPSB0cnVlOwo+Pj4gKwkJcmV0dXJuIE5WTUVfTklEVF9DU0lfTEVOOwo+Pj4g
ICAgCWRlZmF1bHQ6Cj4+PiAgICAJCS8qIFNraXAgdW5rbm93biB0eXBlcyAqLwo+Pj4gICAgCQly
ZXR1cm4gY3VyLT5uaWRsOwo+Pj4gQEAgLTEwOTcsMTAgKzExMTEsOSBAQCBzdGF0aWMgaW50IG52
bWVfaWRlbnRpZnlfbnNfZGVzY3Moc3RydWN0IG52bWVfY3RybCAqY3RybCwgdW5zaWduZWQgbnNp
ZCwKPj4+ICAgIAkJc3RydWN0IG52bWVfbnNfaWRzICppZHMpCj4+PiAgICB7Cj4+PiAgICAJc3Ry
dWN0IG52bWVfY29tbWFuZCBjID0geyB9Owo+Pj4gLQlpbnQgc3RhdHVzOwo+Pj4gKwlib29sIGNz
aV9zZWVuID0gZmFsc2U7Cj4+PiArCWludCBzdGF0dXMsIHBvcywgbGVuOwo+Pj4gICAgCXZvaWQg
KmRhdGE7Cj4+PiAtCWludCBwb3M7Cj4+PiAtCWludCBsZW47Cj4+PiAgICAJYy5pZGVudGlmeS5v
cGNvZGUgPSBudm1lX2FkbWluX2lkZW50aWZ5Owo+Pj4gICAgCWMuaWRlbnRpZnkubnNpZCA9IGNw
dV90b19sZTMyKG5zaWQpOwo+Pj4gQEAgLTExMzAsMTMgKzExNDMsMTkgQEAgc3RhdGljIGludCBu
dm1lX2lkZW50aWZ5X25zX2Rlc2NzKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsIHVuc2lnbmVkIG5z
aWQsCj4+PiAgICAJCWlmIChjdXItPm5pZGwgPT0gMCkKPj4+ICAgIAkJCWJyZWFrOwo+Pj4gLQkJ
bGVuID0gbnZtZV9wcm9jZXNzX25zX2Rlc2MoY3RybCwgaWRzLCBjdXIpOwo+Pj4gKwkJbGVuID0g
bnZtZV9wcm9jZXNzX25zX2Rlc2MoY3RybCwgaWRzLCBjdXIsICZjc2lfc2Vlbik7Cj4+PiAgICAJ
CWlmIChsZW4gPCAwKQo+Pj4gICAgCQkJZ290byBmcmVlX2RhdGE7Cj4+PiAgICAJCWxlbiArPSBz
aXplb2YoKmN1cik7Cj4+PiAgICAJfQo+Pj4gICAgZnJlZV9kYXRhOgo+Pj4gKwlpZiAoIXN0YXR1
cyAmJiBudm1lX211bHRpX2NzcyhjdHJsKSAmJiAhY3NpX3NlZW4pIHsKPj4KPj4gV2Ugd2lsbCBj
bGVhciB0aGUgc3RhdHVzIGlmIHdlIGRldGVjdCBhIHBhdGggZXJyb3IsIHRoYXQgaXMgdG8KPj4g
YXZvaWQgbmVlZGxlc3NseSByZW1vdmluZyB0aGUgbnMgZm9yIHBhdGggZmFpbHVyZXMsIHNvIHlv
dSBzaG91bGQKPj4gY2hlY2sgYXQgdGhlIGdvdG8gc2l0ZS4KPiAKPiBUaGUgcHJvYmxlbSBpcyB0
aGF0IHRoaXMgY2hlY2sgaGFzIHRvIGJlIGRvbmUgYWZ0ZXIgY2hlY2tpbmcgYWxsIHRoZSBucyBk
ZXNjcywKPiBzbyB0aGlzIGNoZWNrIHRvIGJlIGRvbmUgYXMgdGhlIGZpbmFsIHRoaW5nLCBhdCBs
ZWFzdCBhZnRlciBwcm9jZXNzaW5nIGFsbCB0aGUKPiBucyBkZXNjcy4gTm8gbWF0dGVyIGlmIG52
bWVfcHJvY2Vzc19uc19kZXNjKCkgcmV0dXJuZWQgYW4gZXJyb3IsIG9yIGlmCj4gc2ltcGx5IE5W
TUVfTklEVF9DU0kgd2Fzbid0IHBhcnQgb2YgdGhlIG5zIGRlc2MgbGlzdCwgc28gdGhlIGxvb3Ag
cmVhY2hlZCB0aGUKPiBlbmQgd2l0aG91dCBlcnJvci4KPiAKPiBFdmVuIGlmIHRoZSBudm1lIGNv
bW1hbmQgZmFpbGVkIGFuZCB0aGUgc3RhdHVzIHdhcyBjbGVhcmVkOgo+IAo+ICAgICAgICAgICAg
ICAgICAgaWYgKHN0YXR1cyA+IDAgJiYgIShzdGF0dXMgJiBOVk1FX1NDX0ROUikpCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgIHN0YXR1cyA9IDA7Cj4gCj4gd2Ugc3RpbGwgbmVlZCB0byByZXR1
cm4gYW4gZXJyb3IsIGlmIChudm1lX211bHRpX2NzcyhjdHJsKSAmJiAhY3NpX3NlZW4pLgo+IChO
b3QgcmVwb3J0aW5nIGEgQ1NJIHdoZW4gbnZtZV9tdWx0aV9jc3MoKSBpcyBlbmFibGVkLCBpcyBm
YXRhbC4pCj4gCj4gVGhhdCBpcyB3aHkgdGhlIGNvZGUgbG9va3MgbGlrZSBpdCBkb2VzLgo+IAo+
IEkgZ3Vlc3Mgd2UgY291bGQgZG8gc29tZXRoaW5nIGxpa2UgdGhpcywgd2hpY2ggZG9lcyB0aGUg
c2FtZSB0aGluZywKPiBidXQgcGVyaGFwcyBpcyBhIGJpdCBjbGVhcmVyOgo+IAo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMK
PiBpbmRleCBlOTVmMGM0OThhNmIuLmJlZjY4N2I5YTI3NyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L252bWUvaG9zdC9jb3JlLmMKPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPiBAQCAt
MTE2MCw4ICsxMTYwLDEwIEBAIHN0YXRpYyBpbnQgbnZtZV9pZGVudGlmeV9uc19kZXNjcyhzdHJ1
Y3QgbnZtZV9jdHJsICpjdHJsLCB1bnNpZ25lZCBuc2lkLAo+ICAgICAgICAgICAgICAgICAgICAq
IERvbid0IHRyZWF0IGFuIGVycm9yIGFzIGZhdGFsLCBhcyB3ZSBwb3RlbnRpYWxseSBhbHJlYWR5
Cj4gICAgICAgICAgICAgICAgICAgICogaGF2ZSBhIE5HVUlEIG9yIEVVSS02NC4KPiAgICAgICAg
ICAgICAgICAgICAgKi8KPiAtICAgICAgICAgICAgICAgaWYgKHN0YXR1cyA+IDAgJiYgIShzdGF0
dXMgJiBOVk1FX1NDX0ROUikpCj4gKyAgICAgICAgICAgICAgIGlmIChzdGF0dXMgPiAwICYmICEo
c3RhdHVzICYgTlZNRV9TQ19ETlIpKSB7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgIHN0YXR1
cyA9IDA7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgZ290byBjc2lfY2hlY2s7Cj4gKyAgICAg
ICAgICAgICAgIH0KCkkgdGhpbmsgaXRzIHRoZSBvcHBvc2l0ZS4gSWYgd2UgZmFpbGVkIHdpdGgg
RE5SLCB5b3Ugc2hvdWxkIGFzc3VtZQp0aGF0IGVpdGhlciB0aGUgY29udHJvbGxlciB3YW50cyB0
aGUgaG9zdCB0byByZXRyeSwgb3IgaXRzIGEKcGF0aC90cmFuc3BvcnQgZXJyb3IuIFNvIHdlIG5l
ZWQgdG8gbGVhdmUgdGhpcyBuYW1lc3BhY2UgYWxvbmUgYW5kCmFzc3VtZSB0aGF0IHdoZW4gdGhl
IGhvc3QgaXMgY29ubmVjdGVkIGJhY2sgdG8gdGhlIGNvbnRyb2xsZXIsIHRoZQpzY2FuX3dvcmsg
d2lsbCByZXZhbGlkYXRlIGFnYWluLgoKU28geW91IHNob3VsZCBmYWlsIHRoZSBjc2lfY2hlY2sg
b25seSBpZiB5b3Ugc2VlIGEgRE5SIGVycm9yIHN0YXR1cy4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
