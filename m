Return-Path: <SRS0=GcL3=KF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCE8C43460
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 13:57:26 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED4F161154
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 13:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED4F161154
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	Cc:To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IyPoDwH4sQ12fgJmTCgGX4fTZrh3CfgyZRD1oZFYYbI=; b=LgFx0ljkAkM1fFu50vSbSPr2K
	+Ks6Gc9wxnL9pqU1CmCcQ56fvb5AyPsFaPCFJVhxtUYRurLLN1XqrEs7iDZEUvcsGyVR5Byd1jf96
	xqi4CFrWSX65jqzKJo12LSttZwVC4eOo2gYFUe54TwzDfdPOxsjB+sSUiN45NPPlmPGfC93amGv5H
	8Q5DzLtYbjFprz3L1kKCmefPmtZSqFwIM+HZ+eLse0tyLyJg7orkBlefe1f+kfaE0LEcN64q3o9TK
	x3fCuqwXO2xDJSCV/IduaDENbH436Qp4CBm1fTiv1IS1PdJVCyeUxeEM1/V648BiBH6UqDplbkm9u
	25lFp33/A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lg6PE-00EXp9-Ca; Mon, 10 May 2021 13:57:08 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lg6PA-00EXoP-V0
 for linux-nvme@desiato.infradead.org; Mon, 10 May 2021 13:57:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=e8n4SREef+iR3+QP1OZSpYduhI9liSi/zbWMgQgfvO4=; b=boP/qKul65/xmT9fdMalAe0bhO
 2zk9mp57AsQcMMc8nBxcNcfOBDFZSOdggDRtDBCcAEMdPXsrhMdAsgeNyZz2bfuruFg/k8bxfyd9J
 R3fAeeFt9Kb/7/fMeqnOF5lewa0wmSdat0qupb2oSJZjY2j6teXJSWdRPW/blE6zI6x6wkCLC5T63
 CUBZbQIm3dhY06apaJLb+dIQ1kAY+E1lpnz09m0F0Wi6xXIle9fOh90BZAGZwSyYxlB4BAeJBKoE7
 VhHBl2W8vx3I9txzxNvt8y8uoR4rnkSYDCYCOkkxAh+xmk9WpUTwllHXgRpzgiBMIQpyn2W4OFqtj
 9hhsKa6g==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lg6P8-008mNn-Bt
 for linux-nvme@lists.infradead.org; Mon, 10 May 2021 13:57:03 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id EF015B02B;
 Mon, 10 May 2021 13:57:00 +0000 (UTC)
Subject: Re: [PATCHv3] nvme-mpath: delete disk after last connection
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Daniel Wagner <daniel.wagner@suse.de>
References: <20210504085457.GA21826@lst.de>
 <5e4df9ec-c66c-17cf-542f-bac71b490e62@suse.de>
 <d1ca6eab-1ec9-d6c7-ed8a-00d9110bf023@grimberg.me>
 <20210506074341.GC14615@lst.de>
 <96fbc678-a7e8-aaf3-5f15-8c866e683afe@suse.de>
 <d50ca6e6-5340-6f38-bc56-6f10b49d7801@grimberg.me>
 <20210506120855.GA1546@lst.de> <7cd891d9-6aa0-fd98-cbc5-1df2eabbe31d@suse.de>
 <20210507064656.GA24437@lst.de>
 <4fd33328-9060-6e95-dd26-ab013e44c07a@suse.de>
 <20210510062346.GA30116@lst.de>
 <42bf4da0-c266-5413-8bac-949bdadd4024@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <456faa90-094b-ffac-d405-b1ba71445865@suse.de>
Date: Mon, 10 May 2021 15:57:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <42bf4da0-c266-5413-8bac-949bdadd4024@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_065702_567994_E68F6CF5 
X-CRM114-Status: GOOD (  11.63  )
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

T24gNS8xMC8yMSAzOjAxIFBNLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6ClsgLi4gXQo+IE5vdGU6
IHRoaXMgaGFzIGJlZW4gdGVzdGVkIHdpdGggbGF0ZXN0IG52bWUtNS4xMywgYW5kIHRoZSBzaXR1
YXRpb24gaGFzCj4gaW1wcm92ZWQgc29tZXdoYXQgKGFzIGNvbXBhcmVkIHRvIHByZXZpb3VzIHZl
cnNpb25zKSBieSB0aGUgZmFjdCB0aGF0IE1ECj4gaXMgbm93IGFibGUgdG8gcmVjb3ZlciBhZnRl
ciBtYW51YWwgaW50ZXJhY3Rpb24uCj4gQnV0IHdlIHN0aWxsIGVuZCB1cCB3aXRoIGEgbmFtZXNw
YWNlIHdpdGggdGhlIHdyb25nIG5hbWUuCj4gCgouLi4gYW5kIGl0J3MgYWN0dWFsbHkgX25vdF8g
d2hhdCBJIHdhcyBwbGFubmluZyB0byBkZW1vbnN0cmF0ZS4KTGF0ZXN0IHFlbXUgZW11bGF0ZXMg
TlZNZSB3aXRoIENNSUM9Miwgc28gd2UgbmV2ZXIgYWN0dWFsbHkgZW5nYWdlCm11bHRpcGF0aGlu
Zy4KClNvIHNjcmF0Y2ggdGhhdDsgSSdsbCBuZWVkIHRvIHJlZG8gdGhlIHRlc3QuCgpTaWdoLgoK
Q2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlCQkgICAgICAgIEtlcm5lbCBT
dG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUJCQkgICAgICAgICAgICAgICArNDkgOTExIDc0
MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIDkwNDA5IE7DvHJu
YmVyZwpHRjogRi4gSW1lbmTDtnJmZmVyLCBIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZykKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFp
bGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
