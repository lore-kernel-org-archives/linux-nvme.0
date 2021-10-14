Return-Path: <SRS0=o8oB=PC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EC6C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 02:04:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD71D610D0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 02:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CD71D610D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ym8zEFwgfqPSn1gLkQ9Achvhw0SblscnPWmFt3I/wF8=; b=bfx7fH5b5vhc6eTeUee+VMmxUN
	XRCMx7tBTJVdoh1Tc859zc3W/ZVfSMn+epfyOwG83yyJcAiY5BmZTqsFWmnhgq/4bgb/64CTPzoif
	VZz7L47E9atf3DbaHTwb9nJlMDz+QOQvdy2CCuEv72Lm1e9Rhx5q5zfnj+eeptxvJ7nO1aK+03LC2
	fkTwJFEiI0mWSMVqrWZiAgchJaNxxyr4PJ+q+aoESYXc8/1M4DneaI9GH4/dfkUpGF9jmFCkwiFMK
	xUxa2ARJjJGIDn8sgIHK4KN6WdU6ujvAiyaiqbnR15S9FUxYKf5XTAPzlSz8FB4BqwzXvcl5AjuBn
	DbbBDOiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maq6g-001FMW-BJ; Thu, 14 Oct 2021 02:04:30 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maq6d-001FMB-SB
 for linux-nvme@lists.infradead.org; Thu, 14 Oct 2021 02:04:29 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A621610CB;
 Thu, 14 Oct 2021 02:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634177067;
 bh=bIBSu72SF4dh5neygUZwkkZ3mqWV2g00wfIytBrpWPs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hm/icgoaMG1rVjdK3K7TAUutTd2nNg9X0KmyWnCoXNQV08h6rQS8bMmCDLl4hxbXv
 +XdVorxfLJiGwKDTaQ+lby7bkcvJTyxVxmbkSqas9/4Eu+4q5VgIWsDu7P2qFTyUsJ
 y3S/WcKZf9POMpdPKdqpUH622gDBbhCaHMLweXIDqoC+Gs4DEwL6kxltmhPuvR5QMW
 vR/rTJCiZsemIuHA+Pj4pG7EXWK8NL925WfskpzReF8W2tfD/DYMxjqn9cylhpaHoG
 E5o1AfA1tikI++84kd2Kk1csxuLFhd4YVDJnvj+7NpKDYbhPkFx8FO5EOByDhGUmsS
 94pr5qAZbpJ8w==
Date: Wed, 13 Oct 2021 19:04:25 -0700
From: Keith Busch <kbusch@kernel.org>
To: koos vriezen <koos.vriezen@gmail.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: bisected: 5befc7c26e nvme impl non-mdts gives smartd error log
 entries
Message-ID: <20211014020425.GF1594461@dhcp-10-100-145-180.wdc.com>
References: <CAGCbPWTKos2c7aLt35ZvsvK56Tqy05BTOTeaEbL8jJty25J+zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGCbPWTKos2c7aLt35ZvsvK56Tqy05BTOTeaEbL8jJty25J+zg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_190427_953851_ADDE60B5 
X-CRM114-Status: UNSURE (   9.97  )
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

On Sat, Jul 31, 2021 at 10:32:20AM +0200, koos vriezen wrote:
> Hi,
> 
> On my XPS 13 9380 I get local mails with content
> 
> "
> The following warning/error was logged by the smartd daemon:
> 
> Device: /dev/nvme0, number of Error Log entries increased from 28 to 29
> 
> Device info:
> PM981 NVMe Samsung 512GB, S/N:S3ZHNF0KB11472, FW:EXA74D1Q, 512 GB
> "

Your nvme controller is too pedantic about logging errors. This is a
completely harmless host side request: the host doesn't know if the
Identify CNS is supported without trying it first. There's nothing
useful about this event that requires an error log entry, even though
the controller is allowed to do it.

