Return-Path: <SRS0=73dC=AL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AE2C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 15:37:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3825420675
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 15:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O/+jyoar";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cQcGYOV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3825420675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:References:Message-Id:Date:In-Reply-To:From:
	Subject:Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yCeRpVVAJampl7X1cnDtshZOJwRDj0e/aH5vqm5n1ys=; b=O/+jyoaruRCGIP4T0diSIinzS
	I811OKru4X5GSbYZD8OSh9PNvBrvqdTSyjcXFzmxZZeZlBVym9kusZ7dAERxVrA4usSCzhfvntHM5
	l9JIap2Nrl+ps3QcEaVc4CjYO1hOVJ3uZF0ktiT6/bCMdfVhgan+ubQbzyHVkFuUyqEcW2HpPeOC6
	rdBMXVMmoYC4262Djoz69TAFL5LbwWOiQWVDAQgiyfFzZsytpCDVgicUh8cUpmygpPIfoRRgmpXDy
	wItUw9lI2faQuTcvDtszj+wMx/pVTIpU8hPFGDbKGWewnIeSk6l2+DPcyaW3jxRZDRNXHDiDvTVD7
	8pSoHbvYA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqIJk-0002kX-DX; Tue, 30 Jun 2020 15:37:04 +0000
Received: from aserp2120.oracle.com ([141.146.126.78])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqIJc-0002j4-L1
 for linux-nvme@lists.infradead.org; Tue, 30 Jun 2020 15:37:02 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05UFRH79011561;
 Tue, 30 Jun 2020 15:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=WFrx2Ivk6GmRcmtEBd0GAKfNJC3MPi3NAx49ZLQn9kc=;
 b=cQcGYOV754m3QcdOVjp5z7XkyLgHdJ+bDGb/PP76Ves4+R4ZuU7Dki4PXpWdxckjefzH
 /CNhRfitGQHY5MajPx8cOjK0v2Vh9O6r4PJu3soSON5dDOLIlzEucvQpnxePfhfVWf1I
 pxjFO3BdS/hISDWTg9fApvxhG7VwcPB3RGqJgPqNAu42e8+kaoGCync843e03ujZhtWU
 B2zN8V+QGkD8DUoAqLhko0VpRxgqG0XTr3lbVl5wf1HFWZMhRHlcooADaAUZJkOYccT4
 VXcACvU+U3sjV/gng8NegQtvHVQR1azu2LoxnnWUqQDj3G4cWjd7/GOB7ntQbTEQGsEJ mQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 31xx1dt50d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 30 Jun 2020 15:36:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05UFNkw7051090;
 Tue, 30 Jun 2020 15:34:50 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 31xg1wxurh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2020 15:34:50 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05UFYlab013120;
 Tue, 30 Jun 2020 15:34:48 GMT
Received: from dhcp-10-154-182-99.vpn.oracle.com (/10.154.182.99)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 30 Jun 2020 15:34:47 +0000
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCHv4 2/5] null_blk: introduce zone capacity for zoned device
From: Himanshu Madhani <himanshu.madhani@oracle.com>
In-Reply-To: <20200629190641.1986462-3-kbusch@kernel.org>
Date: Tue, 30 Jun 2020 10:34:46 -0500
Message-Id: <B5094B73-43A2-491E-9DE9-931EFA3854B3@oracle.com>
References: <20200629190641.1986462-1-kbusch@kernel.org>
 <20200629190641.1986462-3-kbusch@kernel.org>
To: Keith Busch <kbusch@kernel.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9667
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9667
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1011 adultscore=0
 suspectscore=3 mlxlogscore=999 cotscore=-2147483648 lowpriorityscore=0
 malwarescore=0 phishscore=0 impostorscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006300112
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200630_113656_873316_6F6459F6 
X-CRM114-Status: GOOD (  27.40  )
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
 Daniel Wagner <dwagner@suse.de>, Aravind Ramesh <aravind.ramesh@wdc.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>, hch@lst.de,
 =?utf-8?Q?Matias_Bj=C3=B8rling?= <matias.bjorling@wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cgo+IE9uIEp1biAyOSwgMjAyMCwgYXQgMjowNiBQTSwgS2VpdGggQnVzY2ggPGtidXNjaEBrZXJu
ZWwub3JnPiB3cm90ZToKPiAKPiBGcm9tOiBBcmF2aW5kIFJhbWVzaCA8YXJhdmluZC5yYW1lc2hA
d2RjLmNvbT4KPiAKPiBBbGxvdyBlbXVsYXRpb24gb2YgYSB6b25lZCBkZXZpY2Ugd2l0aCBhIHBl
ciB6b25lIGNhcGFjaXR5IHNtYWxsZXIgdGhhbgo+IHRoZSB6b25lIHNpemUgYXMgYXMgZGVmaW5l
ZCBpbiB0aGUgWm9uZWQgTmFtZXNwYWNlIChaTlMpIENvbW1hbmQgU2V0Cj4gc3BlY2lmaWNhdGlv
bi4gVGhlIHpvbmUgY2FwYWNpdHkgZGVmYXVsdHMgdG8gdGhlIHpvbmUgc2l6ZSBpZiBub3QKPiBz
cGVjaWZpZWQgYW5kIG11c3QgYmUgc21hbGxlciB0aGFuIHRoZSB6b25lIHNpemUgb3RoZXJ3aXNl
Lgo+IAo+IFJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGNoYWl0YW55YS5rdWxrYXJu
aUB3ZGMuY29tPgo+IFJldmlld2VkLWJ5OiBNYXRpYXMgQmrDuHJsaW5nIDxtYXRpYXMuYmpvcmxp
bmdAd2RjLmNvbT4KPiBSZXZpZXdlZC1ieTogRGFuaWVsIFdhZ25lciA8ZHdhZ25lckBzdXNlLmRl
Pgo+IFJldmlld2VkLWJ5OiBNYXJ0aW4gSy4gUGV0ZXJzZW4gPG1hcnRpbi5wZXRlcnNlbkBvcmFj
bGUuY29tPgo+IFJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1z
aGlybkB3ZGMuY29tPgo+IFJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5k
ZT4KPiBTaWduZWQtb2ZmLWJ5OiBBcmF2aW5kIFJhbWVzaCA8YXJhdmluZC5yYW1lc2hAd2RjLmNv
bT4KPiAtLS0KPiBkcml2ZXJzL2Jsb2NrL251bGxfYmxrLmggICAgICAgfCAgMSArCj4gZHJpdmVy
cy9ibG9jay9udWxsX2Jsa19tYWluLmMgIHwgMTAgKysrKysrKysrLQo+IGRyaXZlcnMvYmxvY2sv
bnVsbF9ibGtfem9uZWQuYyB8IDE2ICsrKysrKysrKysrKysrLS0KPiAzIGZpbGVzIGNoYW5nZWQs
IDI0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvYmxvY2svbnVsbF9ibGsuaCBiL2RyaXZlcnMvYmxvY2svbnVsbF9ibGsuaAo+IGluZGV4IDgx
YjMxMWM5ZDc4MS4uZGFlZDRhOWMzNDM2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvYmxvY2svbnVs
bF9ibGsuaAo+ICsrKyBiL2RyaXZlcnMvYmxvY2svbnVsbF9ibGsuaAo+IEBAIC00OSw2ICs0OSw3
IEBAIHN0cnVjdCBudWxsYl9kZXZpY2Ugewo+IAl1bnNpZ25lZCBsb25nIGNvbXBsZXRpb25fbnNl
YzsgLyogdGltZSBpbiBucyB0byBjb21wbGV0ZSBhIHJlcXVlc3QgKi8KPiAJdW5zaWduZWQgbG9u
ZyBjYWNoZV9zaXplOyAvKiBkaXNrIGNhY2hlIHNpemUgaW4gTUIgKi8KPiAJdW5zaWduZWQgbG9u
ZyB6b25lX3NpemU7IC8qIHpvbmUgc2l6ZSBpbiBNQiBpZiBkZXZpY2UgaXMgem9uZWQgKi8KPiAr
CXVuc2lnbmVkIGxvbmcgem9uZV9jYXBhY2l0eTsgLyogem9uZSBjYXBhY2l0eSBpbiBNQiBpZiBk
ZXZpY2UgaXMgem9uZWQgKi8KPiAJdW5zaWduZWQgaW50IHpvbmVfbnJfY29udjsgLyogbnVtYmVy
IG9mIGNvbnZlbnRpb25hbCB6b25lcyAqLwo+IAl1bnNpZ25lZCBpbnQgc3VibWl0X3F1ZXVlczsg
LyogbnVtYmVyIG9mIHN1Ym1pc3Npb24gcXVldWVzICovCj4gCXVuc2lnbmVkIGludCBob21lX25v
ZGU7IC8qIGhvbWUgbm9kZSBmb3IgdGhlIGRldmljZSAqLwo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2Jsb2NrL251bGxfYmxrX21haW4uYyBiL2RyaXZlcnMvYmxvY2svbnVsbF9ibGtfbWFpbi5jCj4g
aW5kZXggODIyNTkyNDJiOWI1Li45NmQxYWRmNmI4MTggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9i
bG9jay9udWxsX2Jsa19tYWluLmMKPiArKysgYi9kcml2ZXJzL2Jsb2NrL251bGxfYmxrX21haW4u
Ywo+IEBAIC0yMDAsNiArMjAwLDEwIEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIGdfem9uZV9zaXpl
ID0gMjU2Owo+IG1vZHVsZV9wYXJhbV9uYW1lZCh6b25lX3NpemUsIGdfem9uZV9zaXplLCB1bG9u
ZywgU19JUlVHTyk7Cj4gTU9EVUxFX1BBUk1fREVTQyh6b25lX3NpemUsICJab25lIHNpemUgaW4g
TUIgd2hlbiBibG9jayBkZXZpY2UgaXMgem9uZWQuIE11c3QgYmUgcG93ZXItb2YtdHdvOiBEZWZh
dWx0OiAyNTYiKTsKPiAKPiArc3RhdGljIHVuc2lnbmVkIGxvbmcgZ196b25lX2NhcGFjaXR5Owo+
ICttb2R1bGVfcGFyYW1fbmFtZWQoem9uZV9jYXBhY2l0eSwgZ196b25lX2NhcGFjaXR5LCB1bG9u
ZywgMDQ0NCk7Cj4gK01PRFVMRV9QQVJNX0RFU0Moem9uZV9jYXBhY2l0eSwgIlpvbmUgY2FwYWNp
dHkgaW4gTUIgd2hlbiBibG9jayBkZXZpY2UgaXMgem9uZWQuIENhbiBiZSBsZXNzIHRoYW4gb3Ig
ZXF1YWwgdG8gem9uZSBzaXplLiBEZWZhdWx0OiBab25lIHNpemUiKTsKPiArCj4gc3RhdGljIHVu
c2lnbmVkIGludCBnX3pvbmVfbnJfY29udjsKPiBtb2R1bGVfcGFyYW1fbmFtZWQoem9uZV9ucl9j
b252LCBnX3pvbmVfbnJfY29udiwgdWludCwgMDQ0NCk7Cj4gTU9EVUxFX1BBUk1fREVTQyh6b25l
X25yX2NvbnYsICJOdW1iZXIgb2YgY29udmVudGlvbmFsIHpvbmVzIHdoZW4gYmxvY2sgZGV2aWNl
IGlzIHpvbmVkLiBEZWZhdWx0OiAwIik7Cj4gQEAgLTM0MSw2ICszNDUsNyBAQCBOVUxMQl9ERVZJ
Q0VfQVRUUihtYnBzLCB1aW50LCBOVUxMKTsKPiBOVUxMQl9ERVZJQ0VfQVRUUihjYWNoZV9zaXpl
LCB1bG9uZywgTlVMTCk7Cj4gTlVMTEJfREVWSUNFX0FUVFIoem9uZWQsIGJvb2wsIE5VTEwpOwo+
IE5VTExCX0RFVklDRV9BVFRSKHpvbmVfc2l6ZSwgdWxvbmcsIE5VTEwpOwo+ICtOVUxMQl9ERVZJ
Q0VfQVRUUih6b25lX2NhcGFjaXR5LCB1bG9uZywgTlVMTCk7Cj4gTlVMTEJfREVWSUNFX0FUVFIo
em9uZV9ucl9jb252LCB1aW50LCBOVUxMKTsKPiAKPiBzdGF0aWMgc3NpemVfdCBudWxsYl9kZXZp
Y2VfcG93ZXJfc2hvdyhzdHJ1Y3QgY29uZmlnX2l0ZW0gKml0ZW0sIGNoYXIgKnBhZ2UpCj4gQEAg
LTQ1Nyw2ICs0NjIsNyBAQCBzdGF0aWMgc3RydWN0IGNvbmZpZ2ZzX2F0dHJpYnV0ZSAqbnVsbGJf
ZGV2aWNlX2F0dHJzW10gPSB7Cj4gCSZudWxsYl9kZXZpY2VfYXR0cl9iYWRibG9ja3MsCj4gCSZu
dWxsYl9kZXZpY2VfYXR0cl96b25lZCwKPiAJJm51bGxiX2RldmljZV9hdHRyX3pvbmVfc2l6ZSwK
PiArCSZudWxsYl9kZXZpY2VfYXR0cl96b25lX2NhcGFjaXR5LAo+IAkmbnVsbGJfZGV2aWNlX2F0
dHJfem9uZV9ucl9jb252LAo+IAlOVUxMLAo+IH07Cj4gQEAgLTUxMCw3ICs1MTYsOCBAQCBudWxs
Yl9ncm91cF9kcm9wX2l0ZW0oc3RydWN0IGNvbmZpZ19ncm91cCAqZ3JvdXAsIHN0cnVjdCBjb25m
aWdfaXRlbSAqaXRlbSkKPiAKPiBzdGF0aWMgc3NpemVfdCBtZW1iX2dyb3VwX2ZlYXR1cmVzX3No
b3coc3RydWN0IGNvbmZpZ19pdGVtICppdGVtLCBjaGFyICpwYWdlKQo+IHsKPiAtCXJldHVybiBz
bnByaW50ZihwYWdlLCBQQUdFX1NJWkUsICJtZW1vcnlfYmFja2VkLGRpc2NhcmQsYmFuZHdpZHRo
LGNhY2hlLGJhZGJsb2Nrcyx6b25lZCx6b25lX3NpemUsem9uZV9ucl9jb252XG4iKTsKPiArCXJl
dHVybiBzbnByaW50ZihwYWdlLCBQQUdFX1NJWkUsCj4gKwkJCSJtZW1vcnlfYmFja2VkLGRpc2Nh
cmQsYmFuZHdpZHRoLGNhY2hlLGJhZGJsb2Nrcyx6b25lZCx6b25lX3NpemUsem9uZV9jYXBhY2l0
eSx6b25lX25yX2NvbnZcbiIpOwo+IH0KPiAKPiBDT05GSUdGU19BVFRSX1JPKG1lbWJfZ3JvdXBf
LCBmZWF0dXJlcyk7Cj4gQEAgLTU3MSw2ICs1NzgsNyBAQCBzdGF0aWMgc3RydWN0IG51bGxiX2Rl
dmljZSAqbnVsbF9hbGxvY19kZXYodm9pZCkKPiAJZGV2LT51c2VfcGVyX25vZGVfaGN0eCA9IGdf
dXNlX3Blcl9ub2RlX2hjdHg7Cj4gCWRldi0+em9uZWQgPSBnX3pvbmVkOwo+IAlkZXYtPnpvbmVf
c2l6ZSA9IGdfem9uZV9zaXplOwo+ICsJZGV2LT56b25lX2NhcGFjaXR5ID0gZ196b25lX2NhcGFj
aXR5Owo+IAlkZXYtPnpvbmVfbnJfY29udiA9IGdfem9uZV9ucl9jb252Owo+IAlyZXR1cm4gZGV2
Owo+IH0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibG9jay9udWxsX2Jsa196b25lZC5jIGIvZHJp
dmVycy9ibG9jay9udWxsX2Jsa196b25lZC5jCj4gaW5kZXggNjI0YWFjMDliMDA1Li4zZDI1Yzlh
ZDIzODMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ibG9jay9udWxsX2Jsa196b25lZC5jCj4gKysr
IGIvZHJpdmVycy9ibG9jay9udWxsX2Jsa196b25lZC5jCj4gQEAgLTI4LDYgKzI4LDE1IEBAIGlu
dCBudWxsX2luaXRfem9uZWRfZGV2KHN0cnVjdCBudWxsYl9kZXZpY2UgKmRldiwgc3RydWN0IHJl
cXVlc3RfcXVldWUgKnEpCj4gCQlyZXR1cm4gLUVJTlZBTDsKPiAJfQo+IAo+ICsJaWYgKCFkZXYt
PnpvbmVfY2FwYWNpdHkpCj4gKwkJZGV2LT56b25lX2NhcGFjaXR5ID0gZGV2LT56b25lX3NpemU7
Cj4gKwo+ICsJaWYgKGRldi0+em9uZV9jYXBhY2l0eSA+IGRldi0+em9uZV9zaXplKSB7Cj4gKwkJ
cHJfZXJyKCJudWxsX2Jsazogem9uZSBjYXBhY2l0eSAoJWx1IE1CKSBsYXJnZXIgdGhhbiB6b25l
IHNpemUgKCVsdSBNQilcbiIsCj4gKwkJCQkJZGV2LT56b25lX2NhcGFjaXR5LCBkZXYtPnpvbmVf
c2l6ZSk7Cj4gKwkJcmV0dXJuIC1FSU5WQUw7Cj4gKwl9Cj4gKwo+IAlkZXYtPnpvbmVfc2l6ZV9z
ZWN0cyA9IGRldi0+em9uZV9zaXplIDw8IFpPTkVfU0laRV9TSElGVDsKPiAJZGV2LT5ucl96b25l
cyA9IGRldl9zaXplID4+Cj4gCQkJCShTRUNUT1JfU0hJRlQgKyBpbG9nMihkZXYtPnpvbmVfc2l6
ZV9zZWN0cykpOwo+IEBAIC02MCw3ICs2OSw3IEBAIGludCBudWxsX2luaXRfem9uZWRfZGV2KHN0
cnVjdCBudWxsYl9kZXZpY2UgKmRldiwgc3RydWN0IHJlcXVlc3RfcXVldWUgKnEpCj4gCj4gCQl6
b25lLT5zdGFydCA9IHpvbmUtPndwID0gc2VjdG9yOwo+IAkJem9uZS0+bGVuID0gZGV2LT56b25l
X3NpemVfc2VjdHM7Cj4gLQkJem9uZS0+Y2FwYWNpdHkgPSB6b25lLT5sZW47Cj4gKwkJem9uZS0+
Y2FwYWNpdHkgPSBkZXYtPnpvbmVfY2FwYWNpdHkgPDwgWk9ORV9TSVpFX1NISUZUOwo+IAkJem9u
ZS0+dHlwZSA9IEJMS19aT05FX1RZUEVfU0VRV1JJVEVfUkVROwo+IAkJem9uZS0+Y29uZCA9IEJM
S19aT05FX0NPTkRfRU1QVFk7Cj4gCj4gQEAgLTE4Nyw2ICsxOTYsOSBAQCBzdGF0aWMgYmxrX3N0
YXR1c190IG51bGxfem9uZV93cml0ZShzdHJ1Y3QgbnVsbGJfY21kICpjbWQsIHNlY3Rvcl90IHNl
Y3RvciwKPiAJCQlyZXR1cm4gQkxLX1NUU19JT0VSUjsKPiAJCX0KPiAKPiArCQlpZiAoem9uZS0+
d3AgKyBucl9zZWN0b3JzID4gem9uZS0+c3RhcnQgKyB6b25lLT5jYXBhY2l0eSkKPiArCQkJcmV0
dXJuIEJMS19TVFNfSU9FUlI7Cj4gKwo+IAkJaWYgKHpvbmUtPmNvbmQgIT0gQkxLX1pPTkVfQ09O
RF9FWFBfT1BFTikKPiAJCQl6b25lLT5jb25kID0gQkxLX1pPTkVfQ09ORF9JTVBfT1BFTjsKPiAK
PiBAQCAtMTk1LDcgKzIwNyw3IEBAIHN0YXRpYyBibGtfc3RhdHVzX3QgbnVsbF96b25lX3dyaXRl
KHN0cnVjdCBudWxsYl9jbWQgKmNtZCwgc2VjdG9yX3Qgc2VjdG9yLAo+IAkJCXJldHVybiByZXQ7
Cj4gCj4gCQl6b25lLT53cCArPSBucl9zZWN0b3JzOwo+IC0JCWlmICh6b25lLT53cCA9PSB6b25l
LT5zdGFydCArIHpvbmUtPmxlbikKPiArCQlpZiAoem9uZS0+d3AgPT0gem9uZS0+c3RhcnQgKyB6
b25lLT5jYXBhY2l0eSkKPiAJCQl6b25lLT5jb25kID0gQkxLX1pPTkVfQ09ORF9GVUxMOwo+IAkJ
cmV0dXJuIEJMS19TVFNfT0s7Cj4gCWRlZmF1bHQ6Cj4g4oCUCj4gMi4yNC4xCj4gCgpSZXZpZXdl
ZC1ieTogSGltYW5zaHUgTWFkaGFuaSA8aGltYW5zaHUubWFkaGFuaUBvcmFjbGUuY29tPgoKLS0K
SGltYW5zaHUgTWFkaGFuaQlPcmFjbGUgTGludXggRW5naW5lZXJpbmcKCgoKCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5n
IGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
