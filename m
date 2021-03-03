Return-Path: <SRS0=PLgZ=IB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46754C433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 20:02:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57FC64EE1
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 20:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57FC64EE1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sZN8sPXgdgs401N28jp5wnFKCiO05VmKHZjSO5377HY=; b=gCGeKNsOtke6JOf/3dqhOzfMC
	eYSqLqd6fvmaGyPcOZhAEUCN9OmNPPJQGar+X2VoBs6ZrpcEq8JqSDSawaPQuILSnMFtosTN6YmLz
	T8LQK6j1YJcwy1TZF6oP/7F4wEsDmMRwZ2TUc3YGqHuGBTTXNTDz35aRRDoWMVRBIGs0ZCeUn4OOm
	n7/f1ZFWbWKit+dYu9SHyMYTVetlcvylmyJivETNhgr5z2DCJEmXzsApUy7PJanGiH+vYJUTwAgoS
	2RiOYvTxaDJf/x92ovpaFIee39x3/krMslOf+HAoNxlihjN5H37aBp7WxIXIt8pmu8fWYqZDTYqRY
	awgy/6IZA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHXh9-006L6w-La; Wed, 03 Mar 2021 20:02:07 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHT4l-005IVL-0E
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 15:06:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:Subject:From:References:Cc:To:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=SOg9gZpHIgPdvbVK1E40xqjIQcHN2GWnSpDou0BBfZQ=; b=vaSTPHGdfElpNvOxWtdY7HSOQM
 L8J3HTMGHj/b8Vu2IJjnMj0tWVFdFX1aJk8wRsTIsj91+Fi4QFOl/gZ9lj/vL6DSUZBqYqmAsAUzV
 08rwVmQyhAm0M1APEbTj89DASm3H3+aomhAxTFdXkKiMwmVEiAZ0EkNfi7oJ0feIUe2PnN1/UwrFx
 vUtelsVnDXOBMfK6y2LHPkvyAVsiItX3mF5EpXy5ghYOKuxM02NLIaVe9oSWKRNPasfoRPecGS8NC
 2rVc/G2pvDO9gmyZ8Dy9wI7RlejlFtVn9wWrUE4qoRZdfSsBRdzUD+x/rZfSFAjkKesUQxp4I8Bwa
 gPKFpY9w==;
Received: from mx2.suse.de ([195.135.220.15])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHRBr-002fqQ-GT
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 13:05:23 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id F061AAD29;
 Wed,  3 Mar 2021 13:05:20 +0000 (UTC)
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20210303121227.65688-1-hare@suse.de>
 <20210303123239.GA28477@lst.de>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv2] nvme: send uevent once a multipath namespace is
 operational again
Message-ID: <eb11c7b3-edc9-b492-12d9-7ff279c3bf97@suse.de>
Date: Wed, 3 Mar 2021 14:05:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210303123239.GA28477@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210303_130523_803802_6BD56797 
X-CRM114-Status: GOOD (  16.38  )
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

T24gMy8zLzIxIDE6MzIgUE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IE9uIFdlZCwgTWFy
IDAzLCAyMDIxIGF0IDAxOjEyOjI3UE0gKzAxMDAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4g
SW4gYW4gYWxsIHBhdGhzIGRvd24gc2NlbmFyaW8gSS9PIHdpbGwgYmUgcmVxdWV1ZWQgb3IgYWJv
cnRlZCwgYW5kIG5vCj4+IGZ1cnRoZXIgSS9PIHdpbGwgYmUgb25nb2luZyBvbiB0aGlzIG5hbWVz
cGFjZS4KPj4gVGhpcyBsZWF2ZXMgdGhlIHVwcGVyIGxheWVycyB1bmFibGUgdG8gZGV0ZXJtaW5l
IGlmIHRoZSBuYW1lc3BhY2UKPj4gYmVjb21lcyBvcGVyYXRpb25hbCBhZ2FpbiBlZy4gYWZ0ZXIg
YSBzdWNjZXNzZnVsIGNvbnRyb2xsZXIgcmVzZXQuCj4+IFdpdGggdGhpcyBwYXRjaCBhICdjaGFu
Z2UnIHVldmVudCB3aWxsIGJlIHNlbnQgcGVyIG11bHRpcGF0aGVkIG5hbWVzcGFjZQo+PiBvbmNl
IHRoZSB1bmRlcmx5aW5nIGNvbnRyb2xsZXIgbW92ZWQgdG8gTElWRSBhbmQgc3RhcnRlZCBJL08g
cHJvY2Vzc2luZwo+PiBieSBjYWxsaW5nIG52bWVfa2lja19yZXF1ZXVlX2xpc3RzKCkuCj4gCj4g
VGhpcyBsb29rcyBmdW5jdGlvbmFsbHkgY29ycmVjdCwgYnV0IEknbSBhIGxpdHRsZSB3b3JyaWVk
IGFib3V0IHRoZQo+IG52bWVfa2lja19yZXF1ZXVlX2xpc3RzIGZ1bmN0aW9uIG5hbWUgYmVpbmcg
YSBsaXR0bGUgb2ZmIG5vdy4gIENhbgo+IGFueW9uZSBvbiB0aGUgbGlzdCB0aGluayBvZiBhIGJl
dHRlciBuYW1lPwo+IApudm1lX3Jlc3RhcnRfcHJvY2Vzc2luZygpPwoKQ2hlZXJzLAoKSGFubmVz
Ci0tIApEci4gSGFubmVzIFJlaW5lY2tlCQkgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hp
dGVjdApoYXJlQHN1c2UuZGUJCQkgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApT
VVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5
IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdGOiBGZWxpeCBJbWVuZMO2cmZm
ZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
