Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37969C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 18:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IdpWB8JZUc+stKA44tqDX3TX8JMi57BAnihHunT2fA8=; b=mx/wmECA9QPtB1NUNaev0qdF+K
	PLD+DcM/bymZyWBxZEoAs3LuaRIpjFA4Qm+RB4w4ZRU529QKPP+Jmh669S86ngaT+xyxboiVFQn0k
	1k5vrzmcRBMd2LzWbCxPsOmMx+LhSuYeQu/44V3ejPWowDNzZH55aNkq1i87S0J1rtmexzCy+OmuH
	8SjY1J3rnkzh1Dmx8SvjRFcHD9Mrfw08ROE/+Rz+iXQIReyr1Sw5jwhTcM+/oFGvZXYqO2eOvGcul
	YPtty+fzxYFHUPlR/fKB3uNr78dLKWsGufcFZs4QYGWFG5j+HxKMtWXmkgK5yXjIesBiI8z9DloSp
	fWy026pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odyd8-00532n-KV; Thu, 29 Sep 2022 18:51:30 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odyd5-00531A-L6
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 18:51:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id E47A7B820D1;
	Thu, 29 Sep 2022 18:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4E5C433C1;
	Thu, 29 Sep 2022 18:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664477484;
	bh=BAN7kalcQCYljgQPH9yUed4JJEDM3aDQ52bRPuz0O4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U8R1xhzEz5m5bIhE8gtG9EjWG1/eodu3/E6dMOasZxhbUygHEdMpFuYCUVujH1b5U
	 oDUP87U6QFhytir35j0JxwYghM1/eWNDBYIkwM59wQrrlkJHZ2BXIk8yU1hReMbIzb
	 5U+vG3nNzao1YhMvDz+GxeYvOm7/uXCTM0miebe4jVHyT6VLjRK5U2wvrb+nlhKIiZ
	 TcSc+7vXYqXkMEFychz7GflvRYAEsihkSMt1zf+rrUSXpOnJTGHYMDnA3G+KUzipUU
	 ghnUIHABV/tckvzhGsQ5ibdrIc3w5H9WknbH7BDofE/6pADH2IwTV4GbueNcOb97s9
	 UL4uO6ikdeXDA==
Date: Thu, 29 Sep 2022 12:51:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, yi.zhang@redhat.com,
	Tomas Bzatek <tbzatek@redhat.com>
Subject: Re: [RFC v0] nvme: do not log errors for user commands
Message-ID: <YzXpKdR/yjzgf2My@kbusch-mbp.dhcp.thefacebook.com>
References: <20220929171338.10792-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929171338.10792-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_115127_857953_32C173D3 
X-CRM114-Status: GOOD (  11.82  )
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

On Thu, Sep 29, 2022 at 07:13:37PM +0200, Daniel Wagner wrote:
> @@ -325,6 +325,9 @@ static void nvme_log_error(struct request *req)
>  		return;
>  	}
>  
> +	if (nr->flags & NVME_REQ_USERCMD)
> +		return;
> +

It would be more consistent with existing usage to set RQF_QUIET in the
request's rq_flags before dispatching if we wanted to suppress user space admin
command errors. If we did that, though, there are no more admin queue users for
the verbose logging since internally generated commands already set RQF_QUIET.

