Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC42C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 22:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5X5xVWc1nkDEIZdla3XpRNW/bQySQD0uGStRSZKwtGE=; b=rEsHygEcUsTbHads9Jk8NiL7pV
	KwKIQh48aXu9iKXtQtcPFb+9IJYop1r9lh4pDPt5d8eiMWoJXvzUyacKPJB85IfQtT8CTDLXLVHqn
	2InEbdh3zHNU0qycdPgpfTD1y9XG9PKZMsWK4KOpFEQvXtCAuQQ8dR4pmw3pRpK76KmpQ60tz9sV0
	CRCWJeUUhHg7iyeGzjzHxP565oXvYzch1qpj+QrLac2n4XBx54c8LlhNMx6Hp64+AgN3MQuJv3cfH
	Yjx9FvgTrZB7t1TmXuBECr0Mk9Y593gI5Cr2fKt1sGpsNGDdPBlomt2bLfdphNsjFGGTFdJsVzQUq
	re6Op07A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSR72-00EBtC-Vm; Thu, 10 Mar 2022 22:18:25 +0000
Received: from mail-pj1-f51.google.com ([209.85.216.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSR70-00EBsc-9b
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 22:18:23 +0000
Received: by mail-pj1-f51.google.com with SMTP id
 mg21-20020a17090b371500b001bef9e4657cso9503316pjb.0
 for <linux-nvme@lists.infradead.org>; Thu, 10 Mar 2022 14:18:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=5X5xVWc1nkDEIZdla3XpRNW/bQySQD0uGStRSZKwtGE=;
 b=02icHR255yBSArooWBsLBaIhGyV4vgM2BxNJKc9RzlOBkuwwP6hfZuNHNUYG0AIkSd
 /V2QUvPnfnzkBVSUS0qjrhQ8W0hB5BZM/xWsj+Z5AWDXm9TKXIcct9iwJJcLNiIEs3QM
 kDYZPwFfiktravodqpL6mFQrhgwFGe7P6V/b7A7RZfiCW3Vm4l58eRaH3Ht39o27ynOf
 u60M2oITNcGUIsNcPtzx+kVJl2zeew4sJaV24evptgBgGu/UWxZgRohV4h2jQDI4NkNP
 eQI/1bPlp1fcMcY/loK5vbcHwROeJEvpPlW0pJPy4w+duO74qWaLMPx8WA+dqfnLzbNI
 C+sA==
X-Gm-Message-State: AOAM530RrrsBpGU8RVC66j99woSsQkt5vZWUI1fgwXH9G/4M+uwL+zp5
 DPG09kOvNCYRurHIMUD08W4=
X-Google-Smtp-Source: ABdhPJy62zhEbGvei3QmnuKG1X3fqXb+LD/edNZIPKgqnhwAVLyBG86WPVpfaMOVxXBkkDzB2GptKQ==
X-Received: by 2002:a17:902:f646:b0:151:d5b1:cbb4 with SMTP id
 m6-20020a170902f64600b00151d5b1cbb4mr7207735plg.150.1646950701430; 
 Thu, 10 Mar 2022 14:18:21 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:8b4d:7ed7:9546:30d2?
 ([2620:15c:211:201:8b4d:7ed7:9546:30d2])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a056a0015c500b004f76735be68sm5366491pfu.216.2022.03.10.14.18.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Mar 2022 14:18:21 -0800 (PST)
Message-ID: <9d645cf0-1685-437a-23e4-b2a01553bba5@acm.org>
Date: Thu, 10 Mar 2022 14:18:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Content-Language: en-US
To: "Bean Huo (beanhuo)" <beanhuo@micron.com>, Jens Axboe <axboe@kernel.dk>,
 "Luca Porzio (lporzio)" <lporzio@micron.com>,
 Manjong Lee <mj0123.lee@samsung.com>,
 "david@fromorbit.com" <david@fromorbit.com>
Cc: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "song@kernel.org" <song@kernel.org>,
 "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
 "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
 "nanich.lee@samsung.com" <nanich.lee@samsung.com>,
 "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
 "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>,
 "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
 "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220306231727.GP3927073@dread.disaster.area>
 <CGME20220309042324epcas1p111312e20f4429dc3a17172458284a923@epcas1p1.samsung.com>
 <20220309133119.6915-1-mj0123.lee@samsung.com>
 <CO3PR08MB797524ACBF04B861D48AF612DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <e98948ae-1709-32ef-e1e4-063be38609b1@kernel.dk>
 <CO3PR08MB797562AAE72BC201EB951C6CDC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <d477c7bf-f3a7-ccca-5472-f9cbb05b83c1@kernel.dk>
 <c27a5ec3-f683-d2a7-d5e7-fd54d2baa278@acm.org>
 <PH0PR08MB7889642784B2E1FC1799A828DB0B9@PH0PR08MB7889.namprd08.prod.outlook.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <PH0PR08MB7889642784B2E1FC1799A828DB0B9@PH0PR08MB7889.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_141822_360327_DBA6149A 
X-CRM114-Status: GOOD (  17.37  )
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

On 3/10/22 13:52, Bean Huo (beanhuo) wrote:
> Yes, in upstream linux and upstream android, there is no such code. But as we know,
> mobile customers have used bio->bi_write_hint in their products for years. And the
> group ID is set according to bio->bi_write_hint before passing the CDB to UFS.
> 
> 
> 	lrbp = &hba->lrb[tag];
>   
>                WARN_ON(lrbp->cmd);
>               + if(cmd->cmnd[0] == WRITE_10)
>                +{
>                  +             cmd->cmnd[6] = (0x1f& cmd->request->bio->bi_write_hint);
>                +}
>                lrbp->cmd = cmd;
>                lrbp->sense_bufflen = UFS_SENSE_SIZE;
>                lrbp->sense_buffer = cmd->sense_buffer;
> 
> I don't know why they don't push these changes to the community, maybe
> it's because changes across the file system and block layers are unacceptable to the
> block layer and FS. but for sure we should now warn them to push to the
> community as soon as possible.

Thanks Bean for having shared this information. I think the above code sets the GROUP
NUMBER information in the WRITE(10) command and also that the following text from the
UFS specification applies to that information:
<quote>
GROUP NUMBER: Notifies the Target device that the data linked to a ContextID:
  -----------------------------------------------------------------------------------------
     GROUP NUMBER Value     |  Function
  -----------------------------------------------------------------------------------------
  00000b                    | Default, no Context ID is associated with the read operation.
  00001b to 01111b (0XXXXb) | Context ID. (XXXX I from 0001b to 1111b ‐ Context ID value)
  10000b                    | Data has System Data characteristics
  10001b to 11111b          | Reserved
  -----------------------------------------------------------------------------------------

In case the GROUP NUMBER is set to a reserved value, the operation shall fail and a status
response of CHECK CONDITION will be returned along with the sense key set to ILLEGAL REQUEST.
</quote>

Since there is a desire to remove the write hint information from struct bio, is there
any other information the "system data characteristics" information can be derived from?
How about e.g. deriving that information from request flags like REQ_SYNC, REQ_META and/or
REQ_IDLE?

Thanks,

Bart.

