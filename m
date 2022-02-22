Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A53C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 17:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lv/yzp2qU/iWN/bZP2mooidjpfWHSN5m7ETfy5Uq9fA=; b=aoW43D8l3jYp6dxPR3PvltMtZI
	qQ8erNLlJuizdUhdy2fPjcwsia5BK6pvmolkn2hkoGpO9YibebsuRkt/+7c4WfE7yz1OveefLtY/n
	ykeN71askOMxr50+cGAcREgc357F2g4LfuiaU3lorSvSC369U8Ek9101pC3d7G/mPAryKeaf2IIwa
	q39NSr4vYiG9bOa4PmMAu/a5cKM+h7FK7uwgkgq5JO3qM9fNRl6HDlA20uEO0cMYS1zTF2jrV1kBo
	3zEC/zp/c9GnARJYOH8j1gPAWvIlzZAqoYMCeDbFPmUQQmJtdpKA/4HlsApKQlxqDAslEawfl2mS6
	NGwsW4Rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMYwB-00Ayyl-2b; Tue, 22 Feb 2022 17:26:55 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMYo3-00AvsI-N0
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 17:18:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 93D5168AFE; Tue, 22 Feb 2022 18:18:26 +0100 (CET)
Date: Tue, 22 Feb 2022 18:18:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Varun Prakash <varun@chelsio.com>, hch@lst.de, kbusch@kernel.org,
 Ran.Anner@dell.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4] nvme-tcp: send H2CData PDUs based on MAXH2CDATA
Message-ID: <20220222171826.GA15042@lst.de>
References: <1642870664-3401-1-git-send-email-varun@chelsio.com>
 <23ddf451-2540-86c2-c403-2614477c130f@grimberg.me>
 <98f61e6a-5bc2-788a-a0e0-557001adcf51@grimberg.me>
 <337cec23-c9ee-1cfb-89fc-e6aec649623c@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <337cec23-c9ee-1cfb-89fc-e6aec649623c@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_091831_952336_6D560C2D 
X-CRM114-Status: GOOD (  14.58  )
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

On Sun, Feb 20, 2022 at 03:05:18PM +0200, Sagi Grimberg wrote:
>
>>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>>
>> Let's wait with this for a moment..
>>
>> Keith,
>> Is it possible that you guys take this for a test run?
>> This is the area that exposed a few issues in the past
>> working against your target device...
>>
>> Ran, maybe you can run it against your target as well?
>>
>> Would love to get your tested-by/acked-by tags.
>
> I think we can move forward with this patch. If this turns
> out to cause any issues we can address those as they come...

Is this a Reviewed-by?

