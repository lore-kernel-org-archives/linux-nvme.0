Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDF6CE7A95
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Sep 2023 15:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wWTiL9+Gr0ITPdXBGP9rodfpHkrobc68g2rL2rOjMKA=; b=YfoHpok6WoZWX+0xO+59g2fWjI
	T/PNVLYfw1bHkRafCTr6HDR99c/siL7tbvCJL+AdVR9UxjYaOoQGrbio0Z+XMwNoV7Z1IqvrkTFYH
	FQkDAPvHqZvQabdbOfDcgtP/ujJsFtvjY0g9xcjcql0496LEt4dbjzv06pXERC//TxvhsuDHXggng
	xowdwuaEmYv+7GIReazIDSUd6dc0AFuG87JUJYPNqcm7Fim281Nxl+8Nsjk2wg2rsKixO8+OrIJdk
	9fOXccoYt0kP/pQ3ZL03KMAge9LBif5lqCG5BnR/eJaw2iYFqVSwGXGSyMRWWnwt7mW4P72LMnP58
	lMorwung==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qknNR-00EXFX-2B;
	Mon, 25 Sep 2023 15:20:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qknNO-00EXDM-0Q
	for linux-nvme@lists.infradead.org;
	Mon, 25 Sep 2023 15:20:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4143768D05; Mon, 25 Sep 2023 17:19:50 +0200 (CEST)
Date: Mon, 25 Sep 2023 17:19:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Guangwu Zhang <guazhang@redhat.com>, Ming Lei <ming.lei@redhat.com>,
	Oleg Solovyov <mcpain@altlinux.org>
Subject: Re: stack smashing detected with 'nvme sanitize-log /dev/nvme0'
Message-ID: <20230925151950.GB444@lst.de>
References: <dckvq3ohgqdkxg7wz4vslf36gaivgldl742vew67oyh2buj5nr@7ypn5ydt6kss> <20230726131643.GA16186@lst.de> <zopmb3355u2vorlkvas3gqb53azp7qtb7yq2kyc3reezlyqtcy@iev3wkvzumsq> <ZON+qrAwuO3eQB6G@kbusch-mbp.dhcp.thefacebook.com> <4ub43j2q4glt42cwgmaf4cohswt4xaz3lna5nquvb5lavjitvv@tctmuwftqil6> <ZOYnzFSgWAwnkWqs@kbusch-mbp> <j4azjg6k4cg3tynmvyl3qqcd7imcoaisy35ssqob34cw3ox32g@qk7dmqt72vbx> <20230828092155.GC30603@lst.de> <fq5ds4d6u7zz3bsag6tj3xdjhodwc25g5nggvalgwmcfovbjma@guuybbch4eja>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fq5ds4d6u7zz3bsag6tj3xdjhodwc25g5nggvalgwmcfovbjma@guuybbch4eja>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230925_081958_325108_D1A3234F 
X-CRM114-Status: GOOD (  15.46  )
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

On Mon, Sep 25, 2023 at 05:09:16PM +0200, Daniel Wagner wrote:
> > The device just seems completely broken unfortunately.
> 
> Just a follow up on this. I've update nvme-cli so that all payloads are
> allocated via the nvme_alloc() helper which ensures that the payloads
> start at a 4k boundary and the buffer is multiple of 4k. This should
> address this issue.

It does not address the issue, it just works around it.   I think we
need a kernel level quirk to make sure we never issue commands that
cause these devices to act so broken to them, as the stack smashing is
a security problem.

