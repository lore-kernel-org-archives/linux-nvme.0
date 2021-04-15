Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE98C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 23:05:45 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D26FC610FA
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 23:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26FC610FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VsS52CnhWO3ypOlmyOjgTOhWeyEbkKR+g2t1fHEPxyk=; b=mXKCyqGDGuZXeCTevg5sRp7Nt
	ptxKM+qBYghBHaDnxVRziifmkSY/XP78hnfJtfg/nzwrFS6j9I3juU6E8edltckYlica3dn01oTY6
	Sw+vYTLZkGNNp9qmq2RG7dpQgtdFPTZSbgVihQFbq3Fykn1W81MlsVjlBixHI1HCoKGD3WGYEZzj3
	MPNhT7PQpbPZdbH418Rg6QBX3SoKJQrDhrH0mEr1vu7CwcUlYJaRl+gN1XkPn49GTgG18LM7jT9DW
	vcaEnP1OLc2bIMGLMrnQRx0MCmCg0ywkuvCV5tjt0Q3ljL1oACFDgZ809vXWTdMIgXe5VHvxVJTBm
	4Dfm2XoFg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXB3B-0000kl-Ob; Thu, 15 Apr 2021 23:05:29 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXB37-0000kU-QP
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 23:05:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=s6EzovWDLBvCLWnUa7QMjsxg3jCJrROoQb9Db9C55tI=; b=uf2zJmgrBwOsovLK29ShK1Xnhv
 5kQAacD7Qw2E4O3LZMlylTjqmJPHIOiFWyRDspXM5RPjViWm2ftArZKEb2ym9cBYJikdwj04m11Ks
 JnPaCRtDentbv1xZADLOhsFZErXtXA6+3zBYryMXfKJViFT06D9otYFBo36ZdXH2OD5b87SlCBqWI
 3jFnmwXiwIr+d5bk/3p47U6HcQK+9kizyqdpmGPpfclcQ5REZjX0ymhma0NjzKaafJnzXWrAcj3Ge
 N5+t8HjMWUtWH7wlQlZw/k44HPBmQ2KcWnRz1jo/9dlB+bssf0EER9z+cyh5DVQRepKnQV2y1T7sI
 UjaHvtrg==;
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXB35-008xW4-EO
 for linux-nvme@lists.infradead.org; Thu, 15 Apr 2021 23:05:24 +0000
Received: by mail-pg1-x52f.google.com with SMTP id j7so8524840pgi.3
 for <linux-nvme@lists.infradead.org>; Thu, 15 Apr 2021 16:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=s6EzovWDLBvCLWnUa7QMjsxg3jCJrROoQb9Db9C55tI=;
 b=qeFaiqRLmL6ONxfrdcbuwAMvTB7F4/l6hhqW2T7XyvMV7wBHZ53mTz9peoj3h+tcnh
 xgJCzBqD52j1ELhBF+CO6nKI6T4IB90rogBMtB9DLZm2+7qPOmj1yoiJDWOFMQq5Yz2z
 +75ONS8Tcwl1V9Ujm7YEd7YjK52pK4zE0eDceRfmLVnt0QYoCx4fmCMLMiZNGFusxffV
 6Moj98DhFf6qtkABQ6FeyMmRWslm1EVAz/X9fgTgxs0FgSEHQtfqj+DeIlMDAi/tLtow
 9pLKsvbzHz9/GV6DjyYC85PhZ+hpiG+QFcE5CWaTjVU1Ng3ZAmUQmMf8NHgAZWsJGcBI
 2AsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s6EzovWDLBvCLWnUa7QMjsxg3jCJrROoQb9Db9C55tI=;
 b=Cdt4xL3oOpnAHTjJ6IcL1txQCKRzxBGQpKiE2ABEYFRMiR9fEl9HzstZ55I5Caq+BI
 /kRPMeZlDmjtH8rdMr8VIIGFASCbtA+MMfYO0V4uj6x0avyYkMVze9Aa+jPZ+eAW5naP
 H0Z26KKYmkjIBg/k3/6P1SCW+JpmKAW87CdgAIBMKbY5BvG+ODjlzDbzJh9sBUaqzq/b
 Gr1BlBDuEhm2LQtL+hxH0bTVLN0NQfd19+SRfJX3NyOT4sfi1krayqjHlmcpasYp/Avf
 iVBYBotbVhdv67YfSauRs36gBDWBv5ffhlpWPtSmYjvLHwL1v03QTbOo3zEV5pKbxQov
 f09A==
X-Gm-Message-State: AOAM531BDPP4jgzu0NyZ5dc0ZrGT7Ixe5mC/DwXT5MLgT910ueRK0QNn
 caq3hVCgjt7wDJ5xUYFC9UQ=
X-Google-Smtp-Source: ABdhPJyluH0lZxVqYizUqS/404T1bXMy03RYym8Tcf7g+bJn6KXxiaxXBIxOdO/ET7dJg/2MsS4dCg==
X-Received: by 2002:a63:510f:: with SMTP id f15mr5496100pgb.390.1618527922054; 
 Thu, 15 Apr 2021 16:05:22 -0700 (PDT)
Received: from [10.230.185.151] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id nv7sm3320478pjb.18.2021.04.15.16.05.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Apr 2021 16:05:21 -0700 (PDT)
Subject: Re: [PATCH 0/1] Add Host Transport Interface option (host-triface)
To: Martin Belanger <nitram_67@hotmail.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 Martin Belanger <martin.belanger@dell.com>
References: <BL0PR13MB429178ADAA0C3C8AA2AA05379C4D9@BL0PR13MB4291.namprd13.prod.outlook.com>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <f693d139-2a3d-a780-9e15-9ab130cdab3f@gmail.com>
Date: Thu, 15 Apr 2021 16:05:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <BL0PR13MB429178ADAA0C3C8AA2AA05379C4D9@BL0PR13MB4291.namprd13.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_160523_514501_919DEA56 
X-CRM114-Status: GOOD (  16.59  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/15/2021 12:28 PM, Martin Belanger wrote:
> From: Martin Belanger <martin.belanger@dell.com>
> 
> In our application, we need a way to force TCP connections to go out a
> specific interface instead of letting Linux select the interface based
> on the routing tables. This patch adds the option 'host-triface' to allow
> specifying the interface to use. Note that corresponding changes to the
> nvme-cli utility will follow.
> 
> Martin Belanger (1):
>    Add 'Transport Interface' (triface) option. This can be used to
>      specify the IP interface to use for the connection. The driver uses
>      that to set SO_BINDTODEVICE on the socket before connecting.
> 
>   drivers/nvme/host/core.c    |  5 +++++
>   drivers/nvme/host/fabrics.c | 14 +++++++++++++
>   drivers/nvme/host/fabrics.h |  6 +++++-
>   drivers/nvme/host/tcp.c     | 41 ++++++++++++++++++++++++++++++++++---
>   4 files changed, 62 insertions(+), 4 deletions(-)
> 

This wasn't able to be done via HOST_TRADDR ?

-- james


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
