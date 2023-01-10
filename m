Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A79FC46467
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jan 2023 17:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6hoY9vdOfXs+cESG1q0GnzI3nxnMuTlBNzEYLx50WMA=; b=hdLK8oDdAza6KXALx05u6DhNxj
	fPsfwET/oGXJmx32pLe4oqBizQauso7rXU4mxfBDXTwu+kdF9sgTwjORw/xHqAq0HsTMUj1Sbv4ch
	NWK33qZ7W3cp3XdM8uLUr+SQ6ZMa06CA+QufLodrt95WsjLUJ56nY2HjGQq6jzx08F0oIUo0Uqwqo
	tb1jB5NqIQ5wVhtL1I52wOw6KPJV8cPllc3i10ooR/7D1QtiGR9pQe8r7rxa4byLov3lCUULh9MQW
	JOoDXpMeiPQ2KJcVCl2Fsw4CajBDm0ERMfeerIiAIg3GuEcl4G8zDQspLsFzXNNVEjJ7ewy23RZpr
	pVsJARWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFIjA-0081sy-09; Tue, 10 Jan 2023 17:48:00 +0000
Received: from soltyk.jannau.net ([144.76.91.90])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFIj2-0081rl-EA
	for linux-nvme@lists.infradead.org; Tue, 10 Jan 2023 17:47:54 +0000
Received: by soltyk.jannau.net (Postfix, from userid 1000)
	id 59C4326F617; Tue, 10 Jan 2023 18:47:45 +0100 (CET)
Date: Tue, 10 Jan 2023 18:47:45 +0100
From: Janne Grunau <j@jannau.net>
To: Hector Martin <marcan@marcan.st>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sven Peter <sven@svenpeter.dev>, asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/9] nvme-apple: fix controller shutdown in
 apple_nvme_disable
Message-ID: <20230110174745.GA3576@jannau.net>
References: <20221129132208.4337-1-hch@lst.de>
 <20221129132208.4337-2-hch@lst.de>
 <c20485ec-28aa-2a45-3eba-8fa384ce0349@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c20485ec-28aa-2a45-3eba-8fa384ce0349@marcan.st>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230110_094752_663546_AABE5D57 
X-CRM114-Status: GOOD (  25.54  )
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

On 2022-11-30 00:41:45 +0900, Hector Martin wrote:
> On 29/11/2022 22.22, Christoph Hellwig wrote:
> > nvme_shutdown_ctrl already shuts the controller down, there is no
> > need to also call nvme_disable_ctrl for the shutdown case.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  drivers/nvme/host/apple.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> > index 94ef797e8b4a5f..56d9e9be945b76 100644
> > --- a/drivers/nvme/host/apple.c
> > +++ b/drivers/nvme/host/apple.c
> > @@ -831,7 +831,8 @@ static void apple_nvme_disable(struct apple_nvme *anv, bool shutdown)
> >  
> >  		if (shutdown)
> >  			nvme_shutdown_ctrl(&anv->ctrl);
> > -		nvme_disable_ctrl(&anv->ctrl);
> > +		else
> > +			nvme_disable_ctrl(&anv->ctrl);
> >  	}
> >  
> >  	WRITE_ONCE(anv->ioq.enabled, false);
> 
> Reviewed-by: Hector Martin <marcan@marcan.st>
> 
> I looked at some of our other implementations and we always seem to do
> both, but this makes sense. If it breaks something we'll notice and
> shout loudly when it makes it into an -rc at the latest :)

This breaks resume for the apple nvme controller. The immediate problem 
is that apple_nvme_reset_work() uses NVME_CC_ENABLE to decide whether to 
call apple_nvme_disable(). Only nvme_disable_ctrl(ctrl, false) clears 
NVME_CC_ENABLE.

Even after extending the check to consider NVME_CC_SHN_NORMAL resume is 
still broken. The host specific reset to re-enable the controller works 
but IO is blocked. The controller logs following messages into its 
syslog:

| RTKit: syslog message: cmd.c:728: Oldest tag 12 is 19 seconds VERY OLD with cmdQe:2
| RTKit: syslog message: cmd.c:732: Oldest tag is about to crash!!
| RTKit: syslog message: cmd.c:720: Oldest high water mark moved up to 21,tag 12, cmdQ CQ_PRI0W

This looks looks like the controller reset after/during shutdown is required
on this controller.

Below patch fixes resume for me. I can send this with comment to
prevent repeating this regression or if preferred handle this in
nvme_disable_ctrl() either via a quirk or an additional parameter.

Janne

--- 
diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index e13a992b6096..82396f9486e1 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -867,7 +867,9 @@ static void apple_nvme_disable(struct apple_nvme *anv, bool shutdown)
			apple_nvme_remove_cq(anv);
		}
 
-               nvme_disable_ctrl(&anv->ctrl, shutdown);
+               if (shutdown)
+                       nvme_disable_ctrl(&anv->ctrl, true);
+               nvme_disable_ctrl(&anv->ctrl, false);
	}
 
	WRITE_ONCE(anv->ioq.enabled, false);

