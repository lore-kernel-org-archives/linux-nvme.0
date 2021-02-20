Return-Path: <SRS0=hrUZ=HW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B4DC433E0
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Feb 2021 15:40:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 023C864ECA
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Feb 2021 15:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023C864ECA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5yJlmpG3Naxr2lJi6Br4tB0qrQ7e8dJb2geBxmg83s8=; b=KqJq24ksLCsBGvFB2wNqf6Z8Y
	eqJN5Y5DN1kmZg9dnfdmQOgWV1sUyrMjJsoK+705bAh4YXe5IVLp4wazk+QyzA1rh2rY1o4H1jtEx
	hcjIh40+PK/ma0JegFmRJIxcHHMqXsEAB0ZYXVZKDPsOGcL4UBP02jRBfc5jQcxVqKGv6sOwplBTM
	m6R15T1sRC7nEJkYq1Q+vtFmjWAUooo4q9DUgjDIoAbpsKyu2iIqerCuf78wgaccJayPKYqxOYI+s
	1geXMdJPdXXbcXoy4cjACWT0Y0//76OLiorqvFxcCqhequCEDUXWBCVVkksg5vhZWmEKF/c7nrsAT
	rQaN9WfbA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lDUMG-0007Xf-6e; Sat, 20 Feb 2021 15:39:48 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lDUMD-0007XH-SY
 for linux-nvme@lists.infradead.org; Sat, 20 Feb 2021 15:39:46 +0000
Received: by mail-pf1-x429.google.com with SMTP id m6so3872389pfk.1
 for <linux-nvme@lists.infradead.org>; Sat, 20 Feb 2021 07:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=jL78P8iozXKyHKO85oZNv31v3JOb6CKWwroOsiUgZp8=;
 b=f99rJD98xKYiXqqtWd/hkwIgWAMNV3h4dwjP/cBrGcdq2JAH7bEzif0aRlMfzDsqyc
 Iu3gOW7ymV1WKuW/a1ByznldOuQhwLh6qfwAuIZGxnuh2dyd91dYEWhz463R3e7MG7mu
 uz8K9D9lYZAFH1Dgj/AQ1GOsA3nn8MV73/aYLR417FCXAu3LtXvoL99KFFOdRFyBWL32
 rJK5kcLdYbtGLmOJADR662wb4gMKR9rw+Sdou8/EagsYnRCYaurFk4ZD6NtEYQe1Z6qd
 yjzpuKbrmjb/auAEs9Xxt3gu2XAuZXgCdRf3hfg2YQLELk1bQCBXh66+JtyP5L+PDoz+
 tcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=jL78P8iozXKyHKO85oZNv31v3JOb6CKWwroOsiUgZp8=;
 b=bkbT9u9f20pY5TWZuKwwcJFbvg0MWCGFvmv4Dm3zAwSgPi04wa4XK+7YUyVx9ibDmP
 BSKk8a1dMcr5Z4KfPSuSDC3DsFOI49UFem5JMda0blEDY51RGzIHWlWpFfYmY1FUZXTF
 Ls4lFK1scQsyNid9glaFBIS0PzT9rlRjFa6WlLO6NZaGosIV6bxJcvGCCQEydfJngPph
 Tb8Z/UxwXRcrC7qcCV1xiEEZYrh2KbbKXB+GHhl+cfJ1h2yKoLwLiQs1yiRTDwEuE3iC
 Cs5meObonLB2wwnXw/9ZRcT6C0TkvgK5LOkZsfs9Dr0OyLY7Cc61WP6eG/JhN5mG0yLE
 NYcg==
X-Gm-Message-State: AOAM530b/ocfk+owSig5LvPrcLUkpic6ZvybdjwHUmUioVZ/3UkoND0Z
 YItxyqAuCyH6iwEdtfgmUYNYBxFtqSG1Cw==
X-Google-Smtp-Source: ABdhPJwakBHJ670Z7IN70YXI9lOkpzI9gZKTCUYyITGGF//xbzhLh5gkquTeFpUA3aIFgi0COHkUfg==
X-Received: by 2002:a62:2aca:0:b029:1bb:4349:f889 with SMTP id
 q193-20020a622aca0000b02901bb4349f889mr14581288pfq.26.1613835583646; 
 Sat, 20 Feb 2021 07:39:43 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id y1sm1466569pjy.55.2021.02.20.07.39.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Feb 2021 07:39:43 -0800 (PST)
Date: Sun, 21 Feb 2021 00:39:40 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: add support namespace management to sysfs
Message-ID: <20210220153940.GA237584@localhost.localdomain>
References: <20210220153610.237288-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210220153610.237288-1-minwoo.im.dev@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210220_103945_934917_AD14D0C4 
X-CRM114-Status: UNSURE (   9.03  )
X-CRM114-Notice: Please train this message.
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Sorry, please ignore this patch. (un-related changes are added)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
