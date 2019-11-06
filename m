Return-Path: <SRS0=IwtP=Y6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2FEC47E49
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2019 00:08:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC3CC21D6C
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2019 00:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q7jSTYxo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgO5vzyK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3CC21D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zTzig75SkCSd7m+QZfk7GkZ0EohvRRZikAhvV46FSz4=; b=q7jSTYxoJCxX+4JYzgavt8zWT
	Vyjf1joN5szilFXNZh2F+FL4cl3Q3s3mMY53h/mnkGM3s6PbzcNALTNULkcgSom9rM0zmAJM8gOtN
	ctHIHYW1Vq40Q5ULJXrd/Q8QmPBVSRFR5HF14MlBDdHYaC0ldjAs22tVfFgVIasz3QqKJggJEV/1/
	4iPpbHLtsVaCql+U6Nf02hTNF8jqhG7Q5OR5x7UPW3uSNE1Xw0ZRaHfONgbKpf2/IBe9bvPzjTSgT
	yex09Ov8pTQf1XovBoNu/L9LRlFJzA8nN5u2S3wRZkCbfDp96H/MSKasZhuPTyyc9x1OW0YlWwNaS
	7y6ReNUNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iS8sL-0006x4-EE; Wed, 06 Nov 2019 00:08:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iS8sI-0006wf-Fv
 for linux-nvme@lists.infradead.org; Wed, 06 Nov 2019 00:08:39 +0000
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0FC65214D8;
 Wed,  6 Nov 2019 00:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572998917;
 bh=d8eua9epBG5FR3oyfrO8a6KH1Z3GMMnPGdw78PUjkOQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IgO5vzyKQlxiswiCAv0ySsNr5xM1suuJtgO7N2+x28RU45JBffkFf8N1OQ1FM5xwj
 5iRqXhFjvhJhQoqhcEIHBCXDk/TGpDXiYcaexlLUYr3xOGgo7y+HdR7OdCAAaLAvmg
 Sz8QqvITUCvfXHe1KPDcbG8ywsRAAk7yZZLnQ94A=
Date: Tue, 5 Nov 2019 19:08:36 -0500
From: Sasha Levin <sashal@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: change nvme_passthru_cmd64 to explicitly mark rsvd
Message-ID: <20191106000836.GH4787@sasha-vm>
References: <20191105061510.22233-1-csm10495@gmail.com>
 <442718702.90376810.1572939552776.JavaMail.zimbra@kalray.eu>
 <20191105153144.GA12437@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191105153144.GA12437@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191105_160838_550235_050BA362 
X-CRM114-Status: UNSURE (   9.17  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Marta Rybczynska <mrybczyn@kalray.eu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Charles Machalow <csm10495@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>, axboe <axboe@fb.com>,
 stable@vger.kernel.org, kbusch <kbusch@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Nov 05, 2019 at 04:31:44PM +0100, Christoph Hellwig wrote:
>On Tue, Nov 05, 2019 at 08:39:12AM +0100, Marta Rybczynska wrote:
>> Looks good to me. However, please note that the new ioctl made it already to 5.3.8.
>
>It wasn't in 5.3, but it seems like you are right and it somehow got
>picked for the stable releases.
>
>Sasha, can you please revert 76d609da9ed1cc0dc780e2b539d7b827ce28f182
>in 5.3-stable ASAP and make sure crap like backporting new ABIs that
>haven't seen a release yet is never ever going to happen again?

Sure, I'll revert it. I guess I wasn't expecting to see something like
this in a -rc release. How did it make it into one if it's not a fix?

-- 
Thanks,
Sasha

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
