Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0DDC433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Dec 2021 09:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+p5rJk+NPvtgdZGqp2mY9BsNO8UwiIiXXFNVBztxEs0=; b=1m+v0EiUOjL+tVZvm8sucDRR3I
	+rOR/soETJ0EOPo4/ZF9ekwb8JFDXWWmjFmcle2lZf11t1EnJpcndfMeIAHb88ZpkrjITFWZjdFYd
	XUQO4CKs+WSegtkPe2XFabJIobDsAvGOMYUlIhbwYdMBpQwolu+YcO+nlyEdXRS+p3mT7r7/NpL+Q
	idnD+cQrpAD+TufJIH3WBcIqKyFvfoWCuoWP2T2TNg8BnZKBSWbTuVeRbi9387XqpSKkoJylqg2JA
	R3L7FfQv7frJAgfOvs8LFZDhdUUaZyIVawI09BLiGrzut8zxzRdchDzpjhXA2VKBu7oWI65ZrMEBM
	NCluK0Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1muAWs-003CBf-CL; Mon, 06 Dec 2021 09:43:26 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1muAWp-003CBF-RD
 for linux-nvme@lists.infradead.org; Mon, 06 Dec 2021 09:43:25 +0000
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J6z4h2pCnzcbm5;
 Mon,  6 Dec 2021 17:43:00 +0800 (CST)
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 17:43:10 +0800
Subject: Re: [PATCH] nvme-multipath: zeroing ana_log_size as well after free
 ana_log_buf
To: Christoph Hellwig <hch@lst.de>
CC: <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
 <jiangtao62@huawei.com>
References: <20211203114715.1936811-1-houtao1@huawei.com>
 <20211206075347.GA10917@lst.de>
From: Hou Tao <houtao1@huawei.com>
Message-ID: <16960197-643f-1e3b-65d4-913cee871cf2@huawei.com>
Date: Mon, 6 Dec 2021 17:43:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20211206075347.GA10917@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211206_014324_108514_FE29DEB5 
X-CRM114-Status: UNSURE (   6.61  )
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

Hi,

On 12/6/2021 3:53 PM, Christoph Hellwig wrote:
>>  	if (ana_log_size > ctrl->ana_log_size) {
>>  		nvme_mpath_stop(ctrl);
>> -		kfree(ctrl->ana_log_buf);
>> +		nvme_mpath_uninit(ctrl);
> This hunk looks unrelated.
It will be related if the value of ana_log_size is reduced again, so you mean
the reduction is impossible ?

> .


