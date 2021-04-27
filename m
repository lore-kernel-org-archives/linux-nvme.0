Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA3EC433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 18:06:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D644F613BD
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 18:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D644F613BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Fpgk0vFLpCqaqbSLcBBGmVRpkSRpyTL95ttVff9mzMc=; b=Q8OBJjRGWKzFc6Fe5XCNMBvmf
	lPfxGVPXhucQD1ODQdvaTEZ7O17ySVCnh9ITRkVw62in7c24yziDaWJL1gdgPBmQtZsvtLQIFaHMx
	AwoR9i1u8G29xd7KPa7cv22G2Ozb5YrLT5+vOEZJzNaBGzi1q5j0r1rWu+e46PdDmf8zHkKDSCqQC
	0xHKACFaKxim4nklj8DjFcdRXCbwMWNV0ctp5v89ZKFqDiR3dwega/K71yILQE3qb95yclbSgY0+9
	ALDUoli6608IK7mP0ToOKco4dfj5Krr55QhebQVvSl4ZlipGdd034UDFUoQ8nQcs7CxuWEZuLXYnC
	9N5xpiPVQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbS5l-0021bo-Er; Tue, 27 Apr 2021 18:05:49 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbS5j-0021bc-6o
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 18:05:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:Subject:From:References
 :Cc:To:Sender:Reply-To:Content-ID:Content-Description;
 bh=rph+eIzjPaoJzzkgPkHU59oNIb9sXzKjcBwjW0RtHvg=; b=DKtLdoIbnujA5hd91J+0GqlGki
 4N/dp5ERsTYyhDp/7Gfw4r2oUnBQ3tQwdTirPEOniRayoyTIzd2yIvDvJqS3H6Rxu9CdE2rPSGo97
 6qq5LrC3oMV+ieRZNTXuDSh7GiERPn7js9AF2InEs8Rzj47QEvRs1S9x8mVsEiZy62Ry+ysCpl85Q
 CNG8k1JqT/zH15K93YpQ31FXDW5jE5i+1liXBg5rIWRpZ0PHnuuG4iQpu6cmAHmPimywjd4V2TerT
 04pubCo6oyIN0KGNj7P52mjjObiq25DMQypK0tHU+g4zBCgLmhx1/t40vbQ1OhYxBdZlln0I/MI/W
 eM610aaQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbS5g-00GuIT-Jx
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 18:05:45 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id EAE5BADB3;
 Tue, 27 Apr 2021 18:05:42 +0000 (UTC)
To: Christoph Hellwig <hch@lst.de>
Cc: mwilck@suse.com, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>,
 Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
 stable@vger.kernel.org
References: <20210427085246.13728-1-mwilck@suse.com>
 <0ff2dbc0-0182-f54d-b750-084feac53601@suse.de>
 <20210427162521.GA26528@lst.de>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Subject: Re: [PATCH v3] nvme: rdma/tcp: fix list corruption with anatt timer
Message-ID: <f82b7f7c-ef12-27bb-1349-d23ea22e50a9@suse.de>
Date: Tue, 27 Apr 2021 20:05:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210427162521.GA26528@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_110544_816840_DA349B84 
X-CRM114-Status: GOOD (  14.05  )
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

T24gNC8yNy8yMSA2OjI1IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbiBUdWUsIEFw
ciAyNywgMjAyMSBhdCAxMTozMzowNEFNICswMjAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+
IEFzIGluZGljYXRlZCBpbiBteSBwcmV2aW91cyBtYWlsLCBwbGVhc2UgY2hhbmdlIHRoZSBkZXNj
cmlwdGlvbi4gV2UgaGF2ZQo+PiBzaW5jZSBlc3RhYmxpc2hlZCBhIGFjdHVhbCByZWFzb24gKGR1
cGxpY2F0ZSBjYWxscyB0byBhZGRfdGltZXIoKSksIHNvCj4+IHBsZWFzZSBsaXN0IGl0IGhlcmUu
Cj4gCj4gU28gd2hhdCBoYXBwZW5zIGlmIHRoZSBvZmZlbmRpbmcgYWRkX3RpbWVyIGlzIGNoYW5n
ZWQgdG8gbW9kX3RpbWVyPwo+IApJIGd1ZXNzIHRoYXQgc2hvdWxkIGJlIGZpbmUsIGFzIHRoZSBi
b2lsZXJwbGF0ZSBzYWlkIGl0IGNhbiBhY3QKYXMgYSBzYWZlIHZlcnNpb24gb2YgYWRkX3RpbWVy
LgoKQnV0IHRoYXQgd291bGQganVzdCBzb2x2ZSB0aGUgY3Jhc2ggdXBvbiBhZGRfdGltZXIoKS4g
V2Ugc3RpbGwgaGF2ZSB0aGUKcHJvYmxlbSB0aGF0IHRoZSBhbmF0dCB0aW1lciBtaWdodCB0cmln
Z2VyIGp1c3QgX2FmdGVyXyBlZwpudm1lX3RjcF90ZWFyZG93bl9hZG1pbl9xdWV1ZSgpLCBjYXVz
aW5nIGl0IHRvIGhpdCBhbiBpbnZhbGlkIGFkbWluIHF1ZXVlLgoKQ2hlZXJzLAoKSGFubmVzCi0t
IApEci4gSGFubmVzIFJlaW5lY2tlCQkgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApo
YXJlQHN1c2UuZGUJCQkgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3
YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIDkwNDA5IE7DvHJuYmVyZwpHRjogRi4gSW1lbmTD
tnJmZmVyLCBIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZykKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52
bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LW52bWUK
