Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C11E7717D
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Dec 2024 02:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QiBP4V1qF/9RWCdBmE++6OoHgjB2YfLFimJXm3/Ro+g=; b=jZI7nf7cmnSEbA3XWUr4bY5D+R
	A3dWXc5rgWQ11c8lhjpdBVAcPtwr5B4UuzAR9bKzdn7KQWLeXC5MpgqAod1ASDsjCL/Yc/kCllYZQ
	1pYkPwjrve0WrU+oh0l96GMn+tJHplWFDsz1xZ0La+HcJEDmE3/+W/i2LtqDQ7tIEQ7emFcN3cgvT
	CCfX5gC+xEwFw25VGVIjMFEsYD+xn58S4x9yGreZ+tyGhc/aXYfx01hojypHIXtf/fg94oxrAktcX
	C93uLYy9hXsdTGMrAXqDC96o6CfuQ/40IpLkAlHuTIxau3aBMzBiH8pC3NL6+36bPnrRvQmTPCHb/
	/CwHCTqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tK7Tq-00000004kWv-2Dva;
	Sun, 08 Dec 2024 02:57:10 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tK7Tk-00000004kWW-0Tug
	for linux-nvme@lists.infradead.org;
	Sun, 08 Dec 2024 02:57:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 075F65C547C;
	Sun,  8 Dec 2024 02:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90EDC4CECD;
	Sun,  8 Dec 2024 02:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733626621;
	bh=taprTIXL15AEDOVOvPxHdOS1UgmutfVw78B9EEoz+vQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lxrSFWSXOKucYi8Zf+1z67tBT88eKNg9cHjrZrcQ6ciS74Zl6rOiGcZ6cRLi0M59t
	 h+r9riRmZgHZdV+cCCD1oJRMFOniU9RfUqaksmjlKwkZaGPj9u7dFbK0u9q4Y30wPb
	 EPiwFhJVBGPE4wGl5ITF7pKhrPvJ3QkKKxfQ0GyFQDPrglOLeKwkm+INIFzP8D0APE
	 pLzWDU/pRgNeJnlH5ye4oWDRf9LzLXcUfYlpgD7NrYBCi+me5D43oVVA+baAfmArdj
	 92CLxHSgmnCwHDR4DABvRD5ZpPYRO5CRAErSyFJdrzEUwnZbNeY6WtpY+Utld1oDKE
	 Rrxz1cQbhq0Ww==
Date: Sat, 7 Dec 2024 19:56:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	fengchun.li@sophgo.com, Inochi Amaoto <inochiama@outlook.com>
Subject: Re: [bug report] WARNING when nvme_probe
Message-ID: <Z1UK-1MQEX_IcoL9@kbusch-mbp.dhcp.thefacebook.com>
References: <PNZPR01MB4528CE2B4B42BD765EC8DDE1FE322@PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM>
 <PNZPR01MB4528980B1F286C5843B70DBFFE322@PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PNZPR01MB4528980B1F286C5843B70DBFFE322@PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241207_185704_202966_9DC10595 
X-CRM114-Status: UNSURE (   9.09  )
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

On Sat, Dec 07, 2024 at 12:26:14PM +0800, Chen Wang wrote:
> On 2024/12/7 12:22, Chen Wang wrote:
> > When I test with latest 6.13-rc1, I see kernel complains as below, but I
> > don't see this in 6.12 serials (6.12-rc1 & 6.12-rc7).
> > 
> > I'm developing PCIe driver and there is a RC switch which has some
> > devices conneted to, including a  nvme device.

Thanks for the report. Should be fixed now with this commit:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=ad0cf42e1fc4810170a8e8e232e85d69073e4d25

