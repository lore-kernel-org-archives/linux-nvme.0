Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683AAC369A2
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Apr 2025 07:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:Message-ID:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uORypPfVGSrwaJfldB3hr0MeZF9q4gVgI0Crjob+UXU=; b=LCYv5V/+ARBzDfUzT4SIw/aEgk
	7OFsqXzCXQq1pm38WjeVd/kPNs0vUF7/JCOBKKKA/l1RsZE2Y3zbhG1rQQTLkvuCQBrEayh7XlNIa
	2uSUcDMq58wjNfs8gOCRtxtoFKRPFAG2zs2y0or4IkgptMWaDu/dDUyurlljBdXt/RPsIDUa9cQR9
	yVrsy/2A0h6LIyDOIyb2NK8p89ugjKfQHz7dACTCHz9YR1kA2Js5RDQb0LOW2RqCyUM21cjPht4Uq
	DhSXfT3fE3Nt5i10+TU/zLvFQdE+ZUVgPEETLvXOiteDRLDEOFJBkKiKKQoq5+eWRLx5zNsJHQSBC
	ewqwBm6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Q9y-00000006Szc-3njp;
	Wed, 09 Apr 2025 07:47:46 +0000
Received: from mailout.nod.at ([116.203.167.152] helo=lithops.sigma-star.at)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Q6J-00000006SJU-0pa0
	for linux-nvme@lists.infradead.org;
	Wed, 09 Apr 2025 07:44:00 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id D3F5E29856A;
	Wed,  9 Apr 2025 09:43:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 1yq2I1MJKfsQ; Wed,  9 Apr 2025 09:43:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 88247298595;
	Wed,  9 Apr 2025 09:43:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id od1ZJE801URs; Wed,  9 Apr 2025 09:43:55 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 642AF29856A;
	Wed,  9 Apr 2025 09:43:55 +0200 (CEST)
Date: Wed, 9 Apr 2025 09:43:55 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: linux-nvme <linux-nvme@lists.infradead.org>
Cc: Daniel Wagner <wagi@monom.org>
Message-ID: <1957517818.260072969.1744184635348.JavaMail.zimbra@nod.at>
Subject: nvmetcli creates tilde directories
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF136 (Linux)/8.8.12_GA_3809)
Thread-Index: jAUW2nbPeE0/SO2z+YoVhl0uS+wqcQ==
Thread-Topic: nvmetcli creates tilde directories
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_004359_394868_8BEECDD6 
X-CRM114-Status: UNSURE (   3.88  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi!

After playing with nvmetcli, I noticed that my home directory was sprinkled
with directories named "~".
It seems like configshell used by nvmetcli does not resolve "~" to my home directory.

From the source:
shell = configshell.shell.ConfigShell('~/.nvmetcli')

Is this a known issue, or is it a misconfiguration on my side?
FWIW, I'm on openSUSE Tumbleweed.

Thanks,
//richard

