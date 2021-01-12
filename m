Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63985C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 08:45:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D479622D58
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 08:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D479622D58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DDU9nUAo9n2TQyvZc6P6kvL3RI2uNAqWJuGDQCAe4jg=; b=NqpSeYHdWoPlC680Jq9DnVPEZ
	rTVbPj88wk2aHw66DDw6Dmg7w2c5ExVJdE1yUg1c0d0IgRtuxE+0t0mxdzVW4kWytbe8VGFBaZdZW
	WCL9tmGHvugVmKmMOtQIQUWMPkqexMD0e4NTNQ6otImwJUcDPFJBq4M0rnEyY8+SmIrkVPCpXtTBH
	OrGkdU1H9lT+QRnXq1yD5t7t7zkQnCW5lMJwTQ9zZL42ecgaw50Ft/6UImNdS/3iLhjWOIH6T9Oxm
	cm7xdnCO9ucUwrDS3ucgjjyqJWwpkJ2eT8o1SE06skE/m0YQG4omxLps/le11xCnT8Yu6Ulyt9Ult
	A/QwbjpDg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzFIZ-00012j-8h; Tue, 12 Jan 2021 08:45:07 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzFIW-000116-9a
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 08:45:05 +0000
Received: by mail-pf1-x42e.google.com with SMTP id c12so969684pfo.10
 for <linux-nvme@lists.infradead.org>; Tue, 12 Jan 2021 00:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=jWPX6hZmgVK227TfENtErWR2Notm/O/UHamVxkWEGjs=;
 b=NguMxHSY/+K0kZu7qjxoCizr884q9x+P/7C//Ih+x+n5Xh8gOCM1Vi4WfhMBisUs4M
 Bjy7sY2Gojfa0isLDMuxb2VjncjVEe0IGECzLBuADGo76t9qIsdY7fZlcrNcdy18NQGF
 5eya2VkSKq0OiHhzwkKvfbMMkgqbZIAYby0xPuypZGE0yXVdKNxmvZ96AkS2VNaIsQty
 R3yRhfNVQlcQ7XNqGCcCJEgPj/qEN/R/Bouck/SEoWwlUJHMJ0jiiFTXbe3agOxC/awP
 yqjPKrBJqTpH15zSqa9E8RU6GhcYkjpQvdPd1ALo7QzRW1j5fkgFjv9s0/ap+rgXDETt
 +eLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=jWPX6hZmgVK227TfENtErWR2Notm/O/UHamVxkWEGjs=;
 b=NuLWaFzWnptub5SkytN/iYQGF896X357XCXFw3wpYJmlSdjl5g11gV57FQm7M0aQGG
 pxM8IP4mCHNLQzUXgR5Yf3LdoUfGJA8UakTBYD/FIqw3MuP14Noy/WBrF1E3YqVdzQWy
 P+22LeLmjkHRTw9FVSRxlK91SBkDcUwINfaHQw18LodNTVOntpgWy+nagmR3sDNMt1aV
 +wFwHJcKl2/BOAuZjRD62FTlJaPyXw798Soh5fKOvq+ik3aQxrRXQu7X+kXGl0Ea3poh
 39JoX79HvUgPDWl9w6L7FIIrhO9JCuspapXmeB7OvOX0yXqKsQTttWWYM/xpYAGGo+9i
 PeUw==
X-Gm-Message-State: AOAM533l3TX71SsZSDMwqOo2iaGGQ3ajmfSCqF1DHr4RQ2cdTd9TnCZg
 JDCOjAXQmm3aZVboZiw0RUg=
X-Google-Smtp-Source: ABdhPJxwDi2sJp6ODthHldjlNR6gvl/EFHK3mfKji6+KNLnh8DKdRUXQxd3D222TLh6P5ZW+Yk9SYg==
X-Received: by 2002:a05:6a00:795:b029:19e:28de:e92a with SMTP id
 g21-20020a056a000795b029019e28dee92amr3761026pfu.36.1610441101979; 
 Tue, 12 Jan 2021 00:45:01 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id h8sm2732083pjc.2.2021.01.12.00.45.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Jan 2021 00:45:01 -0800 (PST)
Date: Tue, 12 Jan 2021 17:44:59 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/3] nvme: add parameter command_retry to enable retry
Message-ID: <20210112084459.GB3227@localhost.localdomain>
References: <20210108144659.7126-1-minwoo.im.dev@gmail.com>
 <20210108144659.7126-4-minwoo.im.dev@gmail.com>
 <20210112080926.GD24949@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210112080926.GD24949@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_034504_401061_0E2AC866 
X-CRM114-Status: GOOD (  18.13  )
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
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello,

On 21-01-12 09:09:26, Christoph Hellwig wrote:
> On Fri, Jan 08, 2021 at 11:46:59PM +0900, Minwoo Im wrote:
> > This patch added a module parameter named command_retry to turn on the
> > command retry feature in this driver.  If turning it on,
> > REQ3_FAILFAST_DRIVER will not be set to requests so that retry can be
> > reached out to nvme_retry_req() based on the module parameter.
> 
> Why would we want to do that, and if so why only conditional on a module
> parameter?

If reqeust->cmd_flags are set with the REQ_FAILFAST_DRIVER in
nvme_init_request(), then it will always go to COMPLETE case rather than
RETRY in nvme_decide_disposition():

	if (blk_noretry_request(req) ||
		...

And I thought that to make command delay feature enabled, module
parameter was a good start to toggle this feature.

Thanks!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
