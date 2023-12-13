Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958BBC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 13:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K3JLS9EHJmzWQKOyBQxolWJZXdpahpvj3m9vR+fEhPA=; b=HLkDgpOPWd8TWLpL/2ibIpFVRY
	Z/P958GHnSinf87Lz9fBj9MdZjFE6FhHpXVI1AqFMeCjtKf1rCR9Xf7h5Fw4WpcYA/7/0EviaTxsB
	C40XKbUmGzvaqd09gsNwk3PiDNBmuR66gCl4DUZUm4S84veK5YDUi2nzg7djAThYs82V1F+EyfmCw
	QTQ5K7GlEh/1Hu7TBthZkPB/W3X06zWnTErQy+2KyxC+HyY4VMHVoBKmBzxsvamnRdHeM94SF5G0E
	QgHKNCraS6Cqf1UynoXp7+vSMHTGGulGE8i/lBTvdjVN96bLD8xVAyOisLZh57LF8L8XCt56h9ye0
	Sy9DGMYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDOwC-00Ek2f-0Z;
	Wed, 13 Dec 2023 13:06:08 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDOw8-00Ek0g-1W
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 13:06:06 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VyRBkQo_1702472759;
Received: from 30.178.83.96(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VyRBkQo_1702472759)
          by smtp.aliyun-inc.com;
          Wed, 13 Dec 2023 21:06:00 +0800
Message-ID: <b35be92b-d6a8-43a5-a542-2083f191ccfe@linux.alibaba.com>
Date: Wed, 13 Dec 2023 21:05:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] nvmet: return invalid filed when check fctype fails
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
References: <1702449172-8920-1-git-send-email-kanie@linux.alibaba.com>
 <1702449172-8920-6-git-send-email-kanie@linux.alibaba.com>
 <20231213084835.GF6184@lst.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20231213084835.GF6184@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_050604_661992_E6AA3D0A 
X-CRM114-Status: UNSURE (   6.03  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


在 2023/12/13 16:48, Christoph Hellwig 写道:
> On Wed, Dec 13, 2023 at 02:32:52PM +0800, Guixin Liu wrote:
>> Return invalid filed status code when check fctype fails in
>> nvmet_parse_connect_cmd().
> Hmm, the fabrics command type really is part of the opcode.  What is the
> reason for you to prefer one error over the other?
>
> Also s/filed/field/g or better 'Invalid Field in Command'
Agree, by the way, should return invalid opcode in 
nvmet_rdma_map_sgl_inline() if nvme_is_write() check fails?

