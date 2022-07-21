Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FC5C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 22:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yMhGUzKhO4q8vsmNjx8vSM3P6eQxLqlaQgZs81EVo2k=; b=Wg1FvVHspR/gZfz6+FBI/7br6D
	LhGuMzgFYrGCidgMgsRGdwcm4y0ndCRltAxbN9OLhnuSICOoqYYGUFo49+OixavSmxcixofGfYPVB
	AaV+ogGCf8+dS/pvKuJatCyuSi+TxwVVXNuCsyuz/xK8rFyi7og5f6tlyyF4LfoUdyt3lzlbd3Lhz
	GTw76www7Zr3YdB6HH0xlsuhnI08V+OkhiaGMagjQr66Lg4H7zafQ1XQ8vJFBGwz4LGDSw8frpzsQ
	KaEpR7WtgawhdbD4pOUfp2wTGd669Ey+7l3SKaLxUmq2kq00bEHL1kJTtpE5QB0wB8wfIggTnb1ML
	a0ICjdcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEeQJ-00CiZu-QS; Thu, 21 Jul 2022 22:13:35 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEeQG-00CiUg-Tw
	for linux-nvme@lists.infradead.org; Thu, 21 Jul 2022 22:13:34 +0000
Received: by mail-wr1-f52.google.com with SMTP id bv24so4159507wrb.3
        for <linux-nvme@lists.infradead.org>; Thu, 21 Jul 2022 15:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yMhGUzKhO4q8vsmNjx8vSM3P6eQxLqlaQgZs81EVo2k=;
        b=dBWKLzM0vZXrL48JlwjoavfxaHrcBQtCFBFe6AMb1U6Q3o5OVY2MM3mwHreYCtW31+
         RGHM+QZgLqRGtJeuqLCWjm2RjVASmcpl5HoMTn6qcLT+jTGEjDEYRQweQzl7CHGF9y+2
         8xoUuqUMl2CskUAkWi7I+wNPP43v723l0HUOV6hzsTq3ayfgwso784nBXLtB6UT9Wsyu
         a0XzaZHcI1x6TFk3NNDGapgiiSGU22mJdSEh+x7WtGMME98b29SdyvdZ/ccocsTaY2FQ
         vrq+PfFrLxOO2F9buV8guuf+fDrQGXoDPoM7FBLWGoWbbgUpxuGGVgPyt7AMbCza/lDI
         ZqPA==
X-Gm-Message-State: AJIora9bjXngmbmJBV7jo6oVp1nm1I2XbCICBD/J0rWRK8m8TtXgV4aL
	taltFsjDJt2RvvhZwRaPAJQ=
X-Google-Smtp-Source: AGRyM1s096zYWMouXG2MBn6K7buWggSH142QGu8Z+nP/LJxCKlDFtw+pvq1YzN9ac1kobWXNg/ukeg==
X-Received: by 2002:a05:6000:187:b0:21e:43b4:f5ed with SMTP id p7-20020a056000018700b0021e43b4f5edmr331405wrx.81.1658441608654;
        Thu, 21 Jul 2022 15:13:28 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c248500b003a3279b9037sm6563617wms.16.2022.07.21.15.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 15:13:28 -0700 (PDT)
Message-ID: <bd233bf9-d554-89cc-4498-c15a45fe860b@grimberg.me>
Date: Fri, 22 Jul 2022 01:13:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [bug report] blktests nvme/tcp triggered WARNING at
 kernel/workqueue.c:2628 check_flush_dependency+0x110/0x14c
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Yi Zhang <yi.zhang@redhat.com>, linux-block
 <linux-block@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <CAHj4cs86Dm577NK-C+bW6=+mv2V3KOpQCG0Vg6xZrSGzNijX4g@mail.gmail.com>
 <5ce566fd-f871-48dc-1cb7-30b745c58f05@grimberg.me>
 <YteeHq8TJBncRvZu@infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <YteeHq8TJBncRvZu@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220721_151332_996759_711A30EA 
X-CRM114-Status: GOOD (  11.78  )
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


>>> Hello
>>>
>>> I reproduced this issue on the linux-block/for-next, pls help check
>>> it, feel free to let me know if you need info/test, thanks.
>>
>>
>> These reports are making me tired... Should we just remove
>> MEM_RECLAIM from all nvme/nvmet workqueues are be done with
>> it?
>>
>> The only downside is that nvme reset/error-recovery will
>> also be susceptible for low-memory situation...
> 
> We can't just do that.  We need to sort out the dependency chains
> properly.

The problem is that nvme_wq is MEM_RECLAIM, and nvme_tcp_wq is
for the socket threads, that does not need to be MEM_RECLAIM workqueue.
But reset/error-recovery that take place on nvme_wq, stop nvme-tcp
queues, and that must involve flushing queue->io_work in order to
fence concurrent execution.

So what is the solution? make nvme_tcp_wq MEM_RECLAIM?

