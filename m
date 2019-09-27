Return-Path: <SRS0=X9H7=XW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586D4C4360C
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 08:17:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BF10207FF
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 08:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fNAnLOJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF10207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rgFKvGkbJxkgXf+5gg33jhRi3zY9RuC4GukeyoqQFF0=; b=fNAnLOJXAOHOgq
	W+7YAPo/yQ7igVlD5LOnAnS0lYty/elVmv9ZsdhC845qXITIUtvCfSsXrXau2F44R4Wclq9GtD+Is
	NKsbuQWtG1M91YB18UHRg9Ypq53X1ho3xXpSSGEc/4eEHVRbHNLh04BXP18CDjPlvOlBKRwdLn1IP
	TQbWgt01ZXPIg5cRG6KidTK9Eflutk8DVhRuUENBB+E3aedTSDcQijLJ7p0cdOiVjFkfQW3JmGLWy
	V6mHcJ/ztMcR7Vzc98TyGWg2SAljt862Hd3PYYd/R8cAJtTyJdvzT0OeLwRbuTmtf1P06TdhyMZzX
	ZdVcc9Esafz5WGg0R7kA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iDlRb-0004Pu-1S; Fri, 27 Sep 2019 08:17:39 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDlRY-0004PZ-7z
 for linux-nvme@lists.infradead.org; Fri, 27 Sep 2019 08:17:38 +0000
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AF6FA20F5;
 Fri, 27 Sep 2019 08:17:35 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A614660BE2;
 Fri, 27 Sep 2019 08:17:35 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com
 (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 8EEC04EBC0;
 Fri, 27 Sep 2019 08:17:35 +0000 (UTC)
Date: Fri, 27 Sep 2019 04:17:35 -0400 (EDT)
From: Yi Zhang <yi.zhang@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1512861450.3461442.1569572255032.JavaMail.zimbra@redhat.com>
In-Reply-To: <0a8fffe2-f607-26ac-43f5-86182b1c782e@mellanox.com>
References: <1437535598.446597.1568798016422.JavaMail.zimbra@redhat.com>
 <2ea07772-3905-fb82-4d73-7458a963677c@mellanox.com>
 <1a2ef415-72fd-7a78-33b3-5a2656246f77@redhat.com>
 <d8526cc2-e270-baf0-1ff6-728e69e8d86a@grimberg.me>
 <0a8fffe2-f607-26ac-43f5-86182b1c782e@mellanox.com>
Subject: Re: NVMeoF RDMA IB: I/O timeout and NULL pointer observed during
 rescan_controller/reset_controller with fio background
MIME-Version: 1.0
X-Originating-IP: [10.68.5.41, 10.4.195.21]
Thread-Topic: NVMeoF RDMA IB: I/O timeout and NULL pointer observed during
 rescan_controller/reset_controller with fio background
Thread-Index: 1A+W8rjGJUCCAPi6cxena8km0p71Tg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Fri, 27 Sep 2019 08:17:35 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190927_011736_320098_AF14BAF1 
X-CRM114-Status: GOOD (  13.76  )
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
Cc: Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGkgU2FnaQoKQ29uZmlybWVkIHRoZSBOVUxMIHBvaW50ZXIgaXNzdWUgd2FzIGZpeGVkIGJ5IHRo
aXMgcGF0Y2gsIGFuZCAiSS9PIDEgUUlEIDAgdGltZW91dCIgc3RpbGwgZXhpc3RzLCB0aGFua3Mu
Cgo8Nj5bIDU4MDcuMjkzNTc3XSBudm1lIG52bWUyOiBjcmVhdGluZyA0OCBJL08gcXVldWVzLgo8
Nj5bIDU4MTcuMjEwMTY4XSBudm1lIG52bWUyOiBSZW1vdmluZyBjdHJsOiBOUU4gInRlc3RucW4i
Cjw2PlsgNTgyMS4xMzAzNDhdIG52bWUgbnZtZTI6IG5ldyBjdHJsOiBOUU4gIm5xbi4yMDE0LTA4
Lm9yZy5udm1leHByZXNzLmRpc2NvdmVyeSIsIGFkZHIgMTcyLjMxLjAuMTg2OjQ0MjAKPDY+WyA1
ODIxLjEzOTgzMF0gbnZtZSBudm1lMjogUmVtb3ZpbmcgY3RybDogTlFOICJucW4uMjAxNC0wOC5v
cmcubnZtZXhwcmVzcy5kaXNjb3ZlcnkiCjw2PlsgNTgyMS4xODUxMjhdIG52bWUgbnZtZTI6IGNy
ZWF0aW5nIDQ4IEkvTyBxdWV1ZXMuCjw2PlsgNTgyMS45MjU3MzZdIG52bWUgbnZtZTI6IG1hcHBl
ZCA0OC8wLzAgZGVmYXVsdC9yZWFkL3BvbGwgcXVldWVzLgo8Nj5bIDU4MjEuOTUwODU1XSBudm1l
IG52bWUyOiBuZXcgY3RybDogTlFOICJ0ZXN0bnFuIiwgYWRkciAxNzIuMzEuMC4xODY6NDQyMAo8
Nj5bIDU4MjEuOTUzMTUyXSBudm1lMm4xOiBkZXRlY3RlZCBjYXBhY2l0eSBjaGFuZ2UgZnJvbSAw
IHRvIDE2MDAzMjEzMTQ4MTYKPDQ+WyA1ODI2LjU0NjU4Nl0gbnZtZV9uc19oZWFkX21ha2VfcmVx
dWVzdDogMjUwNjQ0IGNhbGxiYWNrcyBzdXBwcmVzc2VkCjw0PlsgNTgyNi41NDY1ODldIGJsb2Nr
IG52bWUybjE6IG5vIHVzYWJsZSBwYXRoIC0gcmVxdWV1aW5nIEkvTwo8ND5bIDU4MjYuNTQ2NTkx
XSBibG9jayBudm1lMm4xOiBubyB1c2FibGUgcGF0aCAtIHJlcXVldWluZyBJL08KPDQ+WyA1ODI2
LjU0NjYwNl0gYmxvY2sgbnZtZTJuMTogbm8gdXNhYmxlIHBhdGggLSByZXF1ZXVpbmcgSS9PCjw0
PlsgNTgyNi41NDY2MDldIGJsb2NrIG52bWUybjE6IG5vIHVzYWJsZSBwYXRoIC0gcmVxdWV1aW5n
IEkvTwo8ND5bIDU4MjYuNTQ2NjI0XSBibG9jayBudm1lMm4xOiBubyB1c2FibGUgcGF0aCAtIHJl
cXVldWluZyBJL08KPDQ+WyA1ODI2LjU0NjYyN10gYmxvY2sgbnZtZTJuMTogbm8gdXNhYmxlIHBh
dGggLSByZXF1ZXVpbmcgSS9PCjw0PlsgNTgyNi41NDY2MjldIGJsb2NrIG52bWUybjE6IG5vIHVz
YWJsZSBwYXRoIC0gcmVxdWV1aW5nIEkvTwo8ND5bIDU4MjYuNTQ2NjMzXSBibG9jayBudm1lMm4x
OiBubyB1c2FibGUgcGF0aCAtIHJlcXVldWluZyBJL08KPDQ+WyA1ODI2LjU0NjYzNV0gYmxvY2sg
bnZtZTJuMTogbm8gdXNhYmxlIHBhdGggLSByZXF1ZXVpbmcgSS9PCjw0PlsgNTgyNi41NDY2MzZd
IGJsb2NrIG52bWUybjE6IG5vIHVzYWJsZSBwYXRoIC0gcmVxdWV1aW5nIEkvTwo8ND5bIDU4Mzcu
NDgxMDU0XSBoZmkxX29wYTAuODAyNDogUF9LZXkgMHg4MDI0IGlzIG5vdCBmb3VuZAo8ND5bIDU4
MzcuNDg2MTk5XSBoZmkxX29wYTAuODAyMjogUF9LZXkgMHg4MDIyIGlzIG5vdCBmb3VuZAo8Nj5b
IDU4MzcuNTAzMjc4XSBJUHY2OiBBRERSQ09ORihORVRERVZfQ0hBTkdFKTogaGZpMV9vcGEwOiBs
aW5rIGJlY29tZXMgcmVhZHkKPDQ+WyA1ODgyLjQ2NTM4OF0gaGZpMV9vcGEwLjgwMjQ6IFBfS2V5
IDB4ODAyNCBpcyBub3QgZm91bmQKPDQ+WyA1ODgyLjQ3MDUyMF0gaGZpMV9vcGEwLjgwMjI6IFBf
S2V5IDB4ODAyMiBpcyBub3QgZm91bmQKPDY+WyA1ODgyLjQ4NzY0N10gSVB2NjogQUREUkNPTkYo
TkVUREVWX0NIQU5HRSk6IGhmaTFfb3BhMDogbGluayBiZWNvbWVzIHJlYWR5Cjw0PlsgNTg4OC41
MTUzOTVdIG52bWUgbnZtZTI6IEkvTyAxIFFJRCAwIHRpbWVvdXQKPDM+WyA1ODg4LjUzMzM2MV0g
bnZtZSBudm1lMjogQ29ubmVjdCBjb21tYW5kIGZhaWxlZCwgZXJyb3Igd28vRE5SIGJpdDogNwo8
Nj5bIDU4ODguNTM5NjQ1XSBudm1lIG52bWUyOiBmYWlsZWQgdG8gY29ubmVjdCBxdWV1ZTogMCBy
ZXQ9Nwo8Nj5bIDU4ODguNTQ0OTk0XSBudm1lIG52bWUyOiBSZWNvbm5lY3RpbmcgaW4gMTAgc2Vj
b25kcy4uLgo8Nj5bIDU4OTguNzc0OTU1XSBudm1lIG52bWUyOiBjcmVhdGluZyA0OCBJL08gcXVl
dWVzLgo8Nj5bIDU4OTkuNTcwMDUzXSBudm1lIG52bWUyOiBTdWNjZXNzZnVsbHkgcmVjb25uZWN0
ZWQgKDIgYXR0ZW1wdHMpCjw0PlsgNTkyNy44MTg0NjZdIGhmaTFfb3BhMC44MDI0OiBQX0tleSAw
eDgwMjQgaXMgbm90IGZvdW5kCjw0PlsgNTkyNy44MjM1NTBdIGhmaTFfb3BhMC44MDIyOiBQX0tl
eSAweDgwMjIgaXMgbm90IGZvdW5kCjw2PlsgNTkyNy44NDM5NzJdIElQdjY6IEFERFJDT05GKE5F
VERFVl9DSEFOR0UpOiBoZmkxX29wYTA6IGxpbmsgYmVjb21lcyByZWFkeQo8Nj5bIDYwMDQuOTcw
NDc5XSBudm1lIG52bWUyOiBSZW1vdmluZyBjdHJsOiBOUU4gInRlc3RucW4iCgoKQmVzdCBSZWdh
cmRzLAogIFlpIFpoYW5nCgoKLS0tLS0gT3JpZ2luYWwgTWVzc2FnZSAtLS0tLQpGcm9tOiAiTWF4
IEd1cnRvdm95IiA8bWF4Z0BtZWxsYW5veC5jb20+ClRvOiAiU2FnaSBHcmltYmVyZyIgPHNhZ2lA
Z3JpbWJlcmcubWU+LCAiWWkgWmhhbmciIDx5aS56aGFuZ0ByZWRoYXQuY29tPiwgbGludXgtbnZt
ZUBsaXN0cy5pbmZyYWRlYWQub3JnClNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDIzLCAyMDE5IDEx
OjI1OjMxIFBNClN1YmplY3Q6IFJlOiBOVk1lb0YgUkRNQSBJQjogSS9PIHRpbWVvdXQgYW5kIE5V
TEwgcG9pbnRlciBvYnNlcnZlZCBkdXJpbmcgcmVzY2FuX2NvbnRyb2xsZXIvcmVzZXRfY29udHJv
bGxlciB3aXRoIGZpbyBiYWNrZ3JvdW5kCgpBbnkgdXBkYXRlIFlpID8KCndlIG11c3QgZml4IHRo
aXMgaXNzdWUuLgoKT24gOS8yMC8yMDE5IDc6NTggUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4g
VGhhbmtzIGZvciByZXBvcnRpbmcgWWksCj4KPiBEb2VzIHRoaXMgZml4IHlvdXIgaXNzdWU/Cj4K
PiAtLSAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jIGIvZHJpdmVycy9u
dm1lL2hvc3QvcmRtYS5jCj4gaW5kZXggZGZhMDdiYjlkZmViLi45ODFkYTljZTNjZmMgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jCj4gKysrIGIvZHJpdmVycy9udm1lL2hv
c3QvcmRtYS5jCj4gQEAgLTYxNCw3ICs2MTQsOCBAQCBzdGF0aWMgaW50IG52bWVfcmRtYV9zdGFy
dF9xdWV1ZShzdHJ1Y3QgCj4gbnZtZV9yZG1hX2N0cmwgKmN0cmwsIGludCBpZHgpCj4gwqDCoMKg
wqDCoMKgwqAgaWYgKCFyZXQpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2V0
X2JpdChOVk1FX1JETUFfUV9MSVZFLCAmcXVldWUtPmZsYWdzKTsKPiDCoMKgwqDCoMKgwqDCoCB9
IGVsc2Ugewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fbnZtZV9yZG1hX3N0b3Bf
cXVldWUocXVldWUpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICh0ZXN0X2Jp
dChOVk1FX1JETUFfUV9BTExPQ0FURUQsICZxdWV1ZS0+ZmxhZ3MpKQo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX252bWVfcmRtYV9zdG9wX3F1ZXVlKHF1
ZXVlKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X2luZm8oY3RybC0+Y3Ry
bC5kZXZpY2UsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAiZmFpbGVkIHRvIGNvbm5lY3QgcXVldWU6ICVkIHJldD0lZFxuIiwgaWR4LCAKPiByZXQpOwo+
IMKgwqDCoMKgwqDCoMKgIH0KPiAtLSAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW52bWUKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
