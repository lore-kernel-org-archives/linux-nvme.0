Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23986C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 09:51:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B8F21531
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 09:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="w/KemVS3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="mTdw4JzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B8F21531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BGM0rvnwdyhD6WhYSLp4SNwPVCcqcdXjp+Me8vC4U5I=; b=w/KemVS3Wa75j1V8Ui8XWv2Hl
	xOA+yxREO3v1zzac2bNFsEz2baU5lQmHNlh6Gs7bPHu2Kd+ho2K01VoNC0MGEzLnMGRoEh3LTXHqy
	R7csunWwJ2iP4BpEMSZFlQbFeJj3X2X3deT6DsnyB/jxQHiNsIhIlcsY/rVQZLTlgfdxFE6K7/BhN
	soYqWgffSBxym0/dXQ9qhP+3h0vUTd3nvRb4oPjnzU0F+3sSfecu1hve+xxex25mHqPCkSi8/OWxn
	wNrypMi+QrjhVMfMYfMDguOksrxsOI/T3kLavVCnDPc59zi/WDHOV5xzjvekWaXxc/k/Bq5Iouqcy
	4arjMUFaw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jol0v-00032l-7G; Fri, 26 Jun 2020 09:51:18 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jok5l-00083s-3I
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 08:52:41 +0000
Received: by mail-ed1-x542.google.com with SMTP id g20so6091879edm.4
 for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2020 01:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=DcDHPN9kms1mvGJ+G7SU9GbYWwpk8frXL5FXV5+IcyU=;
 b=mTdw4JzCb/bbzkVPxDnjZTbqdAdeRLdRytGgOOBo8fAfJrX43OGUDufvuosFJ1n2/C
 eqoswxjmwfbt2dL6HV9/NLYahczrRRYjI7w3yQpRx3qdy4fhH6LLvnrxa7ZWfejKXVw3
 7h9SqMpfWp7I6e+WpOyPfC7mVDbquJwIa+MRY0W/Wnaqyv5wcrtCO4gQ4+MoAIGMEIr9
 pMpY885m8Rq6T5LhJmc4o2qlnXrsa04MCfPzHZC7fkxQm25as2P8vD1kzxpERRAkxySZ
 Mo25ZPeBJrxfB3Y/CeWbeJFmG/zIZgvl1dIJnaIiIiAJmaGuQ0YEcIF7Cg5itE2KmGOa
 ZC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=DcDHPN9kms1mvGJ+G7SU9GbYWwpk8frXL5FXV5+IcyU=;
 b=WAtX9wkzSHPXmRU0kgwKJg43UgqLO3DUs9B+TgIpV34t7cUUY3p+3lW2cn0UylGR5d
 xs4j3ylejk+Ws1MEnjYGsyBNPLePkzsgvmZj2RPseAevcmoS0vcWp6caBC+IPAkUIVzD
 vORRP0Bk+YDYATQt+MDxDbz/SH97KC32SfSmOnmIT8FHgcD7nxTpOOgi/ORuIV8s1GTj
 KVXw/jQlC1w4S7sG4f2e+TCLIn1T9XF1bZenkvzQGqbAGxf6Tbhlqy6Gp3GR3Jk+4CyW
 hRWKcH0Z79n2MQKrcKQ2zNPTWcKeJ9wWmugZDnUS2sGTA5ExIpgWMErKyZjYlxf2rCqw
 go5g==
X-Gm-Message-State: AOAM530NhTBcDpXan/HfjcVxtFTTRTmGn8AoEwAo7J69XY+yMU5+4kac
 9xBILs21w4wGAbm10Td8uC1Go7j87hduTEcj/yE=
X-Google-Smtp-Source: ABdhPJyK5M5/nzFAIAV0QK/pk/bTAv0CWknEH3zNrXlspR0Jbpalq6wkkb8sM7jlE9UNadBpZahB4Q==
X-Received: by 2002:a17:906:3653:: with SMTP id
 r19mr29431666ejb.246.1593114686614; 
 Thu, 25 Jun 2020 12:51:26 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id y62sm19411472edy.61.2020.06.25.12.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 12:51:25 -0700 (PDT)
Date: Thu, 25 Jun 2020 21:51:25 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>
Subject: Re: [PATCH 5/6] block: add zone attr. to zone mgmt IOCTL struct
Message-ID: <20200625195125.ccertaiuilofpn6c@MacBook-Pro.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-6-javier@javigon.com>
 <9ac40166-5731-692a-d476-0da9aad2a9aa@lightnvm.io>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9ac40166-5731-692a-d476-0da9aad2a9aa@lightnvm.io>
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
Cc: axboe@kernel.dk, Damien Le Moal <Damien.LeMoal@wdc.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org,
 Nitesh Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
 kbusch@kernel.org, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjUuMDYuMjAyMCAxNzoxMywgTWF0aWFzIEJqw7hybGluZyB3cm90ZToKPk9uIDI1LzA2LzIw
MjAgMTQuMjEsIEphdmllciBHb256w6FsZXogd3JvdGU6Cj4+RnJvbTogSmF2aWVyIEdvbnrDoWxl
eiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+Cj4+Cj4+QWRkIHpvbmUgYXR0cmlidXRlcyBmaWVs
ZCB0byB0aGUgYmxrX3pvbmUgc3RydWN0dXJlLiBVc2UgWk5TIGF0dHJpYnV0ZXMKPj5hcyBiYXNl
IGZvciB6b25lZCBibG9jayBkZXZpY2VzIGluIGdlbmVyYWwuCj4+Cj4+U2lnbmVkLW9mZi1ieTog
SmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+Cj4+U2lnbmVkLW9mZi1i
eTogU2VsdmFLdW1hciBTIDxzZWx2YWt1bWEuczFAc2Ftc3VuZy5jb20+Cj4+U2lnbmVkLW9mZi1i
eTogS2FuY2hhbiBKb3NoaSA8am9zaGkua0BzYW1zdW5nLmNvbT4KPj5TaWduZWQtb2ZmLWJ5OiBO
aXRlc2ggU2hldHR5IDxuai5zaGV0dHlAc2Ftc3VuZy5jb20+Cj4+LS0tCj4+ICBkcml2ZXJzL252
bWUvaG9zdC96bnMuYyAgICAgICB8ICAxICsKPj4gIGluY2x1ZGUvdWFwaS9saW51eC9ibGt6b25l
ZC5oIHwgMTMgKysrKysrKysrKysrLQo+PiAgMiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3pu
cy5jIGIvZHJpdmVycy9udm1lL2hvc3Qvem5zLmMKPj5pbmRleCAyNThkMDM2MTBjYzAuLjdkODM4
MWZlNzY2NSAxMDA2NDQKPj4tLS0gYS9kcml2ZXJzL252bWUvaG9zdC96bnMuYwo+PisrKyBiL2Ry
aXZlcnMvbnZtZS9ob3N0L3pucy5jCj4+QEAgLTE5NSw2ICsxOTUsNyBAQCBzdGF0aWMgaW50IG52
bWVfem9uZV9wYXJzZV9lbnRyeShzdHJ1Y3QgbnZtZV9ucyAqbnMsCj4+ICAJem9uZS5jYXBhY2l0
eSA9IG52bWVfbGJhX3RvX3NlY3QobnMsIGxlNjRfdG9fY3B1KGVudHJ5LT56Y2FwKSk7Cj4+ICAJ
em9uZS5zdGFydCA9IG52bWVfbGJhX3RvX3NlY3QobnMsIGxlNjRfdG9fY3B1KGVudHJ5LT56c2xi
YSkpOwo+PiAgCXpvbmUud3AgPSBudm1lX2xiYV90b19zZWN0KG5zLCBsZTY0X3RvX2NwdShlbnRy
eS0+d3ApKTsKPj4rCXpvbmUuYXR0ciA9IGVudHJ5LT56YTsKPj4gIAlyZXR1cm4gY2IoJnpvbmUs
IGlkeCwgZGF0YSk7Cj4+ICB9Cj4+ZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9ibGt6
b25lZC5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L2Jsa3pvbmVkLmgKPj5pbmRleCAwYzQ5YTRiMmNl
NWQuLjJlNDNhMDBlMzQyNSAxMDA2NDQKPj4tLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvYmxrem9u
ZWQuaAo+PisrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9ibGt6b25lZC5oCj4+QEAgLTgyLDYgKzgy
LDE2IEBAIGVudW0gYmxrX3pvbmVfcmVwb3J0X2ZsYWdzIHsKPj4gIAlCTEtfWk9ORV9SRVBfQ0FQ
QUNJVFkJPSAoMSA8PCAwKSwKPj4gIH07Cj4+Ky8qKgo+PisgKiBab25lIEF0dHJpYnV0ZXMKPj4r
ICovCj4+K2VudW0gYmxrX3pvbmVfYXR0ciB7Cj4+KwlCTEtfWk9ORV9BVFRSX1pGQwk9IDEgPDwg
MCwKPj4rCUJMS19aT05FX0FUVFJfRlpSCT0gMSA8PCAxLAo+PisJQkxLX1pPTkVfQVRUUl9SWlIJ
PSAxIDw8IDIsCj4KPlRoZSBSWlIgYml0IGlzIGVxdWl2YWxlbnQgdG8gdGhlIFJFU0VUIGJpdCBh
Y2Nlc3NpYmxlIHRocm91Z2ggdGhlIAo+cmVzZXQgYnl0ZSBpbiBzdHJ1Y3QgYmxrX3pvbmUuCj4K
PlpGQyBpcyB0aWVkIHRvIFpvbmUgQWN0aXZlIEV4Y3Vyc2lvbnMsIGFzIHRoZXJlIGlzIG5vIHN1
cHBvcnQgaW4gdGhlIAo+a2VybmVsIHpvbmUgbW9kZWwgZm9yIHRoYXQuIFRoaXMgc2hvdWxkIHBy
b2JhYmx5IG5vdCBiZSBhZGRlZCB1bnRpbCAKPnRoZXJlIGlzIGdlbmVyaWMgc3VwcG9ydC4KPgo+
RGFtaWVuLCBjb3VsZCB3ZSBvdmVybG9hZCB0aGUgc3RydWN0IGJsa196aW5lIHJlc2V0IHZhcmlh
YmxlIGZvciBGWlI/IAo+SSBkb24ndCBiZWxpZXZlIHdlIGNhbiBkdWUgdG8gYmFja3dhcmQgY29t
cGF0aWJpbGl0eS4gSXMgdGhhdCB5b3VyIAo+dW5kZXJzdGFuZGluZyBhcyB3ZWxsPwo+Cj4+KwlC
TEtfWk9ORV9BVFRSX1pERVYJPSAxIDw8IDcsCj4KPlRoZXJlIGlzIG5vdCBjdXJyZW50bHkgYW4g
ZXF1aXZhbGVudCBmb3Igem9uZSBkZXNjcmlwdG9yIGV4dGVuc2lvbnMgaW4gCj5aQUMvWkJDLiBU
aGUgYWRkaXRpb24gb2YgdGhpcyBmaWVsZCBzaG91bGQgcHJvYmFibHkgYmUgaW4gYSBwYXRjaCB0
aGF0IAo+YWRkcyBnZW5lcmljIHN1cHBvcnQgZm9yIHpvbmUgZGVzY3JpcHRvciBleHRlbnNpb25z
LgoKVGhlIGludGVudGlvbiB3YXMgdG8ganVzdCByZXBvcnQgdGhlIHZhbHVlcyBvbiB0aGUgSU9D
VEwgYW5kIG1ha2Ugc3VyZQp0aGF0IGNoYW5nZXMgdG8gc3RydWN0IGJsa196b25lIGFyZSBPSy4K
Cj4+K307Cj4+Kwo+PiAgLyoqCj4+ICAgKiBzdHJ1Y3QgYmxrX3pvbmUgLSBab25lIGRlc2NyaXB0
b3IgZm9yIEJMS1JFUE9SVFpPTkUgaW9jdGwuCj4+ICAgKgo+PkBAIC0xMDgsNyArMTE4LDggQEAg
c3RydWN0IGJsa196b25lIHsKPj4gIAlfX3U4CWNvbmQ7CQkvKiBab25lIGNvbmRpdGlvbiAqLwo+
PiAgCV9fdTgJbm9uX3NlcTsJLyogTm9uLXNlcXVlbnRpYWwgd3JpdGUgcmVzb3VyY2VzIGFjdGl2
ZSAqLwo+PiAgCV9fdTgJcmVzZXQ7CQkvKiBSZXNldCB3cml0ZSBwb2ludGVyIHJlY29tbWVuZGVk
ICovCj4+LQlfX3U4CXJlc3ZbNF07Cj4+KwlfX3U4CWF0dHI7CQkvKiBab25lIGF0dHJpYnV0ZXMg
Ki8KPj4rCV9fdTgJcmVzdlszXTsKPj4gIAlfX3U2NAljYXBhY2l0eTsJLyogWm9uZSBjYXBhY2l0
eSBpbiBudW1iZXIgb2Ygc2VjdG9ycyAqLwo+PiAgCV9fdTgJcmVzZXJ2ZWRbMjRdOwo+PiAgfTsK
Pgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51
eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
