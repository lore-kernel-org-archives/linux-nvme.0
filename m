Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8156C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Apr 2022 06:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XyuSFhco7KR1FU+ph3gdEIfwPDiWT/hsNZKPYOwR+C4=; b=LohmzwxAfEsZJnTarnIEYNcTJQ
	5WO/Y2dEQvJ3gK38/iSyFWjFyvywuxFaLV5HaGuj8Tj/lvmZOgBthMQ9Mt05AWide815252Sdj+pO
	ZAWmaAvnCB1y2x4DMrwrGP+GqELCVkgCvK4uNFFbHVHuM+AQAgr0UmF6La2xZNx17rmaYfwXTACDF
	G2AFAL6TBatQALvreCklMtCaIjPXFhb6CarAkai4RXNruyHdV9JMUr7Yeg/W0KF9VqqnTH3broCdY
	pZRjlDXaDIubOyJjGf/zFUqB91Xw75E5rePaRNoAUPeCxpVs+jjornaslg3L5Oacl1ZGChKslQSNV
	2VOJqu3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neA6u-00Bt8P-2z; Tue, 12 Apr 2022 06:34:44 +0000
Received: from mail-m118207.qiye.163.com ([115.236.118.207])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neA6q-00Bt52-M6
 for linux-nvme@lists.infradead.org; Tue, 12 Apr 2022 06:34:43 +0000
Received: from [192.168.1.164] (unknown [218.106.117.245])
 by mail-m118207.qiye.163.com (HMail) with ESMTPA id C9309900C9E;
 Tue, 12 Apr 2022 14:34:35 +0800 (CST)
Message-ID: <5581018c-0d24-abf1-fe91-d073e6b36ae1@kingtous.cn>
Date: Tue, 12 Apr 2022 14:34:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] fix: nvme_update_ns_info method should be called even if
 nvme_ms_ids_equal return false
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 axboe@fb.com, sagi@grimberg.me, kingtous <kingtous@qq.com>
References: <20220408080721.GA2888@lst.de>
 <YlBSO/vH7DjE6kC9@kbusch-mbp.dhcp.thefacebook.com>
 <20220408160424.GB27746@lst.de>
 <21ac620f-d234-13a1-0de7-e3ec1b3272db@kingtous.cn>
 <20220409044351.GA17212@lst.de>
 <33f34253-4418-e16a-89fb-92257749cf3f@kingtous.cn>
 <20220411054945.GA14311@lst.de>
 <dc6e8c8c-7eaf-f502-207c-4907ce58a474@kingtous.cn>
 <20220411060746.GA14519@lst.de>
 <2c504d2e-5c64-72fb-c26b-e086588ecd8d@kingtous.cn>
 <20220412050441.GA5311@lst.de>
From: =?UTF-8?B?6YeR6Z+s?= <me@kingtous.cn>
In-Reply-To: <20220412050441.GA5311@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
 kWDxoPAgseWUFZKDYvK1lXWShZQU83V1ktWUFJV1kPCRoVCBIfWUFZQx1MSVZKGEsaTB8YHU5NSk
 lVAhYTFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PjI6Kzo4PzlKKE0qPzQ3GR8K
 MiEaCy9VSlVKTU9CTE9OSUxNSk9OVTMWGhIXVRYeOxASFRwPFA4IVRgVRVlXWRILWUFZSUpDVUpL
 TVVKSkxVSU9OWVdZCAFZQUlDSUM3Bg++
X-HM-Tid: 0a801c7b2c312d29kusnc9309900c9e
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220411_233440_939702_8A00EB69 
X-CRM114-Status: GOOD (  11.21  )
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

Yes, the issue also exists on Gloway Basic NVMe SSD("MAXIO MAP1002") and 
I can reproduce it every time when I trigger a suspend action.

WD SN550 has no suspend issue on my laptop, where the NVMe controller is 
not "MAXIO MAP1002/1202".

在 2022/4/12 13:04, Christoph Hellwig 写道:
> On Mon, Apr 11, 2022 at 10:20:13PM +0800, 金韬 wrote:
>> btw, I checked the patch code, I noticed "MAXIO MAP1202" is hard coded in
>> pci.c. I think not only MAP1202 has the problem mentioned in this thread,
>> but also "MAXIO MAP1002"(Gloway Basic 1T NVMe SSD, which has the same
>> suspend issue).
> 
> If you can verify it has the issue we can add a quirk for it as well.
> 

