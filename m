Return-Path: <SRS0=7pRJ=KP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B224C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 06:02:27 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF478610A1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 06:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF478610A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dcWxyZeyhZsdICT7Icz7Ac6P7hfygH3/MLAZz6Xqutg=; b=aK1ebHmW7jq7m3R10yx2/e5uI
	E4qU5Dt6UtRgSjGpWTyvZgHBb0k01ubpG+G42MeCN6speqNIeHWUgImm4B/ib2H0YZaOOWbrXJ4ZV
	EP/es7lzXcev4HfNS6jKHDdh2XhjQyBsTF6q+HFhd/e5RjHGlI56k3ZnaJLrHt++tx48wSTgw6+P8
	R7xOGzfbTRLMkR4gyu59nwaKdVt+P4Sae2d2oXHo6SPLoLtE/x99LdZQ4Eu06d4UX2XBsXV/tINLf
	V3Ftwpmu447oLJyiaysoRdZjs6kMvvE1eh2b8Y0bszBHd5ddHe8MJ4LqKSoPWlYQWPhKkTSfmzc4E
	SSdHQBsxw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljbkv-0060vE-Qk; Thu, 20 May 2021 06:02:01 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljbkt-0060v3-5g
 for linux-nvme@desiato.infradead.org; Thu, 20 May 2021 06:01:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=k5o8WY7DxHnNOoCRjjGMY2v4vmNf5q4wJThy1Nvkhvs=; b=PcpmXRHX+NfgUy3i3dm8paI9CR
 rowEjtQSu1IsAWe47oRKoWOf4a4g/WGPkuN9Tb2V+rHeY6Mm7fzT0u0QofUVSuDt3RZmserFRocQD
 jCBB8Ui/woSpW2c2Ocnd25WTi2NF+qXYEe/6lTkFUjw1ISPGs/ZrNo7dF2FJlL/NHSg7Ex6ccD/mg
 1AnRVn+pl/+LNXeBr0+0qUhf9Sc5S8Z0CUO6BWV7dd9S+Gv7Ag/e9SiYWoKqjwc7syTQx3kesneLH
 SQQZ+eyNZR22QimdMjy6XN7fYte8BZEDvnSnaXYLNm6mq4q+a4gMCREb/VTxtZrtgEnMduIRZ0uIF
 TTSddqLg==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljbkq-00FyP4-H1
 for linux-nvme@lists.infradead.org; Thu, 20 May 2021 06:01:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2C5B968BEB; Thu, 20 May 2021 08:01:53 +0200 (CEST)
Date: Thu, 20 May 2021 08:01:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v2 1/4] params: lift param_set_uint_minmax to common code
Message-ID: <20210520060152.GA21781@lst.de>
References: <20210519174340.1144806-1-sagi@grimberg.me>
 <20210519174340.1144806-2-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210519174340.1144806-2-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210519_230156_735417_33D143AF 
X-CRM114-Status: GOOD (  11.98  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, May 19, 2021 at 10:43:37AM -0700, Sagi Grimberg wrote:
> It is a useful helper hence move it to common code so others can enjoy
> it.


This needs a Cc to linux-kernel and linux-nfs.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
