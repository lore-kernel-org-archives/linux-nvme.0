Return-Path: <SRS0=6Yp5=EX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C48C388F9
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Nov 2020 00:07:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1929824654
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Nov 2020 00:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kAiqxQWk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1929824654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:From:To:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=i+EBi/M502EIlifgERI9fJmDUuWoIJCrfzLztrvNT0g=; b=kAiqxQWkEOhLs+RVuQePYq6lGW
	2Tc4vktba/AuD1CwzW4VFJalKrv8QxH/+TCb8LhIqL8tEH/5rbwhJswSC25Y7wmI48CgjNCZdDXEc
	1gysTKdl32iG/pkwwKWgIZzsq46Tu4VWswy8fzJBKPmyvjO4Glc0wyBapRB/GgRBr+I047rDurmox
	u/eLjAWkrnqxHF/amu5FzlYd/kUGhvBwy+rFHBusQRaWYJIHCLo6bj96KSLmeurRFy1KUyi0Bq630
	hb6uyPEGYLeyRF5XKqkUnyCWHmWp54JaRROEa9c0yvS96eDZfW/ucxMCCo+lcxa2FSHsgxozP9MJ4
	aDVyNwpw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keoWf-0008RS-H7; Tue, 17 Nov 2020 00:07:13 +0000
Received: from mga09.intel.com ([134.134.136.24])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1keoWc-0008Qm-8P
 for linux-nvme@lists.infradead.org; Tue, 17 Nov 2020 00:07:11 +0000
IronPort-SDR: KSwj83Zvv4C6ceJcn3KVTSGKFRWM1lavR4zgl6yvbsD6N/FS6vt2f97gF0qB9FBMWn48W624Ra
 0d4kzL4Z3tmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="171006522"
X-IronPort-AV: E=Sophos;i="5.77,483,1596524400"; d="scan'208";a="171006522"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2020 16:06:56 -0800
IronPort-SDR: ddoFpp64Alwx2nmUahWAUFkxTTgFHpxQ6oxS1eNAM3ux5hkqpgSRKLerffai81Omp+gxYdTfUd
 wKksECRj8Muw==
X-IronPort-AV: E=Sophos;i="5.77,483,1596524400"; d="scan'208";a="329880027"
Received: from rrajashe-mobl1.amr.corp.intel.com (HELO [10.212.216.178])
 ([10.212.216.178])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2020 16:06:55 -0800
To: "kbusch@kernel.org" <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: "Rajashekar, Revanth" <revanth.rajashekar@intel.com>
Subject: nvme: subsystem handle not released on hot removal under raid1
 configuration and multipath enabled
Message-ID: <fa9e6605-9d6e-0bde-749c-8987f68320a5@intel.com>
Date: Mon, 16 Nov 2020 16:06:54 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201116_190710_691241_FA4DEA06 
X-CRM114-Status: GOOD (  22.22  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGkgYWxsLApJJ20gdHJ5aW5nIHRvIHJ1biBhIGZldyB0ZXN0cyBvbiBtdWx0aXBhdGggY2FwYWJs
ZSBudm1lIGRldmljZXMgdW5kZXIgcmFpZC0xIGNvbmZpZ3VyYXRpb24uCldoZW4gSSB0cnkgdG8g
aG90IHJlbW92ZSBhIGRldmljZSB2aWEgc3lzZnMsIG9ubHkgdGhlIGJsb2NrIGRldmljZSBpcyBy
ZW1vdmVkIHdoaWxlIHRoZSBzdWJzeXN0ZW0gaGFuZGxlIGlzIHN0aWxsIGluLXRhY3QuCgpCZWZv
cmXCoGhvdMKgcmVtb3ZhbDoKPT09PT09PT09PT09PT09PT09PQojwqBudm1lwqBsaXN0Ck5vZGXC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFNOwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBNb2RlbMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE5hbWVzcGFjZcKgVXNhZ2XCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEZvcm1hdMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBGV8KgUmV2Ci0tLS0tLS0tLS0tLS0tLS3CoC0tLS0tLS0tLS0tLS0tLS0tLS0twqAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0twqAtLS0tLS0tLS3CoC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0twqAtLS0tLS0tLS0tLS0tLS0twqAtLS0tLS0tLQovZGV2L252bWUwbjHC
oMKgwqDCoMKgUEhLRDkzMjUwMDBDMzc1QUdOwqDCoMKgSU5URUzCoFNTRFBEMjFLMzc1R0HCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDHCoMKgwqDCoMKgwqDCoMKg
wqAzNzUuMDjCoMKgR0LCoC/CoDM3NS4wOMKgwqBHQsKgwqDCoMKgNTEywqDCoMKgQsKgK8KgwqAw
wqBCwqDCoMKgRTIwMTA0NTMKL2Rldi9udm1lMW4xwqDCoMKgwqDCoFBIS0Q5MzI1MDAwTjFQNUNH
TsKgwqDCoElOVEVMwqBTU0RQRDIxSzAxNVRBwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAxwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDEuNTDCoMKgVELCoC/CoMKgwqAx
LjUwwqDCoFRCwqDCoMKgwqA1MTLCoMKgwqBCwqArwqDCoDDCoELCoMKgwqBFMjAxMDQ1MwoKI8Kg
bGzCoC9zeXMvYmxvY2sKbWQxMjfCoC0+wqAuLi9kZXZpY2VzL3ZpcnR1YWwvYmxvY2svbWQxMjcK
bnZtZTBjMG4xwqAtPsKgLi4vZGV2aWNlcy9wY2kwMDAwOjY0LzAwMDA6NjQ6MDAuMC8wMDAwOjY1
OjAwLjAvMDAwMDo2NjowMS4wLzAwMDA6Njc6MDAuMC9udm1lL252bWUwL252bWUwYzBuMQpudm1l
MG4xwqAtPsKgLi4vZGV2aWNlcy92aXJ0dWFsL252bWUtc3Vic3lzdGVtL252bWUtc3Vic3lzMC9u
dm1lMG4xCm52bWUxYzFuMcKgLT7CoC4uL2RldmljZXMvcGNpMDAwMDo2NC8wMDAwOjY0OjAwLjAv
MDAwMDo2NTowMC4wLzAwMDA6NjY6MDIuMC8wMDAwOjY4OjAwLjAvbnZtZS9udm1lMS9udm1lMWMx
bjEKbnZtZTFuMcKgLT7CoC4uL2RldmljZXMvdmlydHVhbC9udm1lLXN1YnN5c3RlbS9udm1lLXN1
YnN5czEvbnZtZTFuMQoKI8KgbHNibGsKTkFNRcKgwqDCoMKgwqDCoMKgwqDCoMKgTUFKOk1JTsKg
Uk3CoMKgwqBTSVpFwqBST8KgVFlQRcKgwqBNT1VOVFBPSU5UCm52bWUwbjHCoMKgwqDCoMKgwqDC
oDI1OToxwqDCoMKgwqAwwqAzNDkuM0fCoMKgMMKgZGlzawrilJTilIBtZDEyN8KgwqDCoMKgwqDC
oMKgwqDCoDk6MTI3wqDCoDDCoDM0OS4yR8KgwqAwwqByYWlkMQpudm1lMW4xwqDCoMKgwqDCoMKg
wqAyNTk6M8KgwqDCoMKgMMKgwqDCoDEuNFTCoMKgMMKgZGlzawrilJTilIBtZDEyN8KgwqDCoMKg
wqDCoMKgwqDCoDk6MTI3wqDCoDDCoDM0OS4yR8KgwqAwwqByYWlkMQoKSG90wqByZW1vdmFsOsKg
ZWNob8KgMcKgPsKgL3N5cy9idXMvcGNpL2RldmljZXMvMDAwMFw6NjdcOjAwLjAvcmVtb3ZlCj09
PT09PT09PT09PQoKQWZ0ZXLCoGhvdMKgcmVtb3ZhbDoKPT09PT09PT09PT09PT09PT09PQojwqBu
dm1lwqBsaXN0Ck5vZGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFNOwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBNb2RlbMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoE5hbWVzcGFjZcKgVXNh
Z2XCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEZvcm1hdMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBGV8KgUmV2Ci0tLS0tLS0tLS0tLS0tLS3CoC0tLS0tLS0tLS0tLS0t
LS0tLS0twqAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0twqAtLS0tLS0t
LS3CoC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0twqAtLS0tLS0tLS0tLS0tLS0twqAtLS0tLS0t
LQovZGV2L252bWUwbjHCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC0xwqDCoMKgwqDCoMKgwqDCoMKgwqAw
LjAwwqDCoMKgQsKgL8KgwqDCoDAuMDDCoMKgwqBCwqDCoMKgwqDCoMKgMcKgwqDCoELCoCvCoMKg
MMKgQgovZGV2L252bWUxbjHCoMKgwqDCoMKgUEhLRDkzMjUwMDBOMVA1Q0dOwqDCoMKgSU5URUzC
oFNTRFBEMjFLMDE1VEHCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oDHCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMS41MMKgwqBUQsKgL8KgwqDCoDEuNTDCoMKgVELCoMKg
wqDCoDUxMsKgwqDCoELCoCvCoMKgMMKgQsKgwqDCoEUyMDEwNDUzCgojwqBsbMKgL3N5cy9ibG9j
awptZDEyN8KgLT7CoC4uL2RldmljZXMvdmlydHVhbC9ibG9jay9tZDEyNwpudm1lMG4xwqAtPsKg
Li4vZGV2aWNlcy92aXJ0dWFsL252bWUtc3Vic3lzdGVtL252bWUtc3Vic3lzMC9udm1lMG4xCm52
bWUxYzFuMcKgLT7CoC4uL2RldmljZXMvcGNpMDAwMDo2NC8wMDAwOjY0OjAwLjAvMDAwMDo2NTow
MC4wLzAwMDA6NjY6MDIuMC8wMDAwOjY4OjAwLjAvbnZtZS9udm1lMS9udm1lMWMxbjEKbnZtZTFu
McKgLT7CoC4uL2RldmljZXMvdmlydHVhbC9udm1lLXN1YnN5c3RlbS9udm1lLXN1YnN5czEvbnZt
ZTFuMQoKI8KgbHNibGsKTkFNRcKgwqDCoMKgwqDCoMKgwqDCoMKgTUFKOk1JTsKgUk3CoMKgwqBT
SVpFwqBST8KgVFlQRcKgwqBNT1VOVFBPSU5UCm52bWUwbjHCoMKgwqDCoMKgwqDCoDI1OToxwqDC
oMKgwqAwwqAzNDkuM0fCoMKgMMKgZGlzawrilJTilIBtZDEyN8KgwqDCoMKgwqDCoMKgwqDCoDk6
MTI3wqDCoDDCoDM0OS4yR8KgwqAwwqByYWlkMQpudm1lMW4xwqDCoMKgwqDCoMKgwqAyNTk6M8Kg
wqDCoMKgMMKgwqDCoDEuNFTCoMKgMMKgZGlzawrilJTilIBtZDEyN8KgwqDCoMKgwqDCoMKgwqDC
oDk6MTI3wqDCoDDCoDM0OS4yR8KgwqAwwqByYWlkMQoKSSBndWVzcyB0aGlzIGlzIGJlY2F1c2Ug
dGhlIG1kLXJhaWQxIGRyaXZlciBpcyBzdGlsbCBob2xkaW5nIGEgcmVmZXJlbmNlIHRvIHRoZSBu
dm1lIGRyaXZlciAoa3JlZiBjb3VudCBpcyAyIGluIHRoZSBudm1lIHJlbW92YWwgcGF0aCkuCklz
IHRoaXMgYSBidWcgaW4gbnZtZSBtdWx0aXBhdGg/IEJlY2F1c2UgaXQgd29ya3MgZmluZSB3aXRo
IG11bHRpcGF0aCBvZmYuClBsZWFzZSBsZXQgbWUga25vdyBpZiBtb3JlIGluZm9ybWF0aW9uIGlz
IHJlcXVpcmVkIDopCgpUaGFuayB5b3UsClJldmFudGgKCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1u
dm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1udm1lCg==
