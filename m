Return-Path: <SRS0=n325=NQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190AEC4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Aug 2021 08:27:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3A1361222
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Aug 2021 08:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D3A1361222
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d8ZxYtBWvVplmx//m4IZn2l5RY840j3HM579g0eUt+8=; b=FBhuOMY538GXi7
	P6wayW31ml7P3X0nPWEU0QFDDkOIrW8wslALbbpUeI8NC2dvU1EWlWkig2Er/CDPXLertrYKOXzOj
	o2ittCaKRTI9CRHUgpUiw61D53xMRuGcVsrwTdfl9dAKRSxQmSqs1TLu/368vbrSON91eIY5dGQu4
	8Hx3qGhipGOFTvSWR6Q7KiO9LHTPnEewR6HRJTSjDLcYFZepARvr5IRzI+xXhf1P5zJ5pZeaiY2x5
	n3NKYjXMxasMXgY6cQ9fzGhJW3fhYS6tLe5frrEijJ/4IreGgm3bcRkJNzoq+nxRyzB3h+k8nuVdw
	Hl7KJkwsZuB9DG3XnQIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mIoEx-005v7R-26; Wed, 25 Aug 2021 08:26:31 +0000
Received: from mo-csw1515.securemx.jp ([210.130.202.154]
 helo=mo-csw.securemx.jp)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mIoEt-005v5q-6l
 for linux-nvme@lists.infradead.org; Wed, 25 Aug 2021 08:26:28 +0000
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 17P8Q6qo007365;
 Wed, 25 Aug 2021 17:26:06 +0900
X-Iguazu-Qid: 34trdvrI6vzHvSyZzn
X-Iguazu-QSIG: v=2; s=0; t=1629879965; q=34trdvrI6vzHvSyZzn;
 m=WoRiB9Flbt8BP4+3OyJxp3/Bi6CQzfmha+qyqhldvUA=
Received: from CNN1EMTA03.test.kioxia.com ([202.248.33.144])
 by relay.securemx.jp (mx-mr1510) id 17P8Q4cs021625;
 Wed, 25 Aug 2021 17:26:04 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
 by CNN1EMTA03.test.kioxia.com (Postfix) with ESMTP id 7C1E631B1F;
 Wed, 25 Aug 2021 17:26:04 +0900 (JST)
Received: from CNN1ESTR04.kioxia.com (localhost [127.0.0.1])
 by Switcher-Post_Send (Postfix) with ESMTP id 709B3190579710;
 Wed, 25 Aug 2021 17:22:41 +0900 (JST)
Received: from localhost [127.0.0.1] 
 by CNN1ESTR04.kioxia.com with ESMTP id 0003TAAAAAA0271F;
 Wed, 25 Aug 2021 17:22:41 +0900
Received: from CNN1EXMB03.r1.kioxia.com (CNN1EXMB03.r1.kioxia.com
 [10.232.20.152])
 by Switcher-Pre_Send (Postfix) with ESMTP id 65A1DA00617EA;
 Wed, 25 Aug 2021 17:22:41 +0900 (JST)
Received: from CNN1EXMB02.r1.kioxia.com (10.232.20.151) by
 CNN1EXMB03.r1.kioxia.com (10.232.20.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 25 Aug 2021 17:26:03 +0900
Received: from CNN1EXMB02.r1.kioxia.com ([10.13.100.21]) by
 CNN1EXMB02.r1.kioxia.com ([10.13.100.21]) with mapi id 15.01.2242.010; Wed,
 25 Aug 2021 17:26:03 +0900
From: sasaki tatsuya <tatsuya6.sasaki@kioxia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "kbusch@kernel.org" <kbusch@kernel.org>, 
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] nvme: update keep alive interval when kato is modified
Thread-Topic: [PATCH v2] nvme: update keep alive interval when kato is modified
Thread-Index: AdeYqq0GYCdtylBoR8GOhZA2v9EjoAAMlYwAACq71yA=
Date: Wed, 25 Aug 2021 08:26:03 +0000
Message-ID: <ad3ea07be9174fb68c06c516192bf05e@kioxia.com>
References: <526a1a756d6c4643b15b1b305cc32817@kioxia.com>
 <05033836-83b9-c060-0348-774a02b60d01@grimberg.me>
In-Reply-To: <05033836-83b9-c060-0348-774a02b60d01@grimberg.me>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.211.44.200]
x-tm-as-product-ver: ISME-14.0.0.2080-8.5.1020-26364.007
x-tm-as-result: No-10--3.456500-8.000000
x-tmase-matchedrid: 6E41RGmUyPrUL3YCMmnG4h3Pziq4eLUfPknazlXMVpVYC5LPd7BvbbLs
 vs6J0rHdqH/x4QEYOK+w49/KRoE2DmJY9i/8SxOHrZZaiLezul0L8TGleseLPHls69bzQG/gjUQ
 jwBaLDpQVgI0fS7eHxWFV3cuPc/KP9bPHgjnnomBwju9EALAXQiIk3dpe5X+h7FgZhHZ4fUTzPv
 RcNNSOxtwDtnxW7PKIhVaMx/vKxVShmj3mg7kbBW/6CCblACLhTFQnI+epPIYRQQ4kFqjjJAtBe
 8tVCKUeoi+ZsUmcLQSzaFs1abK0x5soi2XrUn/JIq95DjCZh0zOjM6qu6GAtwfSeK1uwILztO9r
 zDWbK3wqtq5d3cxkNffvWahKfRU4ZJrYsGIvodVf/Sgxp6O06oaDRBK+cuxquIenSbtVLhWeNA7
 blM9Pflr0nVq8TX+O5MhWtwfCk2x9s5ZA7ZT2jkei6YdY6OruPJXcPkgxEwmbYLZwudds349pbp
 RrbisdIMW4USIcKqueqD9WtJkSIw==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--3.456500-8.000000
x-tmase-version: ISME-14.0.0.2080-8.5.1020-26364.007
x-tm-snts-smtp: F0A5A65516F857071B5E67CE998DA067AF24CBAAC98F78215503956817D67AA52000:8
MIME-Version: 1.0
X-CrossPremisesHeadersFilteredBySendConnector: CNN1EXMB03.r1.kioxia.com
X-OrganizationHeadersPreserved: CNN1EXMB03.r1.kioxia.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210825_012627_507034_B586A5EC 
X-CRM114-Status: UNSURE (   9.75  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/25/21 5:42 AM JST, Sagi Grimberg wrote:
> > +	if (cmd->opcode == nvme_admin_set_features &&
> > +	    (cmd->cdw10 & 0xFF) == NVME_FEAT_KATO) {
> > +		/* ms -> s */
> 
> no need for this comment.

Thanks for your comments. I will remove this /* ms -> s*/ comment.

> > +		unsigned int new_kato = DIV_ROUND_UP(cmd->cdw11, 1000);
> > +
> > +		nvme_update_keep_alive(ctrl, new_kato);
> 
> I think you can now inline nvme_update_keep_alive here, no need to keep
> it in a function.

Does this mean the section below needs to be moved from core routine
to nvme_user_cmd_post function?
> > +	dev_info(ctrl->device,
> > +		 "keep alive commands interval on the host is updated from %u ms to %u ms\n",
> > +		 ctrl->kato * 1000 / 2, new_kato * 1000 / 2);
> > +
> > +	nvme_stop_keep_alive(ctrl);
> > +	ctrl->kato = new_kato;
> > +	nvme_start_keep_alive(ctrl);

Thanks.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
