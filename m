Return-Path: <SRS0=vsJd=PF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F22BC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Oct 2021 15:26:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 740C560FE3
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Oct 2021 15:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 740C560FE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=70ZKfllBjZHQa1J4GUObwLCze3CU8wCeQiJAaBSPZwY=; b=nIW/18rdcccTef/IlmNpNygiRI
	96xTb70UfgTZ3l9hVfBS/HrVSXUr8HzDPurcSSFaUbhHLhM8cPyaG971lxh26ugAmYFsAnYotUX8t
	QIWAh+v6LSFkOer8m7X1vkeAtEIYk7xIFCGXnslwt1VcqmKNVAPv6Yxg+RwlICiWTuMVw7tDL4OU/
	kLvpx4YNnTYCo8D1tJd0PvmsYuRuMPnmqlHtsH4REt9NXwEm03ErFc1tq2DqiAbfFctw3rqpchqI1
	3Dv6McSdvjmZzyqWz2uaXemDuZKQIbbL2fzey4IKW4jqp4ahX/NCv1UkbHdfUrKHX3E4g+voBR0z8
	jxvLAbFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mc83l-00Cqwh-4m; Sun, 17 Oct 2021 15:26:49 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mc83i-00CqwQ-VP; Sun, 17 Oct 2021 15:26:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=70ZKfllBjZHQa1J4GUObwLCze3CU8wCeQiJAaBSPZwY=; b=C4UNljiRQnxqpGr/gZae9CnIWT
 j7Uyl2yYks8L0q03i4Yj6wzbXHZfLRSnndsp7bwE+G+8kSeY6JWp3qOqYzPXZm7xgouB3Y3hUQhtB
 Pk4Hz6DQ4fJj9JpSQmWL3lPFrfCQD6hkq6x6Rwnt4SbkGg8suXrp9MdS/9GwqmQ6jlHlFEgk2ZXtF
 TIxTzVAunQ+vPdosDdlLDCl2JNMPGbY3ukZHFD5HB/10NLbW6nDO6fT48v5VJRLhpzgc3wB6XGEom
 dyYnzfPdzBD/IPULfN37GdDBH1ku04zKJuWqNo9uyCNES4imNkH0NlqGgJMRJ5knyNRf5ELnaJOvh
 Cfc6kr6w==;
Received: from [2602:306:c5a2:a380:b27b:25ff:fe2c:51a8]
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mc83d-00ANfc-5J; Sun, 17 Oct 2021 15:26:41 +0000
Subject: Re: [PATCH 00/13] block: add_disk() error handling stragglers
To: Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
 mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 jim@jtan.com, minchan@kernel.org, ngupta@vflare.org,
 senozhatsky@chromium.org, richard@nod.at, miquel.raynal@bootlin.com,
 vigneshr@ti.com, dan.j.williams@intel.com, vishal.l.verma@intel.com,
 dave.jiang@intel.com, ira.weiny@intel.com, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me
Cc: linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mtd@lists.infradead.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211015235219.2191207-1-mcgrof@kernel.org>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <a31970d6-8631-9d9d-a36f-8f4fcebfb1e6@infradead.org>
Date: Sun, 17 Oct 2021 08:26:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211015235219.2191207-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Hi Luis,

On 10/15/21 4:52 PM, Luis Chamberlain wrote:
> This patch set consists of al the straggler drivers for which we have
> have no patch reviews done for yet. I'd like to ask for folks to please
> consider chiming in, specially if you're the maintainer for the driver.
> Additionally if you can specify if you'll take the patch in yourself or
> if you want Jens to take it, that'd be great too.

Do you have a git repo with the patch set applied that I can use to test with?

Thanks.

-Geoff

