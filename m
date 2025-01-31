Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40586C02190
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 04:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NIu5WVUHGLf9gfdTWvOvNK/xFsqLPRxW7J/Q8nhUDO0=; b=aqVxv/il9hsHoRr4UL3gxa8vrL
	M/T6hazmZ8OWJmKPiPnNhjHqv+xmWXtCWE7KcqEfsZnRfXTKTmwx4ukEDPLf2P+t1ilqfTRXRVYUL
	aYgyIO6PGmcSKM07l8ApFBW0kxBx/ukguuQCqoAnhjTEMb0/qi+MxdL3OnjVZZEQJAY6jPHtd8rk6
	Fk7Xke1oskIsQCh224tQvjBIfM4YzXoDnJE811GbHUpkzFlBm+E+gjq6jjYWhx0e6Fi8rLCBbc3JY
	g/9erbxPGocz00BStX9uwU/vz7eQLzDdqbjjUztvdqhOyYCgq8yNPitbvEqotmTh0O68qN1VvD0WA
	9ZqotWXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdipN-0000000A06O-2YUX;
	Fri, 31 Jan 2025 04:40:25 +0000
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdipK-0000000A062-1Yyn
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jan 2025 04:40:24 +0000
Received: from macsyma.thunk.org ([12.221.73.181])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 50V4eFhe029357
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 23:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1738298419; bh=NIu5WVUHGLf9gfdTWvOvNK/xFsqLPRxW7J/Q8nhUDO0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=PCPw4qxxsROGw2PX/NHKbAd85xP/Eidk7VIu5PmPz2yaHhuHymcZRPeRp1kJsika/
	 BmqpzMAIc0jLKRf6+bbvE5E3gSl2Oyl8hUwV8oRXF6TdPdRuZc8wqkpOHi4Xd7ZlUE
	 Ke23JkbUo3zBiBMJtO0oWIxFqFoyNZh33Ap7QBgCm4hdFFxMs6pWx00dp/YfquqtT7
	 EazfVXTezzvo0+RmgElK4dTsjdsBLIEC6oXdnSbMl9i+iXFCVjf4tjCB/Tjhv9jz30
	 sBGW4sSgoDuRMfKYGvk6yaYyF0rdvp4UNqoP8IIZxgYEyuR7izjO2NZZjZD4jLQh/5
	 YZieu+n0RShxQ==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 0DD8B344FF0; Thu, 30 Jan 2025 20:40:15 -0800 (PST)
Date: Thu, 30 Jan 2025 20:40:15 -0800
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, lsf-pc@lists.linux-foundation.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        josef@toxicpanda.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] File system checksum offload
Message-ID: <20250131044015.GB416991@mit.edu>
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
 <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <yq1r04knj7a.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1r04knj7a.fsf@ca-mkp.ca.oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250130_204022_698420_D143D1CB 
X-CRM114-Status: GOOD (  10.44  )
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

On Thu, Jan 30, 2025 at 03:39:20PM -0500, Martin K. Petersen wrote:
> It already works that way. If a device advertises being
> integrity-capable, the block layer will automatically generate
> protection information on write and verify received protection
> information on read. Leveraging hardware-accelerated CRC calculation if
> the CPU is capable (PCLMULQDQ, etc.).

So I'm confused.  If that's the case, why do we need Kanchan Joshi's
patch to set some magic bio flag and adding a mount option to btrfs?

      	     	  	    	     	    - Ted

