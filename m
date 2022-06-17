Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5533EC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jun 2022 16:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NQvpbNnhd1Hb0j8v30FPXqT+MFqFElEXEqSS6ck3brY=; b=k6SNh9+RITKxDLJH+FjDhu6d91
	OmcVjl548STncFKSW+yzlIN0fMejR43skJIkBBavyWpy0kfadwEX+5EGATqVYJ56TTvXqmq8rTO/D
	cpUUVTP6+aeEXqCz53MaVetBxO7r1cnGHFu36OONlioDeTmtUb1DUJGAj9eThI1I3qrY8KoaX51Wz
	NjKVTJiDlq6aiRmhERbtwpn8oZ5zzpL5KpxFXZLBddQV92fUeOAZ9BieGLYVsmCU2N7gJ9S+ePE6U
	+MBG13W1YTRiH+1ZZN73jvDca6Ld5N3G7AL6r2aBbcOMgCvipVwS7b2PerHRHWw0Asdx78m8EFp/j
	QNSYJ3lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2FG0-008L17-Pv; Fri, 17 Jun 2022 16:55:40 +0000
Received: from mail-pj1-f41.google.com ([209.85.216.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2FFx-008L0j-UN
	for linux-nvme@lists.infradead.org; Fri, 17 Jun 2022 16:55:39 +0000
Received: by mail-pj1-f41.google.com with SMTP id x1-20020a17090abc8100b001ec7f8a51f5so1078065pjr.0
        for <linux-nvme@lists.infradead.org>; Fri, 17 Jun 2022 09:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NQvpbNnhd1Hb0j8v30FPXqT+MFqFElEXEqSS6ck3brY=;
        b=OGGz51G8/58F0MVqfP6LZVQC/UY2cttsNuto4l5gB9dzvDVAFmWVNJJbiKv4dFcBRH
         VqNS2ie2wBESrY9mCjWVIVpvB4s/QFn3CECWx/Dh4K/Phdo3T8TjycxJgUiQErFMtkFw
         ZRhd3TSk6XHBlaX2x5Fqf747K/Wfwz8gZ2m2gEzFvy5IBzDX5yeAZcFkqsNnS9jgUBLQ
         n6IF3BHb9fzL1ZTNWOdietZk3D9cAHpvtwXlVQGsIAzjVBD5sw56k8GKZy8VXJtTMoa+
         qqe9QMY1yeuMboB68+mcFD91S4ZpWxi7GkJyog5IOBa0h5wSX5xfK1ckFU1E5e6WVVAS
         Uf5w==
X-Gm-Message-State: AJIora9uOr9/RYMyK5yllxE26MkiwPQHabfa9c8oiIrusN7u1mjF6YBJ
	OARtxshIcVo+lPe0M0p67pg=
X-Google-Smtp-Source: AGRyM1uVwwnPkhP6RYNzI5TunYKnnEx27Gq+Jz+noCToEfYq5XweGJSbPYfjWq1VJ+qXOBF2dFKLpw==
X-Received: by 2002:a17:90a:784f:b0:1ea:fa7d:7013 with SMTP id y15-20020a17090a784f00b001eafa7d7013mr7943869pjl.222.1655484936639;
        Fri, 17 Jun 2022 09:55:36 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:5d24:3188:b21f:5671? ([2620:15c:211:201:5d24:3188:b21f:5671])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902820100b001690b65b2absm3014083pln.175.2022.06.17.09.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 09:55:35 -0700 (PDT)
Message-ID: <c6a0eb8d-ad51-01b1-bc17-758acc37f216@acm.org>
Date: Fri, 17 Jun 2022 09:55:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 5/5] blk-mq: Drop 'reserved' member of busy_tag_iter_fn
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, axboe@kernel.dk,
 damien.lemoal@opensource.wdc.com, hch@lst.de, jejb@linux.ibm.com,
 martin.petersen@oracle.com, hare@suse.de, satishkh@cisco.com,
 sebaddel@cisco.com, kartilak@cisco.com
Cc: linux-rdma@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 nbd@other.debian.org
References: <1655463320-241202-1-git-send-email-john.garry@huawei.com>
 <1655463320-241202-6-git-send-email-john.garry@huawei.com>
 <017cae1e-b45f-04fd-d34c-22ae736b28e5@acm.org>
 <a18fa379-5a9b-ff45-3be4-b253efd96a50@huawei.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <a18fa379-5a9b-ff45-3be4-b253efd96a50@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220617_095538_015420_E7C2A62D 
X-CRM114-Status: GOOD (  13.52  )
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

On 6/17/22 09:42, John Garry wrote:
> On 17/06/2022 17:33, Bart Van Assche wrote:
>> On 6/17/22 03:55, John Garry wrote:
>>> @@ -276,7 +275,7 @@ static bool bt_iter(struct sbitmap *bitmap, 
>>> unsigned int bitnr, void *data)
>>>       else
>>>           tags = hctx->tags;
>>> -    if (!reserved)
>>> +    if (!iter_data->reserved)
>>>           bitnr += tags->nr_reserved_tags;
>>>       /*
>>>        * We can hit rq == NULL here, because the tagging functions
>>
>> Is the above change really necessary?
> 
> It's not totally necessary. Since local variable 'reserved' would now 
> only be used once I thought it was better to get rid of it.
> 
> I can keep it if you really think that is better.

I'd prefer that these changes are either left out or that these are 
moved into a separate patch. I think that will make this patch series 
easier to review.

Thanks,

Bart.

