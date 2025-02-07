Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5CAC02194
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Feb 2025 12:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UFEsJuMiEtCLw1bPRoGAmz+moheXvuQMR5Uhhz75UsA=; b=GRICjdC5uksB0b6KM/olI+t0AS
	GEWmWhqMk8tVflw0DZRbCKZrfAwnzNCsDSZfsNk2+OOPNgBUOu81MygDBbOwqgWmxHecDz7g1MFaX
	vW9I4NF2U1azSxrYVcFwK6rh8keOBaaiTuy/p4jYU8802GvMGLwWCPs2mKD4piKed6JovmGRyAPcg
	xfxYvxJQNM2wtzfgrnkkKDYLLltGM2blsPHdLfnZSA/pp3Qn2NeFgPVhXPXY+s3fhHQ0PR7ilJO9y
	Qf1kIdji0jc39PZrqqODfcLqh7x7mL24hnfZ2IfsmP1m6P19mV4JMPfcg+cr+ydpDNOhYbwh51OJl
	gaw2mCng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgNQ0-00000009VGA-2uq9;
	Fri, 07 Feb 2025 12:25:12 +0000
Received: from dggsgout11.his.huawei.com ([45.249.212.51])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgNPO-00000009V7Q-34B5
	for linux-nvme@lists.infradead.org;
	Fri, 07 Feb 2025 12:24:36 +0000
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YqCnf2C28z4f3lDF
	for <linux-nvme@lists.infradead.org>; Fri,  7 Feb 2025 20:24:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CCB6D1A07B6
	for <linux-nvme@lists.infradead.org>; Fri,  7 Feb 2025 20:24:28 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP1 (Coremail) with SMTP id cCh0CgAHbHx7+6VnRtaCDA--.12125S3;
	Fri, 07 Feb 2025 20:24:28 +0800 (CST)
Message-ID: <7fd947c4-7939-4ccd-8868-3fa419571a78@huaweicloud.com>
Date: Fri, 7 Feb 2025 20:24:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/8] nvme: set BLK_FEAT_WRITE_ZEROES_UNMAP if
 device supports DEAC bit
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, djwong@kernel.org,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
 yangerkun@huawei.com
References: <20250115114637.2705887-1-yi.zhang@huaweicloud.com>
 <20250115114637.2705887-3-yi.zhang@huaweicloud.com>
 <20250128064623.GB21401@lst.de>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250128064623.GB21401@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgAHbHx7+6VnRtaCDA--.12125S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYV7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UQzVbUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250207_042434_936499_089F0B8B 
X-CRM114-Status: UNSURE (   9.07  )
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

On 2025/1/28 14:46, Christoph Hellwig wrote:
> I think you also need to add BLK_FEAT_WRITE_ZEROES_UNMAP to the list
> of features supported by the nvme-mpath stacking driver in
> nvme_mpath_alloc_disk, so that this gets propagated to multipathed
> devices.
> 
> Otherwise this looks good to me.

Ha, thanks for pointing this out, I missed this case, will add.

Thanks,
Yi.


