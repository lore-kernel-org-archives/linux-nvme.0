Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDB0C3DA70
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jul 2024 22:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SUQit5iZxnK+EJFPonIQVmbapzyDBXR0D6jFvdnkXrM=; b=Vh0QNSFVWeDFMCYOpNc7xkD8tH
	zdn5+Ggg/717xZFHUpbvYgN0DxqYncEe0B7FkykuxlEiIf11ju4Q7gpfjVQTmBPS91OudZjCdagzS
	OSaldkSUNF7ebggTJ/zGYP8TVC26+XcOmhKPSD3oFhR2VXGCb2Hp7vSzqAykqcC3UV4NUYhFn7Iwa
	1Fvu4ePgLPV81lNwwOVbAGfEy0+twT2xaa3k4mipIX9eOgz0V+/Xhg2V3aK5yg6phxY4pLbbWEhPD
	Z9cVlPMCjMfTyhKj8JRYaZmEa/rHFwW2SjqMUzItAXmF7WgGt54ZVjZp9smzcGkoswmowRZLYnSCd
	FOkzrUlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sX7Qq-00000002KRF-39zX;
	Thu, 25 Jul 2024 22:59:32 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sX7Qo-00000002KQI-0DSX
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jul 2024 22:59:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id EC076CE11AA;
	Thu, 25 Jul 2024 22:59:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D68CC4AF0A;
	Thu, 25 Jul 2024 22:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721948367;
	bh=5HUs13fFIB0iAJjT87/zUbB6T8pO4vPmlvYZmv1m15s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YlNXNqRBU8wo27J9q0j6+atZPxkin5IaqjyGMWdAdcnC1Z3qsJ65EyYu0ekm4ODoU
	 FH33G6yNg/wmdQb7UCntxYT7Tvdb+dJ6Gc4l26jm1dGl2B5qK4hZ3J+t1/30fjwJh5
	 WTntI7y4VfnDAHoyflEhHYVfd95Vf4UyZqhYaEml6jrUJnl6ubCjVoKRtcYRlLKh58
	 PBoz4G5ziF/nwcLmEaJ4ctLsZvvXxbOItO1qUrd/emCOGusv/P+bBpwSOCGYfO+Jc2
	 bCmv1itfF14UJ11umw2EoRuKIrBoFgn3WR0nCFWt6S4o7+7loVI6UeCa/nbEBOholq
	 oGKcUCgu19n6Q==
Message-ID: <1b8f549d-4d24-48af-baea-952076d37834@kernel.org>
Date: Fri, 26 Jul 2024 07:59:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2] nvme: basic RMEDIA support for host
To: Christoph Hellwig <hch@infradead.org>
Cc: Wang Yugui <wangyugui@e16-tech.com>, linux-nvme@lists.infradead.org
References: <20240723232419.19753-1-wangyugui@e16-tech.com>
 <20240724123052.49185-1-wangyugui@e16-tech.com>
 <6bb781f7-1895-4c8e-8501-dc21732c5e37@kernel.org>
 <ZqJcyw9haCcDvK1r@infradead.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ZqJcyw9haCcDvK1r@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240725_155930_273651_0690B601 
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

On 7/25/24 23:10, Christoph Hellwig wrote:
> On Thu, Jul 25, 2024 at 09:43:45AM +0900, Damien Le Moal wrote:
>> Why not do that now in another patch, at least for the loop target ?
>> Given that they are not that many NVMe-HDD out there, that would be
>> nice to have to test this.
> 
> The code would be in the bdev backend, so it applies to all transport
> equally.  And yes, I'd love to see a patch for that to, but I don't
> want to gate a simple flag check on it.

OK. Will look into it then. I have the setup to test this anyway.

That said, while setting only the rotational media bit should be fairly easy, I
am worried about spec compliance as setting that flag to 1 mandates support for
endurance groups as well. Do we care about this ? I am tempted to say no but not
following the specs is generally a dangerous path we do not want to follow...

-- 
Damien Le Moal
Western Digital Research


