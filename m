Return-Path: <SRS0=McG4=37=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D284C35242
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 19:03:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37AA92168B
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 19:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fQaa3CX5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seagate.com header.i=@seagate.com header.b="S65KcoNI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seagate.com header.i=@seagate.com header.b="Hg/zT6U1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37AA92168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=seagate.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lL3/hhoD8mVkPUtsft/CwWhtSYoKrYyuxovamuTKKqc=; b=fQaa3CX5kOBlCj
	hEQoepM4yXXhGFby5Os+JbbEKTvjQTa5KeO9vbkf/lwTOcBGiDFSjpFodqMU2CXHUsmIapTjRr+OK
	3U8yES29Mv4u2OuSgcBqftwsPQMnXP0/6NQ9uDGhMNqe1Wk6U/KRfu4CASqABj3A0UZstuIWqx86A
	1GYd228yPB5hHJb6AWU/xhMvhBtRzZf3a+cyyPxCkeUMUA++lkC7VAOaC2XH4dbqV+gTXXGWtzj7C
	OyVPFI+F14le/B0IroYItc354unmq5zJnZzyyre85DQQINPUuMhPtWoRdGgBeBYAcJ4qRZ3Efe2Dl
	tjBeEYeM38AbmfVo+3PA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1aoP-0006Hr-Lv; Tue, 11 Feb 2020 19:03:09 +0000
Received: from mx0b-00003501.pphosted.com ([67.231.152.68])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1amv-0004eD-BQ
 for linux-nvme@lists.infradead.org; Tue, 11 Feb 2020 19:01:39 +0000
Received: from pps.filterd (m0075033.ppops.net [127.0.0.1])
 by mx0b-00003501.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01BIwstb041807
 for <linux-nvme@lists.infradead.org>; Tue, 11 Feb 2020 14:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type : content-transfer-encoding; s=proofpoint;
 bh=esHMiUeSwXjyvPJP53vh2XpvLViXxDIgD26JWyQ2GCI=;
 b=S65KcoNIMjLVtR98ZVSi94LI5EfSNce0FZsWNFTCN6Zr1uIAfoepw1xTK71Qf1JQu6Mn
 TED7/zXcYcXk6dNiWCJUhEXScOIMyA/d8xvhfBkhAUE6rLSJwylNkrc+fn6FPwyBOwm3
 sxi3UBT4uKK7Npw5JSA9ziMcP/an1GfZHHgUvqSZDrjVKrZ2EbHxcGsefwx2t3nAvs5s
 6RI0f55YYrLUIKE0bz5mo12aFVFi40cD/PI5E3A56ZikYigsgFw86TXBPun1MWWcGP2U
 BQrNZ+2k6ReV30JuMe9EF1vyWeKPZY76zLtRj0UUJPEjg5GnY7EblO6oo2eckrFpMLXq mg== 
Authentication-Results: seagate.com;
 dkim=pass header.s=google header.d=seagate.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 by mx0b-00003501.pphosted.com with ESMTP id 2y2b03ux2x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Tue, 11 Feb 2020 14:01:34 -0500
Received: by mail-wr1-f70.google.com with SMTP id d8so7335683wrq.12
 for <linux-nvme@lists.infradead.org>; Tue, 11 Feb 2020 11:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=esHMiUeSwXjyvPJP53vh2XpvLViXxDIgD26JWyQ2GCI=;
 b=Hg/zT6U1geDZ1DJi7INZpQOfCx1H1s8YKIjFIYrxBE7U5J1kJ2gS2q93lTfr7Z5TDl
 zhZIGkryOhaj41CMdZmBNT6+mTONSN7nTlKbPJ2iXvru810uG/mxkbAXLrlmN5k33UyY
 oRydwoKwmuYAlXASTvGIQnQqgjn6Y8R2BP0+wcoC6WhzJKyxLiPS1bPKRPzU7+qWeD8b
 eftpNOzX+Z2QFvFj7oKutXcJ1XnCR5F37y/nupXQvQUetUIbeLXsk6ko3PkRhDY4YnKV
 RFRNGnTt70gWI/bVMN59NlMove56w5ThqCVe/JYa5EiqKDK707Dpm72H7sx0bISh9i08
 UEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=esHMiUeSwXjyvPJP53vh2XpvLViXxDIgD26JWyQ2GCI=;
 b=C3c6HJq/yPeTx/MWYO0FxK0lsqRXyTzockOSAda2BFB8qc2RskK8MekNOtEBlc8LjA
 LFFUwsiryOeyNpwO5gPbdhUa78JfqXxjrzY7b7JECo1JXiMAHB5u02tX6ZH7zf8V/gHo
 A3Gb1cGc7KvC4n8DRYs9r6sBR4R5FhrIHaMLoxEnROdtX1UKYoFQvyMr3HJIRj6T0GI+
 HM7LIpvtsIjUd7UOJN+e2JqqFH0MFY2JFNyD3PFFc8UNdxIyWxjuqpopHj/TDlHvjGOl
 W9QHk7/Wx/SXgzuAOn7M5rCFQTUzYcOoVHDxFqrTh6bNXKyb19AfXpkPCGmDSXQXnoD5
 RFQw==
X-Gm-Message-State: APjAAAW5J56R0Q8s6WH3qohFs/RBKUO3RKjKyPQWICef2IWN+alUTShE
 s5clpWrDzxnVWaU26uSg3zSDaCylKU9pTVOB18zY2kA4BA6Ak+ww/p/yQ08jQlb8prdYC0ZqD8e
 PDuy786PqepWumKPrVqDBjr6HAtCJDb13zXXTQpBIxNTCQNQQ7ChvUL1tAtoVDXKmCrWv
X-Received: by 2002:a05:6000:192:: with SMTP id
 p18mr9882356wrx.218.1581447692154; 
 Tue, 11 Feb 2020 11:01:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqwHfJbVEQUane7A9MspJwRA/aOOQTH6DO+weUnfDXUEjV3EmBBcCyAsrVfB8ClNI3/WlIgji5XI59VpkUPkqmM=
X-Received: by 2002:a05:6000:192:: with SMTP id
 p18mr9882325wrx.218.1581447691811; 
 Tue, 11 Feb 2020 11:01:31 -0800 (PST)
MIME-Version: 1.0
References: <CANo=J14resJ4U1nufoiDq+ULd0k-orRCsYah8Dve-y8uCjA62Q@mail.gmail.com>
 <20200211122821.GA29811@ming.t460p>
In-Reply-To: <20200211122821.GA29811@ming.t460p>
From: Tim Walker <tim.t.walker@seagate.com>
Date: Tue, 11 Feb 2020 14:01:18 -0500
Message-ID: <CANo=J14iRK8K3bc1g3rLBp=QTLZQak0DcHkvgZS2f=xO_HFgxQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe HDD
To: Ming Lei <ming.lei@redhat.com>
X-Proofpoint-PolicyRoute: Outbound
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-11_05:2020-02-11,
 2020-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002110128
X-Proofpoint-Spam-Policy: Default Domain Policy
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200211_110137_802396_96C26E00 
X-CRM114-Status: GOOD (  19.49  )
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
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBGZWIgMTEsIDIwMjAgYXQgNzoyOCBBTSBNaW5nIExlaSA8bWluZy5sZWlAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4KPiBPbiBNb24sIEZlYiAxMCwgMjAyMCBhdCAwMjoyMDoxMFBNIC0wNTAw
LCBUaW0gV2Fsa2VyIHdyb3RlOgo+ID4gQmFja2dyb3VuZDoKPiA+Cj4gPiBOVk1lIHNwZWNpZmlj
YXRpb24gaGFzIGhhcmRlbmVkIG92ZXIgdGhlIGRlY2FkZSBhbmQgbm93IE5WTWUgZGV2aWNlcwo+
ID4gYXJlIHdlbGwgaW50ZWdyYXRlZCBpbnRvIG91ciBjdXN0b21lcnPigJkgc3lzdGVtcy4gQXMg
d2UgbG9vayBmb3J3YXJkLAo+ID4gbW92aW5nIEhERHMgdG8gdGhlIE5WTWUgY29tbWFuZCBzZXQg
ZWxpbWluYXRlcyB0aGUgU0FTIElPQyBhbmQgZHJpdmVyCj4gPiBzdGFjaywgY29uc29saWRhdGlu
ZyBvbiBhIHNpbmdsZSBhY2Nlc3MgbWV0aG9kIGZvciByb3RhdGlvbmFsIGFuZAo+ID4gc3RhdGlj
IHN0b3JhZ2UgdGVjaG5vbG9naWVzLiBQQ0llLU5WTWUgb2ZmZXJzIG5lYXItU0FUQSBpbnRlcmZh
Y2UKPiA+IGNvc3RzLCBmZWF0dXJlcyBhbmQgcGVyZm9ybWFuY2Ugc3VpdGFibGUgZm9yIGhpZ2gt
Y2FwIEhERHMsIGFuZAo+ID4gb3B0aW1hbCBpbnRlcm9wZXJhYmlsaXR5IGZvciBzdG9yYWdlIGF1
dG9tYXRpb24sIHRpZXJpbmcsIGFuZAo+ID4gbWFuYWdlbWVudC4gV2Ugd2lsbCBzaGFyZSBzb21l
IGVhcmx5IGNvbmNlcHR1YWwgcmVzdWx0cyBhbmQgcHJvcG9zZWQKPiA+IHNhbGllbnQgZGVzaWdu
IGdvYWxzIGFuZCBjaGFsbGVuZ2VzIHN1cnJvdW5kaW5nIGFuIE5WTWUgSERELgo+Cj4gSERELiBw
ZXJmb3JtYW5jZSBpcyB2ZXJ5IHNlbnNpdGl2ZSB0byBJTyBvcmRlci4gQ291bGQgeW91IHByb3Zp
ZGUgc29tZQo+IGJhY2tncm91bmQgaW5mbyBhYm91dCBOVk1lIEhERD8gU3VjaCBhczoKPgo+IC0g
bnVtYmVyIG9mIGh3IHF1ZXVlcwo+IC0gaHcgcXVldWUgZGVwdGgKPiAtIHdpbGwgTlZNZSBzb3J0
L21lcmdlIElPIGFtb25nIGFsbCBTUXMgb3Igbm90Pwo+Cj4gPgo+ID4KPiA+IERpc2N1c3Npb24g
UHJvcG9zYWw6Cj4gPgo+ID4gV2XigJlkIGxpa2UgdG8gc2hhcmUgb3VyIHZpZXdzIGFuZCBzb2xp
Y2l0IGlucHV0IG9uOgo+ID4KPiA+IC1XaGF0IExpbnV4IHN0b3JhZ2Ugc3RhY2sgYXNzdW1wdGlv
bnMgZG8gd2UgbmVlZCB0byBiZSBhd2FyZSBvZiBhcyB3ZQo+ID4gZGV2ZWxvcCB0aGVzZSBkZXZp
Y2VzIHdpdGggZHJhc3RpY2FsbHkgZGlmZmVyZW50IHBlcmZvcm1hbmNlCj4gPiBjaGFyYWN0ZXJp
c3RpY3MgdGhhbiB0cmFkaXRpb25hbCBOQU5EPyBGb3IgZXhhbXBsZSwgd2hhdCBzY2hlZHVsYXIg
b3IKPiA+IGRldmljZSBkcml2ZXIgbGV2ZWwgY2hhbmdlcyB3aWxsIGJlIG5lZWRlZCB0byBpbnRl
Z3JhdGUgTlZNZSBIRERzPwo+Cj4gSU8gbWVyZ2UgaXMgb2Z0ZW4gaW1wb3J0YW50IGZvciBIREQu
IElPIG1lcmdlIGlzIHVzdWFsbHkgdHJpZ2dlcmVkIHdoZW4KPiAucXVldWVfcnEoKSByZXR1cm5z
IFNUU19SRVNPVVJDRSwgc28gZmFyIHRoaXMgY29uZGl0aW9uIHdvbid0IGJlCj4gdHJpZ2dlcmVk
IGZvciBOVk1lIFNTRC4KPgo+IEFsc28gYmxrLW1xIGtpbGxzIEJESSBxdWV1ZSBjb25nZXN0aW9u
IGFuZCBpb2MgYmF0Y2hpbmcsIGFuZCBjYXVzZXMKPiB3cml0ZWJhY2sgcGVyZm9ybWFuY2UgcmVn
cmVzc2lvblsxXVsyXS4KPgo+IFdoYXQgSSBhbSB0aGlua2luZyBpcyB0aGF0IGlmIHdlIG5lZWQg
dG8gc3dpdGNoIHRvIHVzZSBpbmRlcGVuZGVudCBJTwo+IHBhdGggZm9yIGhhbmRsaW5nIFNTRCBh
bmQgSERELiBJTywgZ2l2ZW4gdGhlIHR3byBtZWRpdW1zIGFyZSBzbwo+IGRpZmZlcmVudCBmcm9t
IHBlcmZvcm1hbmNlIHZpZXdwb2ludC4KPgo+IFsxXSBodHRwczovL3VybGRlZmVuc2UucHJvb2Zw
b2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX2xvcmUua2VybmVsLm9yZ19saW51eC0yRHNjc2lf
UGluZS5MTlguNC40NEwwLjE5MDkxODEyMTMxNDEuMTUwNy0yRDEwMDAwMC00MGlvbGFudGhlLnJv
d2xhbmQub3JnXyZkPUR3SUZhUSZjPUlHRGxnMGxEMGItbmVibUpKMEtwOEEmcj1OVzFYMHlSSE5O
RWx1WjhzT0dYQnhDYlFKWlBXY0lrUFQwVXkzeW5Wc0ZVJm09cFNuSHB0X3VRUTczSlY0VklRZzFD
X1BWQWNMdnFCQnRteXhRSHdXakdTTSZzPXRzbkZQOGJRSUFxN0c2NkI3NUxUZTN2bzRLMTRIYkw5
SkpLc3hsX0xQQXcmZT0KPiBbMl0gaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3Yy
L3VybD91PWh0dHBzLTNBX19sb3JlLmtlcm5lbC5vcmdfbGludXgtMkRzY3NpXzIwMTkxMjI2MDgz
NzA2LkdBMTc5NzQtNDBtaW5nLnQ0NjBwXyZkPUR3SUZhUSZjPUlHRGxnMGxEMGItbmVibUpKMEtw
OEEmcj1OVzFYMHlSSE5ORWx1WjhzT0dYQnhDYlFKWlBXY0lrUFQwVXkzeW5Wc0ZVJm09cFNuSHB0
X3VRUTczSlY0VklRZzFDX1BWQWNMdnFCQnRteXhRSHdXakdTTSZzPUdKd1N4WHRjX3FaSEtuclRx
U2J5dFVqdVJyclFnWnB2VjNieFpZRkRIZTQmZT0KPgo+Cj4gVGhhbmtzLAo+IE1pbmcKPgoKSSB3
b3VsZCBleHBlY3QgdGhlIGRyaXZlIHdvdWxkIHN1cHBvcnQgYSByZWFzb25hYmxlIG51bWJlciBv
ZiBxdWV1ZXMKYW5kIGEgcmVsYXRpdmVseSBkZWVwIHF1ZXVlIGRlcHRoLCBtb3JlIGluIGxpbmUg
d2l0aCBOVk1lIHByYWN0aWNlcwp0aGFuIFNBUyBIREQncyB0eXBpY2FsIDEyOC4gQnV0IGl0IHBy
b2JhYmx5IGRvZXNuJ3QgbWFrZSBzZW5zZSB0bwpxdWV1ZSB1cCB0aG91c2FuZHMgb2YgY29tbWFu
ZHMgb24gc29tZXRoaW5nIGFzIHNsb3cgYXMgYW4gSERELCBhbmQKbWFueSBjdXN0b21lcnMga2Vl
cCBxdWV1ZXMgPCAzMiBmb3IgbGF0ZW5jeSBtYW5hZ2VtZW50LgoKTWVyZ2UgYW5kIGVsZXZhdG9y
IGFyZSBpbXBvcnRhbnQgdG8gSEREIHBlcmZvcm1hbmNlLiBJIGRvbid0IGJlbGlldmUKTlZNZSBz
aG91bGQgYXR0ZW1wdCB0byBtZXJnZS9zb3J0IGFjcm9zcyBTUXMuIENhbiBOVk1lIG1lcmdlL3Nv
cnQKd2l0aGluIGEgU1Egd2l0aG91dCBkcml2aW5nIGxhcmdlIGRpZmZlcmVuY2VzIGJldHdlZW4g
U1NEICYgSEREIGRhdGEKcGF0aHM/CgpUaGFua3MsCi1UaW0KCi0tIApUaW0gV2Fsa2VyClByb2R1
Y3QgRGVzaWduIFN5c3RlbXMgRW5naW5lZXJpbmcsIFNlYWdhdGUgVGVjaG5vbG9neQooMzAzKSA3
NzUtMzc3MAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
