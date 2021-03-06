Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98F0C433DB
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 19:17:32 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85E9D650BC
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 19:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E9D650BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZSxBajOjUe7wFzt/myBy/yeBejUJb+eZjJp55qvghm0=; b=jTsoztQS5UG10+tgv17BGFdNT
	MwJxGHHckyVU1iGi8fJ/pn5M5+H8hda/n/DUsklEdv7NJxZJx72kGz2KQdGWK83ob2BRB2qt8clXw
	KLC7mlhS5R3kelQXMPLbxdoMUNXPxxqgeO7IhEKjSScsa73MNjzjEVMdvbiT1tpYEfV8ExrKY1X8d
	Ws9qzMa9naoN+pyQbw6GVd1cNorJ6HjPcTE3UU7Ib2VOwMOqxKnio3osV9ZOtd7UuJGBjWvddxyjg
	y1J+1NT4K8txK7BbBXmYin4Ic8aD5369obmQ9dcUzkD26A3H7BEykNVqeBByvOn/Gr8wVepZKPg91
	kkDmc+D0w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIcQS-004Mfc-H0; Sat, 06 Mar 2021 19:17:20 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIcQN-004MeP-8c
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 19:17:17 +0000
Received: by mail-pf1-x429.google.com with SMTP id j12so4381493pfj.12
 for <linux-nvme@lists.infradead.org>; Sat, 06 Mar 2021 11:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kqUVrrtsPbleN7F/Llkq2TML2wXkwgbQu5ieD4zDw5I=;
 b=keqXB5iT8k6AtocE0mJPoCKvNBtvC39U+UEyvKJUea8HdX3CJrnEn+XrdqItn3/hWp
 VLqJJE3vzB1tCD6HCEawwiqcWzeeSTuQQc4ZN7SyWzcWQliGZqaFB3iATKgln7426kts
 pv2eEeOL7S4D6KWq9DIytpisykV2DgSH2k5BpPuzzZNy1vn0/nhbzwznQWEblYa/9i5S
 69/taf87iCq5id2CrCFf2Sh2uwLwLBb43yzwybIbIyY2pIEw8Io3oo1DabS1AaSbAHaF
 9elm03M5zJRTtNhiTtLLEBFXX/biG6hoPVRiptp0MJwpKXFDEvV7pAbBq1/poNiy/NS+
 yFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kqUVrrtsPbleN7F/Llkq2TML2wXkwgbQu5ieD4zDw5I=;
 b=FknB+Ur7k4yJu9LWB09OteZfquFx+LctlRZJGn+wq9qO+EMKrUQGQfbSgVlqg0S3tk
 4vs8juz0PmAsLmeoRtefY9cnw7VJHsklzr+L/TYDL6UrCNpdTk1ZQptNAAX6FFzLFsr9
 +AcgrWLVXmB5tBMD+EZeQgLkZGdJThgRblp5Wd5AkJOf3RDYRgNqVXaVMlihcfnfGEhU
 TSp33eitL0hCv7yWf0YKuzU9ePiWtsCxTG5+sBv82iJzbrDb5muJCzUsfHY6KeAQ02qz
 DB6ITj6CZadgVqJdIvip2jSfkGi8//WZheTjHFjVNZBvNs200kl3j23To2TgztFOwGJj
 hmvw==
X-Gm-Message-State: AOAM533Uq8cNE0p7UvbdmGFkXLZKU0+LEL7K4eczT735zvAMVowHjoB/
 ZodMKS56L22TPGlGiWkWhGrL/om+bRU=
X-Google-Smtp-Source: ABdhPJzb6LDmMRX9DVhxK/UnjS5Yohz0W6Ee1nG/4c7p0cGovapMIMwGeh8kt2w09uNLsBSRHmVRFw==
X-Received: by 2002:aa7:804b:0:b029:1ee:5df8:f414 with SMTP id
 y11-20020aa7804b0000b02901ee5df8f414mr14626633pfm.33.1615058233843; 
 Sat, 06 Mar 2021 11:17:13 -0800 (PST)
Received: from [10.230.185.151] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id mp1sm5472640pjb.48.2021.03.06.11.17.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Mar 2021 11:17:13 -0800 (PST)
Subject: Re: [PATCH 4/4] nvme-fc: return NVME_SC_HOST_ABORTED_CMD when a
 command has been aborted
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org
References: <20210226071728.106923-1-hare@suse.de>
 <20210226071728.106923-5-hare@suse.de>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <6b1258f0-ba79-9456-d96e-5fc6b86af3d7@gmail.com>
Date: Sat, 6 Mar 2021 11:17:08 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210226071728.106923-5-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_191715_715506_89EF4DEE 
X-CRM114-Status: UNSURE (   9.85  )
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

On 2/25/2021 11:17 PM, Hannes Reinecke wrote:
> When a command has been aborted we should return NVME_SC_HOST_ABORTED_CMD
> to be consistent with the other transports.
> 
> Cc: James Smart <james.smart@broadcom.com>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/fc.c | 2 +-

Reviewed-by: James Smart <jsmart2021@gmail.com>

Looks good.

-- james



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
