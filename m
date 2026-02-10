Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E579EA3F18
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Feb 2026 22:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M/zMFrnCoe6Q9Z9tEuHYY0LJcYdBtncX2gTW0r5E/X8=; b=kcRDjDklN5IbSkHaswNIGTyekp
	NK5hcGRtYXrsUdSFbqQ9EfDEw8tYwKhKsvwJHldxccu98bgsrhPVuko3OcT3AbrUPcSUkIyQhidrg
	JFkwO5kZnSui2XEuRLGm9OAN9IzQLidXhHWVX1IML747g3BwiTHPqUXOKGeRui/R9drqzQDTu7esH
	v0icOC4oaq4wgQROqI7xSiXiAS7dH45dev0jn0BaACnyrzViuHORPv905tr11Pi+9hgzWPWJ7AubF
	qnvdRSuhew8/gr40W853g53AZ2G1RvgwbE9ruU5ffnwECpYkvqkIwah66wgYZGd1WFf3dRk2R2S2J
	yLUsT4IQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpwCn-0000000HZO6-3ZXQ;
	Tue, 10 Feb 2026 22:27:37 +0000
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpwCk-0000000HZNl-3O5p
	for linux-nvme@lists.infradead.org;
	Tue, 10 Feb 2026 22:27:36 +0000
Received: by mail-dl1-x1231.google.com with SMTP id a92af1059eb24-1271257ae53so1659731c88.1
        for <linux-nvme@lists.infradead.org>; Tue, 10 Feb 2026 14:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770762453; x=1771367253; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M/zMFrnCoe6Q9Z9tEuHYY0LJcYdBtncX2gTW0r5E/X8=;
        b=TvEZFAfLBzhmlzuaG4wHGx0hzMpP97WcRhuaTQ8aZD3JuZN/YLQzUC58jzsOr6fpY6
         QL0KqdpCGKDMEuKc+BcSNxxuWB8FXDGp9WlSj454aIQ5rAyTnVO+pSh9FJE2gsZx5JnZ
         6smi2z8c313aJQo52L0g8gH4T23XJB0F7s/UGKKoeMQs0Z1ohw+dP51RMR7bDWf3YazT
         2e+T5otrCTwjvkyixkQ5leoHANwOYAEaIiWPXQuJfO5QP1XGTAhwHCwCtFK9Q1srwqOM
         zpS+Mz4L9nt6AToXazeFsqy+oV/nn+wYC+1qFnFNYigBp8pJyITE1mg9HIG1ZAfg864+
         YSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770762453; x=1771367253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/zMFrnCoe6Q9Z9tEuHYY0LJcYdBtncX2gTW0r5E/X8=;
        b=B6MqVgth/BM5FqMOZQPG4MHllJwkdkSvHCVa9ImzrJQoznXB2OQl8kpWwSNeH04zkC
         Vp1CcCV9uVq6PZnUIXkwYjvbFR0Z/c5mkmm2FO+nayK1IwJ3kGaHtK/jLIpZdPpykclS
         hMv4NEzDwgNhP4FaaoV0c9/e6lZf1tVjFO55unjJM11xj59bO4uaYC8oxi4RQSPp7xSn
         pePrrvZgdPlc9Ubq1E22eQtKTa947H99kGnsmW9iVqZ98FuCzcg9fgZgf7JTZpqsxr2t
         PmvVxsb1IqVvWz7PQ18sVoAGL2bOU6nUieKqILIKC47lf8OtsnPPEY/r40YI7/sTG9Gf
         sclw==
X-Forwarded-Encrypted: i=1; AJvYcCWEghVYCL7bcVnmC8/n8XQa0qod4uE834j3rBBfKrS4T+21OPwgirBScUq/9YunMVgEqTGIrdaLMk1h@lists.infradead.org
X-Gm-Message-State: AOJu0YxxhKJCfgAuUC+LzYh/IPyZiBr76AjtEwGPGx0ekydgn7mriEcQ
	ShJ7TyLGpsYgLbNAjYoY0rJQocDqh+g/1StaPI00eJOULaHb45vp+VR/epl5hkPuyDc=
X-Gm-Gg: AZuq6aK4nE2bLYWZKlqHp3yxVF/h/7RXO/EdQt1M/lNow3dBBL1nS8hWBrX8Wvq+iDS
	92jUy9cAYQ1z92MmKbBSzIokfqgGSfTn88C5RKvAyG3fIj52wZXE4BziunAccD4q5nR/9Ge5TZO
	hge3ENkEpcWaCj2yT8HWNrdmBskdZ2wzusIyItPmK6OH/hxGMW8fAMpiwbGuik4wTunykXLG01l
	QFzRVrbkhtl6sR7X6kt6F/PobJ4wbYOt6bHgKfHDqxP0SalKZSyJGbZr/O7UQ7ciw0gww7YUCtX
	jNLAavpj9JWOTUXPxhBIqXfW2Mi1uph2B/YncVZ/gXGKZL2pnLCehaFYL7ivuEqdADTx63rqyME
	Y3fjwLnEnQDh+jiQC6+6TODiyhoDkAQHBDCYP02zLwGBiC4lQQHCvnLoQzM2jEaf+HMPV/1pedT
	af+RHAJsQ2mKIDg8XbGxCpIKGE1NU2eAUELXRO3jx9O+cSe0lssw9CzQ==
X-Received: by 2002:a05:7022:248f:b0:119:e55a:9bf5 with SMTP id a92af1059eb24-1270401d549mr7403051c88.17.1770762453401;
        Tue, 10 Feb 2026 14:27:33 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-12706faa047sm10658404c88.14.2026.02.10.14.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 14:27:33 -0800 (PST)
Date: Tue, 10 Feb 2026 14:27:32 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: James Smart <jsmart833426@gmail.com>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/14] nvme: Implement cross-controller reset recovery
Message-ID: <20260210222732.GQ3729-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-9-mkhalfella@purestorage.com>
 <05875e07-b908-425a-ba6f-5e060e03241e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05875e07-b908-425a-ba6f-5e060e03241e@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_142734_850171_EC809E6D 
X-CRM114-Status: GOOD (  18.19  )
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

On Tue 2026-02-10 14:09:27 -0800, James Smart wrote:
> On 1/30/2026 2:34 PM, Mohamed Khalfella wrote:
> ...
> > +unsigned long nvme_fence_ctrl(struct nvme_ctrl *ictrl)
> > +{
> > +	unsigned long deadline, now, timeout;
> > +	struct nvme_ctrl *sctrl;
> > +	u32 min_cntlid = 0;
> > +	int ret;
> > +
> > +	timeout = nvme_fence_timeout_ms(ictrl);
> > +	dev_info(ictrl->device, "attempting CCR, timeout %lums\n", timeout);
> > +
> > +	now = jiffies;
> > +	deadline = now + msecs_to_jiffies(timeout);
> > +	while (time_before(now, deadline)) {
> 
> Q: don't we have something to identify the controller's subsystem 
> supports CCR before we starting selecting controllers and sending CCR ?
> 
> I would think on older devices that don't support it we should be 
> skipping this loop.   The loop could delay the Time-Based delay without 
> any CCR.

I do not think we have something that identifies CCR support at
subsystem level. The spec defines CCRL at the controller level. The loop
should not that bad. nvme_find_ctrl_ccr() should return NULL if CCR is
not supported and nvme_fence_ctrl() will return immediately.

> 
> -- james
> 

