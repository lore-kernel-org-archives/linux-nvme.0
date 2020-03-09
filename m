Return-Path: <SRS0=ldP/=42=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9183EC10F25
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Mar 2020 23:11:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C002146E
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Mar 2020 23:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AsBdG+E9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yBH8XP1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C002146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1BdTRoWvOyEf7jhYCblseuNuVICkl2WB4WHiPdDfz0s=; b=AsBdG+E9xw7bdkwGgHZNm3hAk
	zhWXxUeInTgYgKsImYo+65hhs3Pwgs691TtfRCAu3IPV45QduAtYIuzvpvbz4mogWUxuCOK66QaEE
	L8zKo+xvAGX6jyFhr/27dCRzF+Xy7uJEv2OEomJ/zDLr5cmseXAVUWtUGIBJ8qbIqDiSLBfG0vevs
	pqaAV9tkTX5+U6xtHhjY3+TDpEWwwEkg+9DiIIudkhI20ORoGL1teyXH5ptdWR2b29yGLKyYswfMO
	lI5rouBD07SOxcixiSnhCPqfEg8u80hYyWu5lxJj6gKPJPXJp5oezytLj3orWRTuGubF3CRMPuOqR
	AdMXbHBLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jBRYu-0008Jn-QJ; Mon, 09 Mar 2020 23:11:52 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jBRYs-0008I1-0v
 for linux-nvme@lists.infradead.org; Mon, 09 Mar 2020 23:11:51 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029MxVQ0093452;
 Mon, 9 Mar 2020 23:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=7Iej/HH9ee3MPlu3m8gpUMKmm8GiRPwWw8rOiBCPiC4=;
 b=yBH8XP1GWLcI8MfRUOjJ8j1sg5YEc/AMvbqdim9HIMXiRdg/ndFfKLZH3AWY3iEIE10W
 KOOSA/UScAkKbBQP0jlv+1EGin8P/TVqxk/+0UryQnMrnnfvfoBbpWTbTDoUWrsVD1od
 /2EBlWT/OrYIb9ayttDYy5ZfzPU3QYmHIrOYAxC/ImvBe9iQr1jIP+WkDaWZrRkyRGpg
 MSkrNFgkoiaxs34lfzMN4/+T/RQeoeGRVWMwqM0udp7OLLfJnfTVfwUX+SUkm9Ob38JP
 MFAVXCNs13Hn5HPcvknzCv1wRkUAdSsC/uKHICEOHtbtXcSUwCxsQDsC11ApaApeUz5g 9w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2ym48ssxag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Mar 2020 23:11:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029MxVrS059676;
 Mon, 9 Mar 2020 23:11:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2ymun7wfu5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Mar 2020 23:11:36 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 029NBYsV022934;
 Mon, 9 Mar 2020 23:11:34 GMT
Received: from [10.154.112.208] (/10.154.112.208)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 09 Mar 2020 16:11:34 -0700
Subject: Re: I/O performance with block sizes > 128k
To: Keith Busch <kbusch@kernel.org>
References: <321f0a4b-8a75-8cae-2d77-34ad712225d3@oracle.com>
 <20200309224737.GA15411@redsun51.ssa.fujisawa.hgst.com>
From: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Message-ID: <e580e915-e042-fc1a-3f45-160c12d38f8f@oracle.com>
Date: Mon, 9 Mar 2020 16:11:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309224737.GA15411@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-Antivirus: Avast (VPS 200308-0, 03/07/2020), Outbound message
X-Antivirus-Status: Clean
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 impostorscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090139
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200309_161150_151351_540FF0A1 
X-CRM114-Status: GOOD (  25.46  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMy85LzIwMjAgMzo0NyBQTSwgS2VpdGggQnVzY2ggd3JvdGU6Cj4gT24gTW9uLCBNYXIgMDks
IDIwMjAgYXQgMDI6NDk6MTBQTSAtMDcwMCwgQmlqYW4gTW90dGFoZWRlaCB3cm90ZToKPj4gSSdt
IHNlZWluZyBhIHNpemVhYmxlIGRyb3AgaW4gcGVyZiB3aXRoIHBvbGxlZCBmaW8gdGVzdHMgZm9y
IGJsb2NrIHNpemVzID4KPj4gMTI4azoKPj4KPj4gZmlsZW5hbWU9L2Rldi9udm1lMG4xCj4+IHJ3
PXJhbmRyZWFkCj4+IGRpcmVjdD0xCj4+IHRpbWVfYmFzZWQ9MQo+PiByYW5kcmVwZWF0PTEKPj4g
Z3RvZF9yZWR1Y2U9MQo+Pgo+PiBmaW8gLS1yZWFkb25seSAtLWlvZW5naW5lPWlvX3VyaW5nIC0t
aW9kZXB0aCAxMDI0IC0tZml4ZWRidWZzIC0taGlwcmkKPj4gLS1udW1qb2IKPj4KPj4gVGhlIHBy
b2JsZW0gc2VlbXMgdG8gYmUgcmVsYXRlZCB0byBzd2l0Y2hpbmcgZnJvbSBwcnBfc21hbGxfcG9v
bCB0bwo+PiBwcnBfcGFnZV9wb29sOyB0aGUgZm9ybWVyIGlzIG9wdGltaXplZCBmb3IgSS9PIGJl
dHdlZW4gNGsgYW5kIDEyOGsuCj4+Cj4+IEV4cGFuZGluZyB0aGUgc21hbGwgcG9vbCBzaXplIHRv
IGNvdmVyIHVwIHRvIDI1NmsgaW5jcmVhc2VzIHRoZQo+PiBwZXJmb3JtYW5jZS7CoCBJJ20gbm90
IHN1cmUgaG93ZXZlciBpZiB0aGlzIGlzIHRoZSBwcm9wZXIgYW5kIGdlbmVyYWwgZml4Lgo+PiBG
b3Igb25lIHRoaW5nLCBleHBhbmRpbmcgdGhlIHBvb2wgc2l6ZSBidW1wcyB0aGUgbnVtYmVycyBm
b3IgYSBzaG9ydCBidXJzdAo+PiB0ZXN0ICgxMCBzZWMpIGJ1dCB0aGUgbnVtYmVycyBkcm9wIGFn
YWluIHNpZ25pZmljYW50bHkgZHVyaW5nIGEgbG9uZ2VyCj4+IHRlc3QuwqAgVGhlIGJlaGF2aW9y
IGlzIG5vdCB1bmlxdWUgdG8gaW9fdXJpbmcgZWl0aGVyLsKgIEluY2x1ZGVkIGJlbG93IGFyZSBh
Cj4+IGNvdXBsZSBvZiAyNTZrIGZpbyBwdnN5bmMyIHRlc3RzIGFzIHdlbGwuCj4gSSBhbSBzdXJw
cmlzZWQgeW91J3JlIHNlZWluZyBzdWNoIGEgZHJvcCBqdXN0IGZyb20gdGhlIHBycCBwb29sIHVz
ZWQuCj4KPiBXaGF0IENQVSBhcmNoaXRlY3R1cmUgYXJlIHlvdSB1c2luZz8gUmVhc29uIEkgYXNr
OiB0aGUgZHJpdmVyIGFsbG9jYXRlcwo+IFBBR0VfU0laRSBmb3IgdGhlIGxhcmdlIHBycCBwb29s
LCBidXQgd2UgcmVhbGx5IHdhbnQgY3RybC0+cGFnZV9zaXplCj4gKGFsd2F5cyA0aykuIElmIHlv
dXIgQ1BVIGFyY2hpdGVjdHVyZSBoYXMgYSBQQUdFX1NJWkUgbGFyZ2VyIHRoYW4gNGssCj4gY291
bGQgeW91IHRyeSB0aGUgZm9sbG93aW5nPwoKSXQncyBhbiB4ODZfNjQgdm0gd2l0aCA4R0Igb2Yg
bWVtb3J5LsKgIElzIHRoZSA0ayBwb29sIHNpemUgbWVhbnQgdG8gCnN1cHBvcnQgdXAgdG8gYSAy
TUIgaS9vIHNpemUgdGhlbj8KClRoZSBtYWluIHNlZW1zIHRvIGJlIGEgbG9jayBjb250ZW50aW9u
LCB0aGlzIHdoYXQgSSBzZWUgd2l0aCB0aGUgMjU2ayAKdGVzdCBhZnRlciBydW5uaW5nIGEgd2hp
bGUuwqAgSG93ZXZlcizCoCBJIGNhbid0IHBpbnBvaW50IHRoZSBsb2NrIHdpdGggCnBlcmYgbG9j
azsgaXMgdGhlcmUgYSBiZXR0ZXIgd2F5IHRvIGRvIHRoYXQ/CgogwqDCoMKgIDY1LjA4JcKgIFtr
ZXJuZWxdwqDCoMKgwqDCoMKgIFtrXSBfX3B2X3F1ZXVlZF9zcGluX2xvY2tfc2xvd3BhdGgKIMKg
wqDCoMKgIDIuNDMlwqAgW2tlcm5lbF3CoMKgwqDCoMKgwqAgW2tdIG11dGV4X3NwaW5fb25fb3du
ZXIKCkFyY2hpdGVjdHVyZTrCoMKgwqDCoMKgwqDCoCB4ODZfNjQKQ1BVIG9wLW1vZGUocyk6wqDC
oMKgwqDCoCAzMi1iaXQsIDY0LWJpdApCeXRlIE9yZGVyOsKgwqDCoMKgwqDCoMKgwqDCoCBMaXR0
bGUgRW5kaWFuCkNQVShzKTrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAxNgpPbi1saW5lIENQ
VShzKSBsaXN0OiAwLTE1ClRocmVhZChzKSBwZXIgY29yZTrCoCAxCkNvcmUocykgcGVyIHNvY2tl
dDrCoCAxClNvY2tldChzKTrCoMKgwqDCoMKgwqDCoMKgwqDCoCAxNgpOVU1BIG5vZGUocyk6wqDC
oMKgwqDCoMKgwqAgMQpWZW5kb3IgSUQ6wqDCoMKgwqDCoMKgwqDCoMKgwqAgR2VudWluZUludGVs
CkNQVSBmYW1pbHk6wqDCoMKgwqDCoMKgwqDCoMKgIDYKTW9kZWw6wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCA2MwpNb2RlbCBuYW1lOsKgwqDCoMKgwqDCoMKgwqDCoCBJbnRlbChSKSBYZW9u
KFIpIENQVSBFNS0yNjk5IHYzIEAgMi4zMEdIegpTdGVwcGluZzrCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIDIKQ1BVIE1IejrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMjI5NC44NzYKQm9nb01JUFM6
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA0NTg5Ljc1ClZpcnR1YWxpemF0aW9uOsKgwqDCoMKgwqAg
VlQteApIeXBlcnZpc29yIHZlbmRvcjrCoMKgIEtWTQpWaXJ0dWFsaXphdGlvbiB0eXBlOiBmdWxs
CkwxZCBjYWNoZTrCoMKgwqDCoMKgwqDCoMKgwqDCoCAzMksKTDFpIGNhY2hlOsKgwqDCoMKgwqDC
oMKgwqDCoMKgIDMySwpMMiBjYWNoZTrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDQwOTZLCkwzIGNh
Y2hlOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMTYzODRLCk5VTUEgbm9kZTAgQ1BVKHMpOsKgwqAg
MC0xNQpGbGFnczrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZwdSB2bWUgZGUgcHNlIHRz
YyBtc3IgcGFlIG1jZSBjeDggYXBpYyBzZXAgbXRyciAKcGdlIG1jYSBjcgoKPgo+IC0tLQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9wY2kuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3Bj
aS5jCj4gaW5kZXggZGEzOTJiNTBmNzNlLi42ZWQwNzE2NGQxZTcgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9udm1lL2hvc3QvcGNpLmMKPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9wY2kuYwo+IEBA
IC0yNDU4LDcgKzI0NTgsNyBAQCBzdGF0aWMgaW50IG52bWVfZGlzYWJsZV9wcmVwYXJlX3Jlc2V0
KHN0cnVjdCBudm1lX2RldiAqZGV2LCBib29sIHNodXRkb3duKQo+ICAgc3RhdGljIGludCBudm1l
X3NldHVwX3BycF9wb29scyhzdHJ1Y3QgbnZtZV9kZXYgKmRldikKPiAgIHsKPiAgIAlkZXYtPnBy
cF9wYWdlX3Bvb2wgPSBkbWFfcG9vbF9jcmVhdGUoInBycCBsaXN0IHBhZ2UiLCBkZXYtPmRldiwK
PiAtCQkJCQkJUEFHRV9TSVpFLCBQQUdFX1NJWkUsIDApOwo+ICsJCQkJCQk0MDk2LCA0MDk2LCAw
KTsKPiAgIAlpZiAoIWRldi0+cHJwX3BhZ2VfcG9vbCkKPiAgIAkJcmV0dXJuIC1FTk9NRU07Cj4g
ICAKPiAtLQo+ICAgCj4+IEEgcmVsYXRlZCBxdWVzdGlvbiwgaXMgaXQgcmVxdWlyZWQgZm9yIGRt
YSBwb29sIGFsbG9jYXRpb25zIHRvIHVzZQo+PiBHRlBfQVRPTUlDP8KgIExvb2tzIHRoZXkgY2Fu
IG9ubHkgYmUgY2FsbGVkIGZyb20gbnZtZV9xdWV1ZV9ycSgpLkp1c3QgYXMgYQo+PiB0ZXN0LCBJ
IGNoYW5nZWQgdGhlIGZsYWcgdG8gR0ZQX05PV0FJVCwgYW5kIHRoYXQgc2VlbXMgdG8gYmUgb2su
Cj4gWWVzLCB0aGUgYXRvbWljIGFsbG9jIGlzIGxlZnQgb3ZlciBmcm9tIGEgdGltZSB3aGVuIHRo
aXMgaGFwcGVuZWQgdW5kZXIKPiBhIHNwaW5sb2NrLiBOT1dBSVQgc2hvdWxkIGJlIGZpbmUgaGVy
ZS4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
