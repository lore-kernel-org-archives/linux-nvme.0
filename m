Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E913CEDD89
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 13:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DEfoN8Vn3gmKHWlf0jh4UtY6eytWKRkiu28dZUV0LI0=; b=n5zMr03lsK/MeQDIJXJOvY0WMe
	ZRyB3XXNCwqjcSe5VUrS0PwgzyXr/YUtxIl3UAf3wIlxmcnup3bffa0QjUaj7xcZ5VO/IPVm90BY4
	Cevws3lVq54ui30vI+ym7GbvjleNPxzLtkrNVyGO4ATNTI6i/dy3ll20oJMT2LC+eNbkLrXDJJips
	kcpmH0PF7Jtd5TmZfEG/OAZES2hW8FKLXtT+Pcp6yVsKd/nuI9G9mjPNSthgEwhnveI2qqHzOw0BQ
	T0mg4oFfq9mWtYxJSILXPRjxmtVqqZeCcmG5c9N8JmUtj76J0vzzx0i/V5rjwZ79un9/xeTd668EZ
	JKu58p1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syWju-00000009PAy-2zGw;
	Wed, 09 Oct 2024 13:28:30 +0000
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syWjr-00000009PAP-1hX8
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 13:28:29 +0000
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CD74E114019F;
	Wed,  9 Oct 2024 09:28:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 09 Oct 2024 09:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bjorling.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728480505;
	 x=1728566905; bh=DEfoN8Vn3gmKHWlf0jh4UtY6eytWKRkiu28dZUV0LI0=; b=
	wsPmPxs0s6gTPHrlXfQc1eQeI4BrR/8uGFItw4DIw3VqnIkjr9XIYQbO1Hks6dMh
	wItValAlhayMnjPT/FNsP0KCSaxugGmgIoSpNyZUxNHAtbAClR/b3jb2KZQFNuev
	0yg4rZCBSLXPoKpRahnewIBk7oxZhW+qbg7L6855Jbdii04jsdsZeylFuMODUeNW
	wSU43qWIQ2uN5jhKxHAXnozWyKfhvH39uZiz5H/OTnYJqNTn7iQxoqzdKEDQbyG7
	e+WkoAWk3xUxIH157xzM3RiL64tmKiF/ccpetIxmA6HlRpV6XAnxjJUT8pwNkC+o
	PfBJUUSS2KizFfwMs2cS/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728480505; x=
	1728566905; bh=DEfoN8Vn3gmKHWlf0jh4UtY6eytWKRkiu28dZUV0LI0=; b=o
	lThgFVld3jvKdHZY9P9MoSIC1ygT2EEaczAeT1MMOHuK7LZsq2bk8IG4i87dSScE
	rr3tJQQX9rnmAR79uKQ9SaETE5Mhe/k1qAmV1ItmAwdTrH8a+emZtaZuUkPM+2hC
	5pFT5KaxpjvTqNvh6cXsJ+9iVIRlnsErLVppU23kLScqWMt5w7du3dJGw7jY6KqW
	8jyxV+qvnW0zay4b8uIFGgq7AucWJmY8GbX0GMgnLRDIec8d7qJxE/ooO/Rx7sJ0
	xeq5XzLTu4fKwXBo60Q+mP/ntJEHOOAnRbkUcMP0WnOO4hWF4gRH5BV3L8tdMB1O
	9Jj/idStEyb1Kn0MzPwZA==
X-ME-Sender: <xms:-YQGZ3ITmXcXRdtzzB5I4VKvV4etPw-7_r2glJogLHg6J5VmOTtaQA>
    <xme:-YQGZ7LPs4TFIphLqyAry5QLrkZ7Q8e4iYjPIbpcsFv2-orm6BRtl143ZdZQyQZ-8
    K4yJa7b-Rsv10GDTzs>
X-ME-Received: <xmr:-YQGZ_uyodg_3YvfXy2hD-j9Poq2voqTps1deTywDMADxUIeLfP7RiB3OtcPGNaNAt8757yb-UayGTBJ64Ph-3nZC23mug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpeforghtihgrshcuuehjpphrlhhinhhguceomhessghjohhrlhhinhhgrd
    hmvgeqnecuggftrfgrthhtvghrnhepkeefieeutddvteeguedthedvudfggfevgeevkeeg
    geefkeeufffffeelleevgefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepmhessghjohhrlhhinhhgrdhmvgdpnhgspghrtghpthhtohepledp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgthheslhhsthdruggvpdhrtghpth
    htohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegulhgvmhhorghl
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtrghsshgvlheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqnhhvmhgvsehlihhsthhsrdhinhhfrhgruggvrggu
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqsghlohgtkhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehmrghtihgrshdrsghjohhrlhhinhhgseifuggtrdgtoh
    hmpdhrtghpthhtohepfigrnhhghihughhuihesvgduiedqthgvtghhrdgtohhm
X-ME-Proxy: <xmx:-YQGZwYj7nGupr9G0G8JVWdMfl07SzgAtu2vbv6r9Lxs5W8GbPMSYg>
    <xmx:-YQGZ-YRqC92MmW1vo5ZQ196lZCaPgcXYToO3VqRZkiCiK0x--r_Ug>
    <xmx:-YQGZ0Dfkr85R9YTygdWV6j7RNU7u2HSUo52zqewQngr0Ub-6tUecw>
    <xmx:-YQGZ8Yfukd98v_cdpN8KphHB4oHKvVLB6yMoBOGS7S6yMKy50XAhg>
    <xmx:-YQGZ0kRigUFIhSJAyohh2qeNwYINoIdsGWCxX6oftCxUf-IVBrZL-cH>
Feedback-ID: if4314918:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 09:28:04 -0400 (EDT)
Message-ID: <c6e03246-57aa-41c5-90b9-261c6d6a14d1@bjorling.me>
Date: Wed, 9 Oct 2024 15:27:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nvme: add rotational support
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, dlemoal@kernel.org, cassel@kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Matias_Bj=C3=B8rling?=
 <matias.bjorling@wdc.com>, Wang Yugui <wangyugui@e16-tech.com>
References: <20241008145503.987195-1-m@bjorling.me>
 <20241009074355.GA16181@lst.de>
Content-Language: en-US
From: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>
In-Reply-To: <20241009074355.GA16181@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_062827_537599_41B5E87B 
X-CRM114-Status: GOOD (  10.98  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 09-10-2024 09:43, Christoph Hellwig wrote:
> On Tue, Oct 08, 2024 at 04:55:01PM +0200, Matias Bjørling wrote:
>> From: Matias Bjørling <matias.bjorling@wdc.com>
>>
>> Enable support for NVMe devices that identifies as rotational.
>>
>> Thanks to Keith, Damien, and Niklas for their feedback on the patchset.
> 
> Hmm, the only previous version I've seen was the the RFCs from
> Wang Yugui, last seen in August.
> 
> What the improvement over that version?  Note that it also came
> with basic nvmet support which is kinda nice.

Ah, I made the patches without awareness of the earlier efforts.

This version, together with Keith's nvmet patch, does not rely on 
setting/checking the CRIMS flag.

