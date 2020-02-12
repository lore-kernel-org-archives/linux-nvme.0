Return-Path: <SRS0=S8v+=4A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EA2C2BA83
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 17:35:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7116720873
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 17:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HO/2lG2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7116720873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+oK03CJLOYy16JirtdNLdSNaXv59Uh3Ydga8dXJBG5k=; b=HO/2lG2Cp8+qsd
	yAj47CQJoxk3UZm2QkQSYU2vePFcREaeu4uW487lGcFie4AmI8fiLG8lBWlko1ZCw6esAmJwEivyK
	/ebnPFgBObUL8nSzjsbBUbzHdMsY+s3xCgaeed3p3BE2+mK4Vj3XABKl0hbpHWZSds11c62Csedg4
	gxZQCR3bQn/O+Ql48iGlXC7dWH3JUr9wOw3hxZ52a9Sfp3RuzxB2/bNWf/zsbWziRUbHxfvZN7Nao
	IdLqLFi+SG6kZ3w0jKUG9zO8pjnlEWkYtmObGxFuooDgbx8dEUVfugeNnxwCIcngkJkDJPtVz6uqF
	ev3iTpiZlvXmnCHbVMSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1vvF-0005DD-UK; Wed, 12 Feb 2020 17:35:37 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1vvC-0005Cj-Gt
 for linux-nvme@lists.infradead.org; Wed, 12 Feb 2020 17:35:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 38C8368BFE; Wed, 12 Feb 2020 18:35:29 +0100 (CET)
Date: Wed, 12 Feb 2020 18:35:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: Case-sensitive host NQN
Message-ID: <20200212173529.GA5648@lst.de>
References: <4973fdd4-8a6c-1218-8f82-5413d3fec37f@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4973fdd4-8a6c-1218-8f82-5413d3fec37f@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200212_093534_707536_92E35EB5 
X-CRM114-Status: GOOD (  13.16  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 12, 2020 at 01:58:26PM +0100, Hannes Reinecke wrote:
> Hi all,
> 
> I've stumbled across a slight weirdness for our handling of host NQNs.
> We do format them like
> 
> # cat /etc/nvme/hostnqn
> nqn.2014-08.org.nvmexpress:uuid:36343050-3834-584D-5138-33313030344E
> 
> as this is a UUID, one would expect that it's identical to
> 
> # cat /etc/nvme/hostnqn
> nqn.2014-08.org.nvmexpress:uuid:36343050-3834-584d-5138-33313030344e
> 
> (Note the lowercase letters).
> As it turns out, this is _not_ the case, causing the connection not to
> be established.
> 
> Which is slightly weird, and not what one would expect.
> The NVMe spec only has this vague statement
> "Upon entry NVM host software may process an NVMe qualified name..."
> so we would be spec-compatible when setting the fields to lowercase
> when reading the nqn.

Check section 7.9 of NVMe 1.4:

"NVMe hosts, controllers and NVM subsystems compare (e.g., for equality)
NVMe Qualified Names used by NVMe as binary strings without any text
processing or text comparison logic that is specific to the Unicode
character set or locale (e.g., case folding or conversion to lower case,
Unicode normalization)."

so no, they are case sensitive and the above is by design.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
