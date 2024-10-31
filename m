Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8020E68948
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 02:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a/Bvy5cNdiOoQ6MDzVoroSisFiV0mFEWAnAK7DA1qU8=; b=mLrV43nZCHInX2X8Q9B/BpeMgo
	TwNO1jpO5+Hbq4MCPmWTzy8J9kpY8INOEPxasnpHMTvu9uooLx2ApBTR27reb2SHWwG04hgkIFGjZ
	Xkqz7iJA4w6KdsKbDpAK6ccKajGoUdcDz7dOrISj/900K2Vpz5QM4XK+diW0jF+NygKjjcn314Yis
	fsi4pXnWyP8Nfkx00loGOtknlCtmI3gE7Bnzr+9LObulr55O7cfH13W0F5kgWydlsmMIz8W+oMD+M
	ssbTiAxAFxF2wnTfIeXlgAd+wq0gsBBqq2qFS7nsC08mT3d9AiSSwg2eojZMIJk+UcVVe9Ml+810y
	aZMvRwCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6L5S-00000002Mjg-3kKv;
	Thu, 31 Oct 2024 02:39:02 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6L4J-00000002Mbj-1V6E
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 02:37:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730342269; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=a/Bvy5cNdiOoQ6MDzVoroSisFiV0mFEWAnAK7DA1qU8=;
	b=VMsrmNhP5e9ChMp2s3c7DySGrH4h0m8DLsURWj8zPTZwzkoTy79QdQDfxJgb/bSf73eTu1AztssMrYmJso3845eMtC7z8mFTSGi/4UyN5sbaXJp68Uq+QrEA84Zvvh43riEJr8VhI9dNy4nSP6cnR/yef4csdby3+1awu1iObeg=
Received: from 30.178.82.44(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIGanD._1730342267 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Oct 2024 10:37:48 +0800
Message-ID: <7539e263-76ed-4c54-91ee-f6ff1a5304a3@linux.alibaba.com>
Date: Thu, 31 Oct 2024 10:37:46 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nvmetcli: fix double ana groupid when save config
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de, sagi@grimberg.me, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20241029034312.15083-1-kanie@linux.alibaba.com>
In-Reply-To: <20241029034312.15083-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_193751_584412_7E621DB9 
X-CRM114-Status: GOOD (  11.14  )
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

gentle ping...

Best Regards,

Guixin Liu

在 2024/10/29 11:43, Guixin Liu 写道:
> There are two ana grpid in json file after save the config,
> including ana group: "ana":{"grpid"}, and "ana_grpid", remove one,
> still one can use both of them to set ana_grpid.
>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   nvmet/nvme.py | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/nvmet/nvme.py b/nvmet/nvme.py
> index 59efdb5..41b4845 100644
> --- a/nvmet/nvme.py
> +++ b/nvmet/nvme.py
> @@ -626,7 +626,6 @@ class Namespace(CFSNode):
>       def dump(self):
>           d = super(Namespace, self).dump()
>           d['nsid'] = self.nsid
> -        d['ana_grpid'] = self.grpid
>           return d
>   
>   

