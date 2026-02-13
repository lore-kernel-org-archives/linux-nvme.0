Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F6AEF99CD
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Feb 2026 19:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JsqNgRjpkW7iWmmHD8av+9JnxKnt41E53tPLlYIjOWY=; b=UMKg+EQrl2+zt8tM3YxfvKG/rM
	+ka9n3w+qrJDbTFYQLp0SV5UeL3Gt78sG8lDFp0tIJWsPZHne5N0KSQaAK8jG6tu/8gfmrwSdT0mC
	wWsVyimzfs9l2D3uS7AFKkVjT4I6DY3d/gCeE8VDDHgToTcjzEGj/SZDr2gjy9aURbTU0BZUWpPP8
	+hnIj98gavVLdJbsQz0NFJmcXMDUAjvqieJKPycyQAON+sqJcnwocTutwTEzFMQA+qfRFutPUJq/J
	mi1JWW+KD7+SL2dTlETSCvT5SPSucNzL9TJ/0ACp45OJgfrCCV6VIb5/Yd2ScZmPVsh8u1qzGnLdt
	SYMhqmgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqyqn-00000003qvu-2YUT;
	Fri, 13 Feb 2026 19:29:13 +0000
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqyqk-00000003qvN-36f1
	for linux-nvme@lists.infradead.org;
	Fri, 13 Feb 2026 19:29:12 +0000
Received: by mail-dl1-x1232.google.com with SMTP id a92af1059eb24-126ea4e9694so3292654c88.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Feb 2026 11:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771010949; x=1771615749; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JsqNgRjpkW7iWmmHD8av+9JnxKnt41E53tPLlYIjOWY=;
        b=HhgYqcZ4U4Og/Lq4ZC84qUP8CT6BD7TsbStcH0R/PQ2pad/6bRyDExcFHJLKlldkOR
         BaVafUzYBxWnwe3aSMZyueV/keM1lIVPwNP/26G0ncVuIovex2Hi2wEoPIp9kN2aAqpY
         Qv/VhotXt+uKS79NMne+Dw4Fxh8ckbMu6FGsiwo+2paLmo3kP5fIV3/w8mZXCzL7KWGd
         e9hLpKB2+/vARWHogBBY9jZQJHJvpcisl6DNCwgmMmEcxI9hEbbtrjcwKb7wj0lFV3sh
         NFPj+a3s+K3JHnP7YSdqeUpY1tM9l/NUvPZraHZ1appyY3wRvsS1+emKUIbhQSdxyQLk
         m0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771010949; x=1771615749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsqNgRjpkW7iWmmHD8av+9JnxKnt41E53tPLlYIjOWY=;
        b=gfc5JiKonplftd30lo56qM34wUe6VDNqVlSfhf25Esme+t3b33nNK6amiBiciIEi68
         ihRZ1PaiVAZJYBugM519dbad789l+P6NEqplV8YEGwygVuVsHBypPk0y58ncG8fMa8Sz
         e4R+Y7lgagDFNQ4AlmzB6SEG0UjHD7Z4aK2u5B9Lur5ACn152SaJvc7yNhzLTUi6/VDz
         1RF7aDsUYlmTJTqrBPSWBcZI2eh4uJ+twmV9qigTpJIXQtXjzfxNMtzetCR6b4ELCRN7
         DW+ENBAv0GOY8iSmxME2zSwEpAzoyicj18o77xUh+JeaZfpUJ1IHobES0whXuMG4TZRE
         l74w==
X-Forwarded-Encrypted: i=1; AJvYcCX3opeviO5B7JSMkL9tjsrJh8uvTGOp8OaNws3k+ADOdc84qw+knqSdG8wd5lso48hX47LpGH6KB2tU@lists.infradead.org
X-Gm-Message-State: AOJu0YyRCdwsakXOSVZUY/UlLjJNu3AbFjQShdthByoVgzN0fLfoBJHR
	JGERQUvqN6e7G4GTVkik9G8JWkNcyIgngzrHIC/weDKA2QIKMowtnyTxFO7kIhUp8Q0=
X-Gm-Gg: AZuq6aIzGLKKCSP+ItSrBswd/UfkixHD8qVlXoI+QpwxFA+yzHRs4bbmENiaQ1WvqaU
	6a/kZZL4dDCCOx+2m0m2F8pxgnlNkLCmMYlW996Hq2qRV0JBXceVq3fot9KssTbuSILKGKukJrQ
	aGefvF6DHe5wXI4XnnvaIF/zO2g9Z87/JhuMEtCPMZtb4f0vUz19gsFO6sy/ul4QQZysgIfSiMB
	a6f8a1zWhQ8F9+mJqRgr+IlDx8eZa3mjizOq83VtISIO6RXLVzvXx+TpeRmGWRcyR5adUGedzBs
	sMyDpr0UlO8RM3K74a5k0NZy5+BiD22GkQBq3qGtx9Pn10BKiObkTSU8jRwqKmRDVB1+GVEXdWO
	ffcUa56cfatBp2DSPyny1EZvkhJYVfYWsyWDo4pSD2WOk2WaOP+PWBu6lhCp4dfQFWFz+GMJy8K
	ICCm/lZ+AQKrOXd6UsoiS6G8Bm4zLYNj7IV8pkCTIRSzs=
X-Received: by 2002:a05:7022:249c:b0:119:e56b:9590 with SMTP id a92af1059eb24-1273aded7ddmr1419185c88.21.1771010948854;
        Fri, 13 Feb 2026 11:29:08 -0800 (PST)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-1272a69c961sm6910804c88.5.2026.02.13.11.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 11:29:08 -0800 (PST)
Date: Fri, 13 Feb 2026 11:29:07 -0800
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
Subject: Re: [PATCH v2 13/14] nvme-fc: Use CCR to recover controller that
 hits an error
Message-ID: <20260213192907.GA3435530-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-14-mkhalfella@purestorage.com>
 <864e0ce2-4fa0-4d89-aaaa-a552977781a3@gmail.com>
 <20260210222036.GP3729-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210222036.GP3729-mkhalfella@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_112910_934525_618C3558 
X-CRM114-Status: GOOD (  17.79  )
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

On Tue 2026-02-10 14:20:37 -0800, Mohamed Khalfella wrote:
> On Tue 2026-02-10 14:12:24 -0800, James Smart wrote:
> > On 1/30/2026 2:34 PM, Mohamed Khalfella wrote:
> > > +static void nvme_fc_fenced_work(struct work_struct *work)
> > > +{
> > > +	struct nvme_fc_ctrl *fc_ctrl = container_of(to_delayed_work(work),
> > > +			struct nvme_fc_ctrl, fenced_work);
> > > +	struct nvme_ctrl *ctrl = &fc_ctrl->ctrl;
> > > +
> > > +	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
> > > +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> > > +		queue_work(nvme_reset_wq, &fc_ctrl->ioerr_work);
> > > +}
> > 
> > I'm not a fan of 1, maybe 2, state changes that may silently fail. Some 
> > trace message would be worthwhile to state fencing cancelled/ended.
> > 
> > -- james
> > 
> 
> The change to FENCED should never fail. This is the only transition
> allowed from FENCING state and this is the only place we do that.
> Do you suggest I put WARN_ON() around it?
> 
> The second transition from FENCED to RESETTING can fail if someone
> resets the controller. It should be fine to do nothing in this case
> because they will have queued reset or error work.

Sorry I missed to comment about adding trace message when fencing
finishes. Added it now. 

