Return-Path: <SRS0=W9vg=7X=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF01EC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2020 14:56:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A52DF2072F
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2020 14:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JjvssfdM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fh5YU57L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52DF2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7NQBZOfJ5vnSQzQEcrX2Slm+N9nLo1aqJREXfLFjx0s=; b=JjvssfdMbvs1IY
	OREq5cmC5Nga2xIzYAdhUgeIybK6QpYkF0QS7g/8kS1ozIF/C6xjhTOO+R+gsDzk4+PbnIGM3F8sZ
	CXmsOevqsQy2gh1o0BDQqTQy1ZvabdoeNMnXB25H9yMFZtdkLmrTzGdHZpcwodQJu/7ip6NREJl9l
	Y4rAp9dKTrnGibC9387+Ed3kepJjBxBAuJgQVnqMzy5IRX482+LnI+YjWuR55z43vCbJouC0BrjNV
	hWl4WCvQMDKalOXA8PLB4InYWbRDv96kCVK0yBJUGFjM376PbgKs/gJ6qz1BbfGwe6dwM7GZmjfp/
	nM72Jzq0+l2nml01aQ5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jj294-00086q-9g; Wed, 10 Jun 2020 14:56:02 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jj291-00086D-Gr
 for linux-nvme@lists.infradead.org; Wed, 10 Jun 2020 14:56:01 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05AEqMPa046210;
 Wed, 10 Jun 2020 14:53:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=+MkVzWy7hSx4wdwuzJRJZjRevMWLr+97rQSWPuRETeI=;
 b=Fh5YU57LjGtgILZhyagxCJiKu4+KGIutZ5E9PylZp1Qo5JxWx2sdx1km+teF5HpB/a6Y
 +v/mQIhiwB70zeeL6scNIb2z8RPcYg5Erj51xoP8eYmicfNMe6rRTMFP8AWdwcFHfWEh
 zUKNKLZSX6N17fHLjKr1Nd1gbAE/HEbmt2OtJogrNBJb82X7D/quTe7U5//urcAo3qs5
 0malmVNVWml0c0tESY9EcRYvcmIGCsKFbMMN0ZrJdWOcD+Zv5Ws+fywrNKaj/F4ubd6G
 eEmoRBXwje+OuAgP6QfwhPM9kHvClr+5A6DodADS3CcKGBw03E/87H91mpCguJbEIIz4 8Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 31g2jravr5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 10 Jun 2020 14:53:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05AEi0us135392;
 Wed, 10 Jun 2020 14:53:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 31gmqqdenw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jun 2020 14:53:36 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05AErZYO021813;
 Wed, 10 Jun 2020 14:53:36 GMT
Received: from [10.159.156.250] (/10.159.156.250)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 10 Jun 2020 07:53:34 -0700
Subject: Re: [PATCH 1/1] nvme-fcloop: verify wwnn and wwpn format
To: James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org,
 hch@lst.de
References: <20200526042118.17836-1-dongli.zhang@oracle.com>
 <60df6752-3512-f7a9-b0df-1096b93b8eda@broadcom.com>
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <f93adee4-ebf0-a229-e507-4ef4e4fe812d@oracle.com>
Date: Wed, 10 Jun 2020 07:53:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <60df6752-3512-f7a9-b0df-1096b93b8eda@broadcom.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006100112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006100113
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200610_075559_647439_919A8077 
X-CRM114-Status: GOOD (  17.70  )
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
Cc: sagi@grimberg.me, chaitanya.kulkarni@wdc.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGkgQ2hyaXN0b3BoLAoKV291bGQgeW91IG1pbmQgYXBwbHkgdGhpcyBvbmUgd2l0aCB0aGUgUmV2
aWV3ZWQtYnkgZnJvbSBKYW1lcyBhbmQgU2FnaT8KCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LW52bWUvNjBkZjY3NTItMzUxMi1mN2E5LWIwZGYtMTA5NmI5M2I4ZWRhQGJyb2FkY29tLmNv
bS8KCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW52bWUvYzRlYzJkOWUtYjA4Yy0xOWIy
LTE2YTUtOTM1MjBjYTEzYzJlQGdyaW1iZXJnLm1lLwoKVGhhbmsgeW91IHZlcnkgbXVjaCEKCkRv
bmdsaSBaaGFuZwoKT24gNi80LzIwIDg6MjAgQU0sIEphbWVzIFNtYXJ0IHdyb3RlOgo+IE9uIDUv
MjUvMjAyMCA5OjIxIFBNLCBEb25nbGkgWmhhbmcgd3JvdGU6Cj4+IFRoZSBudm1lIGhvc3QgYW5k
IHRhcmdldCB2ZXJpZnkgdGhlIHd3bm4gYW5kIHd3cG4gZm9ybWF0IHZpYQo+PiBudm1lX2ZjX3Bh
cnNlX3RyYWRkcigpLiBGb3IgaW5zdGFuY2UsIGl0IGlzIHJlcXVpcmVkIHRoYXQgdGhlIGxlbmd0
aCBvZgo+PiB3d25uIHRvIGJlIGVpdGhlciAyMSAoIm5uLTB4Iikgb3IgMTkgKG5uLSkuCj4+Cj4+
IEFkZCB0aGlzIHZlcmlmaWNhdGlvbiB0byBudm1lLWZjbG9vcCBzbyB0aGF0IHRoZSBpbnB1dCBz
aG91bGQgYWx3YXlzIGJlIGluCj4+IGhleCBhbmQgdGhlIGxlbmd0aCBvZiBpbnB1dCBzaG91bGQg
YWx3YXlzIGJlIDE4Lgo+Pgo+PiBPdGhlcndpc2UsIHRoZSB1c2VyIG1heSB1c2UgZS5nLiAweDIg
dG8gY3JlYXRlIGZjbG9vcCBsb2NhbCBwb3J0LCB3aGlsZQo+PiAweDAwMDAwMDAwMDAwMDAwMDIg
aXMgcmVxdWlyZWQgZm9yIG52bWUgaG9zdCBhbmQgdGFyZ2V0LiBUaGlzIG1ha2VzIHRoZQo+PiBy
ZXF1aXJlbWVudCBvZiBmb3JtYXQgY29uZnVzaW5nLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBEb25n
bGkgWmhhbmcgPGRvbmdsaS56aGFuZ0BvcmFjbGUuY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9u
dm1lL3RhcmdldC9mY2xvb3AuYyB8IDI5ICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tCj4+
IMKgIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+Pgo+
Pgo+IAo+IFJldmlld2VkLWJ5OiBKYW1lcyBTbWFydCA8amFtZXMuc21hcnRAYnJvYWRjb20uY29t
Pgo+IAo+IExvb2tzIGdvb2QuIFNvcnJ5IGZvciB0aGUgZGVsYXkuCj4gCj4gLS0gamFtZXMKPiAK
PiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
