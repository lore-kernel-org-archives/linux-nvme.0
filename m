Return-Path: <SRS0=PPGx=2I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6419AC43603
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Dec 2019 19:16:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CAEF21D7D
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Dec 2019 19:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nOnum4VY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="skKZ/5Js"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CAEF21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R1sjQVUC/qMpSnUQ4lcuqniU4djZnl7jRwsdDB6oWYE=; b=nOnum4VYms9Opj
	qZQwH1SI36gjG+9fMmnJS1BNkwtEVM8fYnQoo6jivxMXMhtMp8MuyRiphLe9QOZreewcWuS0V4Dlb
	If/1IjwhF9ifyfXGoTMkA89wivyYtasuClRusLSqx0f+QihIwcMJjIKpnn+EWy4HMoRVc9+kyP9EJ
	FWLwRvioNJcFJIEHhhy9qXPetyiV5Jjtebe2Ks8ApU5yf5n8GgTThGcAQy8uyfmDgmana5Kv+bRIZ
	dSDMKTLOJmQEanmpQc95El4yd8B0LA5de+RO3FqMMdODO8df8aSYg8ypARVI98q4mOtNZ5rP0Y3gy
	pdIe7n60t1aWqJx8oDBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ihenq-0004fc-W9; Wed, 18 Dec 2019 19:16:11 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ihenp-0004e1-27
 for linux-nvme@lists.infradead.org; Wed, 18 Dec 2019 19:16:10 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E90BA21D7D;
 Wed, 18 Dec 2019 19:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576696568;
 bh=blU2l/huwh5P9+7SxSWoEMYG3p1gFdRI5sAbdngTD8g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=skKZ/5Js0Egrh4/rNN6qerz+L/Funn8RT+JxpieFQqzGSKqt0p864lt/cqbmzaSxs
 vcjIjk7znbnihZN6BmSFqB49048V9DUV6rJdwJrgUSGpx1HhSBIHuazzr/gir0BKnS
 DUHjC7iUfmyE/YEqQY9XvWTSftETyBy+/i3j0Up4=
Date: Thu, 19 Dec 2019 04:16:05 +0900
From: Keith Busch <kbusch@kernel.org>
To: Jeffrey Lien <Jeff.Lien@wdc.com>
Subject: Re: NVMe CLI Doc Regen
Message-ID: <20191218191605.GA15983@redsun51.ssa.fujisawa.hgst.com>
References: <BYAPR04MB5656D3C483431C89188A3C22EA530@BYAPR04MB5656.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB5656D3C483431C89188A3C22EA530@BYAPR04MB5656.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191218_111609_129857_A9E86E4E 
X-CRM114-Status: UNSURE (   7.26  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Dec 18, 2019 at 01:03:19AM +0000, Jeffrey Lien wrote:
> Keith,
> I added a new wdc plugin command (vs-telemetry-controller-option) in the =
last pull request and need the new doc files generated.=A0 Could you do a r=
egen of the Documentation files?=A0 =


Got it, new docs pushed now.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
