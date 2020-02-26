Return-Path: <SRS0=MxcY=4O=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7237EC4BA24
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 21:46:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46AC921D7E
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 21:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uuoMq933";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fuzRGw6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46AC921D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:References:Subject:To:From:Date:
	Message-ID:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nzBtU7HmdCNXvKws2eWPy+VbjOVnxfH6eElC+3lVr+o=; b=uuoMq933IERa8eoALsFBqZhL0
	+KcHGkca+OdHb0KfWMpVAClfmI0wzl1qnwXLIYa7eQqu7DxM27a8Wx9uHITmxatYqAQFnrTq2yJUu
	NxYEx+040xjWiwWR9u1+5ToD6yxTUHt7uppTTN356l+yZrJlqAaoHsBCRJjlHsqMupKF4ZBaS+GEL
	PQT5zffxKQWNAC2qNzJQ2nWbzu5Jd6+R1ib4qRbTCFLRbuWcLWqJCRZuTiOSI6/YVW12jEHVvccJw
	ZiLzC4rp1M4g3nKGWmscKyEAXtNIJ1vSfwNPGm8e+0tniS3V2S/MNAlad03ZV2G7HKuhAquPDuMv9
	3VonAE5SA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j74Vv-0006dC-8d; Wed, 26 Feb 2020 21:46:43 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j74Vs-0006cs-HG
 for linux-nvme@lists.infradead.org; Wed, 26 Feb 2020 21:46:41 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01QLgcpw138768;
 Wed, 26 Feb 2020 21:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=3h7pNn4bPM+iSmiA/LXavCVRHaA1GDTR2cY0EbOV6go=;
 b=fuzRGw6V+OUYvMFbmC2djtumPK5KNnU5k9nBVuWw0TVFXlWWOpqgLgzAcTZgtLmn5zdM
 ERJp/thpK4CpKBHJBRZi4ALbEfH9MhbrzvQ+mGh25ZzfcgYzdWV5XUJva1Or3HNjSwX4
 sXQjLe3JS5iDSydds3CmbMgTDUs7bJl3MrfBWfJNRHGEKVd8MYBXdmPTI3iWLRJ0aUKM
 Se1hCtOTm15kav7AWw5/jVzeX3U/tq0823oZdXIakVvVxblaaTULOadjaX1hYR4sZVaH
 6VVnZ9XdMc/OiXaLocur8Hg/vk5s4xGdzwKj0mIyrWaCCrvODsyCkjbRXREAM/eR6ANt rw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2ydct36jp0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2020 21:46:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01QLiBXj012990;
 Wed, 26 Feb 2020 21:46:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2ydj4jk35s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2020 21:46:38 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01QLkbm5018810;
 Wed, 26 Feb 2020 21:46:37 GMT
X-ANTIVIRUS-STATUS: Clean
Received: from [10.154.173.100] (/10.154.173.100) by default (Oracle Beehive
 Gateway v4.0) with ESMTP ; Wed, 26 Feb 2020 13:45:58 -0800
X-ANTIVIRUS: Avast (VPS 200225-0, 02/25/2020), Outbound message
USER-AGENT: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Content-Language: en-US
MIME-Version: 1.0
Message-ID: <a72471a6-788f-2ac6-64b1-1c80d1ff5621@oracle.com>
Date: Wed, 26 Feb 2020 21:45:54 +0000 (UTC)
From: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: nvme_poll() CQ processing
References: <143eb9f1-7f17-591a-4302-a86ea1114e87@oracle.com>
 <20200226202309.GA24127@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20200226202309.GA24127@redsun51.ssa.fujisawa.hgst.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 suspectscore=2
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=2 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260127
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200226_134640_612710_F96227E6 
X-CRM114-Status: GOOD (  15.82  )
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

T24gMi8yNi8yMDIwIDEyOjIzIFBNLCBLZWl0aCBCdXNjaCB3cm90ZToKPiBPbiBXZWQsIEZlYiAy
NiwgMjAyMCBhdCAxMToyMDoxOUFNIC0wODAwLCBCaWphbiBNb3R0YWhlZGVoIHdyb3RlOgo+PiBB
IHNpbXBsZXIgdGhlb3JldGljYWwgZXhhbXBsZSB3aXRoIHR3byB0aHJlYWRzOgo+Pgo+PiBUaHJl
YWQgMSBzdWJtaXRzIGVub3VnaCBJL08gdG8gZmlsbCB0aGUgQ1EKPj4gVGhyZWFkIDEgdGhlbiBw
cm9jZXNzZXMgdHdvIENRRXMsIHR3byBibG9jayBsYXllciB0YWdzIGJlY29tZSBhdmFpbGFibGUu
Cj4+IFRocmVhZCAxIGlzIHByZWVtcHRlZCBieSB0aHJlYWQgMi4KPj4gVGhyZWFkIDIgc3VibWl0
cyB0d28gSS9Pcy4KPj4gVGhyZWFkIDIgcHJvY2Vzc2VzIHRoZSB0d28gQ1FFcyB3aGljaCBpdCBv
d25zLgo+PiBUaHJlYWQgMiBzdWJtaXRzIHR3byBtb3JlIEkvT3MuCj4+IFRob3NlIENRRXMgb3Zl
cndyaXRlIHRoZSBuZXh0IHR3byBDUUVzIHRoYXQgd2lsbCBiZSBwcm9jZXNzZWQgYnkgdGhyZWFk
IDEuCj4+Cj4+IFR3byBvZiB0aHJlYWQgMSdzIElPcyB3aWxsIG5vdCByZWNlaXZlIGEgY29tcGxl
dGlvbi7CoCBUd28gb2YgdGhyZWFkIDIncyBJT3MKPj4gd2lsbCByZWNlaXZlIHR3byBjb21wbGV0
aW9ucy4KPj4KPj4gSnVzdCBhcyBhIHdvcmthcm91bmQsIEkgaGVsZCBjcV9wb2xsX2xvY2sgd2hp
bGUgY29tcGxldGluZyB0aGUgQ1FFcyBhbmQgc2VlCj4+IG5vIGVycm9ycy4KPiBUaGFuayB5b3Ug
Zm9yIHRoZSBub3RpY2UgYW5kIHRoZSBhbmF5bHNpcy4gSSBiZWxpZXZlIHlvdSBhcmUgY29ycmVj
dCwgd2UKPiBuZWVkIHRvIGF2b2lkIHNjaGVkdWxpbmcgdGhlIHRocmVhZCBpZiBpdCBoYXMgY3Fl
J3MgdG8gY29tcGxldGUsCj4gb3RoZXJ3aXNlIGFub3RoZXIgbWF5IGZyZWUgZW5vdWdoIHRhZ3Mg
b3V0IG9mIG9yZGVyLCBhbGxvd2luZyBhIHF1ZXVlCj4gd3JhcC4KPgo+IFlvdXIgd29yay1hcm91
bmQgc291bmRzIG9rYXkgdG8gbWUgZm9yIGltbWVkaWF0ZSBpbmNsdXNpb24gYW5kIGZvciBzdGFi
bGUuCj4gV291bGQgeW91IGxpa2UgdG8gc2VuZCB0aGUgcGF0Y2g/Cj4KPiBMb25nZXIgdGVybSwg
d2Ugc2hvdWxkIGdldCByaWQgb2YgdGhpcyB0d28tcGFzcyBjb21wbGV0aW9uLiBJdCB3YXMKPiBk
b25lIHRoYXQgd2F5IHdoZW4gc3VibWl0IGFuZCBjb21wbGV0ZSB3ZXJlIHVzaW5nIHRoZSBzYW1l
IHNwaW5sb2NrLCBzbwo+IHJlZHVjaW5nIHRoZSBjcml0aWNhbCBzZWN0aW9uIHdhcyBoZWxwZnVs
LCBidXQgd2UgZG9uJ3QgbmVlZCB0aGF0Cj4gYW55bW9yZS4KU3VyZSwgSSdsbCBzZW5kIG9uZSBp
biBhIGJpdC4gSSB1c2VkIHlvdXIgd29yZGluZyBmb3IgdGhlIGNvbW1lbnRzIGlmIAp0aGF0J3Mg
b2suCgotLWJpamFuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1l
Cg==
