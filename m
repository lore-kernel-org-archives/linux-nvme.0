Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B495C433E0
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 20:51:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 246A96509B
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 20:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246A96509B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3xb6JjzUkAwcDuol7UEiH4bTySnS08XY+/BsKYOKKIA=; b=mg3yW63l3Y5mC2RGldGW588yF
	RB/Z8x5+BdEzF+IfAYaxXBy78zMt7nwhdMvNyIRkkiiI3Ak7GKdxQb1hr8/xh8OmuEBCu1yyg/MeG
	R37JwLROa/WsSgk6FM1pQ8WMOTaHjyfOmNauUQMNSFFxyof4FyBVFGl/Gxjg3RkC/Gkzfh9FQR19I
	jetCr5MM5PqoNXcObSVtQTAwMg9KkOekuk/Salk0I6+oFmu93Fm/Otrfpu0ubD2NTubR4fwgy+Glw
	sm5fMLrzId/d3GEpN2xNiHTcldNU65Ql3LQxjojpGhBD9YN5fdj4bh4MpETsvqIMtPCNyI+bgJCas
	nBkL54aqg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIdtQ-004rm5-3d; Sat, 06 Mar 2021 20:51:20 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIdtK-004rjI-Np
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 20:51:16 +0000
Received: by mail-pl1-x632.google.com with SMTP id u11so3052250plg.13
 for <linux-nvme@lists.infradead.org>; Sat, 06 Mar 2021 12:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=VP9Syudo8wNT42+oDpUGNQyN/Yj6mJ9PpFkhDMA3Tn8=;
 b=PNHekqa1ltsZrulE1A9Wn+oRI9jUuaBEZ4P1ybRlHp682T9yjqg3UVvQ/CCSzXtH8x
 96tfHq+a0/t0Paq7Goh/9BLwHK7XwpbS+obamNe3cy7fLBYui1GJg56rRT/tiJaKIiCN
 +QBwSfZuTes5llfEqlxccQymhddobwRSGA2jcsT1DM39ZHLPUoqobF44HuelnPB/XlWq
 asiy02qXaqY6ExRigtuOPo/A9QSAg2C/rz4hvodrVy55jMbGgupQDx8EdSvHt4pknEiE
 /rul3sdMCoMSI2li7XFLc0S5sD0hq0st5qm2uu10MTjEEokzLXGntkJT1JWPUsxQ6Ljo
 8tQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VP9Syudo8wNT42+oDpUGNQyN/Yj6mJ9PpFkhDMA3Tn8=;
 b=F2PR0L/B3b9VNhmbngcQ1R2JTAfZXPUknSFlgrImch+Hvv22h5SN1kLs4j+z74jkFE
 +5DsvPK1+JwXf6hFkTki2SgO+zxId618AAmzSQQniKAOS6CvkEvKiH20XXSGWpePMBEB
 jSdhoNwE4Gtde+rTpxMV0ojErLZ3q3rG9oEDLfFsUQ+2dyPOzQKZW2K0hivwHofWSNeY
 mwMbDGa/T/sqeiYWGBP58AfRaLgYsJ1qd/YHrKJuen0QUl3eGn//aM/s5aDkT9PjC9p8
 rFViSlwAOlyJkfLzBxVV7yphAnRNGXMSu7U6hKnSUGsq7NbejpPaB0GxPJlxqur39Zzb
 xUzw==
X-Gm-Message-State: AOAM530mIZPX26QZDuT9kcoQcUml0B2dUZ2RYQ1kKDK4K4fpRjeOJm7G
 Dqhs/fjnCiMA+QJiqu+U+cM=
X-Google-Smtp-Source: ABdhPJymy645mDh9oWJPap9rHH5n7ZrzfmuwanNi2uLjkS5BYPtBDtvozZUHy8fCT0L/a6Fo5i1EaQ==
X-Received: by 2002:a17:90b:33c4:: with SMTP id
 lk4mr17638211pjb.157.1615063873303; 
 Sat, 06 Mar 2021 12:51:13 -0800 (PST)
Received: from [10.230.185.151] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id d16sm5928271pjd.25.2021.03.06.12.51.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Mar 2021 12:51:12 -0800 (PST)
Subject: Re: [PATCH] nvmet-fc: simplify and fix nvmet_fc_alloc_hostport
To: amit.engel@dell.com, linux-nvme@lists.infradead.org,
 james.smart@broadcom.com
References: <20210304081215.21042-1-amit.engel@dell.com>
 <f2144d4e-247a-34ed-c428-eee8194f2400@gmail.com>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <2f04d343-7ccd-8c7e-bed3-574f8bb354cf@gmail.com>
Date: Sat, 6 Mar 2021 12:51:09 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <f2144d4e-247a-34ed-c428-eee8194f2400@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_205114_975828_7A57D2A1 
X-CRM114-Status: GOOD (  12.22  )
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

On 3/6/2021 11:26 AM, James Smart wrote:
> On 3/4/2021 12:12 AM, amit.engel@dell.com wrote:
>> From: Amit Engel <amit.engel@dell.com>
>>
>> Alloc newhost only if no host has been found in host_list
>> Add a missing tgtport release reference
>>
>> Signed-off-by: Amit Engel <amit.engel@dell.com>
> 
...

I looked at this again for the missing reference and as to why you may 
have wanted to rework this.

I didn't see anything relative to tgtport reference.  There is to be a 
tgtport reference relative to the hostport struct, which is released 
when the hostport is freed.

If the issue is many allocations that are then thrown away (the normal 
case once created), then I recommend you rework your patch to release 
the lock after not finding a match, doing the allocation, then relock 
and re-search, if not found add, if found free the alloc. I'm ok with that.

-- james


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
