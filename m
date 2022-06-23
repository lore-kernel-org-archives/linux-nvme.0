Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F79C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jun 2022 13:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CSfPRsek6TY0ETOoUksAgDlvP5eJ2iNIFz8xmTeCdD8=; b=w+bMObbw3KpLtyHLeqi25ta5jO
	pmVsxxDf2y/e0JkkdBOMJ/bVjBgcWZSCnCaHF5SBQukbYGlK305J9rBzgskOFy5MvpdHkQ3/jqNJl
	Oj3jJ1S4IJz2JoDEo8j6r2ktU+A32ppxqxLVEn9JJs5/p7V1EAD/vYXpTxUIPB0Jfg4Pxr0Az1Vhh
	8tCdltjqB07nzbLxb935oKpelUEbR6oj9bXth/Od8RggrMayMepAKCAlVVQSFaWas1Fe2eA5d0gdA
	GaxtJW41B5OuTJYWQOMG+NHD/OYHij4zeycqWGwPQMR0Oraqp0fqyrNYGlK/+rC5gV7urE04Rov5F
	JEaK+qCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4MdD-00FHiQ-Et; Thu, 23 Jun 2022 13:12:23 +0000
Received: from mail-pj1-f50.google.com ([209.85.216.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4Md5-00FHe5-C2
	for linux-nvme@lists.infradead.org; Thu, 23 Jun 2022 13:12:16 +0000
Received: by mail-pj1-f50.google.com with SMTP id f16so17405862pjj.1
        for <linux-nvme@lists.infradead.org>; Thu, 23 Jun 2022 06:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CSfPRsek6TY0ETOoUksAgDlvP5eJ2iNIFz8xmTeCdD8=;
        b=nO3nlNgdKf5teNMa9m0/psAYs36YLXv4DwiI+BHqvw4c9hKI9RXY5UwVoZtk6KSVTB
         DpIZXjEAg0wsxZHInnWXslN3Dl1E4+oKDpxu7t3GvGF6LEJgibGhjWQztPpOCCCwJ9TS
         6FlPkXEWvTKOtsiJuH09GBoMeU/Gf8D/CVFNXZBhJTwu3Ut/LSYl8liwp49LI/3oJ3t5
         PIaEa0n/0Rwa0/+YrREaL1kJlGX2Lix9asZnHAaDdB2dtSNNO4ZsBs2zSfy1DHGzQJuw
         hRJTQ6tGtQWHB1LtsGeeefy+0zzYrjF0eBwvlNueOX05SSi65x/ndZqWZh5wtIIVIakA
         +eDw==
X-Gm-Message-State: AJIora+CdBxA6N/zYHfuLI9HlolfyOKQARy2v9dWwBLGgHgsTJsGCPef
	CFqFG/7vaAA17iSR82cFOf0=
X-Google-Smtp-Source: AGRyM1tYEwNFwAtN9BR7ToQECHxeTpniI+ubUdkmlhs5UOA+4VbnyarnXYp4aWf6C5UR5DIsVBXrjw==
X-Received: by 2002:a17:903:234c:b0:16a:4d9d:ed09 with SMTP id c12-20020a170903234c00b0016a4d9ded09mr6999802plh.120.1655989933067;
        Thu, 23 Jun 2022 06:12:13 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id w15-20020a170902a70f00b0016a106cb221sm3694381plq.243.2022.06.23.06.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 06:12:12 -0700 (PDT)
Message-ID: <2a124ef2-d46a-0888-0ba9-4890f3581c81@acm.org>
Date: Thu, 23 Jun 2022 06:12:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 5/6] blk-mq: Drop 'reserved' arg of busy_tag_iter_fn
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, axboe@kernel.dk,
 damien.lemoal@opensource.wdc.com, hch@lst.de, jejb@linux.ibm.com,
 martin.petersen@oracle.com, hare@suse.de, satishkh@cisco.com,
 sebaddel@cisco.com, kartilak@cisco.com
Cc: linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
 mpi3mr-linuxdrv.pdl@broadcom.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, nbd@other.debian.org
References: <1655810143-67784-1-git-send-email-john.garry@huawei.com>
 <1655810143-67784-6-git-send-email-john.garry@huawei.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1655810143-67784-6-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220623_061215_453163_B897152E 
X-CRM114-Status: UNSURE (   7.58  )
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

On 6/21/22 04:15, John Garry wrote:
> We no longer use the 'reserved' arg in busy_tag_iter_fn for any iter
> function so it may be dropped.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

