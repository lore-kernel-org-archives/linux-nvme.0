Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C74BD44151
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2024 01:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S/85m0SPK1Ekhtq8hffFjaF11L4SRKnzhDnWIiU/0nk=; b=3HwXSzgtDxDuGKQR22uGFY1Uox
	cqVOg3SC/+tEA50iG/tpwGmTPvS807LyAuhk49MPVJdRq831Up2BGIwpwTsOL6ZRebrvIz/lcfmo3
	aSbTPkTEHM8ucpLfmNB10vul3omfY75ruVQcGPdZxKU0OqQ76opc0UwjUwi5chtnI99iuOBNWCPZI
	qwvKCX53coetNaBwccadFJDiVsj4rlYyfOwkYc5O9Km947VaJtWZarXLQzuKimp9AXoRC0qQ/GTcv
	qTXjOSaL1EtrM7KEwWiUpTbOjYR/MeIfG5mrl+QstkGQWApxixIiEntL9CepJ9t/ZbIQyJ/DYRLn+
	OQt8uGvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDZpp-0000000EAIt-19uu;
	Wed, 20 Nov 2024 01:48:49 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDZpk-0000000EAIG-2gya
	for linux-nvme@lists.infradead.org;
	Wed, 20 Nov 2024 01:48:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732067320; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=S/85m0SPK1Ekhtq8hffFjaF11L4SRKnzhDnWIiU/0nk=;
	b=jHSVcQgF8FZ9mTcfJSyhHtnl5KrPeR7XPZvNtLYvcQxDVwmplcWD29v2bSklJSKnhnQHZoBVW6cHuuo+h7pDCOlubjcg4+4zFAIfl7UvYrq139L5vi5NB3pyg/2D6+p+RjrWNghgHQUrQZrQOceW8YJNcwamIi40wOCLMPfQ5DU=
Received: from 30.178.82.25(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WJq-HTn_1732067317 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 Nov 2024 09:48:38 +0800
Message-ID: <72957e2e-cc7a-40a3-be3d-0814d46f98ee@linux.alibaba.com>
Date: Wed, 20 Nov 2024 09:48:37 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nvme: tuning pr code by using defined structs and macros
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20241119102925.128435-1-kanie@linux.alibaba.com>
 <20241119162112.GB14774@lst.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20241119162112.GB14774@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241119_174845_298551_56C51A0E 
X-CRM114-Status: UNSURE (   4.17  )
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


在 2024/11/20 00:21, Christoph Hellwig 写道:
> Normally definitions should go into linux/nvme.h.  I'd also
> normally expect the different CPTPL bits to be defined separately.

OK, changed in v2, and the change of linux/nvme.h will be in a separate 
patch.

Best Regards,

Guixin Liu


