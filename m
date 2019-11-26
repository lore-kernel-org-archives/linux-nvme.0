Return-Path: <SRS0=Q2qb=ZS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8ABC432C0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 17:39:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 593902073F
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 17:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qbS3oTyK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bW6qkuLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593902073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zabxVaFk73Sxj4xGAyTpk1CNRAEka3Hc9l3WoWR6Bl8=; b=qbS3oTyKC6H4Ds
	kaPWXeGBbrkgvtc0mtxmVyXxP4CtWjV44YlZyp2d96wRjbtq8PNdEjjAhZW5Vi1TpoNXIJKjMn6+T
	e/h7eL/FsWOUNatO3AAQsSoeblXdONU7cnH3YtpjUUs/BJHV1+5HKc0jpKxBTznDuQKiaEKp6nKJG
	WIxhSTLTXF8OO9WXzL/cCSh1iAzRyuuymcqa3YA80lW7TFCgJ2QsUuARenBbEKAS191ZznZWQdT7T
	wBB+oXZ8u3bvURJwzapXpM7/uVzqe3lEmlR1Mzpbnuc8YjA97q1uBYyPLMhn8a/spera3UFM3txYS
	pLzJYtK3+qM9EOlUqvVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZeoF-0007Ps-5g; Tue, 26 Nov 2019 17:39:31 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZeoB-0007PF-TP
 for linux-nvme@lists.infradead.org; Tue, 26 Nov 2019 17:39:28 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F40A72073F;
 Tue, 26 Nov 2019 17:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574789967;
 bh=k5vseHPFcPNtfZolSAZ48U3bYdwd6sjrLwHHme7ig8I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bW6qkuLa5PpTQaZ8xRw7cTRReGU2Esv21AFoMtlZa99SPdW4PkSPxIemj/522XYHp
 lmcxXFmNQQWlsPeXu8Js0Jlag6iyVxKqHLdOR6gsV66HbhtbJi5WWGVPEWrVIKTCIB
 1J8NlhSWFP60/dNbS5lyKgDzcE2StpoHcUI2wPdI=
Date: Wed, 27 Nov 2019 02:39:24 +0900
From: Keith Busch <kbusch@kernel.org>
To: James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH] nvme_fc : add module to ops template to allow module
 references
Message-ID: <20191126173924.GE2906@redsun51.ssa.fujisawa.hgst.com>
References: <20191114231526.21807-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191114231526.21807-1-jsmart2021@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191126_093927_967791_02F44D6D 
X-CRM114-Status: UNSURE (   6.14  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Applied to nvme/for-5.5

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
