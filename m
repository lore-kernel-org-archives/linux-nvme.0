Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903B8C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Nov 2022 10:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:CC:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lFIE649+Mm8C6grmmrzY9H1UQTZTuRm+6ZQLOCtZE2Y=; b=ifDBek7S4INmMe3m076Qc/TrOi
	nsMpYhimbrp80fVpAPmA4FxlxszLdppWIGRg/1Xc+GmQtLYvu3QwcvO/GCFE7ChgPngALvfICbtZg
	RUXSZijP1pQ/DyaXFRouQ41ULXETDjxKr42NmuOdf2Jz3mxlI4+720rUtp2AxoUtPCE4cnf/vGSVu
	rin7gpPhEblPQ3QKPUa5i9zrPqrK8UI7Y5ynzhfj8ROInAgymS9pw8KKjIrFQJP3+G9nFgrVbPn+F
	veIFQDzTRuyACFZS5c16daIW7dzY2JUg59cblp6PWAwGbdEMBWWW0/FlZyK2JaP1Vl9ZlkJFZJ6AP
	RNrBFN1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ot4ir-0051ji-6G; Thu, 10 Nov 2022 10:23:49 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ot4in-0051gi-EC
	for linux-nvme@lists.infradead.org; Thu, 10 Nov 2022 10:23:47 +0000
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N7Hwh751bzmVfc;
	Thu, 10 Nov 2022 18:23:16 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 18:23:31 +0800
Received: from [10.174.179.247] (10.174.179.247) by
 dggpeml500003.china.huawei.com (7.185.36.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 18:23:31 +0800
Message-ID: <144969fe-3764-d5eb-587a-79c4fd195076@huawei.com>
Date: Thu, 10 Nov 2022 18:23:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
To: <kbusch@fb.com>
CC: <linux-nvme@lists.infradead.org>, <yi.zhang@huawei.com>,
	<chengzhihao1@huawei.com>
From: "linan (AK)" <linan122@huawei.com>
Subject: question about CVE-2022-3169
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.247]
X-ClientProxiedBy: dggpeml500009.china.huawei.com (7.185.36.209) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221110_022345_691348_455C4620 
X-CRM114-Status: UNSURE (   2.82  )
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
1e866afd4bcd("nvme: ensure subsystem reset is single threaded")
fixed CVE-2022-3169.

IIUC, ERROR path I got in this CVE:
            CPU1                                CPU2
nvme_dev_ioctl                            nvme_dev_ioctl
   nvme_reset_ctrl_sync                      nvme_reset_subsystem
       reset_work
         nvme_reset_work
           nvme_setup_io_queues
             nvme_remap_bar(dev, size)
               if (size <= dev->bar_mapped_size)
                 return 0;
               iounmap
                                               reg_write32   //error
               ioremap

In nvme_remap_bar(), the premise of ioremap is "size > 
dev->bar_mapped_size".
   size = NVME_REG_DBS + ((nr_io_queues + 1) * 8 * dev->db_stride);
     1)nr_io_queue = dev->nr_allocated_queues - 1, Onece set to
"nvme_max_io_queues(dev) + 1" during probe time, it could not change.
     2)db_stride is doorbell stride, it didn't change during my test
Therefore, I cant find a way to make iounmap happen.

Could you tell me how you trigger the ERROR?

Thanks,
Nan.

