Return-Path: <SRS0=yO6k=IU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12589C433E1
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Mar 2021 19:37:36 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A13376199E
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Mar 2021 19:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13376199E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NGukl8Ro/EJYDg8AP/7+fn+IpOoiKBg3dLmI3jBpuoc=; b=NClgsaE3a78HjMnTwd1sLi79W
	oQrQRx0tTkwlyGsz9vIeIYBTg0N6mnasCeEOQ0NPNJIvn6B1pqEEByGf0V7O0O3c37zxv75plKMYh
	2zVL3p3lvbQLiMvGFuHF7/A/lRX08/+qp3jDZx8F7TJKBIxZDivIzb5Lykfl/inQjyTQAMfHCQvJp
	I7ZQDQhHN9lfp5Nxw9Nb6GfPYFm8HzRPNAzHzLxv8FsmjXUllQ9sXHviki08Whof/ISRQcadmRX/1
	hbxDn3qKyv8KR15BF5Ze40uEEdyoDpsN9JiPSqmjIV4yx0iEwh3LE5Fe/p2dn0Q+a+16A1Dd482SZ
	pDpOVtY2w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOQMb-00CRRC-Um; Mon, 22 Mar 2021 19:37:22 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOQMX-00CRQp-6u
 for linux-nvme@lists.infradead.org; Mon, 22 Mar 2021 19:37:19 +0000
Received: by mail-pj1-x102a.google.com with SMTP id ha17so9032944pjb.2
 for <linux-nvme@lists.infradead.org>; Mon, 22 Mar 2021 12:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=8e60lIBfndUsvMpnvK2c168RQlUrqAtmn3qi4Bc/9CE=;
 b=GQDMV9gdb9hxCaTYXTlb4IN0Nb2ox+CejeaoaOcI2TO4LvIIGw71xkYa8kYyhAHVVm
 9kOqRn/aYpsZzAFVLKxaAFkC/98Lh3ZZIzpc05JFrUEhXcYgyhR9wWAZEoKhgL0fIqmW
 GYQ/AINoKL9X4u6yDtzSYEMyzBKi9r7iiGHSU61npy28RGAOft8OLSvjsZmIKVB8/Yaa
 PjuBOqP9A/vwd2Er0YWctJTEwV3pq+2fWmFTERLt83cTOokzAV0i84xla4RtaEHssAy3
 KyelufoWQxePzeuJey9SgDByCUQEAd1OU9O7ou4fXDwnkK4nim38O6TPuBgtP3LYb+vw
 xjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8e60lIBfndUsvMpnvK2c168RQlUrqAtmn3qi4Bc/9CE=;
 b=pI5KScmWa2801UETsEKfJpZk327AyqibX+aKnAvHQcv9KxXxwn6qOBrp2+u7WMHxgW
 2CRAhpBuiCboAe9zuXVd0XhylnqdGjBMoyzLSsgq505VGUX6QjOWgYBISv+oOjnhJ3EH
 8Z7PvD1pLy9Iw3tQqt3Be1yiw873m8xOVgatA1Z/9la4ClpuDCWRNiJICWYzLrULJV/5
 frHIfps5ghwWTlliVutp9ms5kztKInRZl6WBTBd13cgWq4moX1c9on2alctLwMZT2INV
 yOk2t+ET+gCm9f8LrH4WkTW5GlPpV1odmkYzomJ54Ux65p0rYfs3OnYqCiDd67xQtOkn
 Xa9g==
X-Gm-Message-State: AOAM5334ORSF6CupZksSbUeCTlUOreFDAuUvguH6Ii6U+adUuZX/d38C
 lyhxQGBAV4d8xsmkPJnGT6U=
X-Google-Smtp-Source: ABdhPJz5Zx4o6E9vUHKn5mmL9xJX1IW32jA/0JT2QGKchw26i+NLEjmfoND500oMKuaej75NhnuHQg==
X-Received: by 2002:a17:90a:987:: with SMTP id 7mr648092pjo.97.1616441833553; 
 Mon, 22 Mar 2021 12:37:13 -0700 (PDT)
Received: from [10.230.185.151] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id t4sm227973pjs.12.2021.03.22.12.37.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Mar 2021 12:37:13 -0700 (PDT)
Subject: Re: [PATCH] nvmet-fc: simplify nvmet_fc_alloc_hostport
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "amit.engel@dell.com" <amit.engel@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>
References: <20210322185945.10364-1-amit.engel@dell.com>
 <BYAPR04MB496537278CC338FBE8066FFA86659@BYAPR04MB4965.namprd04.prod.outlook.com>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <c553296f-cd43-56b6-1088-5b4eee5a8736@gmail.com>
Date: Mon, 22 Mar 2021 12:37:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB496537278CC338FBE8066FFA86659@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210322_193717_332495_B172F6DC 
X-CRM114-Status: UNSURE (   8.35  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/22/2021 12:15 PM, Chaitanya Kulkarni wrote:
> On 3/22/21 12:08, amit.engel@dell.com wrote:
>> -		return (match) ? match : ERR_PTR(-ENOMEM);
>> +		return ERR_PTR(-ENOMEM);
>>   	}
> 
> Same comment about return () here.
> 
> 

nothing wrong here....

-- james


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
