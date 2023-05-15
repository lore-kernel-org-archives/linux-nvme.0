Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A23C77B7F
	for <linux-nvme@archiver.kernel.org>; Mon, 15 May 2023 01:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C8Sb3vyP/J4FXcnGUsX7YWCW6o9zL05B5CI6oC5hKhk=; b=4AGoaSL6RUPbNN0l2MzaNvRM3q
	a4XBBXav8yJKRMGBvedLdTLekKDFaeVV4JuoRID3xoSb1Q7xxynDBMUfwuFdizm4oNIOP3F/aaNyG
	TNRqI7DYlLITPKX504lAMGKBmHomhLd3CQ8vJWjfRCQUhcMkFucTX09XHI/3w2Y36PUctJJdnG1ZE
	BSEWa45Me2clNcvTG3ESd0DlQaK8kgG0stqk1GAlpeds052tLYBlaZOt0ARaOMOIG/YKRSx9cvNqq
	cTbxI0B+4Cuj1h4+U6qd3FjMJdPGhJvIuBocGFF+PmuXctiaMQfqrDAHk9+nrRpJ1VxZtoMScq/IV
	5r3ytvXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyNFa-000br1-2o;
	Mon, 15 May 2023 01:43:46 +0000
Received: from [45.249.212.56] (helo=dggsgout12.his.huawei.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyNFW-000bpK-2p
	for linux-nvme@lists.infradead.org;
	Mon, 15 May 2023 01:43:44 +0000
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QKMb137pGz4f3lwf
	for <linux-nvme@lists.infradead.org>; Mon, 15 May 2023 09:43:25 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP3 (Coremail) with SMTP id _Ch0CgBH9CE9jmFkXtnYIg--.28848S3;
	Mon, 15 May 2023 09:43:27 +0800 (CST)
Subject: Re: [RFC PATCH] block: add meaningful macro for flush op flags
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Christoph Hellwig <hch@lst.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "colyli@suse.de" <colyli@suse.de>,
 "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>,
 "agk@redhat.com" <agk@redhat.com>, "snitzer@kernel.org"
 <snitzer@kernel.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "song@kernel.org" <song@kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20230512080757.387523-1-kch@nvidia.com>
 <20230512130042.GA29078@lst.de>
 <67376534-ac4a-3cd9-fab6-fd3a062f5e48@nvidia.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <2ca38f24-6c6f-4975-fcc8-e700c67029ee@huaweicloud.com>
Date: Mon, 15 May 2023 09:43:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <67376534-ac4a-3cd9-fab6-fd3a062f5e48@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgBH9CE9jmFkXtnYIg--.28848S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYI7kC6x804xWl14x267AKxVW5JVWrJwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
	3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230514_184343_128144_4E7EAC31 
X-CRM114-Status: GOOD (  10.73  )
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

Hi,

在 2023/05/13 9:09, Chaitanya Kulkarni 写道:
> On 5/12/23 06:00, Christoph Hellwig wrote:
>> Hell no.  This is just obsfucation.  We can look into actually exposing
>> REQ_OP_FLUSH at the bio level, but not something like this.
>>
> 
> and that's why I made it RFC, thanks for the can you please elaborate
> on "exposing REQ_OP_FLUSH at the bio level" ?

I think Christoph means that use this flag directly for bio, it's only
used for reqeust for now.

Thanks,
Kuai
> 
> I'd really like work that ...
> 
> -ck
> 
> 


