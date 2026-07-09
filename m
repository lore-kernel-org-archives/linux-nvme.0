Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 112EEC43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 10:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Subject:To:References:Mime-Version:Cc:In-Reply-To:
	Message-Id:Date:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=js3GOE6eNJYLE/SjBEOjGlHKW//nqpck89PQglEeI7I=; b=W6+MYVALpmayHPbtKKqH2gdpeG
	zOPvhEXBOmn4WgQtRf3kbaQILx1lbfd3OSvF0hCY1mnya+iDMP2FqG8PbrWexWzVIsJVuRagtFpLZ
	pCsYPS6oHV1UbUrLcbKCzRWFlXKnVnw7hTjUX9EU3W7/BBg3H5Mkl2CE/+NVOOsihQYUDuPXrFHrb
	rAtN927nT3RN8Zhsc9++NY7dGrOf9KFAPNi/aEkIDhGqiGrfEnvOWEXJcFWGB1lrZJhwrkO8xrZuJ
	m93f5FRucv5VJhEFkDhH5E2Yal0oKQs+L6rEWQ+mwMnHqtB0eu+a+c1InMYYIyx4Jt7nDW0vFzt2F
	cIPeznQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whlaj-00000001rHt-3NB6;
	Thu, 09 Jul 2026 10:02:49 +0000
Received: from va-2-50.ptr.blmpb.com ([209.127.231.50])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whlah-00000001rHH-1OgR
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 10:02:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1783591358;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=js3GOE6eNJYLE/SjBEOjGlHKW//nqpck89PQglEeI7I=;
 b=G2/vTerTQHVKtUCxf0lbYJ0hD0o24yQuAOYZfOu3oqx72JtArWF+1mfZkEdVbxfzLDRz6q
 iiQOtwXK8oV5Vh/9rVAXL5YLZF8VWnRdHeaOabmwZea1CR0bqYShjrbgzlzaFe0NZFRjxI
 hYv7UTUuPNvUIxq+JdRwNMzlc6TWu+PrYMkaPTB+jnDBPHPqXG4k7YDqB9NkpeEMrRNksq
 f2qCNYH3u6vRGIexQcZr6CL9Tns4iH7Xj9i3DvNuq28JzCZr2DDSlhsKLB+9d0HNfutR3s
 A+wWC8WII7c2fSC96nXNxARmuT20KfUrCYssTMoQTjyRxqCZRmCo1zWRS6kabg==
Content-Type: text/plain; charset=UTF-8
From: "yu kuai" <yukuai@fygo.io>
Date: Thu, 9 Jul 2026 18:02:32 +0800
Message-Id: <ee70f959-b61e-45d2-b1f0-22bee85b0bdc@fygo.io>
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+26a4f71be+4d4cb3+lists.infradead.org+yukuai@fygo.io>
In-Reply-To: <20260709061500.GE16504@lst.de>
Received: from [192.168.1.104] ([39.182.0.144]) by smtp.larksuite.com with ESMTPS; Thu, 09 Jul 2026 10:02:37 +0000
Cc: "Jens Axboe" <axboe@kernel.dk>, "Tejun Heo" <tj@kernel.org>, 
	"Keith Busch" <kbusch@kernel.org>, "Sagi Grimberg" <sagi@grimberg.me>, 
	"Alasdair Kergon" <agk@redhat.com>, 
	"Benjamin Marzinski" <bmarzins@redhat.com>, 
	"Mike Snitzer" <snitzer@kernel.org>, 
	"Mikulas Patocka" <mpatocka@redhat.com>, 
	"Dongsheng Yang" <dongsheng.yang@linux.dev>, 
	"Zheng Gu" <cengku@gmail.com>, "Coly Li" <colyli@fygo.io>, 
	"Kent Overstreet" <kent.overstreet@linux.dev>, 
	"Josef Bacik" <josef@toxicpanda.com>, 
	"Nilay Shroff" <nilay@linux.ibm.com>, <linux-block@vger.kernel.org>, 
	<cgroups@vger.kernel.org>, <linux-nvme@lists.infradead.org>, 
	<dm-devel@lists.linux.dev>, <linux-bcache@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: yu kuai <yukuai@fygo.io>
References: <20260704195124.1375075-1-yukuai@kernel.org> <20260704195124.1375075-8-yukuai@kernel.org> <20260709061500.GE16504@lst.de>
To: "Christoph Hellwig" <hch@lst.de>, "yu kuai" <yukuai@fygo.io>
Subject: Re: [RFC PATCH v1 07/17] block: support non-blocking bio allocation with a bdev
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_030247_439363_4F1CA28C 
X-CRM114-Status: UNSURE (   6.27  )
X-CRM114-Notice: Please train this message.
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
Reply-To: yukuai@fygo.io
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

=E5=9C=A8 2026/7/9 14:15, Christoph Hellwig =E5=86=99=E9=81=93:
> Maybe we should just move the blkcg allocation back to bio_submit where
> we know we can sleep?

This sounds good, I already switch blkg allocation just before submit_bio()
in some cases in this set.

Just one question, for nowait case, is it correct that we still can't sleep
during submit_bio()? If so, I still need to add nowait special case during
blkg creation. Or I can just return -AGAIN if blkg lookup failed, this is
much simplier.

>
--=20
Thanks,
Kuai

