Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BE3C7618E
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Apr 2023 19:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iZtvXE7JI7XQE3NpP4LKIkQwNvvYslpahddD3NkDfvM=; b=Q9HA3CA/1nl6gCZw2bHKCVKgV3
	GnoFyD31ZfNSP9uop/FERdaVV6lHeN/kL+5RKqore5FAf+uEKFttY6fBKNNROrO4Mrx0GoAlKNuBD
	5vlNePQS+w2eD7wJKKu5MGkQxSD4a6x7W6Zspr2eS6SenwYNOIzB2/Fm4rwyIxFEpZlfY9tbBvnxz
	XE4xTn1OJ1ihDDtcjoJI/nOABg13bb9QP9sv2JaXiVkRfRb0uLdNxEapiqG7ee5EjhFyzwk5ppjMs
	Flh81Ron3O1Y+2QqGgSLTUN049M5ppnBU7IgLhh8EjojVXfvTbMV3LYnct+7yBUihumE2MPGD1GeX
	M434M3JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppa6I-008soW-0n;
	Thu, 20 Apr 2023 19:37:50 +0000
Received: from mail-pg1-x563.google.com ([2607:f8b0:4864:20::563])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppa6F-008sno-25
	for linux-nvme@lists.infradead.org;
	Thu, 20 Apr 2023 19:37:49 +0000
Received: by mail-pg1-x563.google.com with SMTP id 41be03b00d2f7-51b603bb360so1363564a12.2
        for <linux-nvme@lists.infradead.org>; Thu, 20 Apr 2023 12:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1682019466; x=1684611466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iZtvXE7JI7XQE3NpP4LKIkQwNvvYslpahddD3NkDfvM=;
        b=Pf8cT72XXbXe06RRgFbTZWu6wDzJpL9TunjfZD2SBUHD3EFrbYzy2dDlJJuXOyfJFt
         gKd8uiFWmHKoM4wqzcCSb//n/TPpWpgJq9XvgW0KcA1JG9pT5nZNrB0DkT4TFIVFnTh8
         YeP6rpERhC/GgCY3idk2VKyGRWdBBzvYock5Pe+fyspcou/raSpp/bZ4mSBMTQEoEORv
         U7iAD9A5f9JXLMgxhQhG9j2wPqfNzHyob3MABk6yCTj2KIqyn+L2rm+6k/su783ByT4R
         Y/GVR5dKLAQ+jRet9sXFdDcwaYM7u+j9O5hTLDp/hnE8Qmpx+IamRlw0dYj/C4WUfdRn
         aUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682019466; x=1684611466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZtvXE7JI7XQE3NpP4LKIkQwNvvYslpahddD3NkDfvM=;
        b=Vcm6kizvKsThLDCDEOuSBRfUyxiMTuQs8Dg3N0JM8pAvkWgHsjH3bGc3uBywU8TkLx
         xyuwxq3nt92gGb7u8MazKSIdVi60IpNtrGuJ7SEfJ7UvRH6M50PLZsg1vOym10wnZpcO
         xTw1IiQhE/cRqXAoO8bpPR/F3ciKSCFpyfbLe+eswdvG4J5YI1vkCB3JAYhdJ4Zy0+lg
         WyVeD8TEMrlboHuZkDgWkLW79ZmFOAjetDN5A+3+K4sPKsW82+fYyLCzajQD1qTJDeqF
         KAa4MrOc+3jcby31PgeFNQTHFScw4NtutAgQgtOAmdUCPMkw/sp18X2AgO1GoTqNQpE/
         c+Sg==
X-Gm-Message-State: AAQBX9cu7k0WmOnHnuco6o03hNNPQcEfp/wkDr+UVpleASwAMXwbtYbV
	Cnc7zXJCN0ZpH8cq4ugqQXGydXikQfSSYu8LESnXC+TGMGiv3nnrUpsO277kveaSdw==
X-Google-Smtp-Source: AKy350bskiJmwyIYJTK9FeQslooNwtz7EGNCQktW4gTmpoXG3bd/FEJuOSF7CMg/COJu0r1YWOFb+sWK9gUX
X-Received: by 2002:a17:902:c407:b0:1a2:56f4:d369 with SMTP id k7-20020a170902c40700b001a256f4d369mr3253052plk.19.1682019466528;
        Thu, 20 Apr 2023 12:37:46 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id kl5-20020a170903074500b001a92e587f75sm121805plb.113.2023.04.20.12.37.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2023 12:37:46 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 5E82920950;
	Thu, 20 Apr 2023 13:37:45 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 53D75E42E74; Thu, 20 Apr 2023 13:37:45 -0600 (MDT)
Date: Thu, 20 Apr 2023 13:37:45 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Costa Sapuntzakis <costa@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/3] nvme: check IO start time when deciding to defer KA
Message-ID: <20230420193745.GA84552@dev-ushankar.dev.purestorage.com>
References: <20230417225558.2890062-1-ushankar@purestorage.com>
 <20230417225558.2890062-3-ushankar@purestorage.com>
 <c7e4a236-8776-d611-ed9a-ed46b14081fb@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7e4a236-8776-d611-ed9a-ed46b14081fb@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230420_123747_681264_C73C0DC2 
X-CRM114-Status: GOOD (  14.39  )
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

On Tue, Apr 18, 2023 at 07:56:58PM +0300, Sagi Grimberg wrote:
> > +	if (ctrl->kas && !ctrl->comp_seen
> > +		      && nvme_req(req)->start_time >= ctrl->ka_last_check_time)
> >   		ctrl->comp_seen = true;
> 
> indentation is wrong here.
>
> > @@ -1028,6 +1027,8 @@ static inline void nvme_start_request(struct request *rq)
> >   {
> >   	if (rq->cmd_flags & REQ_NVME_MPATH)
> >   		nvme_mpath_start_request(rq);
> > +	else
> > +		nvme_req(rq)->start_time = jiffies;
> 
> nvme_mpath_start_request may not set the start_time if stats are
> disabled...

Thanks for catching these, I'll fix them up in a v2.

