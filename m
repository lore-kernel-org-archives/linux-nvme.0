Return-Path: <SRS0=cpn7=XT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1F5C432C1
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2019 18:19:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F43821655
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2019 18:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kcXP36sr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvoFpw9D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F43821655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kwjkyw4DqNqld8BxTlq30Irm6Aj89I0Dbm5J/10ryqs=; b=kcXP36srTSmTBF
	WOQgLZ3odS8TVjaiybskbKsJhkOSroWCvRwoi86siaXc8yDdBZbVMJJ+LCLfLzzehF74txkySbbV4
	dCtJ6bEw59sTzzHvWObx+9fzwE7Q/h+Q3h3lbzHAr+R2u/nzE1jOJzhM/eVMJ0NTdCEVcHb4O5pJi
	jf7VETZPk/RfITD0RzzNlJwLP4aOaXwPwOSTE27J/wy7BYv2eRM/HVi4Z/Penn8vsmabevbMeel1R
	7UC5C292qu2TMOP5Guf6bY4J8rMKUvwBItAuVAR6ZHR7V9D9YVLADjvxPx3uboIDloePubeKecPpG
	y4J92EZiMwfzIiw2726g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iCpPX-0007vQ-HW; Tue, 24 Sep 2019 18:19:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iCpPV-0007v7-I1
 for linux-nvme@lists.infradead.org; Tue, 24 Sep 2019 18:19:38 +0000
Received: from C02WT3WMHTD6.sdcorp.global.sandisk.com (rap-us.hgst.com
 [199.255.44.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E712A214DA;
 Tue, 24 Sep 2019 18:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569349177;
 bh=OsaS1VYl9pObXZLL3BY3OATmyzBitb7H69LG7NkX9sA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FvoFpw9DjT8FpFiBNkrrT/4hNrcXZOGaxhA7sLSPlWWEYOKhkFLi7Z89tQFVejmTu
 bs7hXMTB9EK/MBz2SExGBgu++N9ONBoyR7501Y2L+wyUtgrGXvExO0jkgPWYZGOc88
 4viA+1LuO8E8PbdJoSHgL1s+8Ecn6/+hGKcpVibI=
Date: Tue, 24 Sep 2019 11:19:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v3] nvme: allow 64-bit results in passthru commands
Message-ID: <20190924181935.GB30811@C02WT3WMHTD6.sdcorp.global.sandisk.com>
References: <786558932.78398145.1569330892814.JavaMail.zimbra@kalray.eu>
 <17936ba6-8f2c-370f-753b-fef8b531c810@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <17936ba6-8f2c-370f-753b-fef8b531c810@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190924_111937_617199_646ED38F 
X-CRM114-Status: UNSURE (   8.18  )
X-CRM114-Notice: Please train this message.
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
Cc: Marta Rybczynska <mrybczyn@kalray.eu>, axboe@fb.com, hch@lst.de,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 24, 2019 at 11:05:36AM -0700, Sagi Grimberg wrote:
> Looks fine to me,
> 
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> 
> Keith, Christoph?

Looks good to me, too.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
