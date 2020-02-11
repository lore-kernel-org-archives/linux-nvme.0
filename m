Return-Path: <SRS0=McG4=37=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E363C352A3
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 12:29:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B9D020714
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 12:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rrvyv5iu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BFTjRH5T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3kfThOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9D020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+GexDAGK8uEzFaQjVyD4ccx4ux4dG1rLvwva/mIR6OE=; b=rrvyv5iu2k7cjA
	IJiP0TxHOBdDuWn6qm5vC18AVU16ou9bjJWNFg5lPOx/7VPPTFhkAhyYngVm8S1uRXLAXne36l6Pk
	PiNWXuzikM9NenfjkQMTnKklWc8nuVQQm7/S1SZO2T3vyJVycSg6SR7Zqg9Fs5oypu93zshaT9D9c
	XP8OSr9bckWp9hUpDBgaImFo6PFypGZ3SX9jzuppQCFC2gSLzwfll1qexcDYSLPLesqjfKmRwvveW
	iqVSMrrq0sk01YSPmO+KF+Zf8tfpjA/Mk9Nmx5mCCZrRIi40ko3nb7rGl8MPwn3LF8vp178uDMWdf
	7sgRrn3wTgGbl1nxnxPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1UfL-0004Yb-7V; Tue, 11 Feb 2020 12:29:23 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1UfI-0004UH-1B
 for linux-nvme@bombadil.infradead.org; Tue, 11 Feb 2020 12:29:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:In-Reply-To:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=uHEOjUhMWrW6Y0OTSi8s083JPpT8Ksjs/CTyJdEAW5w=; b=BFTjRH5TV42T37w/CeRt1eiZBJ
 I3W5avXDiWYPaHl2rBDPZ3Cu1tdhA2V+FcvUgExUWOT7uBlcwW3YZ1DkbDQkotFJsJYdZpXzCEu1O
 E0Y/f4LxDMrYt8znwORAfX5sESWAS7MC94tVkXNmQ50qWOSaXLzEaI/f3jwS27Eu5udeawyk1Y4uW
 ofO/i8WsUfjIpgAIXBwQUY+DHSIep8bcvJvHIC07CmOO/EKEg0o9FqEblL1Sgp1lJfKy+BIpbMWgo
 5wLI3m7GjuxwD048Hw62i1Oz1NxjERHz63grdTeyVH7Xm+VSxEMSTHdLkdwP8dQO7Mg+Xv+HGvgkz
 Di3lz72Q==;
Received: from us-smtp-1.mimecast.com ([207.211.31.81])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1UfF-00034h-Lh
 for linux-nvme@lists.infradead.org; Tue, 11 Feb 2020 12:29:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581424139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uHEOjUhMWrW6Y0OTSi8s083JPpT8Ksjs/CTyJdEAW5w=;
 b=M3kfThOUHI/kXl0TOr92OH7TlC+ooNgMLiqeM6aW+oULOabM1AYust0rLJrHSHViGm3/qQ
 dVfLJsNjcf9Ic5EjxEIOpHxDo9VVg7rI+BSjOlfaYyb78pm8zcCZaqL6EJ9WfMSFRQOaV7
 72ahClClsmcQT4uqBaBVj8MvMsic/Kw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-tbZMTi2APfmrcMiAbIN50A-1; Tue, 11 Feb 2020 07:28:48 -0500
X-MC-Unique: tbZMTi2APfmrcMiAbIN50A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1557800D5E;
 Tue, 11 Feb 2020 12:28:46 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10B0B5C120;
 Tue, 11 Feb 2020 12:28:32 +0000 (UTC)
Date: Tue, 11 Feb 2020 20:28:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Tim Walker <tim.t.walker@seagate.com>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe HDD
Message-ID: <20200211122821.GA29811@ming.t460p>
References: <CANo=J14resJ4U1nufoiDq+ULd0k-orRCsYah8Dve-y8uCjA62Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANo=J14resJ4U1nufoiDq+ULd0k-orRCsYah8Dve-y8uCjA62Q@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

T24gTW9uLCBGZWIgMTAsIDIwMjAgYXQgMDI6MjA6MTBQTSAtMDUwMCwgVGltIFdhbGtlciB3cm90
ZToKPiBCYWNrZ3JvdW5kOgo+IAo+IE5WTWUgc3BlY2lmaWNhdGlvbiBoYXMgaGFyZGVuZWQgb3Zl
ciB0aGUgZGVjYWRlIGFuZCBub3cgTlZNZSBkZXZpY2VzCj4gYXJlIHdlbGwgaW50ZWdyYXRlZCBp
bnRvIG91ciBjdXN0b21lcnPigJkgc3lzdGVtcy4gQXMgd2UgbG9vayBmb3J3YXJkLAo+IG1vdmlu
ZyBIRERzIHRvIHRoZSBOVk1lIGNvbW1hbmQgc2V0IGVsaW1pbmF0ZXMgdGhlIFNBUyBJT0MgYW5k
IGRyaXZlcgo+IHN0YWNrLCBjb25zb2xpZGF0aW5nIG9uIGEgc2luZ2xlIGFjY2VzcyBtZXRob2Qg
Zm9yIHJvdGF0aW9uYWwgYW5kCj4gc3RhdGljIHN0b3JhZ2UgdGVjaG5vbG9naWVzLiBQQ0llLU5W
TWUgb2ZmZXJzIG5lYXItU0FUQSBpbnRlcmZhY2UKPiBjb3N0cywgZmVhdHVyZXMgYW5kIHBlcmZv
cm1hbmNlIHN1aXRhYmxlIGZvciBoaWdoLWNhcCBIRERzLCBhbmQKPiBvcHRpbWFsIGludGVyb3Bl
cmFiaWxpdHkgZm9yIHN0b3JhZ2UgYXV0b21hdGlvbiwgdGllcmluZywgYW5kCj4gbWFuYWdlbWVu
dC4gV2Ugd2lsbCBzaGFyZSBzb21lIGVhcmx5IGNvbmNlcHR1YWwgcmVzdWx0cyBhbmQgcHJvcG9z
ZWQKPiBzYWxpZW50IGRlc2lnbiBnb2FscyBhbmQgY2hhbGxlbmdlcyBzdXJyb3VuZGluZyBhbiBO
Vk1lIEhERC4KCkhERC4gcGVyZm9ybWFuY2UgaXMgdmVyeSBzZW5zaXRpdmUgdG8gSU8gb3JkZXIu
IENvdWxkIHlvdSBwcm92aWRlIHNvbWUKYmFja2dyb3VuZCBpbmZvIGFib3V0IE5WTWUgSEREPyBT
dWNoIGFzOgoKLSBudW1iZXIgb2YgaHcgcXVldWVzCi0gaHcgcXVldWUgZGVwdGgKLSB3aWxsIE5W
TWUgc29ydC9tZXJnZSBJTyBhbW9uZyBhbGwgU1FzIG9yIG5vdD8KCj4gCj4gCj4gRGlzY3Vzc2lv
biBQcm9wb3NhbDoKPiAKPiBXZeKAmWQgbGlrZSB0byBzaGFyZSBvdXIgdmlld3MgYW5kIHNvbGlj
aXQgaW5wdXQgb246Cj4gCj4gLVdoYXQgTGludXggc3RvcmFnZSBzdGFjayBhc3N1bXB0aW9ucyBk
byB3ZSBuZWVkIHRvIGJlIGF3YXJlIG9mIGFzIHdlCj4gZGV2ZWxvcCB0aGVzZSBkZXZpY2VzIHdp
dGggZHJhc3RpY2FsbHkgZGlmZmVyZW50IHBlcmZvcm1hbmNlCj4gY2hhcmFjdGVyaXN0aWNzIHRo
YW4gdHJhZGl0aW9uYWwgTkFORD8gRm9yIGV4YW1wbGUsIHdoYXQgc2NoZWR1bGFyIG9yCj4gZGV2
aWNlIGRyaXZlciBsZXZlbCBjaGFuZ2VzIHdpbGwgYmUgbmVlZGVkIHRvIGludGVncmF0ZSBOVk1l
IEhERHM/CgpJTyBtZXJnZSBpcyBvZnRlbiBpbXBvcnRhbnQgZm9yIEhERC4gSU8gbWVyZ2UgaXMg
dXN1YWxseSB0cmlnZ2VyZWQgd2hlbgoucXVldWVfcnEoKSByZXR1cm5zIFNUU19SRVNPVVJDRSwg
c28gZmFyIHRoaXMgY29uZGl0aW9uIHdvbid0IGJlCnRyaWdnZXJlZCBmb3IgTlZNZSBTU0QuCgpB
bHNvIGJsay1tcSBraWxscyBCREkgcXVldWUgY29uZ2VzdGlvbiBhbmQgaW9jIGJhdGNoaW5nLCBh
bmQgY2F1c2VzCndyaXRlYmFjayBwZXJmb3JtYW5jZSByZWdyZXNzaW9uWzFdWzJdLgoKV2hhdCBJ
IGFtIHRoaW5raW5nIGlzIHRoYXQgaWYgd2UgbmVlZCB0byBzd2l0Y2ggdG8gdXNlIGluZGVwZW5k
ZW50IElPCnBhdGggZm9yIGhhbmRsaW5nIFNTRCBhbmQgSERELiBJTywgZ2l2ZW4gdGhlIHR3byBt
ZWRpdW1zIGFyZSBzbwpkaWZmZXJlbnQgZnJvbSBwZXJmb3JtYW5jZSB2aWV3cG9pbnQuCgpbMV0g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtc2NzaS9QaW5lLkxOWC40LjQ0TDAuMTkwOTE4
MTIxMzE0MS4xNTA3LTEwMDAwMEBpb2xhbnRoZS5yb3dsYW5kLm9yZy8KWzJdIGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xpbnV4LXNjc2kvMjAxOTEyMjYwODM3MDYuR0ExNzk3NEBtaW5nLnQ0NjBw
LwoKClRoYW5rcywgCk1pbmcKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1udm1lCg==
