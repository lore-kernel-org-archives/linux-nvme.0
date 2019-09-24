Return-Path: <SRS0=cpn7=XT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C897C432C1
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2019 15:17:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 502D020665
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2019 15:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BG3VHe0p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xb/Y2syB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 502D020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UMD77ZfjdidHqvY/9R4grtwzLH1zek2+TIrolxMcdwo=; b=BG3VHe0pjUF9Ir
	dj8t7W2c+bWYso2Kpi0LL1rQOpTSFhE1hixRqTrib8tzNcFy0DsHpjCfxuq54doQIe/VLNaQ5u/Uf
	FKMU1kvasZSdbDtpxaP7GsMmWgnH/a9bbujpRNmcs2bRkOWNcTMyzYjRLwefeWcskpy0RUetNco/c
	DpvSy3zwlT7X2szenYA8k5yZhT6rItggUygU80JzHY9LNkbP15bw+egqoaJi/KZ2p3fb88nrzasSR
	PHDh3GDit7p4NakS4X/UWrO2I2FpYQY0SE7/aDPYxz6rlMwZ1fEQ+Ymw1qQEzryqf7XSFw9/uMIL+
	9j57Sh7soPP1lo0H4rxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iCmZb-0000Qp-DU; Tue, 24 Sep 2019 15:17:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iCmZX-0000QD-Oh
 for linux-nvme@lists.infradead.org; Tue, 24 Sep 2019 15:17:49 +0000
Received: from C02WT3WMHTD6 (unknown [8.25.222.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 42FF820665;
 Tue, 24 Sep 2019 15:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569338267;
 bh=TdeSOGDadnIY5cg8R3/WdtI5qw5uznCwCsUzIr1jdYA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Xb/Y2syBaUIN7OR60CiVjSF1KUjKd+cld4fLerJn8/fgKtLbxLKQycMyRoXGHLCgx
 36T+YiL/yXxovL8BAQ9PaGIT7+qRBA81TFqYVmu3FcwB/LtARzPVsJQLBcTBZy+Vsb
 tpHiaWoeU/avqNqIA9XsPyaZ0j9633ZI5uAdnlQw=
Date: Tue, 24 Sep 2019 08:17:45 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jeffrey Lien <Jeff.Lien@wdc.com>
Subject: Re: NVMe CLI Documentation Regen
Message-ID: <20190924151745.GB21929@C02WT3WMHTD6>
References: <DM5PR04MB12448280B8639C509EC336F3EA840@DM5PR04MB1244.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM5PR04MB12448280B8639C509EC336F3EA840@DM5PR04MB1244.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190924_081748_144149_687E3506 
X-CRM114-Status: UNSURE (   8.51  )
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
Cc: linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 24, 2019 at 01:19:40PM +0000, Jeffrey Lien wrote:
> Keith,
> Could you regenerate the nvme cli Documentation dir?  I made a few documentation updates to the some of the wdc plugin commands (vs-internal-log and vs-fw-activate-history) in my last pull request and noticed the .html and .1 files hadn't been updated.  

Yes, will get that pushed out today.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
