Return-Path: <SRS0=k+Rq=MI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8A0C12002
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 09:33:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB0B1613ED
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 09:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0B1613ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NOvQIqvhBStmr4QuNeQGlhHzHI9OrCvl3oIeHy6b2tc=; b=ifNjSiGQrtOou3
	gaErSCtSgW9reOJi5g0S2VkZ0KXJvDhrsePAt8q1eCsMfeoPDQFGsGz0JkdeosVqsW1rx0xzb3sqU
	CsI/dJRCKNmGZJWimydFYKRrtQsWrZckQtBdYxTPwi+Wa6ixoi+Wxlzzf5MNsrvlrOoFy4Is+DNBg
	eaK16DzEOHwOIMT5UAJADODbtLpVa36nte3Y/R7DIA73YZukdaNNLNUFZ6ORtdCaxO+4QMKGwiqQ0
	azco0dOK+MRl0cNjNwfNqk6W+wQSLkpf+rpxhICfOxp6pSY0jrLuB9WrR5NB5VqUu1YW6b6hXPIgh
	9pQftBa2MZ5PDDv/DWqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4KDq-003vz0-M8; Fri, 16 Jul 2021 09:33:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4KDm-003vwZ-Uq
 for linux-nvme@lists.infradead.org; Fri, 16 Jul 2021 09:33:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626428004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m08xqBA+uGZoSfDv0tyerS1nF0XIak+eyqoZwC+cyQU=;
 b=fs+uiCL+FgX9B4Y7CzNcyliC87vtZtwMV4adJC3RD6CV7gFLE38p+4ZAqBQhxtxmL3O6Oi
 E5OrOTQabtzve7ABKXGhJA6iTjDHtndUoQBwwmKWsvTjnQMIjeQNslBEsgi0PHRQrxLdSN
 kTVURCL7orejL2/YPVRswQQmp4YtVsY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-RuIirQ95PvymlHJa_zgO6g-1; Fri, 16 Jul 2021 05:33:23 -0400
X-MC-Unique: RuIirQ95PvymlHJa_zgO6g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 362F5CC621;
 Fri, 16 Jul 2021 09:33:21 +0000 (UTC)
Received: from T590 (ovpn-13-146.pek2.redhat.com [10.72.13.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E5136604CD;
 Fri, 16 Jul 2021 09:33:10 +0000 (UTC)
Date: Fri, 16 Jul 2021 17:33:05 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, David Jeffery <djeffery@redhat.com>,
 Laurence Oberman <loberman@redhat.com>,
 Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
 Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Keith Busch <kbusch@kernel.org>
Subject: Re: New warning in nvme_setup_discard
Message-ID: <YPFSUfG+fMITAH01@T590>
References: <4729812.CpyZKHjjVO@natalenko.name> <YPDr8ucoDCE4NBSe@T590>
 <81322754.HEIg0oD171@natalenko.name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <81322754.HEIg0oD171@natalenko.name>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210716_023327_158598_6DA515E6 
X-CRM114-Status: GOOD (  22.32  )
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

T24gRnJpLCBKdWwgMTYsIDIwMjEgYXQgMDc6NTM6MjhBTSArMDIwMCwgT2xla3NhbmRyIE5hdGFs
ZW5rbyB3cm90ZToKPiBIZWxsby4KPiAKPiBPbiBww6F0ZWsgMTYuIMSNZXJ2ZW5jZSAyMDIxIDQ6
MTY6MTggQ0VTVCBNaW5nIExlaSB3cm90ZToKPiA+ID4gIDg1MCAgICAgaWYgKFdBUk5fT05fT05D
RShuICE9IHNlZ21lbnRzKSkgewo+ID4gCj4gPiBXaGF0IGlzICduJyBhbmQgJ3NlZ21lbnRzJz8K
PiAKPiBTbywgSSB1c2VkIHRoaXMgY2hhbmdlIHRvIGNoZWNrIHRoYXQ6Cj4gCj4gYGBgCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2Nv
cmUuYwo+IGluZGV4IDY2OTczYmI1NjMwNS4uMGE2NGYyZjc3ZGFmIDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+
IEBAIC04NDcsNyArODQ3LDggQEAgc3RhdGljIGJsa19zdGF0dXNfdCBudm1lX3NldHVwX2Rpc2Nh
cmQoc3RydWN0IG52bWVfbnMgKm5zLCAKPiBzdHJ1Y3QgcmVxdWVzdCAqcmVxLAo+ICAJCW4rKzsK
PiAgCX0KPiAgCj4gLQlpZiAoV0FSTl9PTl9PTkNFKG4gIT0gc2VnbWVudHMpKSB7Cj4gKwlpZiAo
dW5saWtlbHkobiAhPSBzZWdtZW50cykpIHsKPiArCQlwcl93YXJuKCJudm1lX3NldHVwX2Rpc2Nh
cmQ6IG4gIT0gc2VnbWVudHMgKCV1ICE9ICV1KVxuIiwgbiwgCj4gc2VnbWVudHMpOwo+ICAJCWlm
ICh2aXJ0X3RvX3BhZ2UocmFuZ2UpID09IG5zLT5jdHJsLT5kaXNjYXJkX3BhZ2UpCj4gIAkJCWNs
ZWFyX2JpdF91bmxvY2soMCwgJm5zLT5jdHJsLT5kaXNjYXJkX3BhZ2VfYnVzeSk7Cj4gIAkJZWxz
ZQo+IAo+IGBgYAo+IAo+IGFuZCB0aGUgcmVzdWx0IGlzOgo+IAo+IGBgYAo+IG52bWVfc2V0dXBf
ZGlzY2FyZDogbiAhPSBzZWdtZW50cyAoMyAhPSAyKQo+IG52bWVfc2V0dXBfZGlzY2FyZDogbiAh
PSBzZWdtZW50cyAoMTIgIT0gMTEpCj4gYGBgCgpDYW4geW91IHRlc3QgdGhlIGZvbGxvd2luZyBw
YXRjaD8KCmRpZmYgLS1naXQgYS9ibG9jay9iZnEtaW9zY2hlZC5jIGIvYmxvY2svYmZxLWlvc2No
ZWQuYwppbmRleCA3Mjc5NTU5MTg1NjMuLjY3M2E2MzRlYWRkOSAxMDA2NDQKLS0tIGEvYmxvY2sv
YmZxLWlvc2NoZWQuYworKysgYi9ibG9jay9iZnEtaW9zY2hlZC5jCkBAIC0yMzYxLDYgKzIzNjEs
OSBAQCBzdGF0aWMgaW50IGJmcV9yZXF1ZXN0X21lcmdlKHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpx
LCBzdHJ1Y3QgcmVxdWVzdCAqKnJlcSwKIAlfX3JxID0gYmZxX2ZpbmRfcnFfZm1lcmdlKGJmcWQs
IGJpbywgcSk7CiAJaWYgKF9fcnEgJiYgZWx2X2Jpb19tZXJnZV9vayhfX3JxLCBiaW8pKSB7CiAJ
CSpyZXEgPSBfX3JxOworCisJCWlmIChibGtfZGlzY2FyZF9tZXJnYWJsZShfX3JxKSkKKwkJCXJl
dHVybiBFTEVWQVRPUl9ESVNDQVJEX01FUkdFOwogCQlyZXR1cm4gRUxFVkFUT1JfRlJPTlRfTUVS
R0U7CiAJfQogCmRpZmYgLS1naXQgYS9ibG9jay9ibGstbWVyZ2UuYyBiL2Jsb2NrL2Jsay1tZXJn
ZS5jCmluZGV4IGExMWIzYjUzNzE3ZS4uZjg3MDdmZjdlMmZjIDEwMDY0NAotLS0gYS9ibG9jay9i
bGstbWVyZ2UuYworKysgYi9ibG9jay9ibGstbWVyZ2UuYwpAQCAtNzA1LDIyICs3MDUsNiBAQCBz
dGF0aWMgdm9pZCBibGtfYWNjb3VudF9pb19tZXJnZV9yZXF1ZXN0KHN0cnVjdCByZXF1ZXN0ICpy
ZXEpCiAJfQogfQogCi0vKgotICogVHdvIGNhc2VzIG9mIGhhbmRsaW5nIERJU0NBUkQgbWVyZ2U6
Ci0gKiBJZiBtYXhfZGlzY2FyZF9zZWdtZW50cyA+IDEsIHRoZSBkcml2ZXIgdGFrZXMgZXZlcnkg
YmlvCi0gKiBhcyBhIHJhbmdlIGFuZCBzZW5kIHRoZW0gdG8gY29udHJvbGxlciB0b2dldGhlci4g
VGhlIHJhbmdlcwotICogbmVlZG4ndCB0byBiZSBjb250aWd1b3VzLgotICogT3RoZXJ3aXNlLCB0
aGUgYmlvcy9yZXF1ZXN0cyB3aWxsIGJlIGhhbmRsZWQgYXMgc2FtZSBhcwotICogb3RoZXJzIHdo
aWNoIHNob3VsZCBiZSBjb250aWd1b3VzLgotICovCi1zdGF0aWMgaW5saW5lIGJvb2wgYmxrX2Rp
c2NhcmRfbWVyZ2FibGUoc3RydWN0IHJlcXVlc3QgKnJlcSkKLXsKLQlpZiAocmVxX29wKHJlcSkg
PT0gUkVRX09QX0RJU0NBUkQgJiYKLQkgICAgcXVldWVfbWF4X2Rpc2NhcmRfc2VnbWVudHMocmVx
LT5xKSA+IDEpCi0JCXJldHVybiB0cnVlOwotCXJldHVybiBmYWxzZTsKLX0KLQogc3RhdGljIGVu
dW0gZWx2X21lcmdlIGJsa190cnlfcmVxX21lcmdlKHN0cnVjdCByZXF1ZXN0ICpyZXEsCiAJCQkJ
CXN0cnVjdCByZXF1ZXN0ICpuZXh0KQogewpkaWZmIC0tZ2l0IGEvYmxvY2svZWxldmF0b3IuYyBi
L2Jsb2NrL2VsZXZhdG9yLmMKaW5kZXggNTJhZGExNGNmZTQ1Li5hNWZlMjYxNWVjMGYgMTAwNjQ0
Ci0tLSBhL2Jsb2NrL2VsZXZhdG9yLmMKKysrIGIvYmxvY2svZWxldmF0b3IuYwpAQCAtMzM2LDYg
KzMzNiw5IEBAIGVudW0gZWx2X21lcmdlIGVsdl9tZXJnZShzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAq
cSwgc3RydWN0IHJlcXVlc3QgKipyZXEsCiAJX19ycSA9IGVsdl9ycWhhc2hfZmluZChxLCBiaW8t
PmJpX2l0ZXIuYmlfc2VjdG9yKTsKIAlpZiAoX19ycSAmJiBlbHZfYmlvX21lcmdlX29rKF9fcnEs
IGJpbykpIHsKIAkJKnJlcSA9IF9fcnE7CisKKwkJaWYgKGJsa19kaXNjYXJkX21lcmdhYmxlKF9f
cnEpKQorCQkJcmV0dXJuIEVMRVZBVE9SX0RJU0NBUkRfTUVSR0U7CiAJCXJldHVybiBFTEVWQVRP
Ul9CQUNLX01FUkdFOwogCX0KIApkaWZmIC0tZ2l0IGEvYmxvY2svbXEtZGVhZGxpbmUtbWFpbi5j
IGIvYmxvY2svbXEtZGVhZGxpbmUtbWFpbi5jCmluZGV4IDZmNjEyZTZkYzgyYi4uMjk0YmUwYzBk
YjY1IDEwMDY0NAotLS0gYS9ibG9jay9tcS1kZWFkbGluZS1tYWluLmMKKysrIGIvYmxvY2svbXEt
ZGVhZGxpbmUtbWFpbi5jCkBAIC02NzcsNiArNjc3LDggQEAgc3RhdGljIGludCBkZF9yZXF1ZXN0
X21lcmdlKHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxLCBzdHJ1Y3QgcmVxdWVzdCAqKnJxLAogCiAJ
CWlmIChlbHZfYmlvX21lcmdlX29rKF9fcnEsIGJpbykpIHsKIAkJCSpycSA9IF9fcnE7CisJCQlp
ZiAoYmxrX2Rpc2NhcmRfbWVyZ2FibGUoX19ycSkpCisJCQkJcmV0dXJuIEVMRVZBVE9SX0RJU0NB
UkRfTUVSR0U7CiAJCQlyZXR1cm4gRUxFVkFUT1JfRlJPTlRfTUVSR0U7CiAJCX0KIAl9CmRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L2Jsa2Rldi5oIGIvaW5jbHVkZS9saW51eC9ibGtkZXYuaApp
bmRleCAzMTc3MTgxYzQzMjYuLjg3ZjAwMjkyZmQ3YSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51
eC9ibGtkZXYuaAorKysgYi9pbmNsdWRlL2xpbnV4L2Jsa2Rldi5oCkBAIC0xNTIxLDYgKzE1MjEs
MjIgQEAgc3RhdGljIGlubGluZSBpbnQgcXVldWVfbGltaXRfZGlzY2FyZF9hbGlnbm1lbnQoc3Ry
dWN0IHF1ZXVlX2xpbWl0cyAqbGltLCBzZWN0b3IKIAlyZXR1cm4gb2Zmc2V0IDw8IFNFQ1RPUl9T
SElGVDsKIH0KIAorLyoKKyAqIFR3byBjYXNlcyBvZiBoYW5kbGluZyBESVNDQVJEIG1lcmdlOgor
ICogSWYgbWF4X2Rpc2NhcmRfc2VnbWVudHMgPiAxLCB0aGUgZHJpdmVyIHRha2VzIGV2ZXJ5IGJp
bworICogYXMgYSByYW5nZSBhbmQgc2VuZCB0aGVtIHRvIGNvbnRyb2xsZXIgdG9nZXRoZXIuIFRo
ZSByYW5nZXMKKyAqIG5lZWRuJ3QgdG8gYmUgY29udGlndW91cy4KKyAqIE90aGVyd2lzZSwgdGhl
IGJpb3MvcmVxdWVzdHMgd2lsbCBiZSBoYW5kbGVkIGFzIHNhbWUgYXMKKyAqIG90aGVycyB3aGlj
aCBzaG91bGQgYmUgY29udGlndW91cy4KKyAqLworc3RhdGljIGlubGluZSBib29sIGJsa19kaXNj
YXJkX21lcmdhYmxlKHN0cnVjdCByZXF1ZXN0ICpyZXEpCit7CisJaWYgKHJlcV9vcChyZXEpID09
IFJFUV9PUF9ESVNDQVJEICYmCisJICAgIHF1ZXVlX21heF9kaXNjYXJkX3NlZ21lbnRzKHJlcS0+
cSkgPiAxKQorCQlyZXR1cm4gdHJ1ZTsKKwlyZXR1cm4gZmFsc2U7Cit9CisKIHN0YXRpYyBpbmxp
bmUgaW50IGJkZXZfZGlzY2FyZF9hbGlnbm1lbnQoc3RydWN0IGJsb2NrX2RldmljZSAqYmRldikK
IHsKIAlzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSA9IGJkZXZfZ2V0X3F1ZXVlKGJkZXYpOwoKVGhh
bmtzLApNaW5nCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
