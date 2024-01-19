Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FDCC47DD9
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jan 2024 20:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ncAX6oaHpEMJrBj/7gkdXNsQoMWvfR0NBQ/WafmPz3o=; b=sLhxkgHpCBlwm5T2+zh22AxIR4
	gfiWVyEA6CZzUFPGTmdXvuYYBW5W6EV0faJDqBRlHJxfZg1R7pGsaTMp54PUszldykai9Mc2mE8dj
	mGII9oGamJO1LW0eplfuYkigpmX+Z892QTyUPVc/l0zReJ493X67+CbsMcoVXF7/CokZsiSGLaCVE
	/tBn+xmMkPtaAvF/Fgvtg0Q2KACT8viHlzVCnqlWEUpKsUvKuZPqQ/iw3ADHSZj8BYz9B0yw6lene
	PKcd2Kf+OWhdlSm5tFQk0Rp/TISTKWLybWrbkdTP6JsMuFABCZ8AOwfuqyvwgU0wrHOBAY/YTHw+7
	qGEvQ8OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQvWl-006ZRs-1w;
	Fri, 19 Jan 2024 20:31:47 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQvWi-006ZRH-2w
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jan 2024 20:31:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 2AE8ACE1EBA;
	Fri, 19 Jan 2024 20:31:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AF5C433F1;
	Fri, 19 Jan 2024 20:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705696302;
	bh=T+iusoCf36oS0nV4RUdsIgsydjZH09SrGeZ9RB2ukiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RGJKHlfAlypNehD5+0vNY/Sy6bqJ/A4R4u/+M1jv22XzcXOIr67js8ZQqTu8W6/7U
	 XY3yg+3uUMMFD7oxLxcKWnD+o/BESFcP0NAzzTquoCY26ufXKkZIjhYUdr2ktL3Fiy
	 t/FmWQNL09iNjl31KmuXAflH4Mz1PhH95YJqL87hDLAEPM+J2Dtu5jrfnoBUp6K66d
	 lGbIHKsotWOUCnIuBHCPNYiDqELzFcxAARxRncatMU8AMt5jprrMS9GVT3AXfKQ6TE
	 HDNgZB/xnxsJl597kfhdxcX3NXkG0P8oCMQpVayUUSV5HjVEhPjF2VvNKf86dMvP2W
	 XHrSUIEsXYMsA==
Date: Fri, 19 Jan 2024 13:31:39 -0700
From: Keith Busch <kbusch@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
Message-ID: <ZarcKxcaG87VE5XR@kbusch-mbp.dhcp.thefacebook.com>
References: <ZaqiPSj1wMrTMdHa@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaqiPSj1wMrTMdHa@casper.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240119_123145_151610_1ACD2FA7 
X-CRM114-Status: GOOD (  15.79  )
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

On Fri, Jan 19, 2024 at 04:24:29PM +0000, Matthew Wilcox wrote:
> It's probably worth doing another roundup of where we are on our journey
> to separating folios, slabs, pages, etc.  Something suitable for people
> who aren't MM experts, and don't care about the details of how page
> allocation works.  I can talk for hours about whatever people want to
> hear about but some ideas from me:
> 
>  - Overview of how the conversion is going
>  - Convenience functions for filesystem writers
>  - What's next?
>  - What's the difference between &folio->page and page_folio(folio, 0)?
>  - What are we going to do about bio_vecs?
>  - How does all of this work with kmap()?
> 
> I'm sure people would like to suggest other questions they have that
> aren't adequately answered already and might be of interest to a wider
> audience.

Thanks for suggesting this, I would like to attend your discussion. If
you have more recent phyr thoughts (possibly related to your bio_vecs
point?), or other tie-ins to large block size support, that would also
be great.

