Return-Path: <SRS0=EFt+=KE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F7EC433B4
	for <linux-nvme@archiver.kernel.org>; Sun,  9 May 2021 08:44:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 721836128E
	for <linux-nvme@archiver.kernel.org>; Sun,  9 May 2021 08:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721836128E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rPxsGxy3N2eJFQkah/UW2YJ6k7m6XS/WanRSWP4hZpg=; b=P2Y918LIxIdKY3Kn4PKnEGiqL
	BGlPVczyUz4TY30YvU6fQn5eelqt2eL0MHRdKDZxGvHFKWx4BtgCn2C7cyjcfnt/kBEI+oEuXaGKa
	ruZdFPeP88p0VMSIxjrBMKEJGrSUa00kNb2d+ZkpGkcUDCWoOP5y6GGsALAa9SyydhrcGSwfIKP2H
	IHhYZSQ+DCKTN6FEDFukmhOMgJKyMuJZTeAjD+cGzy7DryWvRnfYjkpeWK0nG4A503RGeGYqhPaQh
	VsAM+DRme73oCqTvuwo7pfWKmWeVBQ5zfKlK/czH6bW+P/DgpNKNdlER1up8+1Q2JDQ6uN3jtmIi7
	RPQCd9hHw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lff31-00BIuo-Km; Sun, 09 May 2021 08:44:23 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lff2z-00BIub-EO
 for linux-nvme@desiato.infradead.org; Sun, 09 May 2021 08:44:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=4wdcWjM0pBEfDwH+p7AsUNBkSfKFNDKvHYKz0MUg2wM=; b=tI+aAXBaQ0lzhFuboVmgCRJaxw
 e45LoBqCuwdgyvK2dr4wMJevaKdfNQ0S3iPTp6sB+zTGv46kgOVMBAiBJb+IsRJaXkbvm1TPp9jpa
 gQS3BTFfOeZl+4wFfztJSUfAx/jeH7J1niGAY400CdSX9AdDIQm1EkAdbHjyoTX1L8lrbIEAZ0Neo
 3AmpTd7GTj0IvZzFEVE1FP4++apTZ0gOuASgj/Nr0tURjvcsHDtVk4i23wqHGEhqRXmVnrX3ZgN7T
 viLx/sb9Lh8nWh4KFt1+EpysWqIyGfqKg5t2Hett1nOT22Or0qh7M8KTwtoA/oKWFEhz95BfTL7XQ
 aWTOl77w==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lff2w-007u7D-L1
 for linux-nvme@lists.infradead.org; Sun, 09 May 2021 08:44:20 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id BC023B03A;
 Sun,  9 May 2021 08:44:14 +0000 (UTC)
Subject: Re: [bug report] blktests nvme/022 lead kernel WARNING and NULL
 pointer
To: Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>
Cc: linux-nvme@lists.infradead.org, skt-results-master@redhat.com,
 Bruno Goncalves <bgoncalv@redhat.com>
References: <CAHj4cs-hAaHhWU4Kb4NrQ9Fvi7DiH95P=Q=7zK-inxpeZtztkw@mail.gmail.com>
 <3243ab72-ffe3-e655-ef0a-d695885ce2c5@grimberg.me>
 <CAHj4cs9uOHRgRe9PJ3_0A4NMo4T1q4XzCYG6UAV-V=RZ39i1iQ@mail.gmail.com>
 <CAHj4cs-JawWOTNBnQ3OTeNXUb_zeH3-5MrPQWK0=1QPfEJ7ROA@mail.gmail.com>
 <201a97a9-e42f-8d8e-3cc7-e5cf8ba816c2@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <423b7c5e-deb7-3547-6ca4-8f4476e9eb03@suse.de>
Date: Sun, 9 May 2021 10:44:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <201a97a9-e42f-8d8e-3cc7-e5cf8ba816c2@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210509_014418_860555_FC37E40D 
X-CRM114-Status: GOOD (  13.99  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNS83LzIxIDk6NTAgUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4gCj4+PiBIaSBTYWdpCj4+
Pgo+Pj4gQmlzZWN0IHNob3dzIGJlbGxvdyBjb21taXRzIHdhcyB0aGUgZmlyc3QgYmFkIGNvbW1p
dC4KPj4+Cj4+PiBjb21taXQgYTcwYjgxYmQ0ZDlkMmQ2YzA1Y2ZlNmVmMmExMGJjY2MyZTA0MzU3
YSAocmVmcy9iaXNlY3QvYmFkKQo+Pj4gQXV0aG9yOiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3Vz
ZS5kZT4KPj4+IERhdGU6wqDCoCBGcmkgQXByIDE2IDEzOjQ2OjIwIDIwMjEgKzAyMDAKPj4+Cj4+
PiDCoMKgwqDCoCBudm1lOiBzYW5pdGl6ZSBLQVRPIHNldHRpbmcKPj4+Cj4+Cj4+IEhpIFNhZ2kK
Pj4gVGhpcyBpc3N1ZSBoYXMgYmVlbiBjb25zaXN0ZW50bHkgcmVwcm9kdWNlZCB3aXRoIGJsa3Rl
c3RzIG9uIHJlY2VudAo+PiBsaW51eC1ibG9jay9mb3ItbmV4dCwgZG8geW91IGhhdmUgYSBjaGFu
Y2UgdG8gY2hlY2sgaXQ/Cj4gCj4gSSBoYWQgbm90LCBIYW5uZXMgY2FuIHlvdSBoYXZlIGEgbG9v
az8KPiAKQ2FuIHlvdSBjaGVjayBpZiB0aGlzIHBhdGNoIGhlbHBzPwoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbnZtZS90YXJnZXQvbG9vcC5jIGIvZHJpdmVycy9udm1lL3RhcmdldC9sb29wLmMKaW5k
ZXggNzRiM2IxNTBlMWE1Li5hNDhkODIxOWNmOTAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS90
YXJnZXQvbG9vcC5jCisrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvbG9vcC5jCkBAIC00NTgsNiAr
NDU4LDkgQEAgc3RhdGljIHZvaWQgbnZtZV9sb29wX3Jlc2V0X2N0cmxfd29yayhzdHJ1Y3QgCndv
cmtfc3RydWN0ICp3b3JrKQogICAgICAgICAgICAgICAgIGNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1
Y3QgbnZtZV9sb29wX2N0cmwsIGN0cmwucmVzZXRfd29yayk7CiAgICAgICAgIGludCByZXQ7Cgor
ICAgICAgIC8qIHJlc2V0X3dvcmsgbWlnaHQgcnVuIGNvbmN1cnJlbnRseSB0byBkZWxldGVfd29y
ayAqLworICAgICAgIGlmIChjdHJsLT5zdGF0ZSA9PSBOVk1FX0NUUkxfREVMRVRJTkcpCisgICAg
ICAgICAgICAgICByZXR1cm47CiAgICAgICAgIG52bWVfc3RvcF9jdHJsKCZjdHJsLT5jdHJsKTsK
ICAgICAgICAgbnZtZV9sb29wX3NodXRkb3duX2N0cmwoY3RybCk7CgoKQ2hlZXJzLAoKSGFubmVz
Ci0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFy
Y2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTEx
IDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5
MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJl
cjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1udm1lCg==
