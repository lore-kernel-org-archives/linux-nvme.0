Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9A6EB64DA
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jul 2023 10:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YTxad+5h161kTn+agmv4fw9HJH6Ke8XgP1lafVJbXrk=; b=vY26Ojml6sx4t0W2F/xqbnBUls
	RfSrbts33m2ydAQ85hGujN0Q++7EZyafrZffHN0CrF2oUBjQpRFP4aFAAJu4YnPHj26woObfz9m39
	1ELEBM7+8S2YHjBnsrDud87mJi3m2L1AudqpTkcweGFyXWUkk+aBYmuDYZP2VF3eedV26qyD6abqO
	v2Gu+kRmqfEyiSZe9eXXKWox39FTGp9clh5QKQv68TvPCCcWZqZW6Aub8IZ93ANaFG6Xba7gsO7Fa
	TVLP5cOMSlPjFVQ4iortug7ZjJoewncCoKHqWQ7z2ZSe3CoJkHD0TDhDr3MHQkNTpQPh9IBDBWCA/
	H0wQmQFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qM43G-006dmY-2K;
	Wed, 19 Jul 2023 10:04:58 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qM43E-006dlz-0v
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jul 2023 10:04:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 46ABD6131C;
	Wed, 19 Jul 2023 10:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D12C433C7;
	Wed, 19 Jul 2023 10:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689761094;
	bh=YYuM5TJ7Mjk7vwTQijn9eQ4RDymiY2fPsa75ocC2usM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TaOx8KeI8L1l8ZZSWmLTQVCD9LbyW+9t/KrYmf++ujEzBXfU9rxJ/cmUEUGkLWxb+
	 HHRg5JqS7IM/Kpv5yclIMkgDRHrUTUGl3BWAFYWg0q7piLldZCT98KipIskaG8XzOc
	 GcoNmVIJnlbRTRFfDq4m4KvnU6/2ul21gB74ZEEE3zb9CqaY7Q2TCN/9UumfDmV5Bj
	 CrI1e5y1B9siXOe3yMv4Spkx+HZLr8XcVG/9P1atbfXEDS2Z670t5InQZsqZiHHLjX
	 cMKAkXBcQisbJX+VyJgaqLCsM2qxQonsFUbwNM2rAGRdOH4WVqkjXO/+RmgjO45cbb
	 9EH9kHD9pk/8A==
Date: Wed, 19 Jul 2023 12:04:50 +0200
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v1 1/2] nvme: drop multipath config option
Message-ID: <ZLe1QmfGg488wH9D@kbusch-mbp.dhcp.thefacebook.com>
References: <20230719084147.16272-1-dwagner@suse.de>
 <20230719084147.16272-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719084147.16272-2-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230719_030456_383846_0BDD581F 
X-CRM114-Status: GOOD (  14.45  )
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

On Wed, Jul 19, 2023 at 10:41:46AM +0200, Daniel Wagner wrote:
> @@ -3497,13 +3495,10 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
>  			goto out_put_ns_head;
>  		}
>  
> -		if (!multipath) {
> +		if (!multipath)
>  			dev_warn(ctrl->device,
>  				"Found shared namespace %d, but multipathing not supported.\n",
>  				info->nsid);
> -			dev_warn_once(ctrl->device,
> -				"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0\n.");
> -		}

From my reading of this message, I thought the intention was that this
driver will eventually replace it with a:

  			goto out_put_ns_head;

instead of letting the namespace become visible for some unsupported
mode. The warning was to give people a chance to migrate off whatever
unsupported setup they were using, not a deadline for when the warning
dissappears.

