Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6469AC433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 06:21:41 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B64061006
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 06:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B64061006
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oN3YivmH6+9j9FxA6Yk5iqeYEguZAxYwRTHEow2z59g=; b=F4J2ixqUvFp9Fy1gJb+aI6/KM
	k/iTnsfCR/oG8y7Rb+53HrRJl7wPS5+7da/0B4RP9a/u9kGUjXW0VH4rV2kkbyaI2tu16xvlUvPDi
	MLbGjnHf+3TxWEiKeBmgLi+oZ6VAA9S/aVKeUbV+/0I4AxzU9LtosDpkSqQ06Yh6RT6N8w0vgCq/X
	pTO+suWoZD9XjMhX3LdFVUdr7UzYN3h3i6sPzk3Z7jJSC7phROwUnfXsTZE2LSui5xuJR90WxNk8f
	XvImtp4QH5jDsIFJZTRKkbPU6quWpY9EZb6WhVFHEReZYjwk8ax67/shAlKeexV69nRkkRLT8kSi7
	I+RjMivgw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lit6V-00H92x-0b; Tue, 18 May 2021 06:21:19 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lit6P-00H92o-K1
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 06:21:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
 Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
 bh=1K98V2N0jf0bUNFXeOpeOO/j2V7kfzkQrMQaCX73hfM=; b=27P5+z/z2MRWgwHgMV6m8crF0r
 GlifJQkTfyGnhmESv8J2oqm9YPaBGTGz/D562ralrA1v+zGr2HkgMjyi028CSUj6ek0cuqUkb4wa9
 6FTv4gLFbD0BstFJnVyio0UtwIasibFNPorJtuftce+jgFvAy+XsGhy8WuTDsvXUpj/ituiRLNrJK
 hp05tYq/yx5tsTiCqubvn4y1XcDwtMcXjM5SfMKAavmmNh150j58Q3De6YvMBaQnWxiJ60quLq3mO
 lD5Rge+33waIhUIPfBNYQ3Mg13C2ATbGgBdCtK1Cmo3F2CsVJrwC05vF7kvB6MQoG7a4GEKV/zCWz
 rj4mEkpA==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lit6L-00ELiH-DB
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 06:21:12 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C1590AF05;
 Tue, 18 May 2021 06:21:07 +0000 (UTC)
Subject: Re: [PATCH] fabrics: add fast_io_fail_tmo option
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>
References: <20210517182616.607768-1-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <8da9513b-e268-9e99-ef7c-68a4023a6015@suse.de>
Date: Tue, 18 May 2021 08:21:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210517182616.607768-1-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_232109_615462_8F28D4F9 
X-CRM114-Status: GOOD (  13.02  )
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

T24gNS8xNy8yMSA4OjI2IFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IE9wdGlvbiB0byBmYWls
IGZhc3QgSS9PIHdoZW4gY29ubmVjdGluZyB0byBhIGNvbnRyb2xsZXIuIEl0IGlzIHVzZWZ1bAo+
IHRvIHNldCBhIGZhc3QtZmFpbCB0aW1lb3V0IGZvciBudm1lIGluIGNhc2UgdXBwZXIgbGF5ZXIg
U1cgd2FudHMgdG8KPiBkZXRlY3QgdW5yZXNwb25zaXZlIGNvbnRyb2xsZXJzIGVhcmx5IChlLmcu
IG1kcmFpZCkuCj4gCj4gU2lnbmVkLW9mZi1ieTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVy
Zy5tZT4KPiAtLS0KPiAgIGZhYnJpY3MuYyB8IDEyICsrKysrKysrKysrKwo+ICAgZmFicmljcy5o
IHwgIDEgKwo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspCj4gCkQnb2guCgpP
ZiBjb3Vyc2UuCgpSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpD
aGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2Vy
bmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1h
eGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdl
c2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
