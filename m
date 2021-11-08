Return-Path: <SRS0=LsNR=P3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31E1C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Nov 2021 16:45:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7624261215
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Nov 2021 16:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7624261215
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9UDtwx4IYB2KJwIoLzdzUWVX4USEQlUlAQ/21efRqBw=; b=paqspcZhKyqnXDMST+NMHIsAp1
	L8ycyY9OWQ/vFbHqDgTEb5dmRWhqn7lbDdKxZnpmu9zB7To8IjHkIPdEza2DAyUVTrcCd+mLYSeX3
	vzjf1t8YIdN5DcFcmEAdCDWasXr8ithjsw6Y0LGNMGb6kpulqo95g58k5ZO+eaotiFyav+nbUOh/t
	5C5CJDTbGXGQPEshTD+V6HKtI4ZkCay7QEgrgyJZEmmXmkyFjaNTW6n3yL9g3bkCRT8BgMtFDMHqG
	XgpQbrKbFsJUXRhIJeK5FrsSF2MBPFUuqww0Z7Qj9zMT8aLphVNiJgLdqCCYFauIXFngG1fKTTiVQ
	t3ERy6MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mk7lm-00GzhJ-23; Mon, 08 Nov 2021 16:45:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mk7lj-00GzgK-C3
 for linux-nvme@lists.infradead.org; Mon, 08 Nov 2021 16:45:16 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C623261215;
 Mon,  8 Nov 2021 16:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636389914;
 bh=24+higw4tHAQXdAcEApca47M2UCrMCLt/YHSW8F4waU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gniMBhVHs5UN3qcvpJcgFvZg8dFRDhG3udxg/ShBf3qmfZ49VbFVeVSlBOuJlUCJ3
 VM5dIag76M5TWl5kiVBbon0FlxG5pF35p5bO0dsnm0nDelEOxc70bbaacPBLSpkUqg
 opep0WOPICnUU0a1d+05fi6lg6IS/fC7VdlMrx/ugqZiDB+pHzrd3Xr1tROSbyrCk7
 YIiHDSwubHxYUPpLx0itLHYyeL/1D2JLj0S1ipVSNjTybGj+ehm5mFJ+15etG1TtQ4
 VU3veVNAy0No6p97MKfo+bbM/zRJKvUpSrPX68EEe+oe0lKfVwoujOGtPKeb42UKTg
 +NPngABCa/0iw==
Date: Mon, 8 Nov 2021 08:45:11 -0800
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 chaitanyak@nvidia.com, oren@nvidia.com, benishay@nvidia.com,
 borisp@nvidia.com, aviadye@nvidia.com, idanb@nvidia.com,
 jsmart2021@gmail.com
Subject: Re: [PATCH v1 0/4] Add command id quirk for fabrics
Message-ID: <20211108164511.GA2660170@dhcp-10-100-145-180.wdc.com>
References: <20211108144703.7971-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108144703.7971-1-mgurtovoy@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211108_084515_447747_5D427F2C 
X-CRM114-Status: GOOD (  11.66  )
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

On Mon, Nov 08, 2021 at 04:46:57PM +0200, Max Gurtovoy wrote:
> Hi all,
> Commit a2941f6aa71a ("nvme: add command id quirk for apple controllers")
> was merged to fix a regression in apple controllers that was introduced
> after merging commit e7006de6c238 ("nvme: code command_id with a genctr
> for use-after-free validation").
> 
> This series is comming to enable the same quirk for fabrics controllers
> that used the command id index in the same way that was probably used in
> apple controllers.

If there really are targets behaving this way, then this looks good and
necessary, however unfortunate. A TCP target triggered the need for
valid tag validation in the first place.

Are there really fabrics targets behaving this way, or is this series
anticipating they might exist? Apple disregarding specs is nothing new,
but I would have hoped no other targets would do this since most vendors
care about interop.

