Return-Path: <SRS0=W+Vz=CJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F4DC433E2
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 15:38:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAAA0207EA
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 15:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IhQ51vnC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CC7d46o+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAAA0207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MTBj5GAB+Qii+l+AdaRn6iq16qEOZ/A+pl63BgOyNWc=; b=IhQ51vnCJu6oL1CD2LQKanCfd
	CdrM2qt0uUm+9ezlF+pi5dRN4cwd+cPXVjwd4xQ4f1E+fo/nFIouCKBj6Ado2mX0We6tbMNTjmu+c
	gr7/ytyNMawWrwMvfNCIcQiaQ0WAGZWPjsJ7TlV/YB6oNdcMIW/BoEcxJXdFGITA/mMJ15gZ56XHo
	82dYa4ScYt16GMVY/FB+HnUnQMh3Df0fePgqFD89ndhMEbjWuBKPksPgeabTwN0UDovF2ZH/uMXmY
	+B55ze1IF+awf0qTREUeJdnlfIVaEZ+CrinajDdJg45rwcp6jCX08nLOqo3GgrBVWNWClTNDrLc71
	O8NzsvaBA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kClt6-0002PO-Ce; Mon, 31 Aug 2020 15:38:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kClt0-0002Nc-PU
 for linux-nvme@lists.infradead.org; Mon, 31 Aug 2020 15:38:23 +0000
Received: from C02WT3WMHTD6 (unknown [199.255.45.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 587BC207EA;
 Mon, 31 Aug 2020 15:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598888301;
 bh=dRR9aUt1NjPXzfH/fGTX+Nj32yowbXOxYq5Ror+CR0s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CC7d46o+Pm+CkvVrOB6UW6BBM9rmOkPiQmp8VCMBWRsaDgBozGt3RQ+vaCsJaINAQ
 vmjiHw+dZnpdKROSf2KSQFxMBL4ATQpUvXS0jVcvdSpzcMPrHlrRZ1iLDicQUA6cjr
 tB91n7rcJZzyDW8n+usl9/e12mMS/7m/AaPHoiuU=
Date: Mon, 31 Aug 2020 09:38:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.8 11/42] nvme: skip noiob for zoned devices
Message-ID: <20200831153818.GA83475@C02WT3WMHTD6>
References: <20200831152934.1023912-1-sashal@kernel.org>
 <20200831152934.1023912-11-sashal@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200831152934.1023912-11-sashal@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200831_113823_062602_7018D73F 
X-CRM114-Status: GOOD (  13.15  )
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 31, 2020 at 11:29:03AM -0400, Sasha Levin wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> [ Upstream commit c41ad98bebb8f4f0335b3c50dbb7583a6149dce4 ]
> 
> Zoned block devices reuse the chunk_sectors queue limit to define zone
> boundaries. If a such a device happens to also report an optimal
> boundary, do not use that to define the chunk_sectors as that may
> intermittently interfere with io splitting and zone size queries.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

You can safely drop this from stable: nvme zoned devices were only introduced
to linux in 5.9.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
