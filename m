Return-Path: <SRS0=viL0=52=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F29C2BA2B
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2020 05:53:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57DA320801
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2020 05:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Vxj8FF2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57DA320801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nEiqww8OIgbGdGCmZZ225MxYSHzB1FwHhfWmPiF7vvA=; b=Vxj8FF2OEAEL2SLEWhfD9FHvk
	T9m9CCsnijiS3+F5qGVUlaE38JU+Yi0bo4sQg6Q37uqJW8rCg7bz+1Ay+UROlm6g76o3JDzsRiQ+W
	AOI/JM72TB2/d4DhcGDP6euBMLxbjVP2+50GXK2hAzxJ6oM0MlbXPQhJ+KN3RovTYtKdy0BtW99oG
	UqzNL97kTO5WjUqAmdEN7QCxqkCRzxl4l6HxeuJFI70qDEmu2oY8CMqZQlM4/Eba3P0sJs6nlKK+v
	NL61bAw5H9Y3hmOte0hZz+HPJ771n14gcFAndVpNh7v2pBl0Mbymkq2uofMv+wwqIIm/cri0z7fpG
	4qsLfIDdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jMmbI-0008C8-ON; Fri, 10 Apr 2020 05:53:12 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMmbF-0008Bl-Qe
 for linux-nvme@lists.infradead.org; Fri, 10 Apr 2020 05:53:11 +0000
Received: by mail-wm1-f42.google.com with SMTP id d77so1411742wmd.3
 for <linux-nvme@lists.infradead.org>; Thu, 09 Apr 2020 22:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cD0nRhf23O3avfLYPcPzjsdPsBLh/v9vgLocmY2i7Rg=;
 b=AaiNTaAQh+y6Y9ePPrbNozdZN5HseYEbx3QZ1lvYAkc2U+7JRmvoYKOqBtTeVMPT82
 d2r7RkR6NRnlQMi+cjK0ym8csRYIkkU3EUKMmNDEKn4qBImBgjEIm5xTts8ukSxWsfeD
 4cA180z4LYgWYbh2n2SvNp/pzudEtqbWn4vnmDGOLleeJXroOfAXXceqaLtM2S+I+pk8
 sq3n8TJaisnWU+2VgAYi3we/M0+I79FE2b4AegejdSudz3rHU4o4/08f+c//e/mf2zz5
 5zfaxrtMSawWLZPUlnIRFMZpExwyccnm96k5qZrtD+pD5nVVJt/Mkd6WUaYl9dBuayvg
 FERQ==
X-Gm-Message-State: AGi0PuYHdGBz6wY1NzveQDWQbLk71yNP3guaFnEthFemB1Lr/GmvXqGb
 RqkeCBMwofljgPm2WwhOop5fp44t
X-Google-Smtp-Source: APiQypKdXwcroRu1UsoLhltjLOWJnD/rm/bU3Fyu6iY1Wd5/s7cX2Ly2TzoY8XvKWpeSkcLuLUNiug==
X-Received: by 2002:a1c:cc0a:: with SMTP id h10mr3202168wmb.127.1586497987806; 
 Thu, 09 Apr 2020 22:53:07 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:9052:1641:fbba:d9ee?
 ([2601:647:4802:9070:9052:1641:fbba:d9ee])
 by smtp.gmail.com with ESMTPSA id n6sm1352591wmc.28.2020.04.09.22.53.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2020 22:53:07 -0700 (PDT)
Subject: Re: [PATCHv2] nvme: define constants for identification values
To: Keith Busch <kbusch@kernel.org>, Bart Van Assche <bvanassche@acm.org>
References: <20200403175346.1571822-1-kbusch@kernel.org>
 <bdb66a0e-bceb-51f4-c86f-d6861562bf6a@acm.org>
 <20200410050855.GA1894848@dhcp-10-100-145-180.wdl.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ea5f8bc7-4188-4f1c-a42f-8ce8e29b6002@grimberg.me>
Date: Thu, 9 Apr 2020 22:53:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200410050855.GA1894848@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200409_225309_862647_0FC79D44 
X-CRM114-Status: GOOD (  10.68  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> On 2020-04-03 10:53, Keith Busch wrote:
>>> -		if ((id->cmic & (1 << 1)) ||
>>> +		if ((id->cmic & NVME_CTRL_CMIC_MULTI_CTRL) ||
>>>   		    (ctrl->opts && ctrl->opts->discovery_nqn))
>>>   			continue;
>>
>> If this patch is reposted, please remove the parentheses that are
>> superfluous from the above expression.
> 
> Indeed, thanks for pointing that out. I'll send v3 if the other
> maintainers have been swayed to ack.

I'm fine with the changem

Acked-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
