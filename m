Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71FDC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Oct 2022 06:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GFGmeXwzImdz1h+PmMN1s24FBEmejNYEC+q1xWfXEck=; b=gj4ObeCPbBI1aCzJ1/mc7S8Jyu
	upqiav1XrEQ7rM6BaeQD5czLbFv/sE8yasizs+y9lOakYQiIQQmpF+p/QOV4Iwrsj7DcS/xlO0gVT
	V5HmfxkR79r1n2mghxCuBOp8p/8tfe3YYI4tU+iH+4+S1ZYpIsj94jynH9ju2GlrT+TDL5/Tibwkq
	lomc0ZpAd5AUzD9eWsvoEdZs/6K4wZekNwUPnPiAOTx97CvDYmV+L09w4dTMd5rU+QduR4r6WDioc
	B+Eg0X8zrlOKH25l15nbOztbt06tcngyUNJYuwcg7h9YWpcCc4CO92M6BpazcAECJVxnjqPK89Osj
	bMzPfF9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogKMP-0009CA-6G; Thu, 06 Oct 2022 06:27:57 +0000
Received: from mail-pg1-f169.google.com ([209.85.215.169])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1og7f3-00FL9w-Ec; Wed, 05 Oct 2022 16:54:22 +0000
Received: by mail-pg1-f169.google.com with SMTP id a23so8027631pgi.10;
        Wed, 05 Oct 2022 09:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=GFGmeXwzImdz1h+PmMN1s24FBEmejNYEC+q1xWfXEck=;
        b=tf7IjhkoZWeUhGUdrkuy7LpzTDnpCmThu2vU/01YH7kaXYenAc45A7LZm6LfxnmVI7
         rV1E+nLDr6XmApbOpA5UkZ6K2HfLMPOMIoBCI9gRdLbWCjhbNSXdT+YoLW6lxXRLbkww
         mtR1pJnu8yOGeYp4nPy0MhzRcT5xQptOcKib5QWPYB6G+Mx+D5iN9PAhYY/UH6vnl3x9
         cmlxLEMkY7g8YmGnsss2GfEuaz+mDMw3ukBR+qh58psA9DdD5wzNKMlga7W5mIxGcyx7
         5yW4tAQ3UfhSPtFMSKyNNkiYpFiUt/kxKbJuSwfxqlBXlofzhEU5kDTQN4JcCDM85Yd0
         ArNQ==
X-Gm-Message-State: ACrzQf1LPPpnrdvKLYIU3Jp7CRNLh/2at7+QXVB/H3JHdpCbVZlc95Do
	MgTxoR+FNTOTAFwpJmsAA6s=
X-Google-Smtp-Source: AMsMyM5oX6qSPQ4HG3bu8E8hjU3lPQSUd8WrMcNcjR4MljBf6naYCl5wsAAwQMON9m5RMKfn4/SRMQ==
X-Received: by 2002:a62:2985:0:b0:544:77d4:f43b with SMTP id p127-20020a622985000000b0054477d4f43bmr726456pfp.9.1664988858370;
        Wed, 05 Oct 2022 09:54:18 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id j16-20020a170902da9000b00176c6738d13sm10795484plx.169.2022.10.05.09.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 09:54:17 -0700 (PDT)
Message-ID: <e0ea0b0a-5077-de37-046f-62902aca93b6@acm.org>
Date: Wed, 5 Oct 2022 09:54:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH 01/21] block: add and use init tagset helper
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-nvme@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, axboe@kernel.dk,
 efremov@linux.com, josef@toxicpanda.com, idryomov@gmail.com,
 dongsheng.yang@easystack.cn, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
 mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 stefanha@redhat.com, ohad@wizery.com, andersson@kernel.org,
 baolin.wang@linux.alibaba.com, richard@nod.at, miquel.raynal@bootlin.com,
 vigneshr@ti.com, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, sth@linux.ibm.com,
 hoeppner@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 jejb@linux.ibm.com, martin.petersen@oracle.com, hare@suse.de,
 bhelgaas@google.com, john.garry@huawei.com, mcgrof@kernel.org,
 christophe.jaillet@wanadoo.fr, vaibhavgupta40@gmail.com,
 wsa+renesas@sang-engineering.com, johannes.thumshirn@wdc.com,
 ming.lei@redhat.com, shinichiro.kawasaki@wdc.com, vincent.fu@samsung.com,
 christoph.boehmwalder@linbit.com, joel@jms.id.au,
 vincent.whitchurch@axis.com, nbd@other.debian.org,
 ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 asahi@lists.linux.dev
References: <20221005032257.80681-1-kch@nvidia.com>
 <20221005032257.80681-2-kch@nvidia.com>
 <6fee2d7a-7fd1-73ee-2911-87a4ed3e8769@opensource.wdc.com>
 <CAPDyKFpBpiydQn+=24CqtaH_qa3tQfN2gQSiUrHCjnLSuy4=Kg@mail.gmail.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAPDyKFpBpiydQn+=24CqtaH_qa3tQfN2gQSiUrHCjnLSuy4=Kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221005_095421_520481_47E2F615 
X-CRM114-Status: GOOD (  15.66  )
X-Mailman-Approved-At: Wed, 05 Oct 2022 23:27:55 -0700
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

On 10/5/22 02:47, Ulf Hansson wrote:
> On Wed, 5 Oct 2022 at 07:11, Damien Le Moal <damien.lemoal@opensource.wdc.com> wrote:
>> On 10/5/22 12:22, Chaitanya Kulkarni wrote:
>>> +void blk_mq_init_tag_set(struct blk_mq_tag_set *set,
>>> +             const struct blk_mq_ops *ops, unsigned int nr_hw_queues,
>>> +             unsigned int queue_depth, unsigned int cmd_size, int numa_node,
>>> +             unsigned int timeout, unsigned int flags, void *driver_data)
>>
>> That is an awful lot of arguments... I would be tempted to say pack all
>> these into a struct but then that would kind of negate this patchset goal.
>> Using a function with that many arguments will be error prone, and hard to
>> review... Not a fan.
> 
> I completely agree.
> 
> But there is also another problem going down this route. If/when we
> realize that there is another parameter needed in the blk_mq_tag_set.
> Today that's quite easy to add (assuming the parameter can be
> optional), without changing the blk_mq_init_tag_set() interface.

Hi Chaitanya,

Please consider to drop the entire patch series. In addition to the 
disadvantages mentioned above I'd like to mention the following 
disadvantages:
* Replacing named member assignments with positional arguments in a
   function call makes code harder to read and harder to verify.
* This patch series makes tree-wide changes without improving the code
   in a substantial way.

Thanks,

Bart.


