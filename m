Return-Path: <SRS0=Ydhk=OG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5801C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Sep 2021 19:21:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79A336108F
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Sep 2021 19:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 79A336108F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y4x7WXkL8+YpVJL5hZSctmsjUsk1/0+BK5ct+Dv0VZQ=; b=tTqNMW0kEurTYj
	TobhvvI0KwK4wXVYNPjhvBdR0nh2IknO0G6RADxMohvJAoktLk8696SMzhFi/e6m7gzrAirs87onX
	rtt4lfoXTFUPNthw4bnq0ng6270a/9Bt0QVFzrZhGr1hHXHgs9q9nendrMxMuprueWOod7o5IyVsv
	99RbCRJE/LbnIZiWuZ4AMamnWAwvY+32rU6uhQOzSFVX7pYOvpEhSvYw5D+xE+EXA761yj7LrgHbU
	J3ESh5LX1pu6lwzc+5mwpyA/qVm/3thozoR38gw/fxQeZh2spJxmjlQ/LTVis8+nxN+f8FfaOzzxm
	48q9Yz2rR9lvoMhoELbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQwwX-00CFf9-4a; Thu, 16 Sep 2021 19:21:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQwwU-00CFeo-CC
 for linux-nvme@lists.infradead.org; Thu, 16 Sep 2021 19:21:07 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3D4D6108F;
 Thu, 16 Sep 2021 19:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631820066;
 bh=RaMDp2jvBsk7cGF5ttJERgg1GFSeEE0GDaCKL7Sw5vU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XidaLujsQaoOHuisnYtMi9+VgdLc6SPCq/xmcg0R6nh8L84a4+3G+GcbDgSuXKoCL
 9IUqE+MHrYjmezEwkgu2rBZnFGyzuW3OTT/HfClRtvIdBL2PBluOKkNRhWdHzAHtqk
 oQMvfw8qbRqEAZk0HuMeaKUzz4lZd66HTT8i6j1Z7+jCCOvNrE8h5yHvWjHhjANgAs
 6TJ4fY34zDtmCfv9Yx72taok8obFmSwO/cACkhlHyjCfDJ6Lkm0HCEgzXlCtR9+LUE
 EUGhoQJozd57zyujWmmOXHqKaA9oSMjeaJfalMPa+mPsRqpeFuEeUIsOUbgfxuHWa6
 fKhfc26Xqi4uA==
Date: Thu, 16 Sep 2021 12:21:03 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH nvme-cli 1/2] add "State" entry
Message-ID: <20210916192103.GC3908552@dhcp-10-100-145-180.wdc.com>
References: <20210915132912.3004-1-chengjike.cheng@huawei.com>
 <20210915132912.3004-2-chengjike.cheng@huawei.com>
 <74cf36c7-9e18-2b81-08ba-cc4223f3b133@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <74cf36c7-9e18-2b81-08ba-cc4223f3b133@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210916_122106_479024_43C031A2 
X-CRM114-Status: GOOD (  17.36  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Sep 16, 2021 at 04:57:55PM +0000, Chaitanya Kulkarni wrote:
> On 9/15/21 6:29 AM, chengjike wrote:
> > From: chengjike <jiangtao62@huawei.com>
> > 
> > Add "State" entry in nvme-print.c
> > 
> > Signed-off-by: chengjike <chengjike.cheng@huawei.com>
> > ---
> >   nvme-print.c | 15 +++++++++------
> >   1 file changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/nvme-print.c b/nvme-print.c
> > index d321ec0..f2b12c0 100644
> > --- a/nvme-print.c
> > +++ b/nvme-print.c
> > @@ -5647,10 +5647,10 @@ static void nvme_show_list_item(nvme_ns_t n)
> >   	snprintf(format, sizeof(format), "%3.0f %2sB + %2d B", (double)lba,
> >   		l_suffix, nvme_ns_get_meta_size(n));
> >   
> > -	printf("%-21s %-20s %-40s %-9d %-26s %-16s %-8s\n",
> > +	printf("%-21s %-20s %-40s %-9d %-26s %-16s %-8s %-8s\n",
> >   		nvme_ns_get_name(n), nvme_ns_get_serial(n),
> >   		nvme_ns_get_model(n), nvme_ns_get_nsid(n), usage, format,
> > -		nvme_ns_get_firmware(n));
> > +		nvme_ns_get_firmware(n), nvme_ns_get_state(n));
> >   }
> >   
> 
> 
> Where is the definition of the nvme_ns_get_state() ? I didn't find in
> this patch, and your commit log is not helpful at all for the reviewers.

It looks like patch 1 and 2 are reversed.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
