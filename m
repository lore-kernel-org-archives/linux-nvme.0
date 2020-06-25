Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1B4C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:07:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30EC02053B
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QiMyzZp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30EC02053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rUP5wOp1bqqZdvf3AfcJTEX1SqBSQ0fx1GgD1R3HCO4=; b=QiMyzZp4UTvj91QKTVFxKHXdz
	D888ynQRBekHXG3poPfZAfbp9+r0qMUGD8cmKQgRbyY4sdHdQe4VYMK8sgiia19PiJmONFcFuf85u
	b9BYQPJaEHKqIdr8Uja/8rm4Eq3pfbFyHEq6obJ785P+2emyvO0TshUz0X8Kdru9+sgfeuLL2xLeu
	v3BufTRtFIaeAAp/UYDZIgKtqtiORsOvavP+cjc01EkqEV8N3NwsbWL/0fA7NFsUXTdRidkpxF7uC
	OZeXU9dumRr2+wn4V30vqRajejEJdjwX4+UtJE66IIxs3SiHY9NCBcfi6CedwavjTkUxOOyF9VXtJ
	z4cKziGSw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jomCc-00036a-2q; Fri, 26 Jun 2020 11:07:26 +0000
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joknH-0005cF-2G
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 09:37:29 +0000
Received: by mail-yb1-xb41.google.com with SMTP id m16so4177546ybf.4
 for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2020 02:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=naBX3K5K2kkOSnHEKFfy5sY1hjYLBUM1aanVKkFXTPQ=;
 b=h4lzv3oNgZgWH2oHmJeT/SrcY/+ap/9P1wqecZjYWyDquOVWMyGVazpm3oQS+1Prig
 OtY1CqPJ6w8Z0DX3s4WNm86+MOr1Z8z+NTQZYrPfYzSffjG+T52hmke5LeBmAkUP7iU8
 TUudILlJRhNpccuvXCbRMDFrVyOvzQOVbz7MIM1sBRgkx3qbrXEVXN4XzZoKTU4ABjWz
 CstftsCbYNBsWT17GgdCShH76SUUa3eAP28eekqHOK+X71Uujo+uPNkEckqMLhodi1Wd
 C6QBvJ1CgYOyfjlJ+6yx7ajUeA9cFergW6awfeT+AZcmUkinWFDQTZMJ0fdkRwaa8xlw
 Cffw==
X-Gm-Message-State: AOAM5308D5X39hFDeKBZptrFpZkQaf4z6C45Fku2m8sSYEofvvnrwr/T
 LnHVZ4Ikb+fUCX4z+KmuHP0s3eLS
X-Google-Smtp-Source: ABdhPJwiHhL9iMqWKywi8Ra7xt7wjzvVzcDrDaHgXqdAKGyYNp7cajQ5EgmdgUPmS50ENMSk7XG5Yg==
X-Received: by 2002:a9d:7e8d:: with SMTP id m13mr27315116otp.64.1593108821757; 
 Thu, 25 Jun 2020 11:13:41 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:30a8:2583:4785:22e1?
 ([2600:1700:65a0:78e0:30a8:2583:4785:22e1])
 by smtp.gmail.com with ESMTPSA id i11sm191940oom.9.2020.06.25.11.13.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 11:13:39 -0700 (PDT)
Subject: Re: [PATCH] nvme: fix identify error status silent ignore
To: Keith Busch <kbusch@kernel.org>
References: <20200625000257.29981-1-sagi@grimberg.me>
 <20200625170648.GA1533037@dhcp-10-100-145-180.wdl.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <37b14110-7070-c4b5-8b1f-268a570f9160@grimberg.me>
Date: Thu, 25 Jun 2020 11:13:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200625170648.GA1533037@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> @@ -1130,7 +1130,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
>> -		if (status > 0 && !(status & NVME_SC_DNR))
>> +		if (status > 0 && (status & NVME_SC_DNR))
>>   			status = 0;
> 
> Just remove the gratuitous parens, and okay to go. I'll rebase the zns
> tree with this patch.

I think it reads better as is, but I don't care too much.

Do note that this should go to 5.8-rc and the zns will
go to 5.9, but we should be able to handle that as its
early enough...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
