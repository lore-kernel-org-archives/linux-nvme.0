Return-Path: <SRS0=b1+/=KT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7783C04FF3
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 19:51:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 702436109F
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 19:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 702436109F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AC6jRcOdVtKTGyCifCbtYSVO8ZG6hqAu9SF7dX7XM5I=; b=3L4YU3fSI/5oynx/KR7YkNChl
	0u0Zk3USl0+E6QcVNZSE0s54Qy19pcsdpF4rcboCP877fF3F7qDctHXbGY/KxS932NPLInoGeva/a
	NZ2RIqWbIqKVGQMfGj0UZWXvKsHpzvsy3+giKrElw/GhnwSKMc5BARuwG3YFER8Jc4VE6scFvLIWg
	xjbvK9x1YEy3yAvj3cHPM5URSgC+iV5CAZ0UEatbe74Kplncle2ClOKFQuBXTKtvFakf2tFQlTsJU
	XlVbsDUFBJUDFbUcGm/i5io45wn+rjq/adB7fWTtR2BQNhtZ+NNZcBhJJKwVICHA5MLVUm8IsjMlR
	wfPiXtrnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llGb5-001k4v-Q5; Mon, 24 May 2021 19:50:43 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkioO-003zbw-Jv
 for linux-nvme@desiato.infradead.org; Sun, 23 May 2021 07:46:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=qgeGl97uX/ASq/b1LiyPvGm5KNHhtUs0K8R0hHcKHNc=; b=O2I3TnB78h8Tr5Ny3cJq9T+g6p
 b8O3t/eblq+9eV7eGRx7m7n3nePv43YRPngWtDK3+0VxpRRK5b841YkOggZ8MrlMl7270l9RQadD5
 9MKPRpegpHR4Oxja/djnzBvxJ05TPhE3eITXxEf+VAhgflLNwEbgwu4cogPDrTMSpFx3VqW9I1eiD
 GCSLxLa17ZHaKUIOVcaUKJPAnLusarYoTEWCg38blY8tDG/niHWLAsuMKYS+Xmr5Jpiove2IwgQPq
 Z8hd/rql4raS0HFtFlqG6Z8T/50POffgSqrstlQwBoVJ5ZfewZblvc+ij64sK+rgPUp5KvYvSmvpo
 IMEe8rXA==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkioJ-000M7N-Hi
 for linux-nvme@lists.infradead.org; Sun, 23 May 2021 07:46:11 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1621755963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qgeGl97uX/ASq/b1LiyPvGm5KNHhtUs0K8R0hHcKHNc=;
 b=loXc3McbnIlaTeOmap5xh/BtT1gA18JtYlPnnRT16wqHGfTJ19lzfYOvtfB0oOgoXJJBVk
 /ReVtyQfx/H7rkQyR4p+DdQCpRAZIyorp+zG3qS0QxK3kt3astNHDmaxUpril0ODq2rDNt
 r9Vkt/28bb7h7z+3O1fywe0kQCnoBFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1621755963;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qgeGl97uX/ASq/b1LiyPvGm5KNHhtUs0K8R0hHcKHNc=;
 b=ColirDJTDltQ04gjJ+NwT5obDqeCRv1j+ud81TmJU8SNYoFAHUoSAb2/6qAn8/xG4ncH3n
 i/HOh7UwzHlRZeDg==
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id AF152AB5F;
 Sun, 23 May 2021 07:46:03 +0000 (UTC)
Subject: Re: [PATCH 01/26] block: refactor device number setup in
 __device_add_disk
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>, Jim Paris <jim@jtan.com>,
 Joshua Morris <josh.h.morris@us.ibm.com>,
 Philip Kelleher <pjk1939@linux.ibm.com>, Minchan Kim <minchan@kernel.org>,
 Nitin Gupta <ngupta@vflare.org>, Matias Bjorling <mb@lightnvm.io>,
 Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
 Song Liu <song@kernel.org>, Maxim Levitsky <maximlevitsky@gmail.com>,
 Alex Dubov <oakad@yahoo.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-block@vger.kernel.org, dm-devel@redhat.com,
 linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org,
 drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org,
 linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-mmc@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
References: <20210521055116.1053587-1-hch@lst.de>
 <20210521055116.1053587-2-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <d55cba32-b114-513b-09d9-40c289fa95c3@suse.de>
Date: Sun, 23 May 2021 09:46:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210521055116.1053587-2-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210523_004607_758681_27BA9832 
X-CRM114-Status: GOOD (  15.06  )
X-Mailman-Approved-At: Mon, 24 May 2021 11:59:45 -0700
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

T24gNS8yMS8yMSA3OjUwIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBVbnRhbmdsZSB0
aGUgbWVzcyBhcm91bmQgYmxrX2FsbG9jX2RldnQgYnkgbW92aW5nIHRoZSBjaGVjayBmb3IKPiB0
aGUgdXNlZCBhbGxvY2F0aW9uIHNjaGVtZSBpbnRvIHRoZSBjYWxsZXJzLgo+IAo+IFNpZ25lZC1v
ZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgo+IC0tLQo+ICAgYmxvY2svYmxr
LmggICAgICAgICAgICAgfCAgNCArLQo+ICAgYmxvY2svZ2VuaGQuYyAgICAgICAgICAgfCA5NiAr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICAgYmxvY2svcGFydGl0
aW9ucy9jb3JlLmMgfCAxNSArKysrKy0tCj4gICAzIGZpbGVzIGNoYW5nZWQsIDQ5IGluc2VydGlv
bnMoKyksIDY2IGRlbGV0aW9ucygtKQo+IAouLi4gYW5kIGFsc28gZml4ZXMgYW4gaXNzdWUgd2l0
aCBHRU5IRF9GTF9VUCByZW1haW5lZCBzZXQgaW4gYW4gZXJyb3IgCnBhdGggaW4gX19kZXZpY2Vf
YWRkX2Rpc2soKS4KClJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4K
CkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBL
ZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwg
TWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwg
R2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGlu
dXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
