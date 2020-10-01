Return-Path: <SRS0=dhBa=DI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F11C47425
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 19:48:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98DD820848
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 19:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NZvGXsYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98DD820848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:From:Subject:To:
	Message-Id:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nORdbhAvsXfq8JHrNdeJZWDsfS8hWEGOF5sCyg3iMhQ=; b=NZvGXsYiIpB6T9iRdaK4yw0TS
	oM2Drm6dw1YSzVLr3WG0L2XmpFOH0uHdm9bDo/ZJEIAyYzp8+4nyP7jcU1yNmJbmk0u+qzMjhwL2G
	GvmdCmrWfahz1VFI0V2Vv/qtbF6koU6T+n90IIlOjCFGrN9OGFKsnluA0gskDc7ioXOs1fOCwHXlH
	qqL38hqOiV+gF1yWo8y0eObx53b/wt1WnFwg4J4K5gVfxtQSA0PxQ4J8HLSE3NL/fvxr30CLnC06D
	U+6zAxlRSUkkCEFcsid55o+0djtmMjZeQCV4HtwZ3urSUsQuSUEa6lqLF7jgSV4mooH0zh/Oz0W1I
	YRVqNMqYQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kO4Yw-0005T8-0o; Thu, 01 Oct 2020 19:48:22 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kO4Yt-0005S1-OQ
 for linux-nvme@lists.infradead.org; Thu, 01 Oct 2020 19:48:20 +0000
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id DF86014671C73;
 Thu,  1 Oct 2020 12:31:28 -0700 (PDT)
Date: Thu, 01 Oct 2020 12:48:15 -0700 (PDT)
Message-Id: <20201001.124815.793423380665613978.davem@davemloft.net>
To: colyli@suse.de
Subject: Re: [PATCH v9 0/7] Introduce sendpage_ok() to detect misused
 sendpage in network related drivers
From: David Miller <davem@davemloft.net>
In-Reply-To: <20201001.124345.2303686561459641833.davem@davemloft.net>
References: <20201001075408.25508-1-colyli@suse.de>
 <20201001.124345.2303686561459641833.davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [2620:137:e000::1:9]);
 Thu, 01 Oct 2020 12:31:29 -0700 (PDT)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201001_154820_040441_D26E0AD3 
X-CRM114-Status: UNSURE (   9.27  )
X-CRM114-Notice: Please train this message.
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
Cc: michaelc@cs.wisc.edu, amwang@redhat.com, linux-nvme@lists.infradead.org,
 philipp.reisner@linbit.com, hch@lst.de, vbabka@suse.com, sagi@grimberg.me,
 linux-scsi@vger.kernel.org, idryomov@gmail.com, open-iscsi@googlegroups.com,
 mskorzhinskiy@solarflare.com, chaitanya.kulkarni@wdc.com,
 linux-block@vger.kernel.org, hare@suse.de, ceph-devel@vger.kernel.org,
 axboe@kernel.dk, cleech@redhat.com, vvs@virtuozzo.com, eric.dumazet@gmail.com,
 netdev@vger.kernel.org, jlayton@kernel.org, linux-kernel@vger.kernel.org,
 lduncan@suse.com, jack@suse.com
Content-Type: text/plain; charset="iso8859-7"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

RnJvbTogRGF2aWQgTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0Pg0KRGF0ZTogVGh1LCAwMSBP
Y3QgMjAyMCAxMjo0Mzo0NSAtMDcwMCAoUERUKQ0KDQo+IFNlcmllcyBhcHBsaWVkIGFuZCBxdWV1
ZWQgdXAgZm9yIC1zdGFibGUsIHRoYW5rIHlvdS4NCg0KQWN0dWFsbHksIHRoaXMgZG9lc24ndCBl
dmVuIGJ1aWxkOg0KDQpJbiBmaWxlIGluY2x1ZGVkIGZyb20gLi9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9idWcuaDo5MywNCiAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvbGludXgvYnVnLmg6
NSwNCiAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvbGludXgvbW1kZWJ1Zy5oOjUsDQog
ICAgICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L21tLmg6OSwNCiAgICAgICAgICAg
ICAgICAgZnJvbSBuZXQvc29ja2V0LmM6NTU6DQpuZXQvc29ja2V0LmM6IEluIGZ1bmN0aW9uIKFr
ZXJuZWxfc2VuZHBhZ2WiOg0KLi9pbmNsdWRlL2FzbS1nZW5lcmljL2J1Zy5oOjk3OjM6IGVycm9y
OiB0b28gZmV3IGFyZ3VtZW50cyB0byBmdW5jdGlvbiChX193YXJuX3ByaW50a6INCiAgIDk3IHwg
ICBfX3dhcm5fcHJpbnRrKGFyZyk7ICAgICBcDQogICAgICB8ICAgXn5+fn5+fn5+fn5+fg0KDQpX
YXMgdGhpcyBldmVuIGJ1aWxkIHRlc3RlZD8NCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtbnZtZQo=
