Return-Path: <SRS0=Glcz=NV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEE3C43214
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 13:31:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F54460462
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 13:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8F54460462
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:Message-ID:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=x59NUjuU1IS/uuuCO85E1Si3O+p6c67D8BKj11Jb9T4=; b=O9BhdIinYQQnJ/
	re8h/Ec4mFf3IwzLXQe80RpZoLKBDH6Vp6Ya37Y5pmEkXPh31AVXxdAeNsWF4OTcQq2IParvyVHn8
	//xw/u2X8J58Hz1esvsYRTVQ7N0cASvuMtTi5LKzDUjV4uYIU0LNV4EwmEpm6+RL5l3Qfj8chCyMW
	rZbTuu/p5kszbAV7fqzpKRyJ2bNAosat8fa6wheKtT5ZCTV27CaLfqE4Sc2hUflG7wQWEoh6Scm7P
	nk1NVgk7zni6gm04WjjUIWktpioIHXMP6JLAAz0cbHfTIWlV2I0wLqLswSzxzJmnxtUfY9v6pGaAH
	TetjgddmcS+9mEFJPD9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mKhNg-00HJdF-Vv; Mon, 30 Aug 2021 13:31:21 +0000
Received: from smtpout140.security-mail.net ([85.31.212.148]
 helo=fx408.security-mail.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mKhNb-00HJae-0q
 for linux-nvme@lists.infradead.org; Mon, 30 Aug 2021 13:31:19 +0000
Received: from localhost (localhost [127.0.0.1])
 by fx408.security-mail.net (Postfix) with ESMTP id EE3291B7B2DF
 for <linux-nvme@lists.infradead.org>; Mon, 30 Aug 2021 15:30:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
 s=sec-sig-email; t=1630330230;
 bh=1DLxDYoMUGHKlV/cyAnIFMbxDhibe6I9L2Eqi0wSBK4=;
 h=Date:From:To:Subject;
 b=aAJC2hBnZW4uqbBrEf/DjiGlJ2KjV/jj+DC8Fl0hosuOSWvwHcHf1PMIbYtU24yjH
 rtNyoc498VIgya66Xs99AsSokUQA4LFRzuUeB+ESKs2/8dQPWNY+GgVKkgemnsLCmK
 bsDUDV8pghbfOl8yIJuMlfIip+XwOF8JFvLZ7wo8=
Received: from fx408 (localhost [127.0.0.1]) by fx408.security-mail.net
 (Postfix) with ESMTP id B89031B7B2E9 for <linux-nvme@lists.infradead.org>;
 Mon, 30 Aug 2021 15:30:29 +0200 (CEST)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx408.security-mail.net (Postfix) with ESMTPS id 518E81B7B2DD for
 <linux-nvme@lists.infradead.org>; Mon, 30 Aug 2021 15:30:29 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 3EC7727E02A8 for
 <linux-nvme@lists.infradead.org>; Mon, 30 Aug 2021 15:30:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 28C9C27E02E8 for <linux-nvme@lists.infradead.org>;
 Mon, 30 Aug 2021 15:30:29 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 F5vI8O_sAcrs for <linux-nvme@lists.infradead.org>; Mon, 30 Aug 2021 15:30:29
 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTP id 18E2927E02A8 for
 <linux-nvme@lists.infradead.org>; Mon, 30 Aug 2021 15:30:29 +0200 (CEST)
X-Virus-Scanned: E-securemail, by Secumail
Secumail-id: <56f9.612cdd75.50b59.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 28C9C27E02E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=4F334102-7B72-11EB-A74E-42D0B9747555; t=1630330229;
 bh=RfA6iKuLcifnhhh2emMYIptbXe0Po9JfvfsTjBU0C1Q=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=osISjHiNTx8gnvRtbA5QWkVJWpycWdwhPPa0aKoDNbkj0mNW5oesLhfeh2yvCQsYx
 I9k20J/EdCqtUBw1Exrx2pnyT7rYVUYHDYlUucrU10dlgEbb/5mSuZPjEKZFsXHh29
 N8RBW0EaBir89m4g6MlqYxb4a56UKS86FPYsvnnDFlk1J1dLRxpXuS3tj6d5cyJ1mF
 HGj1wHWJbUPoftNYaGFxM5NK7oZZ1sgyT0UmU4M5WMQd97GDrpM3ieVt5dkXXHEcQs
 q2arpFRsd3ddYzucQwXe0K0l0kBvdwskQrMKr/mKW3T8e0bCB1HHw2ZcyYdiGYjrF0
 QL83KKjDwhmgQ==
Date: Mon, 30 Aug 2021 15:30:29 +0200 (CEST)
From: Samuel Jones <sjones@kalrayinc.com>
To: linux-nvme <linux-nvme@lists.infradead.org>
Message-ID: <1058345072.5039165.1630330229081.JavaMail.zimbra@kalray.eu>
Subject: Command timeouts with NVMe TCP kernel driver
MIME-Version: 1.0
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 9.0.0_GA_3990 (ZimbraWebClient - FF70 (Linux)/9.0.0_GA_3990)
Thread-Index: ayHOE/RzT2FdF33jq03xsx6Hy746XA==
Thread-Topic: Command timeouts with NVMe TCP kernel driver
X-ALTERMIMEV2_out: done
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210830_063115_244828_DC7DE6ED 
X-CRM114-Status: GOOD (  21.45  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
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

SGkgYWxsLCAKCkknbSBleHBlcmllbmNpbmcgY29tbWFuZCB0aW1lb3V0cyB3aXRoIHJlY2VudCB2
ZXJzaW9ucyBvZiBudm1lLXRjcCBkcml2ZXIuIEkgaGF2ZSBzZXQgdXAgd2l0aCBhIFZNIHJ1bm5p
bmcgNS44IHdoaWNoIGlzIG9rLCBidXQgdGhlIHNhbWUgdGVzdCBsb2FkICgxMDAlUkQgMTZLIGJs
b2Nrcykgb24gYSBWTSA1LjExIG9yIGxhdGVyLCBpbmNsdWRpbmcgNS4xNC1yYzcsIHNob3dzIHRo
ZSBzYW1lIGlzc3VlLiBUaGUgaW5pdGF0aW9yIGNvbXBsYWlucyBhcyBmb2xsb3dzOiAKCkF1ZyAz
MCAxNDo1ODowNSBjZW50b3M3IGtlcm5lbDogbnZtZSBudm1lMDogcXVldWUgNzogdGltZW91dCBy
ZXF1ZXN0IDB4MTAgdHlwZSA0IApBdWcgMzAgMTQ6NTg6MDUgY2VudG9zNyBrZXJuZWw6IG52bWUg
bnZtZTA6IHN0YXJ0aW5nIGVycm9yIHJlY292ZXJ5IAoKTXkgdGFyZ2V0IGlzIGEgS2FscmF5IHRh
cmdldCwgYnV0IEkgaGF2ZSBubyB0cmFjZSBvZiBhbnkgb3V0c3RhbmRpbmcgY29tbWFuZHMgd2hl
biB0aGlzIHNpdHVhdGlvbiBvY2N1cnMuIFF1aXRlIHRoZSBvcHBvc2l0ZTogVGhlIEthbHJheSBi
b2FyZCBvYnNlcnZlcyB0aGF0IHRoZSBpbml0aWF0b3Igc3RvcHMgc2VuZGluZyBuZXcgcmVxdWVz
dHMgb24gdGhlIHF1ZXVlIHNvbWUgdGltZSBiZWZvcmUgdGhpcyBjb21tYW5kIHRpbWVzIG91dC4g
CgpJIGRvbid0IGhhdmUgYW55IHNpbWlsYXIgaXNzdWVzIHVzaW5nIFNQREsgYXMgYW4gaW5pdGlh
dG9yLiBJIG1hZGUgdGhlIGZvbGxvd2luZyBtb2RpZmljYXRpb24gdG8gbnZtZS10Y3AgY29kZSBh
bmQgbXkgcHJvYmxlbSBoYXMgZGlzYXBwZWFyZWQ6IAoKLS0tIGEvZHJpdmVycy9udm1lL2hvc3Qv
dGNwLmMgCisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jIApAQCAtMjg3LDYgKzI4Nyw3IEBA
IHN0YXRpYyBpbmxpbmUgdm9pZCBudm1lX3RjcF9xdWV1ZV9yZXF1ZXN0KHN0cnVjdCBudm1lX3Rj
cF9yZXF1ZXN0ICpyZXEsIAoqIGRpcmVjdGx5LCBvdGhlcndpc2UgcXVldWUgaW9fd29yay4gQWxz
bywgb25seSBkbyB0aGF0IGlmIHdlIAoqIGFyZSBvbiB0aGUgc2FtZSBjcHUsIHNvIHdlIGRvbid0
IGludHJvZHVjZSBjb250ZW50aW9uLiAKKi8gCisjaWYgMCAKaWYgKHF1ZXVlLT5pb19jcHUgPT0g
cmF3X3NtcF9wcm9jZXNzb3JfaWQoKSAmJiAKc3luYyAmJiBlbXB0eSAmJiBtdXRleF90cnlsb2Nr
KCZxdWV1ZS0+c2VuZF9tdXRleCkpIHsgCnF1ZXVlLT5tb3JlX3JlcXVlc3RzID0gIWxhc3Q7IApA
QCAtMjk2LDYgKzI5Nyw5IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBudm1lX3RjcF9xdWV1ZV9yZXF1
ZXN0KHN0cnVjdCBudm1lX3RjcF9yZXF1ZXN0ICpyZXEsIAp9IGVsc2UgaWYgKGxhc3QpIHsgCnF1
ZXVlX3dvcmtfb24ocXVldWUtPmlvX2NwdSwgbnZtZV90Y3Bfd3EsICZxdWV1ZS0+aW9fd29yayk7
IAp9IAorI2Vsc2UgCisgcXVldWVfd29ya19vbihxdWV1ZS0+aW9fY3B1LCBudm1lX3RjcF93cSwg
JnF1ZXVlLT5pb193b3JrKTsgCisjZW5kaWYgCn0gCgpUbyBiZSBob25lc3QsIHRoaXMgYml0IG9m
IGNvZGUgaGFzIGFsd2F5cyBib3RoZXJlZCBtZTogSSBkb24ndCB1bmRlcnN0YW5kIGhvdyB3ZSBj
YW4gZ3VhcmFudGVlIHRoYXQgdGhlIHRocmVhZCBkb2Vzbid0IGNoYW5nZSBDUFUgYmV0d2VlbiB0
aGUgY2FsbCB0byByYXdfc21wX3Byb2Nlc3Nvcl9pZCgpIGFuZCB0aGUgdHJ5bG9jay4gSSBhc3N1
bWUgdGhhdCBldmVuIGlmIHRoaXMgZG9lcyBvY2N1ciwgdGhlIGZhY3QgdGhhdCB3ZSBob2xkIHF1
ZXVlLT5zZW5kX211dGV4KCkgaXMgc3VwcG9zZWQgdG8gbWFrZSBzdXJlIHRoYXQgdGhlcmUgYXJl
IG5vIGF0b21pY2l0eSBpc3N1ZXMsIGJ1dCBJJ20gY29uY2VybmVkIGFib3V0IHRoZSBsb2dpYyB0
aGF0IHRyaWVzIHRvIGRldGVybWluZSBpZiB0aGVyZSBpcyBhbnkgbW9yZSBwZW5kaW5nIHdvcmsg
YW5kIHJlc2NoZWR1bGUgaW9fd29yayBpZiBhbmQgb25seSBpZiB0aGVyZSBpcyBzb21ldGhpbmcg
dG8gZG8uIEkgY2FuJ3QgcGlucG9pbnQgYW4gaXNzdWUgZnJvbSBqdXN0IHJlYWRpbmcgdGhlIGNv
ZGUgdGhvdWdoLi4gCgpEb2VzIGFueW9uZSBoYXZlIGFueSB0aG91Z2h0cyBvbiB0aGlzPyBJcyBt
eSBwYXRjaCBwcm9vZiB0aGF0IHRoZXJlIGlzIGFuIGlzc3VlIGluIHRoaXMgY29kZSwgb3IgYW0g
SSBsaWtlbHkgdG8gYmUgY2hhbmdpbmcgdGhlIHByb2dyYW0gZmxvdyBzbyBzaWduaWZpY2FudGx5
IHRoYXQgd2UgY2FuJ3QgY29uY2x1ZGU/IEFyZSB0aGVyZSBhbnkgb3BlbiBpc3N1ZXMgd3J0IGNv
bW1hbmQgdGltZW91dHMgYXQgdGhlIG1vbWVudD8gCgpUaGFua3MgaW4gYWR2YW5jZSBmb3IgYW55
IGhlbHAgClNhbQoKU2FtdWVsIEpvbmVzIApEYXRhY2VudGVyIFNXIERldmVsb3BtZW50IE1hbmFn
ZXIg4oCiIEthbHJheSAKUGhvbmU6IApzam9uZXNAa2FscmF5aW5jLmNvbSDigKIgWyBodHRwczov
L3d3dy5rYWxyYXlpbmMuY29tLyB8IHd3dy5rYWxyYXlpbmMuY29tIF0gCgpbIGh0dHBzOi8vd3d3
LmthbHJheWluYy5jb20vIHwgICBdIAoJCkludGVsbGlnZW50IERhdGEgUHJvY2Vzc2luZyAKRnJv
bSBDbG91ZCB0byBFZGdlIAoKUGxlYXNlIGNvbnNpZGVyIHRoZSBlbnZpcm9ubWVudCBiZWZvcmUg
cHJpbnRpbmcgdGhpcyBlLW1haWwuIApUaGlzIG1lc3NhZ2UgY29udGFpbnMgaW5mb3JtYXRpb24g
dGhhdCBtYXkgYmUgcHJpdmlsZWdlZCBvciBjb25maWRlbnRpYWwgYW5kIGlzIHRoZSBwcm9wZXJ0
eSBvZiBLYWxyYXkgUy5BLiBJdCBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgcGVyc29uIHRvIHdo
b20gaXQgaXMgYWRkcmVzc2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50
LCB5b3UgYXJlIG5vdCBhdXRob3JpemVkIHRvIHByaW50LCByZXRhaW4sIGNvcHksIGRpc3NlbWlu
YXRlLCBkaXN0cmlidXRlLCBvciB1c2UgdGhpcyBtZXNzYWdlIG9yIGFueSBwYXJ0IHRoZXJlb2Yu
IElmIHlvdSByZWNlaXZlIHRoaXMgbWVzc2FnZSBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUg
c2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkZWxldGUgYWxsIGNvcGllcyBvZiB0aGlzIG1lc3NhZ2Uu
CgoKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
