Return-Path: <SRS0=Gd08=O5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C66C433EF
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Oct 2021 08:54:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1E3060EE3
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Oct 2021 08:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A1E3060EE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fuckner.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:Message-ID:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6fnDawXeOdjS4rlfiEC/J9klt4a5smn+S1GF4FdorA0=; b=ZAB1a4GNxKMKNP
	sKFmvopMypFUaJC1gfX7+/Deng/ZKG3XRy8uaHNO/moyl1S5QaZBvNGrtLkpwk9xfohR1riwN100M
	e6JiG9RikcQpTvl+6BGNnvzQVwDZWrSKnkryXs8L8FtPdm9HhZNsbswJ8uGoOl0bAolWJq/NVsrZb
	b+4EhgeT68/cBAs9FEPXgaVz9JuaZ20mGFtF7G/aGCVSoGbqNgU/i/Q+S4H6iXQFItNbDxc53z3Qq
	RGhTzkvuVUDOUZPx6B0RnMm8mB+4v+FrtoIBs3IvKMTEo99efO8y3wI0cbCjTjlXcYZroC2MHi8iE
	GoEpxJTpzj6Z2LgAEKRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mZ86d-005LMn-E7; Sat, 09 Oct 2021 08:53:23 +0000
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mZ86Z-005LMS-NO
 for linux-nvme@lists.infradead.org; Sat, 09 Oct 2021 08:53:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1633769595;
 s=strato-dkim-0002; d=fuckner.net;
 h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
 bh=GwZonM5B2P+3D0kA/371pPiHhV7hYMgCQvFBKlENIks=;
 b=Q/JqyIBfZjBRD4Im36nZ39B8rKUolvWRqY6KAvqjCcdM5VXK7OrwXOr/wcu7aXXGxg
 tORG4l1xZ2HCgd9lqA7EVHowO809gdjJeWKPOup2iHATXQfL/YDHgUQBUatfO8McldCu
 fLqZfKZXyjhiDqCEv/NBnIon4fSB2iriiEfnKyLGbkYo2lW1MkZRPlpINCwkzAfwYIuj
 FaOdnpqkSAlZzeVyHhRda9Csl6q4RxEOIoTlP0PR+E6VawFUo0Z3Jwv5qOEtlULt1y4d
 DzoDtu05UH66QWT5UP5QNkgHMAwHWtFi6OaeOuCc9n2D2BMbebkdT00EqAUMwgFn8Gkd
 lRGg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":IWUHfUGtd9+6EujMWHx57N4dWae4bmTbIPWLqR/scRfpbcFYDmdyCXC8+RaJXQFaSViN"
X-RZG-CLASS-ID: mo00
Received: from oxapp05-01.back.ox.d0m.de by smtp-ox.front (RZmta 47.33.8 AUTH)
 with ESMTPSA id 6017e9x998rFeKS
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1
 with 256 ECDH bits, eq. 3072 bits RSA))
 (Client did not present a certificate)
 for <linux-nvme@lists.infradead.org>;
 Sat, 9 Oct 2021 10:53:15 +0200 (CEST)
Date: Sat, 9 Oct 2021 10:53:15 +0200 (CEST)
From: Michael Fuckner <michael@fuckner.net>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Message-ID: <34244386.3221623.1633769595569@com4.strato.de>
Subject: Namespaces on MZQL2960HCJR-00A07
MIME-Version: 1.0
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.5-Rev24
X-Originating-Client: open-xchange-appsuite
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211009_015320_024544_86D7F918 
X-CRM114-Status: UNSURE (   4.56  )
X-CRM114-Notice: Please train this message.
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

I have a system with 2x PM9A3 (FW GDC5302Q) and nvme1 shall use namespacesfor testing.

I could use nvme detach-ns, delete-ns and create-ns, but it fails at attach-ns the new namespace to make it usable:

test135:~ # nvme id-ctrl /dev/nvme1|grep -e nn -e cntlid
cntlid    : 0x6
nn        : 32
test135:~ # nvme attach-ns /dev/nvme1 --namespace-id=1 -controllers=0x6
NVMe status: Controller List Invalid: The controller list provided contains invalid controller ids(0x211c)

Any idea how to attach this or other namespaces back so I can use the drive?

Regards,
 Michael!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
