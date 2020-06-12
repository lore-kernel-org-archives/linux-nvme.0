Return-Path: <SRS0=+Z1J=7Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB0DC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Jun 2020 23:08:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D95F5206D7
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Jun 2020 23:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fe5OE9u2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkAjo4po"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95F5206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E0XoEepvLqlATGeyTYqt41A9vxflCDLWqKSHKuApCt4=; b=Fe5OE9u2kKaViv
	uGMQAtsKKOdkIX8SR2cFIwvCVxU28xm/OGGiB7w2yC7IFyUlTob+OOTZZnpLRoiaLdmlpyHjeJ/FM
	iCMlj6/8yRv9i6w+Tv0LYRdFByWoAAsXzt6qZFvx4e24eLwDObj1F7oZrYk5QwLCQm/9w6nx+71NE
	lGsCnMzdHMqpqv8spgbj30vG0St6gir5GNktND0QavC+XMZhW9xh84XX4cGx05aNXqPRxPJUkCr4M
	I4hlx+ypZ3sZg4Q1BfZ6E+O93G7r6u/7jb2RAykOghpN8Wjhk5xBvLIHUEDKuks0fQtjtdbXw1ZDF
	/OD7XcxlLuOCPMlOOnDA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jjsmK-0006O0-A6; Fri, 12 Jun 2020 23:08:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jjsmG-0006NW-Jz
 for linux-nvme@lists.infradead.org; Fri, 12 Jun 2020 23:08:01 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DCCAC206D7;
 Fri, 12 Jun 2020 23:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592003279;
 bh=4h8G8QS+hApSJYcSExe64qrEkYeFxm6YRBwEBrZ4jU4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dkAjo4po0ZTkT+SfG1kWlUXI4FkiYiPQIJ1ft+9Vll3RSGYlRsAs5LxQhjZsRYoD5
 VeuaWX7KMycOIICMaN3aaLNY+tAIA9XVfM47qwWmbZwAvJBlqgO0XlByMYw/TEzJ9C
 g1nbANRpQEUs+Ik4Jc/iuzunUv4VIy9eyDIsdoMI=
Date: Sat, 13 Jun 2020 08:07:51 +0900
From: Keith Busch <kbusch@kernel.org>
To: Jeffrey Lien <Jeff.Lien@wdc.com>
Subject: Re: [nvme-cli] Commit fix apsrintf return check
Message-ID: <20200612230751.GA8834@redsun51.ssa.fujisawa.hgst.com>
References: <BYAPR04MB565662A7A29C4A0EAE3F64DBEA810@BYAPR04MB5656.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB565662A7A29C4A0EAE3F64DBEA810@BYAPR04MB5656.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200612_160800_676744_CFE22C8D 
X-CRM114-Status: UNSURE (   7.38  )
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
Cc: Brandon Paupore <Brandon.Paupore@wdc.com>,
 Randy Bates <randall.bates@wdc.com>,
 linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jun 12, 2020 at 08:40:57PM +0000, Jeffrey Lien wrote:
> Keith,
> I noticed this commit (f719dfdff59518c2ea75e82695ea0e3e6026a4f7) is only in the 1.11-stable branch and not in the master.  Just wondering if that was intentionally or if it was missed.   I was expecting it in the master branch.  

It was committed to master first here:
https://github.com/linux-nvme/nvme-cli/commit/f4f3fd2ea4b878fe38fd3409f374ded8d5b34a4c

It just has a different SHA.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
