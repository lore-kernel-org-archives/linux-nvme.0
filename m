Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83547C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 03:28:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1749723741
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 03:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1749723741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Y/DeWR9UUVEMHp7SPb6Hca/hadOnhtFW0FC9w8aN7ME=; b=gNXrwZrK447kJ1GFbt0EsbaoB
	0oSFCF4ZzuGr2nw2EZpofF/RgEWrWmfxC7vf00ZnPsl4Sz0hbkfWAywv24YwVk7ylmVrbb8CViJPd
	H4GPtlwFR3wIRPQDkG/CUQa96/HAZ+QrmfVTb5Wi8CAYtORC+iF7U5e0ElFukC4xMkfc3fQGTfHiJ
	G98469l5YAADTPx6zWZlywyhlOGrIh1+mthBaI4+77nNBwU1Ut40w9FF74aVOwO29XUe18t40i74e
	f52gKrNSGfP2BRaw67jN8ucZTMd64C7muq5wo3ol55T1epeuBr9QAoywshdO2biazjjclR2BF4QSj
	RzTCjnoDw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kztJ4-0005fG-2W; Thu, 14 Jan 2021 03:28:18 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kztJ2-0005em-G9
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 03:28:17 +0000
Received: by mail-pj1-x1031.google.com with SMTP id b5so2448166pjk.2
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 19:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=9nhkkrtE602ulc2IMgIwy29Wa+SX1r7yBCEy7VZ3Qvg=;
 b=kaD83Q3aYdlj97Dn4goQHJ9NkdXeTnRNOQgx7wUYfNy7ZC975Blw6sqLnxk2E6JW+F
 QIpZ/wQDb4sBqFloCoObY3aQH6Q3fwcMiTAj7tfO2DwJgothpmg+Bk9DlW2AvBeZWWxe
 Lmcinz+Ol2MFzl4YIDI0EnwnZg121DxEJcLCMeja6fP4a5xU6J29YfcW89hgkcSeDsLo
 ZAiZvsG216obVeeMMo+sNTlNqFj2+ErA06TMJUAVxLarvY4FSfTSbnbJLkp9FVB593BI
 oxmKngSYkFSx1PAngAbogjpxt6vUEGsFGVM+2v4pfc9Xa9/chyeYET4371V85uryc3Dj
 jtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9nhkkrtE602ulc2IMgIwy29Wa+SX1r7yBCEy7VZ3Qvg=;
 b=tBbnDmXXvIXtG/jrrcjD/bxiAvBW1vqPAtKxSiUXSApqxhKwO6YExaFznlVfM3VO6n
 4Ct5w9PELlUDV3qG78/CsQBjpox9Fy9GrYVft3yRm4K9zdg8jnqVBTUZJERmWNb0ippY
 Hhvr2Iu0qHi2LWdcEXd6ai9eyiGtkrsJzDwbWSc3uU1v3+frZK6cuRGcVdgewPNJ9P+m
 MK4cljCQaBqmNF1vvjEwafDCNM6+GGiBIqAh1nk42axLrZALshr85lQJoVsOV4LQg6O6
 mJx3VQPgCJ/a9U5AwU+qd1vpO1obA4z0fpo8MoT2tulJrxtx0vHyKIq+vz9lPW0VJWqQ
 G2yA==
X-Gm-Message-State: AOAM533KB7UAd4u/M38w/PQ9j/l8vQEzW9yItL1G+eToc36vPWumFzRy
 1LKQbDLz4TZNJLDwPPzggEU=
X-Google-Smtp-Source: ABdhPJyEQskrNk5skZKExMS5R4OsPPXGdxpn08cMVLvd1wdjl1bla7VzJQkF/MdIZeTk5WsOKXI76g==
X-Received: by 2002:a17:902:db84:b029:dc:2efb:659b with SMTP id
 m4-20020a170902db84b02900dc2efb659bmr5578907pld.83.1610594894380; 
 Wed, 13 Jan 2021 19:28:14 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id d24sm4042975pjz.13.2021.01.13.19.28.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Jan 2021 19:28:13 -0800 (PST)
Date: Thu, 14 Jan 2021 12:28:11 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2 2/2] nvme: retry commands based on ACRE result
Message-ID: <20210114032811.GB5817@localhost.localdomain>
References: <20210113143538.554-1-minwoo.im.dev@gmail.com>
 <20210113143538.554-3-minwoo.im.dev@gmail.com>
 <20210114031102.GA1509941@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210114031102.GA1509941@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_222816_570785_2A20BE56 
X-CRM114-Status: GOOD (  16.09  )
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
Cc: Jens Axboe <axboe@fb.com>, Chao Leng <lengchao@huawei.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello Keith,

On 21-01-13 19:11:02, Keith Busch wrote:
> On Wed, Jan 13, 2021 at 11:35:38PM +0900, Minwoo Im wrote:
> > @@ -317,6 +316,13 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
> >  			return COMPLETE;
> >  	}
> >  
> > +	if (nvme_req(req)->ctrl->acre) {
> > +		if (!nvme_is_path_error(nvme_req(req)->status) &&
> > +				!blk_queue_dying(req->q))
> > +			return RETRY;
> > +	} else if (blk_noretry_request(req))
> > +		return COMPLETE;
> > +
> >  	return RETRY;
> >  }
> 
> This is returning RETRY for path related errors when blk_notry_request()
> is true. That will deadlock initialization on a command timeout. The
> check should be something like this:
> 
> 	if (nvme_req(req)->ctrl->acre &&
> 	    !nvme_is_path_error(nvme_req(req)->status) &&
> 	    !blk_queue_dying(req->q))
> 		return RETRY;
> 	else if (blk_noretry_request(req))
> 		return COMPLETE;
> 
> 

Thank you for chatching this!  As Chao pointed it out, I will prepare
the next version of this patch.  I really appreciate it.

Thanks!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
