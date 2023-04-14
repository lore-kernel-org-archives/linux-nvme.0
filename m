Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6DEDC77B76
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Apr 2023 12:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZzeAz/PFuhMt3rQNVFJc0aL0ecIBPs6lOaCHe0Gocvk=; b=Z4F0hRmCTAShffLdwDtjfcXeW/
	DJaSEwuvBg7J7143ZethqGbVlQdB4m93e8Nkuij092bvE5HyMyjR73dZh9RLA67DrKcT8quxIn5HM
	e1FDEWAbinehZpbtmsLkQJD+LcX46bTDjmXkwLQuE1/rHHwk4WwJSGykzkunYs7n+QTG89qGb2FQj
	Zpp2JNlT1HYzYstdZIgVfWWBBr5khyiLYE6YioWFhui2FgvXYKww/e8CZs4dd3jfpo0WMnd9LOJSa
	Zj9T3EFf2+1mFZD17jOzpjVMLohWWi5gAbpseHvya0OX9Wj2d7wSERtBYtFpGuerAaHvgvBl+QGtv
	6ZiAQgTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pnIbG-009X30-12;
	Fri, 14 Apr 2023 12:32:22 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pnIbD-009X1o-10
	for linux-nvme@lists.infradead.org;
	Fri, 14 Apr 2023 12:32:20 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b621b1dabso223058b3a.0
        for <linux-nvme@lists.infradead.org>; Fri, 14 Apr 2023 05:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681475537; x=1684067537;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZzeAz/PFuhMt3rQNVFJc0aL0ecIBPs6lOaCHe0Gocvk=;
        b=xulOPWC1n1Kk+vOWWDltd/WbfV5XDGDD9HgwWAunkaENPoqTkuGXgDVkxkFJD3wXuP
         YpoylUfgTLk6F/mM/ynWzE12+9PvPAMnJVr10puRrpCn2cEtDJ9sJvruwGpFBjy7PHhS
         mk+oet2Cwc9Elixr3y59WDHcO+vcdbIkv1/AATVjlTo7h8OH1vwzmnX2Fmf7O+HCf8hW
         tWUOF2wtCQtVeQfQW7AZwnRLdn/syZTrNCGRXmlBLiR++wpEJYPlYbIPuXPXh2YQYkr3
         0gxoBEDUbozkyiaetDutHglho2Wta88vfDsBW8e3rOZ3BF6cmFKTW5d6X6ak1lxDjy11
         q9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681475537; x=1684067537;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzeAz/PFuhMt3rQNVFJc0aL0ecIBPs6lOaCHe0Gocvk=;
        b=C1TMVC/4mXCW+MRvFS+GZgSghxRP64Q643c1QjAPxA77JCRcH4Eqo51geRABa7aU1w
         jOwVeYSSpJzIWYH2Paf1itWVsQbj8J5q8lVVGekm+i338kk9Mph9nTHS5XdTUdEfL/5A
         Pe4xtE+oXZwvknyksG3Jftka+onMMvNMPgX+MXCObyn1mQ7Zcyti0DiFC+8JUnGH0VUF
         B45YwWKtn4wUdXywymMj6YQSyxdoqomBaXW4oZae1C8r+PATG8+kUWA9QSvtht1rw53a
         5ASoFci3oWufgNARY+PwnXBbvo0wJ+uvJIPxiFTj5vw0jQHtZU0oFdqxQW5mdqgq/b3D
         KmrA==
X-Gm-Message-State: AAQBX9cwW/Jt31gFEu9epIKkjDa1HrT5E2AHqNem6Xnx53iY3FNYFAwU
	HclspVwPCqWzpO/GVT4wCZCJKQ00/w1cCJkirEU=
X-Google-Smtp-Source: AKy350YeVTFwjChuvWXMDPfn9hdUvuszJ5dCy+lMF7B/vMF+f7WGsj2RPKavQHMsOMV8lUKEmicf3g==
X-Received: by 2002:a17:902:e881:b0:1a6:7b92:15c2 with SMTP id w1-20020a170902e88100b001a67b9215c2mr2783582plg.4.1681475537517;
        Fri, 14 Apr 2023 05:32:17 -0700 (PDT)
Received: from [192.168.4.201] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id j11-20020a17090a2a8b00b00244938da9b9sm2836717pjd.31.2023.04.14.05.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 05:32:17 -0700 (PDT)
Message-ID: <bfc01a2e-6285-fb41-c1e9-e6c37b61722d@kernel.dk>
Date: Fri, 14 Apr 2023 06:32:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [GIT PULL] nvme updates for Linux 6.4
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <ZDjjF9NWdq+gC0tI@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZDjjF9NWdq+gC0tI@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230414_053219_367746_49C98D01 
X-CRM114-Status: UNSURE (   9.14  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/13/23 11:22 PM, Christoph Hellwig wrote:
> The following changes since commit d8898ee50edecacdf0141f26fd90acf43d7e9cd7:
> 
>   s390/dasd: fix hanging blockdevice after request requeue (2023-04-11 19:53:08 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.4-2023-04-14

Pulled, thanks.

-- 
Jens Axboe



