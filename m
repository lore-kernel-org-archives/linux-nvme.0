Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99EAC433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:41:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA67F2177B
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ubOiCps4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA67F2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0orhEqqCA14ps24X1i4omGMVAHCt86ntaSJzFqviLp8=; b=ubOiCps4JCBnKjCCDwaNVEbmd
	Is1TZzB1O8fu/hEtu9bSe/u+uPEk5U7+3uRpZ5fOeyqqOIpntf4y36iXX7u0+XqYAx+v3W4hkk0z6
	Eti3Ql6jCMhNJAJwqLUTwymZfyfRNshsW5Hjct8otJUfqn9gogc5NRtAwFX5ugtdFAIZOwUGdCXPA
	ozv+Xh/93mN1oovtevjDYwNd+LMGQdQSyfhYz4RA4TF5jCru7Uh8PbtZ4niEQI9y1jFJ9W7lxVeEM
	x6o7eXOtED5t9YyBkzrspLxs1s9foC700K/b0hpZbkO1aJDPRDQKwewS3h4JEj0CrYyVscmf5IEqy
	/2VuCIh0g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3ll5-0007NX-J0; Thu, 06 Aug 2020 19:40:59 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3ll3-0007Lp-7X
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 19:40:58 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 905DFAF28;
 Thu,  6 Aug 2020 19:41:13 +0000 (UTC)
Message-ID: <f00f506389acbe919016f8f4dc9ac6d91442af0c.camel@suse.com>
Subject: Re: [PATCH 1/2] nvme: multipath: round-robin: fix single
 non-optimized path case
From: Martin Wilck <mwilck@suse.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>, Martin George <marting@netapp.com>
Date: Thu, 06 Aug 2020 21:40:55 +0200
In-Reply-To: <20200806131932.20017-2-mwilck@suse.com>
References: <20200806131932.20017-1-mwilck@suse.com>
 <20200806131932.20017-2-mwilck@suse.com>
User-Agent: Evolution 3.36.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_154057_388346_CCDFEE31 
X-CRM114-Status: GOOD (  13.97  )
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
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, 2020-08-06 at 15:19 +0200, mwilck@suse.com wrote:
> From: Martin Wilck <mwilck@suse.com>
> 
> If there's only one usable, non-optimized path,
> nvme_round_robin_path()
> returns NULL, which is wrong. Fix it by falling back to "old", like
> in
> the single optimized path case. Also, if the active path isn't
> changed,
> there's no need to re-assign the pointer.
> 
> Fixes: 3f6e3246db0e ("nvme-multipath: fix logic for non-optimized
> paths")
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> Reported-by: Martin George <marting@netapp.com>

I made a mistake here. It should be

Signed-off-by: Martin George <marting@netapp.com>

because Martin G. provided the initial idea for the fix.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
