Return-Path: <SRS0=tokg=44=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D674DC10DCE
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Mar 2020 00:54:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84F6120663
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Mar 2020 00:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jTIP92XT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MIxbfbkQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F6120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3k/3CAqOEdV+FRuz19C2lw4XsNvK9Bp7NrwYt3xuvs8=; b=jTIP92XTbqA4xu5CU/ey5Vehc
	RfDrAV/MKQMJeZoKJZjvfTkbYCNPYN0QUAKX8KDmuDJwiHgcap5DOrHb7QapgQMWYPqPZp/O08mqi
	5GVGubgDhahbnofshlLlPvrnc66AJzIxaJbe1i6nfrjH0+Pxa2K6J5grVQGxoNX/2TWoibt+FX4NC
	0ooi/E6xM0aBqVNzCamSSywM4HfFJbHxyQ5U113wITs8EdQqwBBf/Rj2pxS07A5vkBZH4Ye3ctaI9
	omZdop1Dzo+eyMvEHhC7gHKpQDiMCaLgej0a0udSRWhzzQ3Vzo7K1IzVdLYQqNMovd9aE3GZzutgH
	AKF9L5sOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jBpdq-0002Px-1F; Wed, 11 Mar 2020 00:54:34 +0000
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jBpdm-0002PI-7l
 for linux-nvme@lists.infradead.org; Wed, 11 Mar 2020 00:54:32 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02B0qpWR012436;
 Wed, 11 Mar 2020 00:54:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=C5h1JJ1ecSZ9ODaOC/WwU2rmCvhG5J0EdllSMCCA7rg=;
 b=MIxbfbkQEyQDJHXOWjyoDb0vaskWdxhyqKqTspx2P/uZyCY7UvIqmRovS0eNU/PakOkT
 GeALiHp3WR2LHVxFZZ1Ejs0VFdGCHB79OJBmAYZF4IIw0e1LlCdx+UCyX1UqdVv7yMoH
 Gx85psqkIaGT2kMUJDkd6KAf5P9govT5lB03MJ0R/yQcCT541N7DjhVt4oB9KL/iFDV3
 BUj9pwGbJ1NgNTrspKFwWvliWC2tV2I1HHR3nHPyNIDs/93uRsesNRbE6H61FhXZHmNc
 PL+zie3jNMKlAxOnUmYlTpMGl4XSC9F/NUyyt9V57Lc/oVJEO9QkVhmFz0lO6Zk+8INe lQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2yp9v63ss6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Mar 2020 00:54:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02B0ksPx062035;
 Wed, 11 Mar 2020 00:52:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2yp8nx2apg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Mar 2020 00:52:08 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02B0q6ql016703;
 Wed, 11 Mar 2020 00:52:06 GMT
Received: from [10.154.112.130] (/10.154.112.130)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 17:52:06 -0700
Subject: Re: I/O performance with block sizes > 128k
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@infradead.org>
References: <321f0a4b-8a75-8cae-2d77-34ad712225d3@oracle.com>
 <20200310170818.GA28008@infradead.org>
 <20200310194421.GB17237@redsun51.ssa.fujisawa.hgst.com>
From: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Message-ID: <3971720d-d05d-9a08-cb5e-6396df70a8b2@oracle.com>
Date: Tue, 10 Mar 2020 17:52:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310194421.GB17237@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-Antivirus: Avast (VPS 200310-0, 03/10/2020), Outbound message
X-Antivirus-Status: Clean
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003110001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003110002
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200310_175430_362512_F2CDF786 
X-CRM114-Status: GOOD (  14.48  )
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMy8xMC8yMDIwIDEyOjQ0IFBNLCBLZWl0aCBCdXNjaCB3cm90ZToKPiBPbiBUdWUsIE1hciAx
MCwgMjAyMCBhdCAxMDowODoxOEFNIC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPj4g
T24gTW9uLCBNYXIgMDksIDIwMjAgYXQgMDI6NDk6MTBQTSAtMDcwMCwgQmlqYW4gTW90dGFoZWRl
aCB3cm90ZToKPj4+IEknbSBzZWVpbmcgYSBzaXplYWJsZSBkcm9wIGluIHBlcmYgd2l0aCBwb2xs
ZWQgZmlvIHRlc3RzIGZvciBibG9jayBzaXplcyA+Cj4+PiAxMjhrOgo+PiBUcnkgdXNpbmcgYSBj
b250cm9sbGVyIHdpdGggU0dMIHN1cHBvcnQuICBOVk1lIFBSUCB1bmZvcnR1bmF0ZWx5IGFyZQo+
PiBhIGNvbXBsZXRlbHkgYnJhaW4gZGVhZCBzY2hlbWUgb25jZSB5b3UgdXNlIG5vbi10aW55IEkv
TyBzaXplcyAoCj4+IGFuZCBhY3R1YWxseSByZWFsbHkgcGFpbmZ1bCBldmVuIGZvciB0aG9zZSBm
b3Igb3RoZXIgcmVhc29ucykuCj4gU0dMIHdvdWxkIHJlYWxseSBoZWxwIGlmIHlvdSBoYXZlIHBo
eWlzY2FsIGNvbnRpbnVpdHksIGFuZCBuZXZlciBuZWVkcwo+IHRvIGFsbG9jYXRlIGZyb20gdGhl
IGRtYSBwb29scy4gSWYgbW9zdCBwYWdlcyBpbiB0aGUgdHJhbnNmZXIgYXJlIG5vdAo+IHBoeXNp
Y2FsbHkgY29udGlndW91cywgdGhvdWdoLCBQUlAgaXMgc3RpbGwgbW9yZSBtZW1vcnkgZWZmaWNp
ZW50LiBCdXQKPiB5ZXMsIHRoZSBQUlAgZm9ybWF0IGlzIC4uLiB1bmlxdWUuIDopClNvIHdpdGgg
U0dMIHlvdSBjYW4gcG90ZW50aWFsbHkgYnlwYXNzIGRtYSBwb29sIGFsbG9jYXRpb24gYnV0IHdp
dGggUFJQIAp5b3UgYWx3YXlzIGhhdmUgdG8gcmVnYXJkbGVzcyBvZiBjb250aWd1aXR5PwoKPgo+
IEZXSVcsIEkgY291bGRuJ3QgbWVhc3VyZSBhIHBlcmZvcm1hbmNlIGRyb3Agb24gcmVhbCBoYXJk
d2FyZSBjb21wYXJpbmcKPiB0aGUgbGFyZ2UgcG9vbCB2cyB0aGUgc21hbGwgb25lLgoKSSB0b29r
IG91dCBteSB3b3JrYXJvdW5kLgoKSSBjYW4ndCBzZWUgYSBiaWcgZHJvcCBvbiBoL3cgd2l0aCAy
NTZrIGVpdGhlcjsgaG93ZXZlciwgSSBjYW4ndCBwdXNoIAp0aGUgdGVzdHMgZmFyIGVub3VnaCBi
ZWNhdXNlIHRoZXkgaGFuZyBkZXBlbmRpbmcgb24gdGhlIG51bWJlciBvZiBmaW8gCmpvYnMgYW5k
IGlvZGVwdGguCgpUaGV5IHNlZW0gdG8gYmUgc3R1Y2sgaW4gYW4gaW9fdXJpbmcgcG9sbCBsb29w
OgoKIMKgwqDCoCA1OC45MSXCoCBba2VybmVsXcKgwqDCoMKgwqDCoMKgwqDCoCBba10gYmxrX3Bv
bGwKIMKgwqDCoCAyNy4wMSXCoCBba2VybmVsXcKgwqDCoMKgwqDCoMKgwqDCoCBba10gaW9faW9w
b2xsX2dldGV2ZW50cwogwqDCoMKgwqAgOC41NiXCoCBba2VybmVsXcKgwqDCoMKgwqDCoMKgwqDC
oCBba10gYmxrZGV2X2lvcG9sbAoKSSBoYWQgdG8ga2lsbCB0aGUgZmlvIGpvYnMgYW5kIGdvdCBh
IGJ1bmNoIG9mIHRoaXMgb3V0cHV0OgoKSm9iczogMTAzIChmPTEwMyk6IApbcig0KSxfKDEpLHIo
MTIpLF8oMSkscigyKSxfKDEpLHIoMTApLF8oMSkscigyKSxfKDEpLHIoMSksXygxKSxyKDcpLF8o
MSkscigxKSxfKDIpLHIoMTYpLF8oMSkscig1KSxfKDEpLHIoNiksXygyKSxyKDIpLF8oMSkscigy
KSxfKDEpLHIoMiksXygxKSxyKDMpLF8oMSkscig5KSxfKDEpLHIoNCksXygyKSxyKDUpLF8oMSks
cigzKSxfKDEpLHIoMSksXygxKSxyKDQpLF8oMikscigyKV1bMGZpbzogCmpvYiAnZmlvdGVzdCcg
KHN0YXRlPTUpIGhhc24ndCBleGl0ZWQgaW4gMzAwIHNlY29uZHMsIGl0IGFwcGVhcnMgdG8gYmUg
CnN0dWNrLiBEb2luZyBmb3JjZWZ1bCBleGl0IG9mIHRoaXMgam9iLgoKSG9wZWZ1bGx5IEplbnMg
Y2FuIGNvbW1lbnQgd2hhdCB0aGlzIG1lYW5zLgoKLS1iaWphbgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGlu
dXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
