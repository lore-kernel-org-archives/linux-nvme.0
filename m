Return-Path: <SRS0=imtT=XI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58725C49ED7
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2019 17:41:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B3BA20830
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2019 17:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jxLOSzq2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3BA20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:In-Reply-To:
	Message-ID:To:From:Date:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	References:List-Owner; bh=Wqu2o7+eynvXB04dFx2ismxU6l0ousiPCHG1ZKhk7fY=; b=jxL
	OSzq2jSjOiHE/F1bYzdeDewm0lOzvv0OJzJP9lShAz53duIv83VygYpWGGM16rKJQm5Wz4LzABD3c
	StQGeVz3rJjdF6/aCGO4T4eAeTpSnwz4BDBrS34TL2JPjgACG9ToOCY1xHUQ/9IUj21fYaSVHibpq
	WJjLVrSrAEh6JLBU26XKK044OQFQ0HWmxq3ZEzW5qT4MGygdXu2qX0ohQeSESHLI7ouit81cuftsT
	h6z9osyv5PQFfPvdmukhBIK7ZQNtgSgN2pBZEX70YGATGnf8LW5BGRUTZ3hKntw23dNqW6cxBm4Po
	VN3Qy2timUYb1XokfbRp7lvVb49rLjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i8pZ1-0001fD-L1; Fri, 13 Sep 2019 17:40:55 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i8pYz-0001ek-5S
 for linux-nvme@lists.infradead.org; Fri, 13 Sep 2019 17:40:54 +0000
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 57CA910DCC8B
 for <linux-nvme@lists.infradead.org>; Fri, 13 Sep 2019 17:40:50 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EB87600C6
 for <linux-nvme@lists.infradead.org>; Fri, 13 Sep 2019 17:40:50 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com
 (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 44A5018005A0
 for <linux-nvme@lists.infradead.org>; Fri, 13 Sep 2019 17:40:50 +0000 (UTC)
Date: Fri, 13 Sep 2019 13:40:50 -0400 (EDT)
From: Yi Zhang <yi.zhang@redhat.com>
To: linux-nvme@lists.infradead.org
Message-ID: <1137688987.11971676.1568396450210.JavaMail.zimbra@redhat.com>
In-Reply-To: <1753358694.11967186.1568394608486.JavaMail.zimbra@redhat.com>
Subject: incorrect sysfs reported by realpath for nvme disk when
 nvme-core:multipath enabled
MIME-Version: 1.0
X-Originating-IP: [10.72.12.24, 10.4.195.9]
Thread-Topic: incorrect sysfs reported by realpath for nvme disk when
 nvme-core:multipath enabled
Thread-Index: +xp204qhoHpbW/6DG/44Z5ZvcGEqqg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Fri, 13 Sep 2019 17:40:50 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190913_104053_248111_178E46B6 
X-CRM114-Status: GOOD (  14.51  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGVsbG8KCldoZW4gSSB1c2UgJ3JlYWxwYXRoJyB0byBnZXQgdGhlIG52bWUgc3lzZnMgb24gbGF0
ZXN0IDUuMy4wLXJjOCBmb3IgTlZNZSBTU0QsIHNlZW1zIGl0IHJlcG9ydGVkIGluY29ycmVjdGx5
IHN5c2ZzLCBjb3VsZCBhbnlvbmUgaGVscCBjaGVjayBpdD8KCgpbMV0gbnZtZS1jb3JlIG11bHRp
cGF0aD1ZCiMgbHNwY2kgfCBncmVwIC1pIG5vbgo4NjowMC4wIE5vbi1Wb2xhdGlsZSBtZW1vcnkg
Y29udHJvbGxlcjogU2Ftc3VuZyBFbGVjdHJvbmljcyBDbyBMdGQgTlZNZSBTU0QgQ29udHJvbGxl
ciAxNzJYYS8xNzJYYiAocmV2IDAxKQphZjowMC4wIE5vbi1Wb2xhdGlsZSBtZW1vcnkgY29udHJv
bGxlcjogSW50ZWwgQ29ycG9yYXRpb24gTlZNZSBEQyBTU0QgWzNETkFORCwgQmV0YSBSb2NrIENv
bnRyb2xsZXJdCgojIG52bWUgbGlzdApOb2RlICAgICAgICAgICAgIFNOICAgICAgICAgICAgICAg
ICAgIE1vZGVsICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTmFtZXNwYWNlIFVz
YWdlICAgICAgICAgICAgICAgICAgICAgIEZvcm1hdCAgICAgICAgICAgRlcgUmV2ICAKLS0tLS0t
LS0tLS0tLS0tLSAtLS0tLS0tLS0tLS0tLS0tLS0tLSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tIC0tLS0tLS0tLSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSAtLS0t
LS0tLS0tLS0tLS0tIC0tLS0tLS0tCi9kZXYvbnZtZTBuMSAgICAgQlRMRTgxOTAwMDNYMlAwSUdO
ICAgRGVsbCBFeHByZXNzIEZsYXNoIE5WTWUgUDQ2MDAgMi4wVEIgQUlDICAxICAgICAgICAgICAy
LjAwICBUQiAvICAgMi4wMCAgVEIgICAgICA0IEtpQiArICAwIEIgICBRRFYxRFAxNQovZGV2L252
bWUxbjEgICAgICAgICAgIFMzOVdOQTBLMjAxMTM5IERlbGwgRXhwcmVzcyBGbGFzaCBQTTE3MjVh
IDEuNlRCIEFJQyAgICAgMSAgICAgICAgICAgMS42MCAgVEIgLyAgIDEuNjAgIFRCICAgIDUxMiAg
IEIgKyAgMCBCICAgMS4xLjEgCgojIGNhdCAvc3lzL21vZHVsZS9udm1lX2NvcmUvcGFyYW1ldGVy
cy9tdWx0aXBhdGggClkKCiMgbHNibGsgCk5BTUUgICAgICAgICAgICAgICAgICAgICAgICAgTUFK
Ok1JTiBSTSAgIFNJWkUgUk8gVFlQRSBNT1VOVFBPSU5UCnNkYSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICA4OjAgICAgMCAyMjIuNUcgIDAgZGlzayAK4pSc4pSAc2RhMSAgICAgICAgICAgICAg
ICAgICAgICAgICA4OjEgICAgMCAgIDYwME0gIDAgcGFydCAvYm9vdC9lZmkK4pSc4pSAc2RhMiAg
ICAgICAgICAgICAgICAgICAgICAgICA4OjIgICAgMCAgICAgMUcgIDAgcGFydCAvYm9vdArilJTi
lIBzZGEzICAgICAgICAgICAgICAgICAgICAgICAgIDg6MyAgICAwIDIyMC45RyAgMCBwYXJ0IAog
IOKUnOKUgHJoZWxfcmRtYS0tcGVyZi0tMDctcm9vdCAyNTM6MCAgICAwICAgIDUwRyAgMCBsdm0g
IC8KICDilJzilIByaGVsX3JkbWEtLXBlcmYtLTA3LXN3YXAgMjUzOjEgICAgMCAgICAgNEcgIDAg
bHZtICBbU1dBUF0KICDilJTilIByaGVsX3JkbWEtLXBlcmYtLTA3LWhvbWUgMjUzOjIgICAgMCAx
NjYuOUcgIDAgbHZtICAvaG9tZQpudm1lMG4xICAgICAgICAgICAgICAgICAgICAgIDI1OTowICAg
IDAgICAxLjhUICAwIGRpc2sgCm52bWUxbjEgICAgICAgICAgICAgICAgICAgICAgMjU5OjIgICAg
MCAgIDEuNVQgIDAgZGlzayAKCiMgcmVhbHBhdGggIC9zeXMvZGV2L2Jsb2NrLzI1OTowCi9zeXMv
ZGV2aWNlcy9wY2kwMDAwOmFlLzAwMDA6YWU6MDAuMC8wMDAwOmFmOjAwLjAvbnZtZS9udm1lMS9u
dm1lMG4xICAgLS0tLS0tLS0+IHNob3VsZCBpdCBiZSAvc3lzL2RldmljZXMvcGNpMDAwMDphZS8w
MDAwOmFlOjAwLjAvMDAwMDphZjowMC4wL252bWUvbnZtZTAvbnZtZTBuMSA/CgojIHJlYWxwYXRo
ICAvc3lzL2Rldi9ibG9jay8yNTk6Mgovc3lzL2RldmljZXMvdmlydHVhbC9udm1lLXN1YnN5c3Rl
bS9udm1lLXN1YnN5czEvbnZtZTFuMSAgICAgICAgICAgICAgIC0tLS0tLS0tPiBObyBwY2kgYWRk
cmVzcyByZXR1cm5lZCwgYnVnPwoKCgpbMl0gbnZtZS1jb3JlIG11bHRpcGF0aD1OCiMgcm1tb2Qg
bnZtZQojIHJtbW9kIG52bWUtY29yZQojIG52bWUgbGlzdAojIG1vZHByb2JlIG52bWUtY29yZSBt
dWx0aXBhdGg9TgojIGNhdCAvc3lzL21vZHVsZS9udm1lX2NvcmUvcGFyYW1ldGVycy9tdWx0aXBh
dGgKTgpbcm9vdEByZG1hLXBlcmYtMDcgfl0kIG1vZHByb2JlIG52bWUKTkFNRSAgICAgICAgICAg
ICAgICAgICAgICAgICBNQUo6TUlOIFJNICAgU0laRSBSTyBUWVBFIE1PVU5UUE9JTlQKc2RhICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDg6MCAgICAwIDIyMi41RyAgMCBkaXNrIArilJzilIBz
ZGExICAgICAgICAgICAgICAgICAgICAgICAgIDg6MSAgICAwICAgNjAwTSAgMCBwYXJ0IC9ib290
L2VmaQrilJzilIBzZGEyICAgICAgICAgICAgICAgICAgICAgICAgIDg6MiAgICAwICAgICAxRyAg
MCBwYXJ0IC9ib290CuKUlOKUgHNkYTMgICAgICAgICAgICAgICAgICAgICAgICAgODozICAgIDAg
MjIwLjlHICAwIHBhcnQgCiAg4pSc4pSAcmhlbF9yZG1hLS1wZXJmLS0wNy1yb290IDI1MzowICAg
IDAgICAgNTBHICAwIGx2bSAgLwogIOKUnOKUgHJoZWxfcmRtYS0tcGVyZi0tMDctc3dhcCAyNTM6
MSAgICAwICAgICA0RyAgMCBsdm0gIFtTV0FQXQogIOKUlOKUgHJoZWxfcmRtYS0tcGVyZi0tMDct
aG9tZSAyNTM6MiAgICAwIDE2Ni45RyAgMCBsdm0gIC9ob21lCm52bWUxbjEgICAgICAgICAgICAg
ICAgICAgICAgMjU5OjAgICAgMCAgIDEuOFQgIDAgZGlzayAKbnZtZTBuMSAgICAgICAgICAgICAg
ICAgICAgICAyNTk6MiAgICAwICAgMS41VCAgMCBkaXNrIAoKW3Jvb3RAcmRtYS1wZXJmLTA3IH5d
JCByZWFscGF0aCAvc3lzL2Rldi9ibG9jay8yNTk6MAovc3lzL2RldmljZXMvcGNpMDAwMDphZS8w
MDAwOmFlOjAwLjAvMDAwMDphZjowMC4wL252bWUvbnZtZTEvbnZtZTFuMQoKW3Jvb3RAcmRtYS1w
ZXJmLTA3IH5dJCByZWFscGF0aCAvc3lzL2Rldi9ibG9jay8yNTk6Mgovc3lzL2RldmljZXMvcGNp
MDAwMDo4NS8wMDAwOjg1OjAyLjAvMDAwMDo4NjowMC4wL252bWUvbnZtZTAvbnZtZTBuMQoKCiAg
IApCZXN0IFJlZ2FyZHMsCiAgWWkgWmhhbmcKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtbnZtZQo=
