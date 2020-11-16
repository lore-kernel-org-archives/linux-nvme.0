Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48144C4742C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 07:41:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14D4216C4
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 07:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h/N19/vs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14D4216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=L4UUQBmwJ2PcsXQIrG3rEkSv3Po79xZ2ApQQtv1Bp5I=; b=h/N19/vswDCv/Pmb6o7IcBQFp
	jakvFJtfO1PEATMcDukHmeELpAk0ITg+roOiITPYG+ug8oXQGljVe4+qaSqRywnwTifCu/6uP/jdA
	G9GGsaO0sreLYlelBi/iF1+65L3rh09xG6Dv9dtIP/c5wCDEZA5K5268Yi4LlRrTC5JvImzg6WvHA
	MW/xBKAqGc59K4NtRTVm/3EPgy6uv9IYr6aSe1hXjnGDrUzF/RAjacb7BJBFcv5siF/66HnD2XcM6
	fkn6+t8/py057ajVRkrR36UGbK6MfPuFUFLhe0Iv3Obh1MIlXPywUxzpWLzd+lg1jBnZQc3nYagwr
	f5uNAlhlw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keZ8b-0004ba-Az; Mon, 16 Nov 2020 07:41:21 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1keZ8X-0004aW-Ue
 for linux-nvme@lists.infradead.org; Mon, 16 Nov 2020 07:41:19 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D7CF0AC2E;
 Mon, 16 Nov 2020 07:41:16 +0000 (UTC)
Subject: Re: [PATCH v4 04/19] lpfc: vmid: Add the datastructure for supporting
 VMID in lpfc
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
References: <1604895845-2587-1-git-send-email-muneendra.kumar@broadcom.com>
 <1604895845-2587-5-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <6b25f549-267a-0e97-68ea-b58e33980116@suse.de>
Date: Mon, 16 Nov 2020 08:41:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1604895845-2587-5-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201116_024118_310115_AE9AF7C5 
X-CRM114-Status: GOOD (  16.18  )
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
Cc: pbonzini@redhat.com, jsmart2021@gmail.com, mkumar@redhat.com,
 emilne@redhat.com, Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTEvOS8yMCA1OjIzIEFNLCBNdW5lZW5kcmEgd3JvdGU6Cj4gRnJvbTogR2F1cmF2IFNyaXZh
c3RhdmEgPGdhdXJhdi5zcml2YXN0YXZhQGJyb2FkY29tLmNvbT4KPiAKPiBUaGlzIHBhdGNoIGFk
ZHMgdGhlIHByaW1hcnkgZGF0YXN0cnVjdHVyZXMgbmVlZGVkIHRvIGltcGxlbWVudCBWTUlEIGlu
IGxwZmMKPiBkcml2ZXIuIEl0IG1haW50YWlucyB0aGUgY2FwYWJpbGl0eSwgY3VycmVudCBzdGF0
ZSwgaGFzaCB0YWJsZSBmb3IgdGhlCj4gdm1pZC9hcHBpZCBhbG9uZyB3aXRoIG90aGVyIGluZm9y
bWF0aW9uLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEdhdXJhdiBTcml2YXN0YXZhIDxnYXVyYXYuc3Jp
dmFzdGF2YUBicm9hZGNvbS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogSmFtZXMgU21hcnQgPGpzbWFy
dDIwMjFAZ21haWwuY29tPgo+IApSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1
c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAg
ICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25z
IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJu
YmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBs
aXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
