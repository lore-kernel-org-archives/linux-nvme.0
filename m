Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C339EC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 02:21:48 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BD6261132
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 02:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD6261132
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bmzbNzsLhpn08oJ3Odd7rT2BoCr3xGU8UMYU80laDkY=; b=VCuQMkrQvEyUJhJbq12ZsPkv5
	qkL/Uy62geWaTzJm4W8WsXwx+AGyIUCiK1JVdmKRJ2q8Fzm99BNhdbA3lBNTYR7dLZ0ky5ut6dKg4
	v0VYlUIwm/Yp9kpEeiYVwyKcg8A+aE8DOCwE5/fRHk3bhOmF3EWFpezCSVv4TAqMK0dqbbVDnL47q
	eIVB5RTuU8OESxP5DWT9r2DF5wFbJ0pNm40kBPat+Fn650wZBVqya4XwcRQ1AVp6oTyRT1g1RGTHJ
	0OtbmQHY3MCywYySGhC2n8elLuammmux8fzbLVOZXxX8mGCB8kKarxh9dzlvYocd4Od0EaVrS9ZFO
	yeZzi8P+A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgeV7-001lr0-0Q; Wed, 12 May 2021 02:21:29 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgeV3-001lqd-JK
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 02:21:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=daaDmlZfNtYf87e9KKZ0tzPnbye9JR8o5YOaGDdi4mk=; b=0IvJoHZSclnBoXLKW0IU22e21F
 qdx3U/zdgiQR2F+g7HQ/YU29NKuzLFTQ8cOnrdYnAcHsdwGLna4xSSK9NOya7xbfF5STtPN64D+s3
 UIjiHNzwPouHndOiqQvupZgR7R0XRFTWWdRjCkW3EttxckbEy4rDSxPX4+DRpDCDxSWPie/bSDhBC
 rpGMXrz/n5VGjxCadNQ8Far8ZtSryf/5kH5GMAIV2rY33K7r987GYViML9zxTKe2ybH34QFGPrSar
 QFXTGKURiMkN7QnNlqyb+lZ+21GYaLD1JGQ7UHI8wiuiqKQ/YqPsHDLaaZzw6dJGZUziEdWaoDQhS
 J9VBCnaQ==;
Received: from mail-pf1-f171.google.com ([209.85.210.171])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgeV0-00A381-Jx
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 02:21:24 +0000
Received: by mail-pf1-f171.google.com with SMTP id k19so17470564pfu.5
 for <linux-nvme@lists.infradead.org>; Tue, 11 May 2021 19:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=daaDmlZfNtYf87e9KKZ0tzPnbye9JR8o5YOaGDdi4mk=;
 b=nk/77c1D68HF3zft6uLkCGwnZjekI3DkqdW0We6lHxEoy7nKkl3haveNZjQ7eNaHrt
 naws6VFqTEEGf2fyK+flQ0/1s2EWlFryPIu8Olhk64hcOnFDf93dkuJ6N9A223m55Qrg
 rNvuSYWt3ZBMIfo8/8xu4xvG95eU/3JAH3Y9Z9g9bc1uP1hvVHWzd8IORKWD31cZUePb
 a6DGd6K7NXAyY8blqPfi4O5uHV7ruzLR6g3JRvfQOccGXQdVLoPT9nX9DkLi3dBStjs4
 r7FiKy7bD9n1mrLFqQuSYk2YUSjotM9n2bPDqOsBFCETdhKpqU0mBhfh7WOgKD2aFWGn
 32bg==
X-Gm-Message-State: AOAM530Ux8/2sbun9JA8iJ1W+IdFlHGLz+cVEP0dYMZMxVi8YmhA/7AM
 +q7qd8J9iEUJq1glAnRhDEI=
X-Google-Smtp-Source: ABdhPJxg29un7hemzeM5RTmLf4VW113rEN7QX/F07mMfJ5zwt/qmJ20P8JnH+74H64FqIu6d5/qcuA==
X-Received: by 2002:aa7:8e85:0:b029:28f:2620:957e with SMTP id
 a5-20020aa78e850000b029028f2620957emr33862188pfr.40.1620786080715; 
 Tue, 11 May 2021 19:21:20 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:76b9:3c77:17e3:3073?
 ([2601:647:4000:d7:76b9:3c77:17e3:3073])
 by smtp.gmail.com with ESMTPSA id w74sm14613953pfc.173.2021.05.11.19.21.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 May 2021 19:21:18 -0700 (PDT)
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "msnitzer@redhat.com" <msnitzer@redhat.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "roland@purestorage.com" <roland@purestorage.com>,
 "mpatocka@redhat.com" <mpatocka@redhat.com>, "hare@suse.de" <hare@suse.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "rwheeler@redhat.com" <rwheeler@redhat.com>, "hch@lst.de" <hch@lst.de>,
 "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
 "zach.brown@ni.com" <zach.brown@ni.com>, "osandov@fb.com" <osandov@fb.com>
References: <BYAPR04MB49652C4B75E38F3716F3C06386539@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <4b8985f1-8a94-d611-e9fb-1b5e32a19f1e@acm.org>
Date: Tue, 11 May 2021 19:21:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49652C4B75E38F3716F3C06386539@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210511_192122_685293_5340C5DF 
X-CRM114-Status: GOOD (  14.65  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/10/21 5:15 PM, Chaitanya Kulkarni wrote:
> * What we will discuss in the proposed session ?
> -----------------------------------------------------------------------
> 
> I'd like to propose a session to go over this topic to understand :-
> 
> 1. What are the blockers for Copy Offload implementation ?
> 2. Discussion about having a file system interface.
> 3. Discussion about having right system call for user-space.
> 4. What is the right way to move this work forward ?
> 5. How can we help to contribute and move this work forward ?

Are there any blockers left? My understanding is that what is needed is
to implement what has been proposed recently
(https://lore.kernel.org/linux-nvme/yq1blf3smcl.fsf@ca-mkp.ca.oracle.com/).
Anyway, I'm interested to attend the conversation about this topic.

Thanks,

Bart.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
