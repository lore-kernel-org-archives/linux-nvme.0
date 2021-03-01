Return-Path: <SRS0=Uoxm=H7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F48C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 19:09:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B2E5614A5
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 19:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2E5614A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2w4KzvvCDYPaxYYFJ//Wv/B5jSuPBI9j2qJOUvRfFAc=; b=QYMpGxuCNyUHlfAEu4S9LNnwX
	UV2EaOm4BH/Oc/VOzMIWf98iiNUeOviWJHPku1lwbJ5VPz4jjc3z86bMLPEAYEZosmJB1t1adplin
	gQmagm/K563a1pw4WITp4pBZ0ocXx8MThXk26KwMmXbCmwZhdmESnpUppHTBnNjrSnZxwE4AMCmjH
	A+/qorGV1O8XDHzoYWjPUk4bKcYxBKeCTJPZ44b0/ij0j/8M/jUoWgVwFwZJ1Ytn5MIzySk/dLqlv
	KTLpOadYr3mXzoCNTj02c3vxs7FxUHohXdlqXRtY+v8Qwt9WauXIIVKiAI01FoOhozGy2bzSZMU1A
	nCZrPUzpQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lGnvQ-0002Oe-PT; Mon, 01 Mar 2021 19:09:48 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGnvN-0002ND-Td
 for linux-nvme@lists.infradead.org; Mon, 01 Mar 2021 19:09:46 +0000
Received: by mail-pf1-x429.google.com with SMTP id o188so5493915pfg.2
 for <linux-nvme@lists.infradead.org>; Mon, 01 Mar 2021 11:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tkLXIsyj8QwPTa8S6ZCydBzEEuL0sPAusmidO8lcg/M=;
 b=bqRQ5TUYvSvXmKIOgFbzZr9i1aifmPKdLLAZdbxvk47LayreepUmO1IsKtVJk1ZZkA
 vRzcNT9n5Zy7g4eac4VEvroUuGeSzRoawIRAie058tuLCuwxmUb2esBGemkpTMj9+NG6
 KgFoAq6w4TN9N0OlxwjO7mAST0jwgBpADXxkyAmGvW3x4X4CjJQyI4BfFxDYp+T8NUXu
 B7VxugkEzC88f15exz1v4L9P5d1wP7jSIik213zltPQVlnvNz3CMtHhJgKapI5oXPRuz
 LOLlQDyLowuyMtyZ9BMm+x0CwaWvm5gByKhtnijZSZOR+SxNh6b4xHeP2jD7dXv9+NRF
 iP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tkLXIsyj8QwPTa8S6ZCydBzEEuL0sPAusmidO8lcg/M=;
 b=jQSOO3abeOL86Av391egpaU9fJfdmKuKmW+uMNBLAJ/Po5pn+sFIZTpnbCPgbPrfKJ
 rerSEBAnNPXm2BKcgVDOEqwUZkwuUWKEF90SB7v1166tuHfRCQ65uxMC2GcxiLnbs+6E
 nj7XCektFChSNeNoMPSVKINwIcW1CmWhcbSNx9O/ltySxkz9o4M27xmInEf8hKHcG2Ua
 +5r/gepPwff6/gYXaMGZCNttqyp43mlymUAM8XBSPBQageSahhR1yE/7W121KyHzH6Ft
 Z6CEQFlxaKYfuM5kYdTH1X0OiAXuupKeJavgkWJOTn0i4H6Xc13+msN8zbsYrvsOpVH7
 ZXfw==
X-Gm-Message-State: AOAM532gLURPURXTB/doLYicV4pRSs3lXoGJuvFF89rk9i/OWfM79G4K
 H+xKJ83LmZH6cJ637wglbN0=
X-Google-Smtp-Source: ABdhPJzMbObpeWcyMj1RKL35/YYHcQykXuAmt3mpY/tzAlxZwG2NWds+MRqayEmf0BZioO247W0eVA==
X-Received: by 2002:a63:4621:: with SMTP id t33mr14803865pga.22.1614625783849; 
 Mon, 01 Mar 2021 11:09:43 -0800 (PST)
Received: from [10.69.69.102] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id y20sm6203008pfb.138.2021.03.01.11.09.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Mar 2021 11:09:43 -0800 (PST)
Subject: Re: [PATCH V2 6/8] nvme-fc: fix the function documentation comment
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20210301020611.18669-1-chaitanya.kulkarni@wdc.com>
 <20210301020611.18669-7-chaitanya.kulkarni@wdc.com>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <6a5e6fc3-9ebb-3b72-4181-d1c7a9500598@gmail.com>
Date: Mon, 1 Mar 2021 11:09:42 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210301020611.18669-7-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210301_140946_016321_F5E59F60 
X-CRM114-Status: GOOD (  11.66  )
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
Cc: kbusch@kernel.org, james.smart@broadcom.com, sagi@grimberg.me, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/28/2021 6:06 PM, Chaitanya Kulkarni wrote:
> The nvme_fc_rcv_ls_req() function has first argument as pointer to
> remoteport named portprt, but in the documentation comment that is name
> is used as remoteport. Fix that to get rid if the compilation warning.
> 
> drivers/nvme//host/fc.c:1724: warning: Function parameter or member 'portptr' not described in 'nvme_fc_rcv_ls_req'
> drivers/nvme//host/fc.c:1724: warning: Excess function parameter 'remoteport' description in 'nvme_fc_rcv_ls_req'
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>

Thanks

Reviewed-by:  James Smart <jsmart2021@gmail.com>

-- james

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
