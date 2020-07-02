Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2907C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 06:55:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 954F02067D
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 06:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="amiQ9cqm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="FN7XbHQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954F02067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=peGNbv2THPo7OTBoDWR9aaftrCrDglSAfDDtz1BOb2M=; b=amiQ9cqmfJhBI4pH2AYaWb/oPB
	mCwkGyRtm0fG/yaFI6g1QKZt7OhlpuxR1JniiP+rZZCCol2Nnk+MubkK4AUdEAA0qDt5FGuEcMwA5
	zPEzfD7mwIVN6ZRw0AVmNtS4hmrxEhQkVXj4Aksu7aI+/ZZckvRLwA65vsMASIYVPORHr8wdLpLTy
	EMjipJNZ3ItWDAURX4ZwpoMzjHeIHA2IvVf/ef38YWA2qgDj9KyMsc4f6dhPQR6cS/DESm4MK8qdI
	iPWBzgblt1VBBjAv3Podi3j8WMbpNy4p4XoowCWWHMd0WeFljlTF3Lam+/tuKrDD5sr3exzNrQO13
	eKNQXD5A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqt7m-0008Oj-AW; Thu, 02 Jul 2020 06:55:10 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqt7h-0008KI-7P
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 06:55:06 +0000
Received: by mail-ed1-x541.google.com with SMTP id d18so16803836edv.6
 for <linux-nvme@lists.infradead.org>; Wed, 01 Jul 2020 23:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tKRN22hKzeStPgjui2Aao8XmNMEwN3gIdlFGNF8bcf4=;
 b=FN7XbHQo4xyfGORiZbDAiwfaCw/As7tXLMA465wGW51kVtnODvtYjipR9wQxgboJzd
 wXCkztxzx6y8/gowuiSm3AHBtzPsTfoz9n9otceNQ4lDVLPxb2UnF0qp84KptNLIMqj7
 xSGvguJVkAGewqgACIN9/FrDqSMT2sEWTtcjj5i0Sono1FMDkxLN/FaH5F895nqwn3D6
 uC4M6E9gsy2bMJzKETUN0oTuQnjpalqmRzxzHSiwaXizvXNBrU+SPBbX/MtbtpYiLNIZ
 3vhtXADC7XWqNhs3hLpjrLx1CZNxvyiodKcaT1D1ZbPSvqksdldWTaTitN4a4cuM6Dlf
 sPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tKRN22hKzeStPgjui2Aao8XmNMEwN3gIdlFGNF8bcf4=;
 b=klwBI5Fz1afk3EPt1i5qoixZbvYEpj7VP47oAub6SezJNKzkgf0uDZ+WQh6TU/MODQ
 TaTv9mahNFqcLBxpWpM+dal3WfO8VaXK+/MR09NPSkwcgmnp8fb8LC//3Dtq0cchQ5Mp
 5bFrko2t1mdt+mo2dtGnRWyZ9a+sdVWePJ6dxlgWHwoyugyRfeykJrTLDvxLx2TuRfUa
 6XDLWDKWdfSMEw8HnblO/4fhYFszIslnqN4iOccWi7AOSA6N5qbVHEY1IkbK28KLy/f4
 pZt5NT/OuPc6OxdjxCwf2Q5vBy2wpMMZPNYBaWGJjNjEAkJE6iHGEjWC4sg88n5JImYH
 uLEg==
X-Gm-Message-State: AOAM530w8tFAH+s2yDzsnAvBNoP4E/iKdbHQ4oPnv6yJ6SHBRbhqP2Vz
 6CX7gMVZDlDgJrpPjVnv68ITc09QtOqz72tF
X-Google-Smtp-Source: ABdhPJyNaV0mZrV9WTfrMB2Fykl35XKkFhaci5zrL8Xo4QS2a1xUy6GDh/BvSNhowznWRuVYIhoAEA==
X-Received: by 2002:a05:6402:202e:: with SMTP id
 ay14mr33026426edb.233.1593672902962; 
 Wed, 01 Jul 2020 23:55:02 -0700 (PDT)
Received: from localhost.localdomain ([194.62.217.57])
 by smtp.gmail.com with ESMTPSA id cz2sm7912769edb.82.2020.07.01.23.55.02
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 01 Jul 2020 23:55:02 -0700 (PDT)
From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To: linux-nvme@lists.infradead.org
Subject: [V2 PATCH 0/4] ZNS: Extra features for current patche
Date: Thu,  2 Jul 2020 08:54:34 +0200
Message-Id: <20200702065438.46350-1-javier@javigon.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_025505_430105_560E6429 
X-CRM114-Status: GOOD (  16.26  )
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
Cc: axboe@kernel.dk, Damien.LeMoal@wdc.com, sagi@grimberg.me,
 linux-block@vger.kernel.org, kbusch@kernel.org,
 =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>, mb@lightnvm.io,
 hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

RnJvbTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+CgpUaGlzIHBh
dGNoc2V0IGV4dGVuZHMgem9uZWQgZGV2aWNlIGZ1bmN0aW9uYWxpdHkgb24gdG9wIG9mIHRoZSBl
eGlzdGluZwpaTlMgcGF0Y2hzZXQgdGhhdCBLZWl0aCBzZW50LgoKQ2hhbmdlcyBzaW5jZSBWMQog
IC0gUmVtb3ZlIG5ldyBJT0NUTHMgZm9yIHpvbmUgbWFuYWdlbWVudCBhbmQgem9uZSB2YWx1ZXMu
IEkgYmVsaWV2ZSB3ZQogICAgd2lsbCBuZWVkIHRoZSB6b25lIG1hbmFnZW1lbnQgSU9DVEwgdG8g
c3VwcG9ydCBuZXcgWk5TIGZlYXR1cmVzIGluCiAgICB0aGUgbmVhciBmdXR1cmUsIGJ1dCB3ZSB3
aWxsIHdhaXQgdW50aWwgd2UgdXBzdHJlYW0gdGhlc2UgdG9vLiBJbgogICAgdGhlIG1lYW50aW1l
LCBmZWVkYmFjayBvbiB0aGUgSU9DVEwgaXMgd2VsY29tZS4gV2UgZHJvcCB0aGUgem9uZQogICAg
dmFsdWVzIElPQ1RMIGNvbXBsZXRlbHkgLSBOaWtsYXMgc2VuZCBhIHBhdGNoIHRvIGV4cG9zZSBt
YXIgLyBtb3IKICAgIHRocm91Z2ggc3lzZnMgYWxyZWFkeSAtIHdlIHdpbGwgZXh0ZW5kIG9uIHRo
aXMgaWYgbmVlZGVkLgoKICAtIFJlaW1wbGVtZW50IHpvbmUgb2ZmbGluZSB0cmFuc2l0aW9uIHRv
IGJlIGEgSU9DVEwgaW4gaXRzZWxmLCBhcyB0aGUKICAgIHJlc3Qgb2YgdGhlIGV4aXN0aW5nIHpv
bmUgdHJhbnNpdGlvbnMuIEluIHRoZSBwcm9jZXNzLCBpbXBsZW1lbnQgYQogICAgd2F5IGZvciBk
cml2ZXJzIHRvIHJlcG9ydCB6b25lIGZlYXR1cmUgc3VwcG9ydCBpbiB0aGUgbmV3bHkgYWRkZWQK
ICAgIGZlYXR1cmUgZmxhZ3MuIFJlZmFjdG9yIHN1cHBvcnQgZm9yIGNhcGFjaXR5IHRvIGFkb3B0
IHRoaXMgbW9kZWwuCiAgICBIZXJlLCBub3RlIHRoYXQgd2UgaGF2ZSBtYWludGFpbmVkIGJlaGF2
aW91ciBmb3IgdGhlIHNjc2kgZHJpdmVyLAogICAgZXZlbiB0aG91Z2ggem9uZV9zaXplID09IHpv
bmVfY2FwYWNpdHkKCiAgLSBSZWltcGxlbWVudCB0aGUgem9uZSBjb3VudCBjb25zaXN0ZW5jeSBj
aGVjayB0byBkbyBhIGNvcnJlY3Qgem9uZQogICAgY2FsY3VsYXRpb24uIE1vdmUgdGhpcyBsb2dp
YyB0byB0aGUgaW5pdGlhbGl6YXRpb24gbG9naWMsIGluc3RlYWQgb2YKICAgIGRvaW5nIGl0IGVh
Y2ggdGltZSB3ZSByZXBvcnQgem9uZXMuCgpUaGFua3MsCkphdmllcgoKLS0tIFYxIGNvdmVyIGxl
dHRlciAtLS0KClBhdGNoZXMgMS01IGFyZSB6b25lZCBibG9jayBpbnRlcmZhY2UgYW5kIElPQ1RM
IGFkZGl0aW9ucyB0byBleHBvc2UgWk5TCnZhbHVlcyB0byB1c2VyLXNwYWNlLiBPbmUgbWFqb3Ig
Y2hhbmdlIGlzIHRoZSBhZGRpdGlvbiBvZiBhIG5ldyB6b25lCm1hbmFnZW1lbnQgSU9DVEwgdGhh
dCBhbGxvd3MgdG8gZXh0ZW5kIHpvbmUgbWFuYWdlbWVudCBjb21tYW5kcyB3aXRoCmZsYWdzLiBJ
IHJlY2FsbCBhIGNvbnZlcnNhdGlvbiBpbiB0aGUgbWFpbGluZyBsaXN0IGZyb20gZWFybHkgdGhp
cyB5ZWFyCndoZXJlIGEgc2ltaWxhciBhcHByb2FjaCB3YXMgcHJvcG9zZWQgYnkgTWF0aWFzLCBi
dXQgbmV2ZXIgbWFkZSBpdAp1cHN0cmVhbS4gV2UgZXh0ZW5kZWQgdGhlIElPQ1RMIGhlcmUgdG8g
YWxpZ24gd2l0aCB0aGUgY29tbWVudHMgaW4gdGhhdAp0aHJlYWQuIEhlcmUsIHdlIGFyZSBoYXBw
eSB0byBnZXQgc2lnbi1vZmZzIGJ5IGFueW9uZSB0aGF0IGNvbnRyaWJ1dGVkCnRvIHRoZSB0aHJl
YWQgLSBqdXN0IGNvbW1lbnQgaGVyZSBvciBvbiB0aGUgcGF0Y2guCgpQYXRjaCA2IGlzIG52bWUt
b25seSBhbmQgYWRkcyBhbiBleHRyYSBjaGVjayB0byB0aGUgWk5TIHJlcG9ydCBjb2RlIHRvCmVu
c3VyZSBjb25zaXN0ZW5jeSBvbiB0aGUgem9uZSBjb3VudC4KClRoZSBwYXRjaGVzIGFwcGx5IG9u
IHRvcCBvZiBKZW5zJyBibG9jay01LjggKyBLZWl0aCdzIFYzIFpOUyBwYXRjaGVzLgoKVGhhbmtz
LApKYXZpZXIKCgpKYXZpZXIgR29uesOhbGV6ICg0KToKICBibG9jazogQWRkIHpvbmUgZmxhZ3Mg
dG8gcXVldWUgem9uZSBwcm9wLgogIGJsb2NrOiBhZGQgc3VwcG9ydCBmb3Igem9uZSBvZmZsaW5l
IHRyYW5zaXRpb24KICBudm1lOiBBZGQgY29uc2lzdGVuY3kgY2hlY2sgZm9yIHpvbmUgY291bnQK
ICBibG9jazogYWRkIGF0dHJpYnV0ZXMgdG8gem9uZSByZXBvcnQKCiBibG9jay9ibGstY29yZS5j
ICAgICAgICAgICAgICAgfCAgMiArKwogYmxvY2svYmxrLXpvbmVkLmMgICAgICAgICAgICAgIHwg
MTEgKysrKysrKy0tCiBkcml2ZXJzL2Jsb2NrL251bGxfYmxrX3pvbmVkLmMgfCAgMiArKwogZHJp
dmVycy9udm1lL2hvc3QvY29yZS5jICAgICAgIHwgIDUgKysrKy0KIGRyaXZlcnMvbnZtZS9ob3N0
L252bWUuaCAgICAgICB8ICA2ICsrKy0tCiBkcml2ZXJzL252bWUvaG9zdC96bnMuYyAgICAgICAg
fCA0MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystCiBkcml2ZXJzL3Njc2kvc2Qu
YyAgICAgICAgICAgICAgfCAgMiArKwogZHJpdmVycy9zY3NpL3NkX3piYy5jICAgICAgICAgIHwg
IDggKysrKystLQogaW5jbHVkZS9saW51eC9ibGtfdHlwZXMuaCAgICAgIHwgIDMgKysrCiBpbmNs
dWRlL2xpbnV4L2Jsa2Rldi5oICAgICAgICAgfCAgNCArKystCiBpbmNsdWRlL3VhcGkvbGludXgv
Ymxrem9uZWQuaCAgfCAyOSArKysrKysrKysrKysrKysrKysrKysrKy0KIDExIGZpbGVzIGNoYW5n
ZWQsIDEwMyBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKCi0tIAoyLjE3LjEKCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1h
aWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
