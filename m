Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3EEC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 17:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rlzr1rQUCyqmb5pIMuKIamrgpyiKC9geInPOmysbNos=; b=py8/a7m3/wTxe9xqPo3IywltBo
	SUsz4tZ4vUg9AWT7L+IVpKlUd65r40wzl5sqgSy1nHjlt2vAyB0wi4CmhXiw1E9GxtSDB45U3BPbd
	RasMCICNXc69+zjoR65VGe+X0y+hMjI4e20fQF22N8LdqPJh0+QMzzbd18EwuLV6QxCt4Zpn6tvYZ
	V5IRhPfF/Rr9Pkcfl6bcOaUg9JDp7UzimSGCACWSt7bYTNPj35rF3q3VFsEkalIghAnMf9dwYATun
	ePSPnU7TJiRH/jNUdkSQhkPEU9RHN5X7pI+XuASeEAmJHJI23lXiAVtper4VSJ3mSQy9tcfK0aPiZ
	p7JbXCkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXQpI-00HHHy-A9; Thu, 24 Mar 2022 17:00:44 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXQpE-00HHG5-NE
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 17:00:41 +0000
Received: by mail-wr1-f44.google.com with SMTP id j18so7516603wrd.6
 for <linux-nvme@lists.infradead.org>; Thu, 24 Mar 2022 10:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=rlzr1rQUCyqmb5pIMuKIamrgpyiKC9geInPOmysbNos=;
 b=3imJsSbctqk+VxBTLpFThd3emfCFXd51oqeMT1CTJ9F16yPGWYRAAAYqv0xIdpSZWz
 V4kyZFyXzkvEc4mFSlGwCq/QIkeaV64ADhaiDWHNWb3fewp0nBHM0YK9YH77Ye5tJMMH
 mNKuqQ9hC0uJrK0/WTlxVPxomMazmOcLLZb8H0hKE5Vb1T8buDHnOfuGGT52vMNWuIM9
 gJdM63F24OGqB/ojzrdCOYvqHvdehTm7BN/J45rOxNNecmxMuEVc2S6oLiLxkCtEbvi0
 72Qs9E0hp2xMFG2M0d71f7eRU/dtTuZYRVGxVsTrJOqwlxqUas+cvdif9/PtTUKQ1phb
 lSsQ==
X-Gm-Message-State: AOAM532rb+AARxwNiD8BCo8LQLuSTqTDx14LEL3UCN2Pdc7Xqa2CaN3h
 hpg7D8HQy8K4PhkAPb1vlPa2Y6CiFSg=
X-Google-Smtp-Source: ABdhPJyhaARoMktIWRgFtmg0dfiASdhy/EK1zC7ZfI1IXSqyYSb9NKsFi3x9A4b7iF4VTKJcq3DkFg==
X-Received: by 2002:adf:f747:0:b0:203:ded4:dbd with SMTP id
 z7-20020adff747000000b00203ded40dbdmr5448134wrp.343.1648141238592; 
 Thu, 24 Mar 2022 10:00:38 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.129.dynamic.barak-online.net.
 [85.65.206.129]) by smtp.gmail.com with ESMTPSA id
 m3-20020a5d64a3000000b00203ed35b0aesm5125294wrp.108.2022.03.24.10.00.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Mar 2022 10:00:38 -0700 (PDT)
Message-ID: <7ee4a989-264d-7fcd-88ae-b0abf424ba07@grimberg.me>
Date: Thu, 24 Mar 2022 19:00:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] Revert "nvme-multipath: fix hang when disk goes live over
 reconnect"
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20220324000620.4127-1-kch@nvidia.com>
 <a51dcb74-9664-41a6-7a05-1aee2ba0572a@grimberg.me>
 <6ad3113d-a1a8-9ee4-bb7a-9a61639fb691@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <6ad3113d-a1a8-9ee4-bb7a-9a61639fb691@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220324_100040_805622_00D2035D 
X-CRM114-Status: GOOD (  10.11  )
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


>>> This reverts commit d50c992edf10b95d2034097405c94fecfbe1ef7f which is
>>> causing following OOPs:
>>
>> Hey Chaitanya, can you please elaborate on the scenario that triggered
>> this?
>>
>> Thanks.
>>
> 
> I pulled the changes, build the kernel and it produced OOPs.

Wow! the bug was so nasty that it produced the oops when you built
the kernel, even before installing or running it. Good that
we removed it :)

