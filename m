Return-Path: <SRS0=b1+/=KT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD25C2B9F7
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 20:20:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F2016140B
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 20:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2016140B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=McSfXuoCuEyW9HTwmQM97Fx7IL2EQNT0imFdUxNrtKw=; b=R+YNVJuMMBAUXzoqd2gNIAKr3
	9x89oKxgzRqTwGBKQ3R07ZaA//bD1s9960/2q5OerUpm2T93zlzWqD0qQ28jmYZsxJgxpqJxg09eA
	ATANYKTwaJXJyU/eYPOP0kQsO35JACi0HyMiirAqRy/ejI9twmvmKJ9obX1QggBVf0hvrNwqzuBKM
	vn9Jj4YSmwYkiwzG5nQ9qQjQX//HaUTzzBeCT4xSQMuAFE/+FtGMnatBl3ZMYWBWrFvWFggmMx4zW
	W+zIY6RKWMYs4N0fjB5WJh1i+JocUQKSgnY7BP5w+NaE9Cj8bHKeDnHG2/P6GS+d1KXA8XsQP8wwo
	xBMYBHEcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llH3D-001oT5-JG; Mon, 24 May 2021 20:19:47 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkjFb-00420I-KV
 for linux-nvme@desiato.infradead.org; Sun, 23 May 2021 08:14:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=qndw/8cRfR4n5MxN573Up92okpro6jHBBSJUlmT8TIg=; b=d9wc31KFSKQlnBnkyvcq/ckDQm
 DiGakhMdZTlHhZj913fVy/MjfYTZANk+k55Bjw1WpukaUYIklEtIc2CDsPaKsCGk5GtcoXTukGa1x
 B175ZaVavHTFycbDES5yPYJ9Ibbj7Cf4ADd8HGKOEYMCpxE81GSgQ/RWp6cSGPjto1RsKfImyzPiD
 qfjmFfN5JON+ncP8tODYHq5enlTa6gkNto/0Una/i5KDA8hw9pt/VHkpgy9YI+YTNLlvAmsfYvJxq
 caE3oQti22WB11YEoszPqv/b3b5ooI6igS/NxDZPTKz2GHeCLFcODsr4oObKPuD18TJ3lwufYiEET
 IaHJjHMw==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkjFZ-000Mz9-4w
 for linux-nvme@lists.infradead.org; Sun, 23 May 2021 08:14:18 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1621757655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qndw/8cRfR4n5MxN573Up92okpro6jHBBSJUlmT8TIg=;
 b=BboH4k8Cgtr8ut3UnJS7S2lcjUSVsG7bLs55qAKpnYW7W6yzl7lrzmSCJs8gJAAyQHkPls
 Cqzncpt6NU6MBbTplNLSwznQQLj0oej9F0hTcII+iaq2eB+edEZrKejx/CEg/1vJmgEse1
 Xb/WD7COir2jUA6PLoQQx1M9hQilQc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1621757655;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qndw/8cRfR4n5MxN573Up92okpro6jHBBSJUlmT8TIg=;
 b=ZWkRqzGdCAwcqXvet4aJDvklif5PL9OFvnqYcpjg1x2JORSYO/pj7EFixuKPkE9QN8Zw/p
 ddjCgprrATKXjMCw==
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B877DAAFD;
 Sun, 23 May 2021 08:14:15 +0000 (UTC)
Subject: Re: [PATCH 16/26] nvdimm-btt: convert to
 blk_alloc_disk/blk_cleanup_disk
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>, Jim Paris <jim@jtan.com>,
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
 <20210521055116.1053587-17-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <7c4aa44c-5cd7-5ff5-4641-052f337067ab@suse.de>
Date: Sun, 23 May 2021 10:14:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210521055116.1053587-17-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210523_011417_358299_E201C5CF 
X-CRM114-Status: GOOD (  14.73  )
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

T24gNS8yMS8yMSA3OjUxIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBDb252ZXJ0IHRo
ZSBudmRpbW0tYnR0IGRyaXZlciB0byB1c2UgdGhlIGJsa19hbGxvY19kaXNrIGFuZAo+IGJsa19j
bGVhbnVwX2Rpc2sgaGVscGVycyB0byBzaW1wbGlmeSBnZW5kaXNrIGFuZCByZXF1ZXN0X3F1ZXVl
Cj4gYWxsb2NhdGlvbi4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGxzdC5kZT4KPiAtLS0KPiAgIGRyaXZlcnMvbnZkaW1tL2J0dC5jIHwgMjQgKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tCj4gICBkcml2ZXJzL252ZGltbS9idHQuaCB8ICAyIC0tCj4gICAyIGZpbGVz
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pCj4gClJldmlld2VkLWJ5
OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIu
IEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QK
aGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2
ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8
cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4
IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZt
ZQo=
