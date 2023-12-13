Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFDAC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 12:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yoh5xf5R5WsNaHWUCNlxFWK1jHxo3EP3Yy2iVTvMAhw=; b=zMwCh7FEWNiLdXafpkVZytmsAn
	gzdqLf74hmWALj1ao03ovnL3dP5Y45hGRSI3eVQ99BWcQARzSNrjQKz7MJKoTWJb80P4cT5bV4VNb
	fV7b7FHMVu/mWTbpIyzefcPdlkWTwAbV/ChX24tdeLaxPRkPBZdC8yo4mWbYgCiGsQboG5eNosS20
	SUCYsMOZwHaR06QQRmfmXZJ0HLue6Q0W843TOtTD1qrjQ1QJjYVPrLhZGUmmiFAyidSn2TD/RdWR4
	xiATueR+X4wxcCMTEKiEPBS5dvWoVHmiI0ttORpc+A8PkvQkkFYwPfpi9dtaKOj+OnfO9wJGbZqKS
	UWfLqLZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDOpt-00EiDt-2U;
	Wed, 13 Dec 2023 12:59:37 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDOpq-00EiDL-2S
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 12:59:36 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VyR9v6D_1702472367;
Received: from 30.178.83.96(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VyR9v6D_1702472367)
          by smtp.aliyun-inc.com;
          Wed, 13 Dec 2023 20:59:28 +0800
Message-ID: <1db09834-5cbe-4e27-938d-8ba4d50347d0@linux.alibaba.com>
Date: Wed, 13 Dec 2023 20:59:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] nvmet: relocate the cntlid_ida to the internal of
 subsystem
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
References: <1702449172-8920-1-git-send-email-kanie@linux.alibaba.com>
 <1702449172-8920-5-git-send-email-kanie@linux.alibaba.com>
 <20231213084649.GE6184@lst.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20231213084649.GE6184@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_045934_997025_CE69AD30 
X-CRM114-Status: UNSURE (   8.64  )
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


在 2023/12/13 16:46, Christoph Hellwig 写道:
> On Wed, Dec 13, 2023 at 02:32:51PM +0800, Guixin Liu wrote:
>> As per the NVMe specification, the cntlid must be unique within an NVM
>> subsystem. Therefore, the cntlid_ida should be moved internally within
>> the subsystem.
> Sagi added this with a commit log of:
>
> "
> nvmet: Make cntlid globally unique
>      
> We usually log the cntlid which is confusing in case
> we have multiple subsystems each with it's own cntlid ida.
> Instead make cntlid ida globally unique and log the initial
> association.
> "
>
> which seems reasonable.  If you have a reason for not making it unique,
> it needs to be stated here so we can weight it against the original
> reason for making the ids globally unique.

Emm, I just change this per the NVMe spec, Sagi's comment is reasonable.


