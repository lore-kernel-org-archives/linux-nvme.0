Return-Path: <SRS0=KSy6=7J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69437C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2020 18:07:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432D42075A
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2020 18:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ct+K4QmI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UDLPzB3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432D42075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nlYq6+w46NQcATOQvj56HphII50o6WuPL6893ro5Alo=; b=ct+K4QmIr3ta5YsTPOEheOscb
	VRxT7ozIgt2Hb6ZwJhkQobBQbLl+e8zPWRFHaKIxB1tlf/wN/nxkTUahqtQcvJi/KKKtin0+zRehi
	R+cf7XxrdQ7C0XZzuU9uD3362AoFcmvDrAzD1x2jBGPvnf+XZkEX6nRnKVX+rHim/SF7aDNlLKSqz
	AMx+Wj8vc9FXxrmnxHi7pCNI9CnWiLkrMDHEQaRY6s7Bj+yvHlRpMcqqjqSgoCkgHSq37dCe6/kyG
	WfjqFpyTJtzeVKYaWn2GK2LmlS5NFX+o5VLVJ516Q52/l7X5Wa+twtjix7pEGAx29KvceD5HEIU+h
	RJjm/asFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1je0SQ-00053G-OY; Wed, 27 May 2020 18:07:14 +0000
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1je0SL-00052Q-PB
 for linux-nvme@lists.infradead.org; Wed, 27 May 2020 18:07:12 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04RI28Lb120155;
 Wed, 27 May 2020 18:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=+h/gGcyWHKhcDMgy1dZJ30IPaBXOLlyVVZC9lm/roic=;
 b=UDLPzB3nXuSobGjgTr+BHjwz619MBmLwPHTthZ4nF1kKAzf9jKtuPiUkhOfh0s56hR2W
 dgNJi42vitdXgqHmhVE+3FrszPO0IQ7ylV9PI6xv1JyhlnHrrZS6vsdcC7vB3uM2DlQV
 f679+fDixQgCl9PJaboj5TW/e8r7+bZ38HZDmWo2gKaM7nRgm48Q4Ohe/tNAuT9fZuTn
 1obDRnQH/6STxQRIj8stypxIGDglDDXJ1gTppBpgX3fH3/wsIfX/wHjezqDD7DK2nKOX
 uArLXsLGpNWptMeZ+XuMyIfze/2NYUJQkYoiSnKefVsemF+KXfukjMKq9oAMJXAd5g3g Cg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 318xe1gytx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 May 2020 18:07:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04RI357h150070;
 Wed, 27 May 2020 18:07:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 317ddr7xe3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 May 2020 18:07:06 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04RI75JA025708;
 Wed, 27 May 2020 18:07:05 GMT
Received: from dhcp-10-76-241-128.usdhcp.oraclecorp.com (/10.76.241.128)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 27 May 2020 11:07:05 -0700
Subject: Re: [PATCH 0/3] blk-mq/nvme: improve nvme-pci reset handler
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
References: <20200520115655.729705-1-ming.lei@redhat.com>
From: Alan Adamson <alan.adamson@oracle.com>
Message-ID: <22083f76-43f5-38a1-0e2d-84b626a6fd50@oracle.com>
Date: Wed, 27 May 2020 11:09:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520115655.729705-1-ming.lei@redhat.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9633
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=4 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9633
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 adultscore=0 cotscore=-2147483648 mlxscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=4 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200527_110709_902837_0AF9854E 
X-CRM114-Status: GOOD (  22.00  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SSB0ZXN0ZWQgdGhpcyBwYXRjaCBhZ2FpbnN0IGEgdGltZW91dCB0ZXN0IEkndmUgYmVlbiB3b3Jr
aW5nIHdpdGggYW5kIApJJ20gZ2V0dGluZyBhIGhhbmcuCgojIGNhdCBibG9jay1lcnIuc2gKc2V0
IC14CmVjaG8gMTAwID4gL3N5cy9rZXJuZWwvZGVidWcvZmFpbF9pb190aW1lb3V0L3Byb2JhYmls
aXR5CmVjaG8gMTAwMCA+IC9zeXMva2VybmVsL2RlYnVnL2ZhaWxfaW9fdGltZW91dC90aW1lcwpl
Y2hvIDEgPiAvc3lzL2Jsb2NrL252bWUwbjEvaW8tdGltZW91dC1mYWlsCmRkIGlmPS9kZXYvbnZt
ZTBuMSBvZj0vZGV2L251bGwgYnM9NTEyIGNvdW50PTEKCgojIHNowqAgYmxvY2stZXJyLnNoCisg
ZWNobyAxMDAKKyBlY2hvIDEwMDAKKyBlY2hvIDEKKyBkZCBpZj0vZGV2L252bWUwbjEgb2Y9L2Rl
di9udWxsIGJzPTUxMiBjb3VudD0xCgoqKioqIEhhbmcgKioqKgoKIyBkbWVzZwouCi4KLgpbwqDC
oCA3OS40MDMyNTNdIEZBVUxUX0lOSkVDVElPTjogZm9yY2luZyBhIGZhaWx1cmUuCiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5hbWUgZmFpbF9pb190aW1lb3V0LCBpbnRlcnZhbCAxLCBw
cm9iYWJpbGl0eSAxMDAsIHNwYWNlIAowLCB0aW1lcyAxMDAwClvCoMKgIDc5LjQwMzI1NV0gQ1BV
OiA1IFBJRDogMCBDb21tOiBzd2FwcGVyLzUgTm90IHRhaW50ZWQgNS43LjAtcmM3KyAjMQpbwqDC
oCA3OS40MDMyNTZdIEhhcmR3YXJlIG5hbWU6IE9yYWNsZSBDb3Jwb3JhdGlvbiBPUkFDTEUgU0VS
VkVSIApYNi0yL0FTTSxNT1RIRVJCT0FSRCwxVSwgQklPUyAzODA1MDEwMCAwOC8zMC8yMDE2ClvC
oMKgIDc5LjQwMzI1N10gQ2FsbCBUcmFjZToKW8KgwqAgNzkuNDAzMjU5XcKgIDxJUlE+ClvCoMKg
IDc5LjQwMzI2N13CoCBkdW1wX3N0YWNrKzB4NmQvMHg5YQpbwqDCoCA3OS40MDMyNzBdwqAgc2hv
dWxkX2ZhaWwuY29sZC41KzB4MzIvMHg0MgpbwqDCoCA3OS40MDMyNzNdwqAgYmxrX3Nob3VsZF9m
YWtlX3RpbWVvdXQrMHgyNi8weDMwClvCoMKgIDc5LjQwMzI3NV3CoCBibGtfbXFfY29tcGxldGVf
cmVxdWVzdCsweDFiLzB4MTIwClvCoMKgIDc5LjQwMzI4MF3CoCBudm1lX2lycSsweGQ5LzB4MWYw
IFtudm1lXQpbwqDCoCA3OS40MDMyODddwqAgX19oYW5kbGVfaXJxX2V2ZW50X3BlcmNwdSsweDQ0
LzB4MTkwClvCoMKgIDc5LjQwMzI4OF3CoCBoYW5kbGVfaXJxX2V2ZW50X3BlcmNwdSsweDMyLzB4
ODAKW8KgwqAgNzkuNDAzMjkwXcKgIGhhbmRsZV9pcnFfZXZlbnQrMHgzYi8weDVhClvCoMKgIDc5
LjQwMzI5MV3CoCBoYW5kbGVfZWRnZV9pcnErMHg4Ny8weDE5MApbwqDCoCA3OS40MDMyOTZdwqAg
ZG9fSVJRKzB4NTQvMHhlMApbwqDCoCA3OS40MDMyOTldwqAgY29tbW9uX2ludGVycnVwdCsweGYv
MHhmClvCoMKgIDc5LjQwMzMwMF3CoCA8L0lSUT4KW8KgwqAgNzkuNDAzMzA1XSBSSVA6IDAwMTA6
Y3B1aWRsZV9lbnRlcl9zdGF0ZSsweGMxLzB4NDAwClvCoMKgIDc5LjQwMzMwN10gQ29kZTogZmYg
ZTggZTMgNDEgOTMgZmYgODAgN2QgYzcgMDAgNzQgMTcgOWMgNTggMGYgMWYgNDQgCjAwIDAwIGY2
IGM0IDAyIDBmIDg1IGQyIDAyIDAwIDAwIDMxIGZmIGU4IDE2IGMzIDk5IGZmIGZiIDY2IDBmIDFm
IDQ0IDAwIAowMCA8NDU+IDg1IGU0IDBmIDg4IDNkIDAyIDAwIDAwIDQ5IDYzIGM0IDQ4IDhkIDE0
IDQwIDQ4IDhkIDBjIGM1IDAwIDAwClvCoMKgIDc5LjQwMzMwOF0gUlNQOiAwMDE4OmZmZmZiOTdl
OGM1NGJlNDAgRUZMQUdTOiAwMDAwMDI0NiBPUklHX1JBWDogCmZmZmZmZmZmZmZmZmZmZGQKW8Kg
wqAgNzkuNDAzMzA5XSBSQVg6IGZmZmY5NzgxYmY3NmNjNDAgUkJYOiBmZmZmZDk1ZTdmNzQzMjAw
IFJDWDogCjAwMDAwMDAwMDAwMDAwMWYKW8KgwqAgNzkuNDAzMzEwXSBSRFg6IDAwMDAwMDEyN2Nj
ZDZlNmMgUlNJOiAwMDAwMDAwMDMxNTczODYyIFJESTogCjAwMDAwMDAwMDAwMDAwMDAKW8KgwqAg
NzkuNDAzMzEwXSBSQlA6IGZmZmZiOTdlOGM1NGJlODAgUjA4OiAwMDAwMDAwMDAwMDAwMDAyIFIw
OTogCjAwMDAwMDAwMDAwMmM0YzAKW8KgwqAgNzkuNDAzMzExXSBSMTA6IDAxMWI5MjFlNTgwYmM0
NTQgUjExOiBmZmZmOTc4MWJmNzZiYjQ0IFIxMjogCjAwMDAwMDAwMDAwMDAwMDIKW8KgwqAgNzku
NDAzMzExXSBSMTM6IGZmZmZmZmZmYmQxNGMxMjAgUjE0OiBmZmZmZmZmZmJkMTRjMjA4IFIxNTog
CmZmZmZmZmZmYmQxNGMxZjAKW8KgwqAgNzkuNDAzMzE0XcKgIGNwdWlkbGVfZW50ZXIrMHgyZS8w
eDQwClvCoMKgIDc5LjQwMzMxOF3CoCBjYWxsX2NwdWlkbGUrMHgyMy8weDQwClvCoMKgIDc5LjQw
MzMxOV3CoCBkb19pZGxlKzB4MjMwLzB4MjcwClvCoMKgIDc5LjQwMzMyMF3CoCBjcHVfc3RhcnR1
cF9lbnRyeSsweDFkLzB4MjAKW8KgwqAgNzkuNDAzMzI1XcKgIHN0YXJ0X3NlY29uZGFyeSsweDE3
MC8weDFjMApbwqDCoCA3OS40MDMzMjldwqAgc2Vjb25kYXJ5X3N0YXJ0dXBfNjQrMHhiNi8weGMw
ClvCoCAxMDkuNjc0MzM0XSBudm1lIG52bWUwOiBJL08gNzU0IFFJRCAzNCB0aW1lb3V0LCBhYm9y
dGluZwpbwqAgMTA5LjY3NDM5NV0gbnZtZSBudm1lMDogQWJvcnQgc3RhdHVzOiAweDAKW8KgIDEz
OS44Nzk0NTNdIG52bWUgbnZtZTA6IEkvTyA3NTQgUUlEIDM0IHRpbWVvdXQsIHJlc2V0IGNvbnRy
b2xsZXIKW8KgIDEzOS44OTUyNjNdIEZBVUxUX0lOSkVDVElPTjogZm9yY2luZyBhIGZhaWx1cmUu
CiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5hbWUgZmFpbF9pb190aW1lb3V0LCBpbnRl
cnZhbCAxLCBwcm9iYWJpbGl0eSAxMDAsIHNwYWNlIAowLCB0aW1lcyA5OTkKW8KgIDEzOS44OTUy
NjVdIENQVTogNSBQSUQ6IDI0NzAgQ29tbToga3dvcmtlci81OjFIIE5vdCB0YWludGVkIDUuNy4w
LXJjNysgIzEKW8KgIDEzOS44OTUyNjZdIEhhcmR3YXJlIG5hbWU6IE9yYWNsZSBDb3Jwb3JhdGlv
biBPUkFDTEUgU0VSVkVSIApYNi0yL0FTTSxNT1RIRVJCT0FSRCwxVSwgQklPUyAzODA1MDEwMCAw
OC8zMC8yMDE2ClvCoCAxMzkuODk1MjcxXSBXb3JrcXVldWU6IGtibG9ja2QgYmxrX21xX3RpbWVv
dXRfd29yawpbwqAgMTM5Ljg5NTI3Ml0gQ2FsbCBUcmFjZToKW8KgIDEzOS44OTUyNzldwqAgZHVt
cF9zdGFjaysweDZkLzB4OWEKW8KgIDEzOS44OTUyODFdwqAgc2hvdWxkX2ZhaWwuY29sZC41KzB4
MzIvMHg0MgpbwqAgMTM5Ljg5NTI4Ml3CoCBibGtfc2hvdWxkX2Zha2VfdGltZW91dCsweDI2LzB4
MzAKW8KgIDEzOS44OTUyODNdwqAgYmxrX21xX2NvbXBsZXRlX3JlcXVlc3QrMHgxYi8weDEyMApb
wqAgMTM5Ljg5NTI5Ml3CoCBudm1lX2NhbmNlbF9yZXF1ZXN0KzB4MzMvMHg4MCBbbnZtZV9jb3Jl
XQpbwqAgMTM5Ljg5NTI5Nl3CoCBidF90YWdzX2l0ZXIrMHg0OC8weDUwClvCoCAxMzkuODk1Mjk3
XcKgIGJsa19tcV90YWdzZXRfYnVzeV9pdGVyKzB4MWViLzB4MjcwClvCoCAxMzkuODk1Mjk5XcKg
ID8gbnZtZV90cnlfc2NoZWRfcmVzZXQrMHg0MC8weDQwIFtudm1lX2NvcmVdClvCoCAxMzkuODk1
MzAxXcKgID8gbnZtZV90cnlfc2NoZWRfcmVzZXQrMHg0MC8weDQwIFtudm1lX2NvcmVdClvCoCAx
MzkuODk1MzA1XcKgIG52bWVfZGV2X2Rpc2FibGUrMHgyYmUvMHg0NjAgW252bWVdClvCoCAxMzku
ODk1MzA3XcKgIG52bWVfdGltZW91dC5jb2xkLjgwKzB4OWMvMHgxODIgW252bWVdClvCoCAxMzku
ODk1MzExXcKgID8gc2NoZWRfY2xvY2srMHg5LzB4MTAKW8KgIDEzOS44OTUzMTVdwqAgPyBzY2hl
ZF9jbG9ja19jcHUrMHgxMS8weGMwClvCoCAxMzkuODk1MzIwXcKgID8gX19zd2l0Y2hfdG9fYXNt
KzB4NDAvMHg3MApbwqAgMTM5Ljg5NTMyMV3CoCBibGtfbXFfY2hlY2tfZXhwaXJlZCsweDE5Mi8w
eDFiMApbwqAgMTM5Ljg5NTMyMl3CoCBidF9pdGVyKzB4NTIvMHg2MApbwqAgMTM5Ljg5NTMyM13C
oCBibGtfbXFfcXVldWVfdGFnX2J1c3lfaXRlcisweDFhMC8weDJlMApbwqAgMTM5Ljg5NTMyNV3C
oCA/IF9fc3dpdGNoX3RvX2FzbSsweDQwLzB4NzAKW8KgIDEzOS44OTUzMjZdwqAgPyBfX2Jsa19t
cV9yZXF1ZXVlX3JlcXVlc3QrMHhmMC8weGYwClvCoCAxMzkuODk1MzI2XcKgID8gX19ibGtfbXFf
cmVxdWV1ZV9yZXF1ZXN0KzB4ZjAvMHhmMApbwqAgMTM5Ljg5NTMyOV3CoCA/IGNvbXBhdF9zdGFy
dF90aHJlYWQrMHgyMC8weDQwClvCoCAxMzkuODk1MzMwXcKgIGJsa19tcV90aW1lb3V0X3dvcmsr
MHg1YS8weDEzMApbwqAgMTM5Ljg5NTMzM13CoCBwcm9jZXNzX29uZV93b3JrKzB4MWFiLzB4Mzgw
ClvCoCAxMzkuODk1MzM0XcKgIHdvcmtlcl90aHJlYWQrMHgzNy8weDNiMApbwqAgMTM5Ljg5NTMz
NV3CoCBrdGhyZWFkKzB4MTIwLzB4MTQwClvCoCAxMzkuODk1MzM3XcKgID8gY3JlYXRlX3dvcmtl
cisweDFiMC8weDFiMApbwqAgMTM5Ljg5NTMzN13CoCA/IGt0aHJlYWRfcGFyaysweDkwLzB4OTAK
W8KgIDEzOS44OTUzMzldwqAgcmV0X2Zyb21fZm9yaysweDM1LzB4NDAKW8KgIDEzOS44OTc4NTld
IG52bWUgbnZtZTA6IFNodXRkb3duIHRpbWVvdXQgc2V0IHRvIDEwIHNlY29uZHMKW8KgIDEzOS45
MDExODZdIG52bWUgbnZtZTA6IDU2LzAvMCBkZWZhdWx0L3JlYWQvcG9sbCBxdWV1ZXMKCk9uIDUv
MjAvMjAgNDo1NiBBTSwgTWluZyBMZWkgd3JvdGU6Cj4gSGksCj4KPiBGb3IgbnZtZS1wY2ksIGFm
dGVyIGNvbnRyb2xsZXIgaXMgcmVjb3ZlcmVkLCBpbi1mbGlnaHQgSU9zIGFyZSB3YWl0ZWQKPiBi
ZWZvcmUgdXBkYXRpbmcgbnIgaHcgcXVldWVzLiBJZiBuZXcgY29udHJvbGxlciBlcnJvciBoYXBw
ZW5zIGR1cmluZwo+IHRoaXMgcGVyaW9kLCBudm1lLXBjaSBkcml2ZXIgZGVsZXRlcyB0aGUgY29u
dHJvbGxlciBhbmQgZmFpbHMgaW4tZmxpZ2h0Cj4gSU8uIFRoaXMgd2F5IGlzIHRvbyB2aW9sZW50
LCBhbmQgbm90IGZyaWVuZGx5IGZyb20gdXNlciB2aWV3cG9pbnQuCj4KPiBBZGQgQVBJcyBmb3Ig
Y2hlY2tpbmcgaWYgcXVldWUgaXMgZnJvemVuLCBhbmQgcmVwbGFjZSBudm1lX3dhaXRfZnJlZXpl
Cj4gaW4gbnZtZS1wY2kgcmVzZXQgaGFuZGxlciB3aXRoIGNoZWNraW5nIGlmIGFsbCBucyBxdWV1
ZXMgYXJlIGZyb3plbiAmCj4gY29udHJvbGxlciBkaXNhYmxlZC4gVGhlbiBhIGZyZXNoIG5ldyBy
ZXNldCBjYW4gYmUgc2NoZWR1bGVkIGZvcgo+IGhhbmRsaW5nIG5ldyBjb250cm9sbGVyIGVycm9y
IGR1cmluZyB3YWl0aW5nIGZvciBpbi1mbGlnaHQgSU8gY29tcGxldGlvbi4KPgo+IFNvIGRlbGV0
aW5nIGNvbnRyb2xsZXIgJiBmYWlsaW5nIElPcyBjYW4gYmUgYXZvaWRlZCBpbiB0aGlzIHNpdHVh
dGlvbi4KPgo+IFdpdGhvdXQgdGhpcyBwYXRjaGVzLCB3aGVuIGZhaWwgaW8gdGltZW91dCBpbmpl
Y3Rpb24gaXMgcnVuLCB0aGUKPiBjb250cm9sbGVyIGNhbiBiZSByZW1vdmVkIHZlcnkgcXVpY2ts
eS4gV2l0aCB0aGlzIHBhdGNoLCBubyBjb250cm9sbGVyCj4gcmVtb3ZpbmcgY2FuIGJlIG9ic2Vy
dmVkLCBhbmQgY29udHJvbGxlciBjYW4gcmVjb3ZlciB0byBub3JtYWwgc3RhdGUKPiBhZnRlciBz
dG9wcGluZyB0byBpbmplY3QgaW8gdGltZW91dCBmYWlsdXJlLgo+Cj4gTWluZyBMZWkgKDMpOgo+
ICAgIGJsay1tcTogYWRkIEFQSSBvZiBibGtfbXFfcXVldWVfZnJvemVuCj4gICAgbnZtZTogYWRk
IG52bWVfZnJvemVuCj4gICAgbnZtZS1wY2k6IG1ha2UgbnZtZSByZXNldCBtb3JlIHJlbGlhYmxl
Cj4KPiAgIGJsb2NrL2Jsay1tcS5jICAgICAgICAgICB8ICA2ICsrKysrKwo+ICAgZHJpdmVycy9u
dm1lL2hvc3QvY29yZS5jIHwgMTQgKysrKysrKysrKysrKysKPiAgIGRyaXZlcnMvbnZtZS9ob3N0
L252bWUuaCB8ICAxICsKPiAgIGRyaXZlcnMvbnZtZS9ob3N0L3BjaS5jICB8IDM3ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0KPiAgIGluY2x1ZGUvbGludXgvYmxrLW1xLmgg
ICB8ICAxICsKPiAgIDUgZmlsZXMgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlv
bnMoLSkKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
