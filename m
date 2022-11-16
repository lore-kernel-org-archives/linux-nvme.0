Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C782BC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 06:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BasQHCTc+Q4Xmx/0JwPxVSA8eu1OBOSvP9Z0czyrSVs=; b=wunp7BdHLNufwye1dJwl9B42n6
	Opps22ueIDy9YvOyD461xEbA7OPxXXyRRETdRpo26W0Y1TQtN5nkd6bMCGJs6dNAln2IdzVZWxaWY
	TLn91nlyKUV+ysnBW8oK5zhAAxqnCOQR5/JL12AHGpLAnrQbr5FEJ9TwV9aHFqf3rMvg8maZSX4EO
	ZHBBhai22OQd27FEIXvD91g6R8ofasrN1HUGNsBkT9zsJYUTu0NkW6b7gqUrSNCRPEQUvla/RbhcB
	amriSbPSNQL3qNngbd3Ivv4vFsfduMa8HBHv+tAsyncDbY4/HjuDhiPBfjWHkIe6wSAG7qIzXe/M1
	OZt0xGPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovCNg-000ORH-7r; Wed, 16 Nov 2022 06:58:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovCNd-000OQI-VH
	for linux-nvme@lists.infradead.org; Wed, 16 Nov 2022 06:58:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5652168AA6; Wed, 16 Nov 2022 07:58:38 +0100 (CET)
Date: Wed, 16 Nov 2022 07:58:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Aleksandr Miloserdov <a.miloserdov@yadro.com>,
	Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org, linux@yadro.com,
	Konstantin Shelekhin <k.shelekhin@yadro.com>,
	Dmitriy Bogdanov <d.bogdanov@yadro.com>
Subject: Re: [PATCH v2 1/2] nvmet: expose IEEE OUI to configfs
Message-ID: <20221116065838.GA19952@lst.de>
References: <20221115115810.75848-1-a.miloserdov@yadro.com> <20221115115810.75848-2-a.miloserdov@yadro.com> <1243d214-e399-237f-e70d-bb4541a66b28@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1243d214-e399-237f-e70d-bb4541a66b28@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_225842_166923_018DBD8B 
X-CRM114-Status: GOOD (  13.59  )
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

On Tue, Nov 15, 2022 at 04:05:14PM +0200, Sagi Grimberg wrote:
>> index c8a061ce3ee5..48a2f587f38a 100644
>> --- a/drivers/nvme/target/admin-cmd.c
>> +++ b/drivers/nvme/target/admin-cmd.c
>> @@ -372,6 +372,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
>>   	memcpy_and_pad(id->fr, sizeof(id->fr),
>>   		       UTS_RELEASE, strlen(UTS_RELEASE), ' ');
>>   +	put_unaligned_le24(subsys->ieee_oui, id->ieee);
>> +
>
> Any particular reason why it is placed here and not where the comment
> was?

Keeping the ID assignment together seems pretty reasonable to me.

