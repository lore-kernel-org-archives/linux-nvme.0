Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33AAC6FA82
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 15:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aZS4m1wJ5siZy3uQhnyxxollDJ0LGTwY6AUsvXN/fsM=; b=P2gbhYtfbO0DNCg6JuePVy0ZiP
	tP6E/9sAxbqpJutXadTho4WM04Qgynh6udCFD7jukWFzkcqLHcLsb69pAF+oUIo0CyqwOkm14KEm/
	EVC1Es6KffjYL2iUI7P2GLd5l0ysN69GhNhAhkDJl1t8RAW6PTN4eaXue4pF7N4VJD1SrOmg8RZVb
	lmt5H4HHluLPjY51kKfcWod1jSS6mQ+YGOFy5Igl30/4srUl0HPF+eTzgYTSUQiOMah7YWgxwQArR
	/ql6Ya+3LVcHuG6zd+TKmn6hUDo6fs8l6bdk4e459K3rTsQzBWmWZIiEVFzTPDzrZ3PpYwLerCUPf
	mYMeJ89w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obO5T-00GR02-AS; Thu, 22 Sep 2022 15:26:03 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obO5P-00GQxx-3g
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 15:26:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 135B3B80D18;
	Thu, 22 Sep 2022 15:25:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3438CC433D6;
	Thu, 22 Sep 2022 15:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663860355;
	bh=poznrY4CTrw8KA9LGkTIZ6sSA44ugDWcov0/KS8+M/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sWk/ygaO7gSszVEY5gVieV573+Yz6kbT33bu2cGRGwJYYfBPV10e/2x/vEPQTuC00
	 TTVuAZtBrQXaPfLMBVcNG0XKtX6k1nIHhYTF2sltUBxTneRlVwPlAshuZMLwhOEF/z
	 Y55knOqMfiO36LmCFGlbv7Df8rqf1a59cLgoPDrDU8oZWIMIQVvl88BSrWS0kvBxg/
	 HElLWaMXwFJ1beySPboXZDDMLBhbzWH6HwQd/sg8LjeLhDn0R7pW5HvumlegmD8iR7
	 e4G02G6GXSc5rF0ZCJvwI7HCiy8my1Ck7bEulsSVv8CP63gfYwGSGhOc6jqDsNt0ww
	 ourTnHOmSh+IA==
Date: Thu, 22 Sep 2022 09:25:52 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
	James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH v2 1/2] nvme: enumerate controller flags
Message-ID: <Yyx+gBKsWiYjwpW8@kbusch-mbp.dhcp.thefacebook.com>
References: <20220922081538.13364-1-sagi@grimberg.me>
 <20220922081538.13364-2-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922081538.13364-2-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_082559_380645_CF30FBAE 
X-CRM114-Status: GOOD (  18.87  )
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

On Thu, Sep 22, 2022 at 11:15:36AM +0300, Sagi Grimberg wrote:
> We expect to grow a few of these flags for various purposes
> so make them a proper enumeration.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/host/nvme.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index bdc0ff7ed9ab..fcf891467e68 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -233,6 +233,11 @@ struct nvme_fault_inject {
>  #endif
>  };
>  
> +enum nvme_ctrl_flags {
> +	NVME_CTRL_FAILFAST_EXPIRED	= (1 << 0),
> +	NVME_CTRL_ADMIN_Q_STOPPED	= (1 << 1),
> +};

Don't shift these. They are used with set/clear/test_bit() APIs, which take the
bit position rather than the value.

> +
>  struct nvme_ctrl {
>  	bool comp_seen;
>  	enum nvme_ctrl_state state;
> @@ -354,8 +359,6 @@ struct nvme_ctrl {
>  	u16 maxcmd;
>  	int nr_reconnects;
>  	unsigned long flags;
> -#define NVME_CTRL_FAILFAST_EXPIRED	0
> -#define NVME_CTRL_ADMIN_Q_STOPPED	1
>  	struct nvmf_ctrl_options *opts;
>  
>  	struct page *discard_page;

