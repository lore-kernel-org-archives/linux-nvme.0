Return-Path: <SRS0=73dC=AL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A087C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 15:34:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB7AB2074F
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 15:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sp44OcKh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wypfa8AL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7AB2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:References:Message-Id:Date:In-Reply-To:From:
	Subject:Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7YA/r6QnSI8CX8kaqRSs/8XVsR8XyVcwsFADRR6SmDI=; b=sp44OcKhpg9fz0upIo7081pd6
	c72RYgwPCeuXiwuD4jpGDULjZjbvgyM1fEALoSYo+BB97nqNQXjDyLi04eVNEsbT9WvcLnhfwRcAE
	mH2Qp5fp3j/CMeAXLuU3P3ggmZs9UCskFPWOyxBM5HBLwLtbMZ/ESEdXkPX0joJM9COGgCiphjGCk
	hD0KBsU2YtHi55OLBIFK/4+xXXbkAyhPVOf/oom3dyayXDMulrp2yAdEjRhvaj3o0QuCClcVI9qM+
	67NEF9dinHGJYy90YK3e9Iq8m6dhlSpuPFdB72canXtc0R5sCuV2vZLibWO4w7rWwOtCdu92GEFBi
	sWfwJ+7Qw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqIHY-0002SF-UM; Tue, 30 Jun 2020 15:34:48 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqIHQ-0002R1-H1
 for linux-nvme@lists.infradead.org; Tue, 30 Jun 2020 15:34:46 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05UFRIbx109591;
 Tue, 30 Jun 2020 15:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=vd6uNjLFbYhcZn1EIjYn4Jt+bsag5IRWJKCrY9Q25BY=;
 b=Wypfa8ALEiyFM/UodorZWPL6wt2hD9ysfy2PPhHYbp6nfvRCj5qc5BPUD3Fwa4jAEjDF
 NgyMYX7Hh+8CYk63tJ8RmdbgreXYDzedNH+7lHtoSUAYnxV7obYR5GkJL5S5JtxYSdNg
 2nc83Okqs/+ormmAPEAZCe0MJExvB+FP2RnWiOjWt74ENZq8wbUhhkhJcTAny49d+QeJ
 GcvYzfCzjI7c7AdXu/hNKznXfkBp9O5pqRXLW7VBWW5EltzJEU5/dFAgbA0yVAhBQK4A
 p+OGdQqBCqiGp/LpTkfpoVD6KovqODa+JALW6j+PsMpjrjmHPP64I9hHUOtRhYLA18IG XA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 31ywrbkgyd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 30 Jun 2020 15:34:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05UFMfZY098421;
 Tue, 30 Jun 2020 15:34:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 31xg13pw3m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2020 15:34:25 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05UFYLG6009162;
 Tue, 30 Jun 2020 15:34:21 GMT
Received: from dhcp-10-154-182-99.vpn.oracle.com (/10.154.182.99)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 30 Jun 2020 15:34:20 +0000
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCHv4 1/5] block: add capacity field to zone descriptors
From: Himanshu Madhani <himanshu.madhani@oracle.com>
In-Reply-To: <20200629190641.1986462-2-kbusch@kernel.org>
Date: Tue, 30 Jun 2020 10:34:18 -0500
Message-Id: <3598CF55-095F-477C-BEE2-93F11FAF44BD@oracle.com>
References: <20200629190641.1986462-1-kbusch@kernel.org>
 <20200629190641.1986462-2-kbusch@kernel.org>
To: Keith Busch <kbusch@kernel.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9667
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=999 suspectscore=3 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006300112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9667
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 mlxlogscore=999
 clxscore=1011 cotscore=-2147483648 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=3 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006300112
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200630_113440_741199_BACCBD28 
X-CRM114-Status: GOOD (  26.26  )
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
Cc: axboe@kernel.dk, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>, hch@lst.de,
 =?utf-8?Q?Matias_Bj=C3=B8rling?= <matias.bjorling@wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cgo+IE9uIEp1biAyOSwgMjAyMCwgYXQgMjowNiBQTSwgS2VpdGggQnVzY2ggPGtidXNjaEBrZXJu
ZWwub3JnPiB3cm90ZToKPiAKPiBGcm9tOiBNYXRpYXMgQmrDuHJsaW5nIDxtYXRpYXMuYmpvcmxp
bmdAd2RjLmNvbT4KPiAKPiBJbiB0aGUgem9uZWQgc3RvcmFnZSBtb2RlbCwgdGhlIHNlY3RvcnMg
d2l0aGluIGEgem9uZSBhcmUgdHlwaWNhbGx5IGFsbAo+IHdyaXRlYWJsZS4gV2l0aCB0aGUgaW50
cm9kdWN0aW9uIG9mIHRoZSBab25lZCBOYW1lc3BhY2UgKFpOUykgQ29tbWFuZAo+IFNldCBpbiB0
aGUgTlZNIEV4cHJlc3Mgb3JnYW5pemF0aW9uLCB0aGUgbW9kZWwgd2FzIGV4dGVuZGVkIHRvIGhh
dmUgYQo+IHNwZWNpZmljIHdyaXRlYWJsZSBjYXBhY2l0eS4KPiAKPiBFeHRlbmQgdGhlIHpvbmUg
ZGVzY3JpcHRvciBkYXRhIHN0cnVjdHVyZSB3aXRoIGEgem9uZSBjYXBhY2l0eSBmaWVsZCB0bwo+
IGluZGljYXRlIHRvIHRoZSB1c2VyIGhvdyBtYW55IHNlY3RvcnMgaW4gYSB6b25lIGFyZSB3cml0
ZWFibGUuCj4gCj4gSW50cm9kdWNlIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgaW4gdGhlIHpvbmUg
cmVwb3J0IGlvY3RsIGJ5IGV4dGVuZGluZwo+IHRoZSB6b25lIHJlcG9ydCBoZWFkZXIgZGF0YSBz
dHJ1Y3R1cmUgd2l0aCBhIGZsYWdzIGZpZWxkIHRvIGluZGljYXRlIGlmCj4gdGhlIGNhcGFjaXR5
IGZpZWxkIGlzIGF2YWlsYWJsZS4KPiAKPiBSZXZpZXdlZC1ieTogSmVucyBBeGJvZSA8YXhib2VA
a2VybmVsLmRrPgo+IFJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGNoYWl0YW55YS5r
dWxrYXJuaUB3ZGMuY29tPgo+IFJldmlld2VkLWJ5OiBKYXZpZXIgR29uesOhbGV6IDxqYXZpZXIu
Z29uekBzYW1zdW5nLmNvbT4KPiBSZXZpZXdlZC1ieTogRGFuaWVsIFdhZ25lciA8ZHdhZ25lckBz
dXNlLmRlPgo+IFJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1z
aGlybkB3ZGMuY29tPgo+IFJldmlld2VkLWJ5OiBNYXJ0aW4gSy4gUGV0ZXJzZW4gPG1hcnRpbi5w
ZXRlcnNlbkBvcmFjbGUuY29tPgo+IFJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVA
c3VzZS5kZT4KPiBTaWduZWQtb2ZmLWJ5OiBNYXRpYXMgQmrDuHJsaW5nIDxtYXRpYXMuYmpvcmxp
bmdAd2RjLmNvbT4KPiAtLS0KPiBibG9jay9ibGstem9uZWQuYyAgICAgICAgICAgICAgfCAgMSAr
Cj4gZHJpdmVycy9ibG9jay9udWxsX2Jsa196b25lZC5jIHwgIDIgKysKPiBkcml2ZXJzL3Njc2kv
c2RfemJjLmMgICAgICAgICAgfCAgMSArCj4gaW5jbHVkZS91YXBpL2xpbnV4L2Jsa3pvbmVkLmgg
IHwgMTUgKysrKysrKysrKysrKy0tCj4gNCBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9ibG9jay9ibGstem9uZWQuYyBiL2Js
b2NrL2Jsay16b25lZC5jCj4gaW5kZXggMjM4MzFmYTg3MDFkLi44MTE1MmEyNjAzNTQgMTAwNjQ0
Cj4gLS0tIGEvYmxvY2svYmxrLXpvbmVkLmMKPiArKysgYi9ibG9jay9ibGstem9uZWQuYwo+IEBA
IC0zMTIsNiArMzEyLDcgQEAgaW50IGJsa2Rldl9yZXBvcnRfem9uZXNfaW9jdGwoc3RydWN0IGJs
b2NrX2RldmljZSAqYmRldiwgZm1vZGVfdCBtb2RlLAo+IAkJcmV0dXJuIHJldDsKPiAKPiAJcmVw
Lm5yX3pvbmVzID0gcmV0Owo+ICsJcmVwLmZsYWdzID0gQkxLX1pPTkVfUkVQX0NBUEFDSVRZOwo+
IAlpZiAoY29weV90b191c2VyKGFyZ3AsICZyZXAsIHNpemVvZihzdHJ1Y3QgYmxrX3pvbmVfcmVw
b3J0KSkpCj4gCQlyZXR1cm4gLUVGQVVMVDsKPiAJcmV0dXJuIDA7Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvYmxvY2svbnVsbF9ibGtfem9uZWQuYyBiL2RyaXZlcnMvYmxvY2svbnVsbF9ibGtfem9u
ZWQuYwo+IGluZGV4IGNjNDc2MDZkOGZmZS4uNjI0YWFjMDliMDA1IDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvYmxvY2svbnVsbF9ibGtfem9uZWQuYwo+ICsrKyBiL2RyaXZlcnMvYmxvY2svbnVsbF9i
bGtfem9uZWQuYwo+IEBAIC00Nyw2ICs0Nyw3IEBAIGludCBudWxsX2luaXRfem9uZWRfZGV2KHN0
cnVjdCBudWxsYl9kZXZpY2UgKmRldiwgc3RydWN0IHJlcXVlc3RfcXVldWUgKnEpCj4gCj4gCQl6
b25lLT5zdGFydCA9IHNlY3RvcjsKPiAJCXpvbmUtPmxlbiA9IGRldi0+em9uZV9zaXplX3NlY3Rz
Owo+ICsJCXpvbmUtPmNhcGFjaXR5ID0gem9uZS0+bGVuOwo+IAkJem9uZS0+d3AgPSB6b25lLT5z
dGFydCArIHpvbmUtPmxlbjsKPiAJCXpvbmUtPnR5cGUgPSBCTEtfWk9ORV9UWVBFX0NPTlZFTlRJ
T05BTDsKPiAJCXpvbmUtPmNvbmQgPSBCTEtfWk9ORV9DT05EX05PVF9XUDsKPiBAQCAtNTksNiAr
NjAsNyBAQCBpbnQgbnVsbF9pbml0X3pvbmVkX2RldihzdHJ1Y3QgbnVsbGJfZGV2aWNlICpkZXYs
IHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxKQo+IAo+IAkJem9uZS0+c3RhcnQgPSB6b25lLT53cCA9
IHNlY3RvcjsKPiAJCXpvbmUtPmxlbiA9IGRldi0+em9uZV9zaXplX3NlY3RzOwo+ICsJCXpvbmUt
PmNhcGFjaXR5ID0gem9uZS0+bGVuOwo+IAkJem9uZS0+dHlwZSA9IEJMS19aT05FX1RZUEVfU0VR
V1JJVEVfUkVROwo+IAkJem9uZS0+Y29uZCA9IEJMS19aT05FX0NPTkRfRU1QVFk7Cj4gCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9zZF96YmMuYyBiL2RyaXZlcnMvc2NzaS9zZF96YmMuYwo+
IGluZGV4IDZmN2ViYTY2Njg3ZS4uMTgzYTIwNzIwZGE5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
c2NzaS9zZF96YmMuYwo+ICsrKyBiL2RyaXZlcnMvc2NzaS9zZF96YmMuYwo+IEBAIC01OSw2ICs1
OSw3IEBAIHN0YXRpYyBpbnQgc2RfemJjX3BhcnNlX3JlcG9ydChzdHJ1Y3Qgc2NzaV9kaXNrICpz
ZGtwLCB1OCAqYnVmLAo+IAkJem9uZS5ub25fc2VxID0gMTsKPiAKPiAJem9uZS5sZW4gPSBsb2dp
Y2FsX3RvX3NlY3RvcnMoc2RwLCBnZXRfdW5hbGlnbmVkX2JlNjQoJmJ1Zls4XSkpOwo+ICsJem9u
ZS5jYXBhY2l0eSA9IHpvbmUubGVuOwo+IAl6b25lLnN0YXJ0ID0gbG9naWNhbF90b19zZWN0b3Jz
KHNkcCwgZ2V0X3VuYWxpZ25lZF9iZTY0KCZidWZbMTZdKSk7Cj4gCXpvbmUud3AgPSBsb2dpY2Fs
X3RvX3NlY3RvcnMoc2RwLCBnZXRfdW5hbGlnbmVkX2JlNjQoJmJ1ZlsyNF0pKTsKPiAJaWYgKHpv
bmUudHlwZSAhPSBaQkNfWk9ORV9UWVBFX0NPTlYgJiYKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91
YXBpL2xpbnV4L2Jsa3pvbmVkLmggYi9pbmNsdWRlL3VhcGkvbGludXgvYmxrem9uZWQuaAo+IGlu
ZGV4IDBjZGVmNjcxMzVmMC4uNDJjMzM2NmNjMjVmIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvdWFw
aS9saW51eC9ibGt6b25lZC5oCj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L2Jsa3pvbmVkLmgK
PiBAQCAtNzMsNiArNzMsMTUgQEAgZW51bSBibGtfem9uZV9jb25kIHsKPiAJQkxLX1pPTkVfQ09O
RF9PRkZMSU5FCT0gMHhGLAo+IH07Cj4gCj4gKy8qKgo+ICsgKiBlbnVtIGJsa196b25lX3JlcG9y
dF9mbGFncyAtIEZlYXR1cmUgZmxhZ3Mgb2YgcmVwb3J0ZWQgem9uZSBkZXNjcmlwdG9ycy4KPiAr
ICoKPiArICogQEJMS19aT05FX1JFUF9DQVBBQ0lUWTogWm9uZSBkZXNjcmlwdG9yIGhhcyBjYXBh
Y2l0eSBmaWVsZC4KPiArICovCj4gK2VudW0gYmxrX3pvbmVfcmVwb3J0X2ZsYWdzIHsKPiArCUJM
S19aT05FX1JFUF9DQVBBQ0lUWQk9ICgxIDw8IDApLAo+ICt9Owo+ICsKPiAvKioKPiAgKiBzdHJ1
Y3QgYmxrX3pvbmUgLSBab25lIGRlc2NyaXB0b3IgZm9yIEJMS1JFUE9SVFpPTkUgaW9jdGwuCj4g
ICoKPiBAQCAtOTksNyArMTA4LDkgQEAgc3RydWN0IGJsa196b25lIHsKPiAJX191OAljb25kOwkJ
LyogWm9uZSBjb25kaXRpb24gKi8KPiAJX191OAlub25fc2VxOwkvKiBOb24tc2VxdWVudGlhbCB3
cml0ZSByZXNvdXJjZXMgYWN0aXZlICovCj4gCV9fdTgJcmVzZXQ7CQkvKiBSZXNldCB3cml0ZSBw
b2ludGVyIHJlY29tbWVuZGVkICovCj4gLQlfX3U4CXJlc2VydmVkWzM2XTsKPiArCV9fdTgJcmVz
dls0XTsKPiArCV9fdTY0CWNhcGFjaXR5OwkvKiBab25lIGNhcGFjaXR5IGluIG51bWJlciBvZiBz
ZWN0b3JzICovCj4gKwlfX3U4CXJlc2VydmVkWzI0XTsKPiB9Owo+IAo+IC8qKgo+IEBAIC0xMTUs
NyArMTI2LDcgQEAgc3RydWN0IGJsa196b25lIHsKPiBzdHJ1Y3QgYmxrX3pvbmVfcmVwb3J0IHsK
PiAJX191NjQJCXNlY3RvcjsKPiAJX191MzIJCW5yX3pvbmVzOwo+IC0JX191OAkJcmVzZXJ2ZWRb
NF07Cj4gKwlfX3UzMgkJZmxhZ3M7Cj4gCXN0cnVjdCBibGtfem9uZSB6b25lc1swXTsKPiB9Owo+
IAo+IC0tIAo+IDIuMjQuMQo+IAoKUmV2aWV3ZWQtYnk6IEhpbWFuc2h1IE1hZGhhbmkgPGhpbWFu
c2h1Lm1hZGhhbmlAb3JhY2xlLmNvbT4KCi0tCkhpbWFuc2h1IE1hZGhhbmkJT3JhY2xlIExpbnV4
IEVuZ2luZWVyaW5nCgoKCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LW52bWUK
