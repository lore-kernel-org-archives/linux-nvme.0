Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E472AC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 08:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TgyujVBWfviggPeQDUWOqLsyjM0f5GYV66yVSB7k0PQ=; b=aZ/VpZUvYMhXzOGoWOHQZZPR7b
	haqr9C1FQ18hO+H6K4zgvF+Szg5ywaw9sPDzziRKA8C8mlw84kmqctLfVEWpPwA1X83wJFZDFormW
	rhjFaKnr0ZGe07HAnbGOhub0p5+of2s8mGq2aRfT7MfjIsxJ1IjkC81/IliC4mbWNVByMvrQ2lpXB
	uvlHFzw08Tm6HJUHH4PSw0HVa4Mouz/ZuG5Z+YdUaLx9yK05GI2v79g7IMH9dY2VvtN1LGgUR83Jb
	B7Ct4A4MWYa0Ny7/SIvENQKBP1sQs4lDxyN3164VrFBfBHTNwKe4S1l7pBaL1mYeYiRy1vGEy8GAO
	FHv/tjXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol4mD-00Guno-6g; Wed, 19 Oct 2022 08:50:13 +0000
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol4mA-00GuhH-P5
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 08:50:12 +0000
Received: by mail-lj1-x230.google.com with SMTP id i21so18332346ljh.12
        for <linux-nvme@lists.infradead.org>; Wed, 19 Oct 2022 01:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TgyujVBWfviggPeQDUWOqLsyjM0f5GYV66yVSB7k0PQ=;
        b=lcASvWkIGYIBL1kOUmlNKRmizZXQRQCQswLcY7rtUWLD0Recpakmj4moxmyZJqQajc
         /bjCQ77pl6OpEHcbkLCMwgdnn0URcmcvR9sgn3HQJcZpRr+U/qMGLwJf+jUyckXiAkcE
         PS9h9Cft/8HKkwv/XLFaqE+Xr0oH9H1SEwvqRIjWIJ/3ocbNfAcLk8iTN3ltIAQNGCfl
         zoN9xm7THLogOo2DvAg2/TbBxm6IaXZRxi1JqIXGAjcGBzTu34y+PN4QmKHQOslH0MoO
         B/xByLm3DoUwCoB7qryimZA+c+w9lvRCkOUIxKEWTvux0q1VLvr+SCdV6RiHMDV4g+/Q
         sbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgyujVBWfviggPeQDUWOqLsyjM0f5GYV66yVSB7k0PQ=;
        b=ICxigI1QWK1e1Cug953u29NbGyUiRIDudXDWsIeGxWHrXnHM7ewdyhjyZ9ztsr6kMX
         ERHwK/laqrvRzNe8ASdaXPbz0uCysAnxEsa6m2aoi7S3u5JDOY5gYsegpbwMdgxkACJs
         rqnOOsKHlxEe8ASfH6K5Xf7+mnI152cDVzmj9adO7E+vkj0m54CY4w4NtRFRQedLl8kL
         yuhhXThazEyF0Xm8Znss5NO7NH1PyheB1BWgbBYUp6OmZWClgcAalZ7yyG8IhJg5iUf3
         njRr5DcVK0GY7bTMq4ASPcbnMIicDpves7ANAQM0CnbUQ7B3ePL37f5Rp7t9XoImjbwl
         bWpQ==
X-Gm-Message-State: ACrzQf04Ykiba7uK5AQ6XR9cSLUg/dkTrARd38dug1H3f6KXjk5fg9vr
	4fiGTnL2FJ44Ex1GpUeP9Sg=
X-Google-Smtp-Source: AMsMyM7V0jWaYMejCjjBwvos1eWkWorpojnU7u8wFu3p2iQGarhhfM5w+u+UJF18+ij6iUmRLalRAA==
X-Received: by 2002:a2e:8186:0:b0:26e:8cc0:3d0c with SMTP id e6-20020a2e8186000000b0026e8cc03d0cmr2344263ljg.425.1666169407575;
        Wed, 19 Oct 2022 01:50:07 -0700 (PDT)
Received: from localhost ([2a02:aa7:4006:e2e9:da26:9eee:3340:6a5b])
        by smtp.gmail.com with ESMTPSA id l9-20020ac25549000000b004991437990esm2211765lfk.11.2022.10.19.01.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 01:50:06 -0700 (PDT)
Date: Wed, 19 Oct 2022 10:50:04 +0200
From: Pankaj Raghav <pankydev8@gmail.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, Arunpandian J <apj.arun@samsung.com>,
	gost.dev@samsung.com
Subject: Re: [PATCH nvme-cli] tests: Update license to GPL-2.0-or-later
Message-ID: <20221019085004.54mtkhi5qoix5ef6@quentin>
References: <20220517061456.7623-1-dwagner@suse.de>
 <20221019070321.ra5wns3sc3dv3r74@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019070321.ra5wns3sc3dv3r74@carbon.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_015010_832363_08FBCE56 
X-CRM114-Status: GOOD (  13.95  )
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

Hi Daniel,
> > When I reviewed the tests I asked wrongly for GPL-2.0-only. The
> > project is using the GPL-2.0-or-later license. Relax the license
> > requirement to GPL-2.0-or-later.
> > 
> > Cc: Arunpandian J <apj.arun@samsung.com>
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > ---
> > Hi Arunpandian,
> > 
> > Sorry for the mess, but could I get a signed-off-by from you?
> 
> ping?
> 
I heard from the team that he left Samsung. Do we have any other
alternative to get this patch in?

-- 
Pankaj Raghav

