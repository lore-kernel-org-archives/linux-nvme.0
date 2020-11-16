Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7567C55ABD
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 07:25:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D636222B9
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 07:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BMCFehwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D636222B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BWrcl7nlw1YnSrYw8PRtutkEKw6vKfj2NNJdGOq9i4k=; b=BMCFehweSxK5ZjItQvOhadEqa
	r8rqCzGBQ1k3E9u348SX8dAd/9kiWKMjcKp+wBad2z5F5X6Y85YBi6tjXXGpp5wWFvcqMvOOKUa43
	FBaYGEBu5jaHyaBmXO2g1baMtiD1ajYlSuZWW6x/dknWimSuD2/Ou0ESAUNIPKYVeosoURy/QZgGZ
	j9mnwTEti/Ag1VA95YvIqEBFVvRZf+PMrhjFkk3e33jotmYw3HOTpKXIZDtM7m7JY15rC3OLvha9R
	9KVKUVapu8sBXf6iK51sOkOx1akT75zeJjCfXaMSkdu1LYPKiz4ScyiJ60Dxw34sd6RT7ZFSHLNvs
	IiO4nE+Aw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keYtI-00031u-0s; Mon, 16 Nov 2020 07:25:32 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1keYtB-00030z-5X
 for linux-nvme@lists.infradead.org; Mon, 16 Nov 2020 07:25:25 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 889D8AC2E;
 Mon, 16 Nov 2020 07:25:22 +0000 (UTC)
Subject: Re: [PATCH v4 01/19] cgroup: Added cgroup_get_from_kernfs_id
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
References: <1604895845-2587-1-git-send-email-muneendra.kumar@broadcom.com>
 <1604895845-2587-2-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <5a0d67ec-8d0a-9a6e-a599-797beeb117fa@suse.de>
Date: Mon, 16 Nov 2020 08:25:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1604895845-2587-2-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201116_022525_326775_B8130B66 
X-CRM114-Status: GOOD (  16.75  )
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
 emilne@redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTEvOS8yMCA1OjIzIEFNLCBNdW5lZW5kcmEgd3JvdGU6Cj4gQWRkZWQgYSBuZXcgZnVuY3Rp
b24gY2dyb3VwX2dldF9mcm9tX2tlcm5mc19pZCAgdG8gcmV0cmlldmUgdGhlIGNncm91cAo+IGFz
c29jaWF0ZWQgd2l0aCBjZ3JvdXAgaWQuCj4gSXQgdGFrZXMgY2dyb3VwaWQgYXMgYW4gYXJndW1l
bnQgYW5kIHJldHVybnMgY2dycCBhbmQgb24gZmFpbHVyZQo+IGl0IHJldHVybnMgTlVMTC4KPiBF
eHBvcnRlZCB0aGUgc2FtZSBhcyB0aGlzIGNhbiBiZSB1c2VkIGJ5IGJsay1jZ29ydXAuYwo+IAo+
IEFkZGVkIGZ1bmN0aW9uIGRlY2xhcmF0aW9uIG9mIGNncm91cF9nZXRfZnJvbV9rZXJuZnNfaWQg
aW4gY2dvcnVwLmgKPiBFeHBvcnRlZCB0aGUgY2dyb3VwX2dldF9lX2Nzcwo+IAo+IFNpZ25lZC1v
ZmYtYnk6IE11bmVlbmRyYSA8bXVuZWVuZHJhLmt1bWFyQGJyb2FkY29tLmNvbT4KPiAKClJldmll
d2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KCkNoZWVycywKCkhhbm5lcwot
LSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNo
aXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3
NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0
MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6
IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbnZtZQo=
