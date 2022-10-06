Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A55C433FE
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Oct 2022 12:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jbbunQNMPloTuntY0ZQ37zu1JnfQlYhwRzvSx8ZYj5w=; b=PjcEilXbogZT4gZCfm868Zixqx
	4/2fpqsJO+uFPFr3iz8rjcqZq6oRcPdOewZHnRGjBf3P06JCgJkHUWM9ATIvITg5jAdEGNRIxl7la
	uSeSZyzOvj2ItRBn0voHo1XfOa/hFEqJOP6kYV7jhvVAlaa76dc9WwE22lftB61gglGAomHFjItPH
	B5nRlhCp2k+faB8FY8P3HzloP2hd5LChdQ0Fv1FIbA6HJlsaJTcMEZAtZF0KlXnQnnXdvyNJC4B3k
	Sj7SxxMOjFo7ylneBUO4bjZ55/Yi6/bIouOFlTU16W6fXZq1GU12vcxOUs5CyRu83TwTKMxBPhh2w
	lStFvuLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogPnv-002Bl5-EI; Thu, 06 Oct 2022 12:16:43 +0000
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogPns-002Biq-VT
	for linux-nvme@lists.infradead.org; Thu, 06 Oct 2022 12:16:42 +0000
Received: by mail-lf1-x135.google.com with SMTP id d6so2390007lfs.10
        for <linux-nvme@lists.infradead.org>; Thu, 06 Oct 2022 05:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jbbunQNMPloTuntY0ZQ37zu1JnfQlYhwRzvSx8ZYj5w=;
        b=ebEIZIdVEhSz8fpmgaRxDUzPi4+xoFaeLMvG/w2zHWAL43NM3zk5n7rHrvwkoQ3vEQ
         /+QQSdwrt2mdxB9AHmrTkUZJoaYqMuMJUWVIl6Y4CSbkqJCTc3/ONTIujqfwbcylIO+O
         qddVF7lOfg4U3Z+jWiHKIzpXQ/1d9agvV9X1iW8d2PEhkvZxEuRalJFNa8ioth0j1MUL
         o+UovxhZ/RvKuv7xu7PIEFi6hOvyYYcx5KrgpBAa6zjSTvwscSAyG5JK+doy/UnpO90M
         yk85FV2yfmJFobZxLOOi2YSfizu1C2m8a/LxO9ePRs6iS0tj1tJK2uYi63lBYEfs0n9x
         fHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbbunQNMPloTuntY0ZQ37zu1JnfQlYhwRzvSx8ZYj5w=;
        b=RX417xO0tHVok7TEBid6LIkUlWR6pBRTJk3mFRKjBHbBiC6pqlccGpa6dZj5OfW/4k
         9gLaxVFO1/ueUZaZgwykqql/ZZJWnAuYkas0bn42/mM4VPPwHk5yOF+wP9GcLvtLQ/zC
         9dO/7Gb8Vs4uGpS1D8wOg7DABj1UbbthQUBFlqqz33qrUtJB+51ul2FiAK3Izfoe8p5O
         1M6TT+d+bfSFImKSpeMPAo6LhgSHRTS4qbapy3grXciEttVETKpMr56xfOr5B0zkNRL/
         XD/OPp2e30mmSqQXpy14mAsj9CMxuIEBxoZUWsYMXIPBoe2FW+tX58Z3n5fvFNHao4z4
         DYwA==
X-Gm-Message-State: ACrzQf3hmJwZd5XMXLciY1KMKPUkixdCvgl/bgqBspO+ffbhdxxJSFqN
	SFHkn0qbDOvSuMtExHGtnyU=
X-Google-Smtp-Source: AMsMyM50ao9hPAr9v67m4fuduKzYDW2KBwmbQg4bqI62SEKPLB/xL/h9LpR1N6BbuntQUgVUjI43Jg==
X-Received: by 2002:a05:6512:4cb:b0:4a2:25b6:9e73 with SMTP id w11-20020a05651204cb00b004a225b69e73mr1842854lfq.30.1665058597739;
        Thu, 06 Oct 2022 05:16:37 -0700 (PDT)
Received: from localhost (80-62-116-36-mobile.dk.customer.tdc.net. [80.62.116.36])
        by smtp.gmail.com with ESMTPSA id y22-20020a197516000000b0048af4dc964asm2673804lfe.73.2022.10.06.05.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:16:36 -0700 (PDT)
Date: Thu, 6 Oct 2022 14:16:35 +0200
From: Pankaj Raghav <pankydev8@gmail.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	yi.zhang@redhat.com, Tomas Bzatek <tbzatek@redhat.com>,
	Alan Adamson <alan.adamson@oracle.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	gost.dev@samsung.com, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v1] nvme: do not log errors for user commands
Message-ID: <20221006121635.awoafzxyu6nkrqfj@quentin>
References: <20221006093628.22089-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006093628.22089-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221006_051641_047144_5DF3CEAF 
X-CRM114-Status: GOOD (  15.01  )
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

On Thu, Oct 06, 2022 at 11:36:28AM +0200, Daniel Wagner wrote:
> User space might issue commands which fail. Even though userland
> handles them correclty, these command get logged which irritates
> users.
> 
> E.g. libnvme's nvme_scan_topology function is using Namespace
> Identification Descriptor list (CNS Value 0x03) for discovering. It
> handles the case where it fails but still the kernel logs this as
> error:
> 
>  nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) DNR
>  nvme1: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) DNR
> 
> This disables error logging via nvme_log_error for all passthrough
> commands. Instead reverting the complete patch, let's disable this bit
> until the interested parties in extended logging have figured out how
> to do it without introducing regressions. Removing the now
> non-functional part in nvme_log_error can be done later if needed.
<snip>
> @@ -151,6 +151,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
>  	bio = req->bio;
>  	ctrl = nvme_req(req)->ctrl;
>  
> +	req->rq_flags |= RQF_QUIET;

With this, we are disabling logging for ADMIN and IO commands via the
ioctl. IMO, the error logging for IO commands could be useful for
debugging. But I do understand your regression argument here.

>  	ret = nvme_execute_passthru_rq(req, &effects);
>  
>  	if (result)

We can also send admin commands via the uring_cmd interface:
nvme_dev_uring_cmd(). Should we also enable RQF_QUIET flags for them?

P.S: I sent a patch today that touches the error logging in NVMe that
sets the starting LBA as zero for IO passthrough requests.
https://lore.kernel.org/linux-nvme/20221006091053.36611-1-p.raghav@samsung.com/


