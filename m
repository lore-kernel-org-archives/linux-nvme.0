Return-Path: <SRS0=GtbF=H3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3477DC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 17:34:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B817864F20
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 17:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B817864F20
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SvGvcvhQn/ue6obByiqPPo1fw1idlbCAd2PNJAfQSLU=; b=LkGzHMLGRwLbVNPIXwaBnyidO
	1PGtfxtciy3+OTXTM0yXEXEKUFGFWRRxPdRoCXOdeaKdi2mjJ2Wh/qxGkp88kRZjQLxcAGJMkXHZb
	QZ/lP1y4RL6WR0hobecIUYlj1Wq9SdbM98NCoFzF+xSxhJx+PEclGchzFfF83vbC/eyzVIEQQ9SaO
	V5KqrPFbrUqtpEvNqFSlCpoVdgQgU92UfBWMsXOV2Qrs/ewyS4ZDuXeq4uzmq1DuUhuFXQ21CCL5r
	rd1rjnRBlxug6bON+H1sO7YTbX8IEunmbYr8pvIijiwqFjibrWdZDWnVuI4ao7tf3gMlyEhLcQa+7
	kT5rZFBJQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFKWi-0003ZW-0E; Thu, 25 Feb 2021 17:34:12 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFKWf-0003Z3-ES
 for linux-nvme@lists.infradead.org; Thu, 25 Feb 2021 17:34:10 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 52376ACCF;
 Thu, 25 Feb 2021 17:34:08 +0000 (UTC)
Subject: Re: [PATCH 5/6] nvme: return NVME_SC_ABORT_QUEUE for cancelled
 commands
To: Keith Busch <kbusch@kernel.org>
References: <20210225105527.75277-1-hare@suse.de>
 <20210225105527.75277-6-hare@suse.de>
 <20210225164308.GE31593@redsun51.ssa.fujisawa.hgst.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <2ddca50e-ca0c-00b4-589a-3587101ac452@suse.de>
Date: Thu, 25 Feb 2021 18:34:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210225164308.GE31593@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210225_123409_611097_9C857D2A 
X-CRM114-Status: GOOD (  19.24  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Daniel Wagner <dwagner@suse.de>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8yNS8yMSA1OjQzIFBNLCBLZWl0aCBCdXNjaCB3cm90ZToKPiBPbiBUaHUsIEZlYiAyNSwg
MjAyMSBhdCAxMTo1NToyNkFNICswMTAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IEEgcmVx
dWVzdCB3aWxsIGJlIGNhbmNlbGxlZCB3aGVuIGEgcXVldWUgaXMgZGVsZXRlZCwgc28gd2Ugc2hv
dWxkCj4+IGJlIHJldHVybmluZyBhIHN0YXR1cyBvZiBOVk1FX1NDX0FCT1JUX1FVRVVFLgo+IAo+
IEknbSBub3Qgc3VyZSBpZiB0aGlzIG1ha2VzIHNlbnNlLiBUaGUgY29udHJvbGxlciBkaWRuJ3Qg
cmV0dXJuIGEgc3RhdHVzCj4gaW4gdGhpcyBjYXNlLCBzbyB0aGUgaG9zdCBpcyByZWNsYWltaW5n
IHRoZSBjb21tYW5kIGFic2VudCBhIHN0YXR1cyBmcm9tCj4gdGhlIGNvbnRyb2xsZXIuIElzIHRo
ZXJlIGEgcGFydGljdWxhciBzaXR1YXRpb24gd2hlcmUgdGhpcyBwYXRjaAo+IG1hdHRlcnM/Cj4g
ICAKTm90IHJlYWxseS4gWW91IGFyZSByaWdodCwgSSBndWVzcyBJJ2xsIGRyb3AgaXQuCgpDaGVl
cnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVs
IFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZl
bGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2No
w6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52
bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LW52bWUK
