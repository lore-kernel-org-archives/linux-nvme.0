Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAE2C4707A
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 17:32:02 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F5AB61168
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 17:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5AB61168
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fsb6sFm3dZbHgDsZ+IKW68v2dsPcOp12Omee/P2lsU0=; b=mBTVVUk4laL82sGOKM2hl3iYnG
	XO66LD9KascLbaVsEugIf1Gkpc5sxJ7uH01y+hmmqZp+A9mwU5G5fovSJ6lhBkn/KMrTioRz4jhVL
	TUAe47gu1htA5SBGmOhaVgoN8Sl2mj76gAMcNXbrDs9iEKk/5F+iZ3RaTbM9H1nzB/uNsw/IsU3i5
	gvwnpeZqhSruMzw1LxFpxSFrDSD2VOW7yGMxJ/d74pl2wnnROT6D2vuSwGKw2T8zpnxzN6lr+QA+Z
	9skPALokSr87vTrGIFcqKptvY3Gd/WUV1FAzJ9KquQNY/jkJ9IZKQgts3Uq2BhLDz++HcrYnlRJJj
	oF22dKhg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lk8zq-000WCt-Fh; Fri, 21 May 2021 17:31:38 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lk8zn-000WBu-IN
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 17:31:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=U8vjUZd9dJywG8M0z86+PE9K7912Wg25C68e3M+Frlc=; b=BwRjKy0X1xMKPYBzDYGGKRRiyP
 311WywNt2UbW5ACeXFBDEZm81ql4B3ZTTAIz4cniOwHqYIUs+U5hCnQr556lanbNhHZIpf2wyNyNC
 33TVb5dru/h36eCYdwWF/Xq7186zrZPzZpgIC7lBl30bO+cJeR3evkBXL+kFxMWdlHGyysNKqS+dg
 qnjdcYl3urFDPMaJ2wbGqPvqPjk86tO5Pd4DC06UauXh6wYSwI3eLSgx8xxCUxh0VHeANajSL8EVq
 wJVOCPnIDZdk6OmVfBPj35CJfw9uayLEYA/bT+0gqG2wERD1gIOv1IHxAMzORBrAUMWSpv2IUSWlC
 JBGaIkPw==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lk8zl-00HJc3-07
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 17:31:34 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5347161168;
 Fri, 21 May 2021 17:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621618292;
 bh=OG23lV2iBZOz9Wi57t4JrGC9Btm0OCvWAaAL5rT2Rhs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GSkYUhxHlXxUdKGYyTuDBpRttRih5xw+K1i19km6VOo4CE97qB612nkgEm3ijjhER
 2oWoTLN3UZVDcLgbzhNTf8Z3POtH3R8+ua8p6WKTMSGDWOW0uhsbKoUAzHEUZ8LwP4
 nh+3DEiOoF/YDgTQVLUY45/buDwSwsfE+EhqsYkiRHmAkYP9/FShvTFkCSSf3cLFZb
 s5H6p+CeBJ8AizHqbOdsXZ4Bnn2uCTkQDx4KyWugRW//K7ID0FHpsOIs7F6lmKdGR6
 nhDcFUebNoqHPS7UdJ2x9VBYRe54erOsLz+5bmlc2jVxJsgAglQFe2q79B/17wkpEL
 eLSYY2CdexIYg==
Date: Sat, 22 May 2021 02:31:25 +0900
From: Keith Busch <kbusch@kernel.org>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc: "hch@lst.de" <hch@lst.de>, "Williams, Dan J" <dan.j.williams@intel.com>,
 "Schofield, Alison" <alison.schofield@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Weiny, Ira" <ira.weiny@intel.com>,
 "Widawsky, Ben" <ben.widawsky@intel.com>
Subject: Re: [BISECTED] nvme probe failure with v5.13-rc1
Message-ID: <20210521173125.GC29013@redsun51.ssa.fujisawa.hgst.com>
References: <40071b11108987556d0473f9d968fe7dcd3f304a.camel@intel.com>
 <20210521145705.GA29013@redsun51.ssa.fujisawa.hgst.com>
 <e8ad9de961f3bfcb748733b59c189aa577ffa1fd.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e8ad9de961f3bfcb748733b59c189aa577ffa1fd.camel@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_103133_083241_DA157779 
X-CRM114-Status: UNSURE (   9.54  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, May 21, 2021 at 04:50:15PM +0000, Verma, Vishal L wrote:
> 
> Thanks for looking into it - yes with that the problem goes away.
> Let me chat with the simics folks and see if I can get them to fix it.

Thanks for confirming. It sounds like the simics implementation is
missing a default case in its identify function's CNS check and simply
loses track of the command. I'd wager it probably also times out for any
reserved or unsupported CNS value.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
