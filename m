Return-Path: <SRS0=b1+/=KT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DD3C04FF3
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 20:09:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41001613EA
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 20:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41001613EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=48ZugJaNDJu045w9EbObe6nMyRVa7xnBg6NwxaLEYoM=; b=4g8iRPTu57VFawokYIg0ERvHs
	jvAt7d8TnTs6AmdIRJJnHBJcD5RaRQP8v99XoLQoGrWRUdUYinBb0ar6SRtm87Isw+Q6Yg8pP/VmR
	C0ZdszVynu90Nka5hFTE4oAeXEhu92XhhK3jN9V19Lp0GP/BVY2vHBVtvOxpTpb/4HHiVkHB29jsh
	HFj2RZEQ1B5YyoF+Eg85l+DkQ08ibJRpjozhvDtXnq1TTSie5xkkb83P6aggsKMIqhKGzYZYSZfFz
	OiPvBaFJY6wa2J+idvNqkigfQGeu4wLqShWBAOXiF0aNPzBJPMIZvpxTxtZc/gjA0nXOeO/YWoMHM
	4OPRk0iLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llGtI-001n6u-Hd; Mon, 24 May 2021 20:09:32 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkj6d-0041Af-GM
 for linux-nvme@desiato.infradead.org; Sun, 23 May 2021 08:05:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=r0CnFan1k07OcfnvGuqY1FMssFuQj0eT2+mYEtmGNso=; b=cttIp6DoO/WH9afN80LQD6xXkN
 nKukKyQnJQyHoW1VrJLamuY07k8LR8KFQEIvZ+2+0WDezHjieli6X7LbAfp5vnehRhBZo7nwkpmK2
 UpFUHTcRIuyMIWCk46g/5/FV178z0icEYsNU2+AWyqnOyBg8RPJU/FXKIvbxc1Mcn4OZBdKHGiw8N
 vOg2fu1S4xZb+ivfPP8wcGz0lB1Rw4bUJBRAuAwj5zYFUkgjjfzgOSkwtbhUmKP2UvVJt7zl0b+0V
 VQuOHyLi8Wh7JiPp4qiM+0pr8fpU+MvJAnWrNnYL/G32ola8t/6u6crwB8qeYlQ4IlVpsvAEhqjxn
 2otvosWA==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkj6a-000MhO-SS
 for linux-nvme@lists.infradead.org; Sun, 23 May 2021 08:05:02 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1621757099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0CnFan1k07OcfnvGuqY1FMssFuQj0eT2+mYEtmGNso=;
 b=Md1LP0e76M+djeruCjtVt3UuzZhAa3Lnixb+7+UHtJP72BalQHXVAJ5VjykbXfodwHAuVF
 jTr9oEIWges7dv36vwyjT8czWx2QThNilsZlmBTQvF69oHauSSrayfRRbinf6Yt3WYXiPH
 NtcPnw5ZQkHYs1fZq4qVjB2GCUuSCcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1621757099;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0CnFan1k07OcfnvGuqY1FMssFuQj0eT2+mYEtmGNso=;
 b=UxMYevwyVO2hLzjr67gtOpS11dsaz1CMnntZMGC2dux9ybwxUJfsseIEBF31dgYoBgLUJS
 FkRxPC91JsntrVBw==
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 6389EAB6D;
 Sun, 23 May 2021 08:04:59 +0000 (UTC)
Subject: Re: [PATCH 12/26] bcache: convert to blk_alloc_disk/blk_cleanup_disk
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
 <20210521055116.1053587-13-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <da21fbea-7711-3fa8-9281-76a016cec258@suse.de>
Date: Sun, 23 May 2021 10:04:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210521055116.1053587-13-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210523_010501_089726_6F9E0D0A 
X-CRM114-Status: GOOD (  14.71  )
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
ZSBiY2FjaGUgZHJpdmVyIHRvIHVzZSB0aGUgYmxrX2FsbG9jX2Rpc2sgYW5kIGJsa19jbGVhbnVw
X2Rpc2sKPiBoZWxwZXJzIHRvIHNpbXBsaWZ5IGdlbmRpc2sgYW5kIHJlcXVlc3RfcXVldWUgYWxs
b2NhdGlvbi4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5k
ZT4KPiAtLS0KPiAgIGRyaXZlcnMvbWQvYmNhY2hlL3N1cGVyLmMgfCAxNSArKysrLS0tLS0tLS0t
LS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQo+
IApSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpI
YW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3Jh
Z2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0
OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIu
IDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNm
w7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LW52bWUK
