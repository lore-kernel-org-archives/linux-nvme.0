Return-Path: <SRS0=YFbx=KA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C6CC43461
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 20:11:45 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 184AB61006
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 20:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 184AB61006
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=W3gyM81tOVHMbinkacFuj1TnteeCLPwBB/i91M+tkwQ=; b=GxWzoKTuti+81hPK8y31pFgjF
	gFd/OhAbmX9pnvrNLvCaWMFHEz3dO8CN6wek8qGmf2XLHlHd1m9QavspM+cSG962AS8Xg9dFFyEtd
	BHXBtH6YBpDAW0gpqaOn74OGsujdQ0LFswU1YrMKVOqLkCEzuUCcoAwHAxamu5kiSMvv24n1M0bl0
	jvrroiEmvaHOX3bigYY3GsQVK5aMPUHReD2A+EByGLmPsldB1W9q9rp0CcaJDX4bXr1pCNBJvDgt5
	jr7rJ5npNyrdO1PicoMyQNTIOq3BcaQQsRip4brZYj/CtmPgKnv66+EyOoski2v0TWn4HSfQMgLLs
	33F8KlK2Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leNrk-002EM7-Fg; Wed, 05 May 2021 20:11:28 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leNrc-002ELp-Se
 for linux-nvme@desiato.infradead.org; Wed, 05 May 2021 20:11:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
 :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=61zPOfrSLxJAqHbYceDQkD9BIZ6sKCLMqtUsBUkD3y8=; b=D0dGONI1T0OoATuAE1tbBdVfF0
 0nOsFAL/1y3VwJUf38WpvWBx6sulfeKsuVxxeaBT0RfjvMHdhOQegqwjSxnvGr1+OLXhqhZo130AT
 6GqUr42QOhvOlqZ6RtZp73RS/D/dkJ8yIwNE+paMFoG6SapxyK8MEzN1Cm4dQcQRpz6XQOfZlwBVw
 B/xGBnag485vUaOfTuSn+vz/MjT8zZjyn4sD+h2kcuoEySvomQSqFU33+K9zd0pMsbPr/7kMMjlZ6
 N/CtuAbr73QIZiNneoSIWaXMGF/ns/DE5Dj5EXOWZ0tI0hTcCL5GmXHLE8uLXjJBNMEBTFsC0jFsE
 M3KYbCuA==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leNrZ-005ENk-OE
 for linux-nvme@lists.infradead.org; Wed, 05 May 2021 20:11:18 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA33360241;
 Wed,  5 May 2021 20:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620245477;
 bh=cuOsS++t2vXK+AA9iLBWLgp2KpQe1v1VkMeaxuVPziU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UDUtS3k1G1L67VgCXsISK3wKUEmelTD9/bIED1C9g3LbCebC0HIy7/3OQtUdowCIa
 7S0lmKiUv0GecoElF257uDgIJKUMONY3GQW+BfcPoEI9QZ73u/UMiU6QZp2rKKr8Rz
 gzDExpYnlZAa7W1q1MhSDF9sYrPZoEJgvC5egEdc+GHwjt3pXcpprxFuveSMLa0zem
 jg/Y60iwD0SSHIlIxi1aYrINZhFLvPXPc+9+ArrbI6ObAJ4GhJ1s+7r6TcTFilO3bt
 DrAb7Bz7G+BnbsD42XEHJtCVVum9KxQQDPXfxwaSAYQIFPu+kck/jfsuiVVZs+jlgO
 azE66Sjm1m+pQ==
Date: Wed, 5 May 2021 13:11:14 -0700
From: Keith Busch <kbusch@kernel.org>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/1] nvme: Export CSTS register via sysfs
Message-ID: <20210505201114.GA1186772@dhcp-10-100-145-180.wdc.com>
References: <0D18CE6C-4390-4040-98A6-14204DE33253@oracle.com>
 <20210318165213.GA31675@redsun51.ssa.fujisawa.hgst.com>
 <0D017D65-3D7C-4165-B25B-21E6A6FFDED5@oracle.com>
 <20210318194653.GA2690@dhcp-10-100-145-180.wdc.com>
 <20210319065158.GA11263@lst.de>
 <20210319152208.GA3794@redsun51.ssa.fujisawa.hgst.com>
 <20210319153008.GA14280@lst.de>
 <49CFFA55-5A71-4C0D-8816-11EB88087AAA@oracle.com>
 <20210319173009.GA4198@redsun51.ssa.fujisawa.hgst.com>
 <023A7AD6-3606-4C3A-8D16-5E65A55551F0@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <023A7AD6-3606-4C3A-8D16-5E65A55551F0@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210505_131117_834437_0EBA2CDB 
X-CRM114-Status: GOOD (  12.76  )
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

T24gV2VkLCBNYXkgMDUsIDIwMjEgYXQgMDY6NDA6NTRQTSArMDAwMCwgQWxhbiBBZGFtc29uIHdy
b3RlOgo+IE5lZWQgdG8gcmV2aXNpdCB0aGlzIGlzc3VlIGFnYWluLiAgSW4gdGhlIG9yaWdpbmFs
IGNhc2Ugd2UgbmVlZGVkIHRvCj4gZ2V0IGFjY2VzcyB0byB0aGUgY3N0cyByZWdpc3Rlci4gV2Ug
d2VyZSBhYmxlIHRvIG1vdmUgdG8gdXNpbmcgdGhlCj4g4oCZc3RhdGXigJkgc3lzZnMgYXR0cmli
dXRlLgo+IAo+IFdlIGFyZSBub3cgZ2V0dGluZyBhIHNpbWlsYXIgcmVxdWVzdCBmcm9tIG91ciBt
YW51ZmFjdHVyaW5nIHRlYW0uIFRoZXkKPiBhcmUgdXNpbmcgbnZtZS1jbGkgc2hvdy1yZWdzIHRv
IGFzc2lzdCBkZWJ1Zy4gVGhlIOKAmXN0YXRl4oCZIGF0dHJpYnV0ZSBpcwo+IG5vdCBzdWZmaWNp
ZW50IGFuZCB0aGV5IHdhbnQgdG8gdXNlIHRoZSBwcm9kdWN0aW9uIHZlcnNpb24gb2YgdGhlCj4g
a2VybmVsICh3aGljaCBlbmFibGVzIENPTkZJR19JT19TVFJJQ1RfREVWTUVNKSByYXRoZXIgdGhh
biBhIHNwZWNpYWwKPiBrZXJuZWwuIElkZWFsbHksIHdlIHdvdWxkIHdhbnQgbnZtZS1jbGkgc2hv
dy1yZWdzIHRvIHdvcmsgd2hldGhlciBvcgo+IG5vdCBDT05GSUdfSU9fU1RSSUNUX0RFVk1FTSBp
cyBjb25maWd1cmVkLiBPdGhlciB0aGFuIGV4cG9ydGluZyB0aGUKPiByZWdpc3RlcnMgdGhydSBz
eXNmcyBhdHRyaWJ1dGVzLCBpcyB0aGVyZSBhbnkgb3RoZXIgbWVjaGFuaXNtIHRvIGdldAo+IHNo
b3ctcmVncyB0aGUgZGF0YSBpdCBuZWVkcz8KCkFwcGVuZCBrZXJuZWwgcGFyYW1ldGVyICJpb21l
bT1yZWxheGVkIi4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
