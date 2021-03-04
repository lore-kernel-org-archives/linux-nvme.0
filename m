Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B650C433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 08:41:07 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD5CF64F0A
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 08:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5CF64F0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wyonBuqOqXVcASaigQhu8C9Xx9WyYGOn6rSIzE4IMAw=; b=bhycb4IpcYy9rhw7KGRdwSNkx
	9sUmRiShE/yqeNYTgMNv8COpEFN0EJn03G4JuonY/whZarBIXWFtZ/RMlFl3TB8CWUtWoTnsJWccG
	3/gUlgqa40X+ad+sqxKbbrqgMremKq7m/w427gZB+hupb3kNBghyn5pa8y1cxT9MdKwCxpr1OeUN1
	+012/D3MJHujh7jqB/rtIyMb4G9cOC62IDGbwQoOfckpbRuloGYf4rNNnLgNO2XtN9rHno9Q+AkGj
	mDEjQg8TNX4LSAclycOXKcqKBjNM2r4NCxLL5yfsq0Zwv8JpdcuGoZLpdk58bRHwZrLzq+TNEuFH6
	kB68D3c1w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHjXR-0089XD-VB; Thu, 04 Mar 2021 08:40:54 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHi07-007znl-3P
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 07:02:41 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A6DFEAB8C;
 Thu,  4 Mar 2021 07:02:21 +0000 (UTC)
Subject: Re: [PATCH 1/3] nvme-fabrics: only reserve a single tag
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org
References: <20210303125304.1200789-1-hch@lst.de>
 <20210303125304.1200789-2-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <15e2f9bb-d1c4-57e9-18b7-935e95bab7e5@suse.de>
Date: Thu, 4 Mar 2021 08:02:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210303125304.1200789-2-hch@lst.de>
Content-Language: en-US
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

T24gMy8zLzIxIDE6NTMgUE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IEZhYnJpY3MgZHJp
dmVycyBjdXJyZW50bHkgcmVzZXJ2ZSB0d28gdGFncyBvbiB0aGUgYWRtaW4gcXVldWUuICBCdXQK
PiBnaXZlbiB0aGF0IHRoZSBjb25uZWN0IGNvbW1hbmQgaXMgb25seSBydW4gb24gYSBmcmVzaGx5
IGNyZWF0ZWQgcXVldWUKPiBvciBhZnRlciBhbGwgY29tbWFuZHMgaGF2ZSBiZWVuIGZvcmNlIGFi
b3J0ZWQgd2Ugb25seSBuZWVkIHRvIHJlc2VydmUKPiBhIHNpbmdsZSB0YWcuCj4gCj4gU2lnbmVk
LW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+Cj4gLS0tCj4gICBkcml2ZXJz
L252bWUvaG9zdC9mYWJyaWNzLmggfCA3ICsrKysrKysKPiAgIGRyaXZlcnMvbnZtZS9ob3N0L2Zj
LmMgICAgICB8IDQgKystLQo+ICAgZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jICAgIHwgNCArKy0t
Cj4gICBkcml2ZXJzL252bWUvaG9zdC90Y3AuYyAgICAgfCA0ICsrLS0KPiAgIGRyaXZlcnMvbnZt
ZS90YXJnZXQvbG9vcC5jICB8IDQgKystLQo+ICAgNSBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRp
b25zKCspLCA4IGRlbGV0aW9ucygtKQo+IApSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxo
YXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAg
ICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29s
dXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFH
IE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFp
bGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
