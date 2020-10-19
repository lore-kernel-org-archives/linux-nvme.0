Return-Path: <SRS0=Xx51=D2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB83FC433E7
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 10:06:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 527BD20791
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 10:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OKTC7mi2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527BD20791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qsM0oszZyC/ckc2yDGOv+J48Db2W/YjoZ25UN3iS6Zw=; b=OKTC7mi2kgZm99M3S/PcWtjB7
	fC7hXWUK8GQHeZKHNs7p27+oGhVqspfeHfSSg7sxYBcwQlGkQif/e7fsN86h/q/4010gTLfdGVheE
	BgVD07MJfJpNS5ifPDJl0gzAq7JiNmeT+CxlOvxaRTYKM7XLBk26TPnHih9D0foMdt8jLLto8WYvc
	Zkvgw5XVCu+S4i3Ve130Bn5lQMkmxoOXii64zZYVyO1xxGA50npNBZpzX8h9TwXCzHd4Vor2QH1/Y
	hSrbZQJRkklyTCX2eseULLq36yuVeWnMSOjwp10YFjfisKiHXu3t+Xl3uJLQ/XZ8iVLOqoUKXobPT
	rVnFDAxsQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUS3Y-0001D4-2j; Mon, 19 Oct 2020 10:06:20 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUS3W-0001CK-8M
 for linux-nvme@lists.infradead.org; Mon, 19 Oct 2020 10:06:18 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 43E9BAEA2
 for <linux-nvme@lists.infradead.org>; Mon, 19 Oct 2020 10:06:17 +0000 (UTC)
Subject: Re: [PATCH] nvme-fc: wait for queues to freeze before calling
 update_hr_hw_queues
To: linux-nvme@lists.infradead.org
References: <20201016211724.48707-1-james.smart@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <112e9185-bd5e-24f6-d893-163c011c6b60@suse.de>
Date: Mon, 19 Oct 2020 12:06:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201016211724.48707-1-james.smart@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201019_060618_403588_0DA45EA0 
X-CRM114-Status: GOOD (  19.20  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTAvMTYvMjAgMTE6MTcgUE0sIEphbWVzIFNtYXJ0IHdyb3RlOgo+IE9uIHJlY29ubmVjdCwg
dGhlIGNvZGUgY3VycmVudGx5IGRvZXMgbm90IGZyZWV6ZSB0aGUgY29udHJvbGxlciBiZWZvcmUK
PiBwb3NzaWJseSB1cGRhdGluZyB0aGUgbnVtYmVyIGh3IHF1ZXVlcyBmb3IgdGhlIGNvbnRyb2xs
ZXIuCj4gCj4gQWRkIHRoZSBmcmVlemUgYmVmb3JlIHVwZGF0aW5nIHRoZSBudW1iZXIgb2YgaHcg
cXVldWVzLiBOb3RlOiB0aGUgcXVldWVzCj4gYXJlIGFscmVhZHkgc3RhcnRlZCBhbmQgcmVtYWlu
IHN0YXJ0ZWQgdGhyb3VnaCB0aGUgcmVjb25uZWN0Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IEphbWVz
IFNtYXJ0IDxqYW1lcy5zbWFydEBicm9hZGNvbS5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL252bWUv
aG9zdC9mYy5jIHwgNyArKysrKy0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQo+IFJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3Vz
ZS5kZT4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAg
ICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMg
R21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5i
ZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxp
c3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
