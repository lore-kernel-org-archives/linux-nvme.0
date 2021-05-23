Return-Path: <SRS0=b1+/=KT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C397C04FF3
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 19:57:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 330656105A
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 19:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330656105A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=U0xEcFGpsS+wDxknNo6OVxKRA1gPoXSmVANE9E+yHsM=; b=hqhJR5Uc4tLsU5Ae/bl+ZiCYk
	MaxuBJXkzZzArWyEJqICbBPV7YzpUOFADpQaGxEuxLMXtiNHMaydriTeHehcYN6r0aYARA6BR2Osu
	SEItqEw4LLmQvUYZR4ujxa95UsJRhKQUfqPtfHBeWs43hH3Ytv+creWmmnnULvYaHjs6IYHNj+lZx
	nLBfr/vHVKsbYRgv/SU5G04kMIltdk361GvYo7WeVtm0gYpi4+jWtz4hvCq7Y+ckV97t7n3+J/JQs
	N71TkoDeyaWSYhN3/avLjk9r+9szgaktE+tmDD59macfdHdRZlZYvS5ff7hkiyU+ewfiFDQ2h6jJR
	WH1QmkN1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llGgw-001lJI-2i; Mon, 24 May 2021 19:56:46 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkixB-0040Nn-SC
 for linux-nvme@desiato.infradead.org; Sun, 23 May 2021 07:55:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=QbwAHhPm9GLJVETYtpBk/OiPxHo7G68rDTDzgn19Fsc=; b=fzTt1+mb7C54adsRTw0usAxv1e
 07GG+CR5nWg3XGrm0Ta+6B4/HzD29yh4Mjm7Ynq4VMmmYOfP2W3G5HlUrjx8lIK4WZqOpTq+Uk1kx
 QmPqgMTC7xnVLDaolDdeuuD2atvHq/gD1SuuHRSHisof9ESoBWeLAJxnpQyLsAaoJKdfmqhmzr9AL
 4soFDlMu+auENyr437aJ7iauGwSK5RvSP1cmuqyIoXKBSTjC/0d9INusLxA4hR0ZQh/NRspBYTtpx
 C8N2hUz+QnccXW7MMVBxCFxoqCNrJOQdEIfkwR49fuw1er+MzSFO/hLQWgM4TQN37yZdF0KGsdGev
 UuJjLBLA==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkix9-000MLs-BZ
 for linux-nvme@lists.infradead.org; Sun, 23 May 2021 07:55:16 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1621756514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QbwAHhPm9GLJVETYtpBk/OiPxHo7G68rDTDzgn19Fsc=;
 b=PSmQUQUSmMpj8AgljcgmgvL48ZfLtdYVEBYnr/42zGZ587TI08SIxLsO+5NgrgkRI6vOro
 Rm9c5OX+h9MIqppjBKupzHAd2Hs8vdT54gqpBdwAJEMlDjOBjYSv4EUUYou8Q+e3SZufbZ
 b+SB6HU5XHXIUV9ekpUjUtbJZggckAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1621756514;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QbwAHhPm9GLJVETYtpBk/OiPxHo7G68rDTDzgn19Fsc=;
 b=fZhiHl3U98WLdlRqZwGpFkK44Ry0eiyLSe/ReleypzZZcEqglw2fxQ310pZYIGfwu8Lozw
 zLLo4mb7f9mH0FDg==
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id E7E30AC46;
 Sun, 23 May 2021 07:55:13 +0000 (UTC)
Subject: Re: [PATCH 05/26] block: add blk_alloc_disk and blk_cleanup_disk APIs
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
 <20210521055116.1053587-6-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <04082e94-5180-2363-4479-a09cdfdc466d@suse.de>
Date: Sun, 23 May 2021 09:55:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210521055116.1053587-6-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210523_005515_562073_FFCB50E2 
X-CRM114-Status: GOOD (  15.32  )
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

T24gNS8yMS8yMSA3OjUwIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBBZGQgdHdvIG5l
dyBBUElzIHRvIGFsbG9jYXRlIGFuZCBmcmVlIGEgZ2VuZGlzayBpbmNsdWRpbmcgdGhlCj4gcmVx
dWVzdF9xdWV1ZSBmb3IgdXNlIHdpdGggQklPIGJhc2VkIGRyaXZlcnMuICBUaGlzIGlzIHRvIGF2
b2lkCj4gYm9pbGVycGxhdGUgY29kZSBpbiBkcml2ZXJzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IENo
cmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgo+IC0tLQo+ICAgYmxvY2svZ2VuaGQuYyAgICAg
ICAgIHwgMzUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgIGluY2x1ZGUv
bGludXgvZ2VuaGQuaCB8IDIyICsrKysrKysrKysrKysrKysrKysrKysKPiAgIDIgZmlsZXMgY2hh
bmdlZCwgNTcgaW5zZXJ0aW9ucygrKQo+IApSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxo
YXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAg
ICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29s
dXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFH
IE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFp
bGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
