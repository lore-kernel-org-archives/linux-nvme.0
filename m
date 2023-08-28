Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20B3C83F11
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Aug 2023 09:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qs5to4rwtCdiLFb9zpC7gJ2AeG93kNIbfdCwsy60hww=; b=lkTHmHqsU1Ja93c3ZN+6Co/d37
	ZgLH4K2KiUd0NE33GVv5yCEnP36YRdfWEUq5JpFdHncbBqc7BV7sBua2wwywwqlBnBYUjKDZhoMcV
	f3feyG2phE5d6pVp4P+mh3PT1/BN4Fy1VLm2X3+UmqLQO/Qc5UbSEHRrp0OoptpsPGA1QpxY17KAz
	9ppEbxAIP4/zdx02zdOGffniCodVmZx3HVqFhZLT4NV+EC59umvyeh8SJaAjhhPBF8rJXi9/LxNNW
	qk2S+tIGmielRGGmxP/CFdVZ/CklCsBPpnyvNNnH+3mL3bolu3Xnp/CN7SaWEkEz2MnTtJEztdFXJ
	CN13dClQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qaYQO-009DTz-1K;
	Mon, 28 Aug 2023 09:20:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qaYQL-009DSg-1Q
	for linux-nvme@lists.infradead.org;
	Mon, 28 Aug 2023 09:20:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 86AA56732D; Mon, 28 Aug 2023 11:20:38 +0200 (CEST)
Date: Mon, 28 Aug 2023 11:20:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Guangwu Zhang <guazhang@redhat.com>, Ming Lei <ming.lei@redhat.com>,
	Oleg Solovyov <mcpain@altlinux.org>
Subject: Re: stack smashing detected with 'nvme sanitize-log /dev/nvme0'
Message-ID: <20230828092038.GB30603@lst.de>
References: <dckvq3ohgqdkxg7wz4vslf36gaivgldl742vew67oyh2buj5nr@7ypn5ydt6kss> <20230726131643.GA16186@lst.de> <zopmb3355u2vorlkvas3gqb53azp7qtb7yq2kyc3reezlyqtcy@iev3wkvzumsq> <ZON+qrAwuO3eQB6G@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZON+qrAwuO3eQB6G@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230828_022041_619017_27380084 
X-CRM114-Status: GOOD (  14.03  )
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

On Mon, Aug 21, 2023 at 09:11:38AM -0600, Keith Busch wrote:
> I don't think we want to bounce to kernel memory for the device to
> overwrite it. I suggest just change nvme-cli's stack allocated santize
> log to a use page aligned and sized buffer.

That assumes it actually overwrites it in that case and doesn't just
have a PRP parsing bug when there is not enough alignment.

We should be able to find out by enabling KASAN and then requiring the
larger alignment before re-running the reproducer.

