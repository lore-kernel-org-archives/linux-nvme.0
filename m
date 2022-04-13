Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DEEC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 22:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2cwsdqpMLrDBBUFhHc5jfg8idgOuulANohdziKdAHQQ=; b=VNBypaqv5ESR+iih/SRgIBWWVQ
	Uic8YSSAVVL8t6VdGTzYdsDQOeS7Wpw6J+GBtUHPg2M2NGfz2LiXF48iTqHP4vTyJSGCu5EHyGHyS
	La6ieQfZgTPXHZULhn7Pcg/qZfzjNbQwXQMxtJmap7u8wjeK1NpFUBnHkpxf/PwP5p37GuGqxqIzi
	QstQNMBpKCorLB+g4EZ/hj5Jbt2bfxLQaTdq+zhxNtx5g1cR4kant806Fw96LBOaxMjcrUA4LIbkO
	pFpY5qKILWK5YkmB7HUtpCdtptZaMN780RQce7EBWR5FjUcosXrZUkR5E05XcEjPmVFdO8VjkZHob
	PwkAPehw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nelkl-002zwb-2V; Wed, 13 Apr 2022 22:46:23 +0000
Received: from mail-pj1-f52.google.com ([209.85.216.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nelki-002zum-A9
 for linux-nvme@lists.infradead.org; Wed, 13 Apr 2022 22:46:21 +0000
Received: by mail-pj1-f52.google.com with SMTP id bg24so3430490pjb.1
 for <linux-nvme@lists.infradead.org>; Wed, 13 Apr 2022 15:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=2cwsdqpMLrDBBUFhHc5jfg8idgOuulANohdziKdAHQQ=;
 b=XLT9IIHtHdYS59+KE/nk6mW4ZxVRUVRzfyXFjfhe+fKlkbuBNkAKrsv3ewVKzt8tfq
 Jfwp27e0jiQNNTTuldbO5kmFe/qKZkYVGbbCGYjwCos8TspcbSDSPS8R3xPQQ0x1EM61
 jQ+ELvDThIpErND5Iaad8gi5Q09oRW/DSyoPyuoLAMfvNMRu2ARZDNUc2wTW9QFNzuuW
 lQQVBUToX9hsau2e6nGSsU8kYzrF0IBj5enQBnL/JwFFGKONjic/6uCWHYRIgifPiJ8E
 z0qYnM/IJ98RP+LsEP5b9NHbrO0FVel1YJGvNamj+rFh5hC754HsE3FtJrFf8GNIcEyM
 S+ig==
X-Gm-Message-State: AOAM531TPxLvLdzVo9oy3bjwc+wAHXytAW04ST3ipnj/Gt+2b6foCY7G
 +UMbp/TfNogiUxXGFPpm1zs=
X-Google-Smtp-Source: ABdhPJyjcwgXoumWQUd7bG00td/RSuBc9Jphv63JwVZmpO6y5RA/dml1VKvJHFdnXVc2BE5Ty7qjXw==
X-Received: by 2002:a17:90a:5409:b0:1ca:8a21:323b with SMTP id
 z9-20020a17090a540900b001ca8a21323bmr1024482pjh.135.1649889978757; 
 Wed, 13 Apr 2022 15:46:18 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:4cb9:acfe:1291:f290?
 ([2620:15c:211:201:4cb9:acfe:1291:f290])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a17090ab28700b001ca9514df81sm82313pjr.45.2022.04.13.15.46.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Apr 2022 15:46:17 -0700 (PDT)
Message-ID: <af030072-d932-5e38-64d6-bfd28152862b@acm.org>
Date: Wed, 13 Apr 2022 15:46:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: can't run nvme-mp blktests
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>
Cc: yi.zhang@redhat.com, sagi@grimberg.me, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
 <YlZXOC4VgmDrUGIP@infradead.org> <YlcKqu3roZQSxZe8@bombadil.infradead.org>
 <YlcLOM49JsdlBqTW@infradead.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <YlcLOM49JsdlBqTW@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220413_154620_395947_CE2472B1 
X-CRM114-Status: GOOD (  15.97  )
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

On 4/13/22 10:41, Christoph Hellwig wrote:
> On Wed, Apr 13, 2022 at 10:38:50AM -0700, Luis Chamberlain wrote:
>> On Tue, Apr 12, 2022 at 09:53:12PM -0700, Christoph Hellwig wrote:
>>> On Tue, Apr 12, 2022 at 05:24:04PM -0700, Luis Chamberlain wrote:
>>>> I do have CONFIG_NVME_MULTIPATH=y but I also have:
>>>
>>> I'd suggest to ignore broken tests that require a deprecated option
>>> that will eventually be removed.
>>
>> CONFIG_NVME_MULTIPATH will eventually be nuked?
> 
> You'll only get a single namespace without it once the phaseout is
> complete, yes.  If you want nvme multipathing you'll need it, which
> is the story since day one.
> 
> If Bart wants to test dm-multipath I think his earlier srp_tests are
> the much better choice.

I'm not sure whether the nvme-mp tests test any code that is not yet tested by
any nvme or srp test. How about removing these tests since these tests make
it harder than necessary to run blktests?

Thanks,

Bart.

