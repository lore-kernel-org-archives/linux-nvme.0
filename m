Return-Path: <SRS0=Uoxm=H7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E1CC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 02:07:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F21964E01
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 02:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F21964E01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=etOsFNBEKClryc+DfaaZlHUkFuhVpHlTDtjgYqm+dAA=; b=lOB2yh44RxKj0dpSsCQ6gcGzu
	hD+V9TApST/ygAWb05DCg5qEx5CxvWpu17kbg3qP8tfvHMcLj0J/R7QEJLlbjw6CZ1Yn8O7k02adU
	zz5+1pVovq+X5BkRxXUhupIXVwZgLbddwqT7am3CfCk0VtIBUMTF78qE+rkrsHUwb9BMXZ+CRgtdU
	rWg6ZZHwdd7SqNPzZKzKvQrel1enpMKOEGnmEVTcADdkXRjCfJftyRvbeGDpQla4xHbWvxPB016LJ
	pGfV+Ktd4aiB9ztIpsE5IX53LB1RnDZZEzlGjPjSmKirLY9rIGExbe2sgId5bERKRV7BCRMcvfmqr
	/8Ck1l6fA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lGXxa-0004V1-Q9; Mon, 01 Mar 2021 02:06:58 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGXxX-0004Ti-P7
 for linux-nvme@lists.infradead.org; Mon, 01 Mar 2021 02:06:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614564416; x=1646100416;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hzqO0PzDFiT/8Qfj7NQ+B7kp8xKkwD6IXV9KGCAVsCc=;
 b=iGU5K+NkDQm+I3YuLPIYgK7ldt6fi9amObuFJyYT+cXsx1pqUmpFO5N5
 dqzLmMjPP+QR7X/BGwLcOISC7ns2+hE0c/SHH6vcBrt10opXRekMkIxs1
 zg4PmQXRDNtL3Pvdv3KJBH3UPrD4VYRskwu6uScz+oOqeCo2GBRPujIo0
 EncweoJI/O2w9quQ8H+lAAkhatpyOlCgGh6gZutz+Nqy5tbWs51jgiR5Y
 J5T3AgDrsBl4cnB7Iww00gKMAA2398QNDMWW/DDiTL9dmCB346gfmfk1U
 nHGZaA8Z5WhhKSlQSdT0/1aqCZu/tsLY3ahaXomESWUJ0R2l/RLvqVOrv Q==;
IronPort-SDR: onEwW2slDXfLZkhA/iWaR7WqZQMGm4Uk/3G3TBxR9TAjGo6lQVg1gUNEePksNA+nipaZi2rlyu
 yBRyjXB2P12j37+OCImMnteuZIqWZFyV8NPk9mrGj5H/ziGkZMYRYkxiDw6be7y23YiZHv7c+q
 QQf5g3d+Rn3WNQ7BfEePetxi8JN0K+rZeQvCSqSsZ7hIytUEWfMyU2WWOIdRZsrLKtoYcbPd5j
 L6Ef+rvG29+1suMgGwLcV2bNoApjmw37nPc+9qvM2p94wUmwhABWZlqtDFVQHmBYfJVDlc7FS+
 riY=
X-IronPort-AV: E=Sophos;i="5.81,214,1610380800"; d="scan'208";a="162191638"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2021 10:06:56 +0800
IronPort-SDR: 6QzzDGRm+vpH3Uk4tTnI3dKQ/Beie4tpg+DfTXWCABHw8m9of9ANO0luYJ1210eA4UMgu1PYUj
 VjxvYSX2mt/qQV7kh6ZPKhIhYWArAGoJLfFn2CP4ygalLwfVzi/O/EDc/BegH1eGexYonjd/b7
 9IvDLLF4+97ur+J6/SPGlYF0hQi3ZV4F9nNPDWz7NpHgN2P/BqtWYjEU2J91bePSjZnbb99ge8
 /gfWU1Sh4SG26KeEU2uqo8qj7e1xOOyMSU+gRYphAukB/7Dz9U2nXnOLpi7q3+13oD+jksMCwx
 m/AVT15goc+LPYj6NG1txF1n
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2021 17:48:12 -0800
IronPort-SDR: jjDRSE88ZnrjOZBthrD6CSDOCjp7sPW9gSnZDyVFecNkCsPkmopaHpxF1PV47cEUd+goElThkj
 CDxwW5WChrFI/g0ypyO0B3OxqTvF0pVyB6scNw6fxqE++RP7VG49Fz8KV4BbtO/aaRtqDVwsCc
 YDwa74ZeN1baVqQG+nQ1d5Al5OaZp3ImL620krVMH/QnwCyAYpFwpf7vsBfk9Gp3on9PP7F5nr
 PI1PwQHqOFoQhVMeJuDFOjeChAW3O3S9sgSwcy2slK+JatKiQoJDp5ZevYBgpcpPLYLPufz+66
 NEk=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 28 Feb 2021 18:06:55 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 5/8] nvme-core: don't check nvme_req flags for new req
Date: Sun, 28 Feb 2021 18:06:08 -0800
Message-Id: <20210301020611.18669-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210301020611.18669-1-chaitanya.kulkarni@wdc.com>
References: <20210301020611.18669-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210228_210655_953589_D1EEB345 
X-CRM114-Status: GOOD (  16.09  )
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
Cc: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, james.smart@broadcom.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

bnZtZV9jbGVhcl9yZXF1ZXN0KCkgaGFzIGEgY2hlY2sgZm9yIGZsYWcgUkVRX0RPTlRQUkVQIGFu
ZCBpdCBpcyBjYWxsZWQKZnJvbSBudm1lX2luaXRfcmVxdWVzdCgpIGFuZCBudm1lX3NldHVvX2Nt
ZCgpLgoKVGhlIGZ1bmN0aW9uIG52bWVfaW5pdF9yZXF1ZXN0KCkgaXMgY2FsbGVkIGZyb20gbnZt
ZV9hbGxvY19yZXF1ZXN0KCkKYW5kIG52bWVfYWxsb2NfcmVxdWVzdF9xaWQoKS4gRnJvbSB0aGVz
ZSB0d28gY2FsbGVycyBuZXcgcmVxdWVzdCBpcwphbGxvY2F0ZWQgZXZlcnl0aW1lLiBGb3IgbmV3
bHkgYWxsb2NhdGVkIHJlcXVlc3QgUlFGX0RPTlRQUkVQIGlzIG5ldmVyCnNldC4gU2luY2UgYWZ0
ZXIgZ2V0dGluZyBhIHRhZywgYmxvY2sgbGF5ZXIgc2V0cyB0aGUgcmVxLT5ycV9mbGFncyA9PSAw
CmFuZCBuZXZlciBzZXRzIHRoZSBSRVFfRE9OVFBSRVAgd2hlbiByZXR1cm5pbmcgdGhlIHJlcXVl
c3QgOi0KCm52bWVfYWxsb2NfcmVxdWVzdCgpCglibGtfbXFfYWxsb2NfcmVxdWVzdCgpCgkJYmxr
X21xX3JxX2N0eF9pbml0KCkKCQkJcnEtPnJxX2ZsYWdzID0gMCA8LS0tLQoKbnZtZV9hbGxvY19y
ZXF1ZXN0X3FpZCgpCglibGtfbXFfYWxsb2NfcmVxdWVzdF9oY3R4KCkKCQlibGtfbXFfcnFfY3R4
X2luaXQoKQoJCQlycS0+cnFfZmxhZ3MgPSAwIDwtLS0tCgpUaGUgYmxvY2sgbGF5ZXIgZG9lcyBz
ZXQgcmVxLT5ycV9mbGFncyBidXQgUkVRX0RPTlRQUkVQIGlzIG5vdCBvbmUgb2YKdGhlbSBhbmQg
dGhhdCBpcyBzZXQgYnkgdGhlIGRyaXZlci4KClRoYXQgbWVhbnMgd2UgY2FuIHVuY29uZGl0aW5h
bGx5IHNldCB0aGUgUkVRX0RPTlRQUkVQIHZhbHVlIHRvIHRoZQpycS0+cnFfZmxhZ3Mgd2hlbiBu
dm1lX2luaXRfcmVxdWVzdCgpLT5udm1lX2NsZWFyX3JlcXVlc3QoKSBpcyBjYWxsZWQKZnJvbSBh
Ym92ZSB0d28gY2FsbGVycy4KCk1vdmUgdGhlIGNoZWNrIGZvciBSRVFfRE9OVFBSRVAgZnJvbSBu
dm1lX2NsZWFyX252bWVfcmVxdWVzdCgpIGludG8KbnZtZV9zZXR1cF9jbWQoKS4KClRoaXMgaXMg
bmVlZGVkIHNpbmNlIG52bWVfYWxsb2NfcmVxdWVzdCgpIG5vdyBnZXRzIGNhbGxlZCBmcm9tIGZh
c3QKcGF0aCB3aGVuIE5WTWVPRiB0YXJnZXQgaXPCoGNvbmZpZ3VyZWQgd2l0aCBwYXNzdGhydSBi
YWNrZW5kIHRvIGF2b2lkCnVubmVjZXNzYXJ5IGNoZWNrcyBpbiB0aGUgZmFzdCBwYXRoLgoKU2ln
bmVkLW9mZi1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxjaGFpdGFueWEua3Vsa2FybmlAd2RjLmNv
bT4KLS0tCiBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgfCAxMSArKysrKy0tLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKaW5kZXgg
ZGFiMTg0NzJlMzlmLi40ODU4MTE0ZjRmOGEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0
L2NvcmUuYworKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKQEAgLTU3NCwxMSArNTc0LDkg
QEAgRVhQT1JUX1NZTUJPTF9OU19HUEwobnZtZV9wdXRfbnMsIE5WTUVfVEFSR0VUX1BBU1NUSFJV
KTsKIAogc3RhdGljIGlubGluZSB2b2lkIG52bWVfY2xlYXJfbnZtZV9yZXF1ZXN0KHN0cnVjdCBy
ZXF1ZXN0ICpyZXEpCiB7Ci0JaWYgKCEocmVxLT5ycV9mbGFncyAmIFJRRl9ET05UUFJFUCkpIHsK
LQkJbnZtZV9yZXEocmVxKS0+cmV0cmllcyA9IDA7Ci0JCW52bWVfcmVxKHJlcSktPmZsYWdzID0g
MDsKLQkJcmVxLT5ycV9mbGFncyB8PSBSUUZfRE9OVFBSRVA7Ci0JfQorCW52bWVfcmVxKHJlcSkt
PnJldHJpZXMgPSAwOworCW52bWVfcmVxKHJlcSktPmZsYWdzID0gMDsKKwlyZXEtPnJxX2ZsYWdz
IHw9IFJRRl9ET05UUFJFUDsKIH0KIAogc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQgbnZtZV9y
ZXFfb3Aoc3RydWN0IG52bWVfY29tbWFuZCAqY21kKQpAQCAtODkyLDcgKzg5MCw4IEBAIGJsa19z
dGF0dXNfdCBudm1lX3NldHVwX2NtZChzdHJ1Y3QgbnZtZV9ucyAqbnMsIHN0cnVjdCByZXF1ZXN0
ICpyZXEsCiB7CiAJYmxrX3N0YXR1c190IHJldCA9IEJMS19TVFNfT0s7CiAKLQludm1lX2NsZWFy
X252bWVfcmVxdWVzdChyZXEpOworCWlmICghKHJlcS0+cnFfZmxhZ3MgJiBSUUZfRE9OVFBSRVAp
KQorCQludm1lX2NsZWFyX252bWVfcmVxdWVzdChyZXEpOwogCiAJbWVtc2V0KGNtZCwgMCwgc2l6
ZW9mKCpjbWQpKTsKIAlzd2l0Y2ggKHJlcV9vcChyZXEpKSB7Ci0tIAoyLjIyLjEKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxp
bmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
