Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC958C27C5F
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Jun 2024 15:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bJjdaJP4724RtLXpO3gWKz5GOXiHQ/vxskT4zGL4ufc=; b=0hHzSY16tACFhbZ0DYxeZYRmvD
	rfwrdlyZVI3sIFjnFATfCD1mUjxNcTi80kahosmPmjfRzxxJBFaceeiKiOFCeiqXiOdJG9h76v1al
	ZLK4w9sGrYmI4m+9f+xB3n8VzWyUtgsO8ILCuRhALKoJj8OKLoA2SvIPPlxlakGnFjUaTa5dRuCZT
	CznbBI1aeCImc7nbQBpsDswMswTwwAbG1hmspkZc9mz38wyq7xcUVSmV3/UfJyc3ZvdyYbkqV1a6I
	boyfUfvoEsmxSbCaFkTva7BMvMXea67Yiu4CF//SYwvj/+H7VQL/qYDJjNOG/ZPJvXJxOXM+27SaH
	7IB3pPMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFbIp-0000000EeXO-1IMZ;
	Fri, 07 Jun 2024 15:14:51 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFbIi-0000000EeWi-0vPt
	for linux-nvme@lists.infradead.org;
	Fri, 07 Jun 2024 15:14:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 17BB961F99;
	Fri,  7 Jun 2024 15:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8391C3277B;
	Fri,  7 Jun 2024 15:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717773280;
	bh=NnBq12hDlH76ZbF8KzE8J/G8QE/AQetgsK6NDs3jrEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bV1EV4taoke60kaWbgU7bMccFSiQKboXTEnB17ohmYl9fr+v5D2REttF/8zeFM1D+
	 WVSCTWxZimvtuCGCZ30Bfldz1fwJBcRY9R0pI5c0YiGJDMMCeGa6gcgzNKnXKDNgMb
	 +4SAuc+cM7KpcvK9i8IkiLU58kdqMgm5mgmhX+xyJtnnWiNGSsW2TC2tK/tBurfiW6
	 RtYMwrc7mwVdkL+7sAKPNUD+sPJ6tBQHR7B7HFXIyjvfteUA91dySHiP5atfJg96HA
	 EZW6jx9WzXuOmkJMpHDNPQ5TApMtUkIrKTVBr060QDdXtWEBPNfW4vN8lyRlRhfED/
	 W/WEN9DKygszQ==
Date: Fri, 7 Jun 2024 09:14:37 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, javier.gonz@samsung.com,
	bvanassche@acm.org, gost.dev@samsung.com,
	Hui Qi <hui81.qi@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v2] nvme: enable FDP support
Message-ID: <ZmMj3d1Rvv-5E6Ey@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20240528151007epcas5p32583675f647553923e5ba4987e9bc6ed@epcas5p3.samsung.com>
 <20240528150233.55562-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528150233.55562-1-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_081444_332417_19A1DD14 
X-CRM114-Status: GOOD (  10.67  )
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

On Tue, May 28, 2024 at 08:32:33PM +0530, Kanchan Joshi wrote:
> Flexible Data Placement (FDP), as ratified in TP 4146a, allows the host
> to control the placement of logical blocks so as to reduce the SSD WAF.
> 
> Userspace can send the data lifetime information using the write hints.
> The SCSI driver (sd) can already pass this information to the SCSI
> devices. This patch does the same for NVMe.
> 
> Fetches the placement-identifiers (plids) if the device supports FDP.
> And map the incoming write-hints to plids.

Looks good to me. I'll queue this up for 6.11 after we can rebase to the
block 6.11 tree once that's created.

