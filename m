Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC65C3064D
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jun 2024 08:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x3+eAOe1i1Z7vPP2L6p8LjDhEKjTebGqK0YH2zEsuOg=; b=durCbATc9wc751BTpY1n4IsFWZ
	8sjr56E5aZG706SAdJ1LxI1grpIr7e25hRVP2W3meoHfdCB2Anh4HAYJTbkoI4F/4O+y1XiwbqLB7
	yD/u43aQnHlMZO4H/+9ykF0I0B5m1aqDn5hOm/3XaTUFXsWBpcBveO1PQE5k0XWLMHgc4M5Yfail6
	biCaUG+hnQhCTzvlDSJLCXHRrl9AEfyfcavO+zKpNvgFTlksOm9hQXH5uRF8QZijdgjW665CYETy9
	2DYAuOGtvm79w1dDDe0E8Y1ZbdP2fj2RWa2O77S8ckRj3zQW6uSvXmQWA09TXfPkbmbrFZ4Li9DD2
	djxkO3tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMkF1-00000009gsh-2Bug;
	Thu, 27 Jun 2024 08:12:27 +0000
Received: from smtp45.i.mail.ru ([95.163.41.83])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMkEx-00000009gr4-3fEK
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jun 2024 08:12:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=x3+eAOe1i1Z7vPP2L6p8LjDhEKjTebGqK0YH2zEsuOg=; t=1719475941; x=1719565941; 
	b=GEcc8yHZB9AHDm5qSwyl12WhhAzCqSBsqjgXfrlZ74ysfYwmx70cp+Lge1OIMh1ZH8zLWGvCJmw
	Yn3i/wOH5ouCMOJqGSQdhSyHkZOnVIszPzD+LJznV/lbrJnzRg2EXT7jPj4zRJqE/7x0ocs765u3j
	09Al4oNKdzARLx2Kx9G6A3fIedBYIaDOI+ndw+sfmcmqCdaY4kOUAQEE1nEM5AabRtkcjdTsDaGma
	uYkahZI7mSROQ1KTL2G4/M2HT0XDFkfO3Ns8WkfMbzUPCBNQ0hY/6UvvUXjXZqw0f3sNZMCePOeIY
	pGbR4+tXXu3caGMWknBkf+0vMM7BPqCzbH3Q==;
Received: by exim-smtp-84f7fbf7d8-hgbp6 with esmtpa (envelope-from <m.lombardi85@mail.ru>)
	id 1sMkEq-00000000IIS-2ARm; Thu, 27 Jun 2024 11:12:17 +0300
Date: Thu, 27 Jun 2024 10:12:13 +0200
From: Maurizio Lombardi <m.lombardi85@mail.ru>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, sagi@grimberg.me, emilne@redhat.com,
	hare@kernel.org, kbusch@meta.com, linux-nvme@lists.infradead.org,
	mlombard@redhat.com
Subject: Re: [PATCH v2 7/7] nvme: add reserved ioq tags for cancel
Message-ID: <Zn0e0PK+PM0G4Xkl@kalibr>
References: <50a62d8e-b45e-4ae0-81dc-f12c46a5a65b@grimberg.me>
 <20240626183819.23960-1-jmeneghi@redhat.com>
 <Znxl9kFmoJWg1S0D@kbusch-mbp.dhcp.thefacebook.com>
 <fc2fd513-ab39-4d87-b2ce-e1f86bdf5d45@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc2fd513-ab39-4d87-b2ce-e1f86bdf5d45@redhat.com>
Authentication-Results: exim-smtp-84f7fbf7d8-hgbp6; auth=pass smtp.auth=m.lombardi85@mail.ru smtp.mailfrom=m.lombardi85@mail.ru
X-Mailru-Src: smtp
X-4EC0790: 1
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD99270B3E0DC24D31F5B22ABB6212E75010C393A61199937B3182A05F538085040CA18840792EFC4503DE06ABAFEAF670592D03C92C1332CE242691B0D61574D9D67D05D8178A78D18
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7811C3E343B302E2EEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637E1AAA91777E61F958638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8E7DD242A918C0CA735F198FCC5BB6E55467B8D0DABA48FEE20879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C02F11D39E7306DD338941B15DA834481FA18204E546F3947C2FFDA4F57982C5F4F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637F3E38EE449E3E2AE389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F7900637CD70681E7BFD3F6ED81D268191BDAD3DBD4B6F7A4D31EC0BE2F48590F00D11D6D81D268191BDAD3D78DA827A17800CE7BF2C217CD5393D68EC76A7562686271ED91E3A1F190DE8FD2E808ACE2090B5E14AD6D5ED66289B5259CC434672EE63711DD303D21008E298D5E8D9A59859A8B6D082881546D9349175ECD9A6C639B01B78DA827A17800CE70711EC19236D5A3D731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A50DBFCA885B49B1B75002B1117B3ED696171575B65B8C712B33EE06AFCD964888823CB91A9FED034534781492E4B8EEADFCE5E68AF59B345DBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD93B9BA3C444D644977DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF73CE5ED334B109971B409890F28D265C9E02706BFDCD54D8E3939CE84F3A4057192AF36DABE85845443676941C84C1C8A4B24C32AE573C610698F5CD53E22D8CE27C0CBEB90944DB9FDC11CE098E8E5C913E6812662D5F2AAF96C8710EA0325A80F89563ADA45E48C3981EEBE9DB10F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojLaF05p8kWooaXnKDo4m1OA==
X-Mailru-Sender: A8F475CF1C824D1CBA77B1F2B8087B007CF7695A04774D2EECD36BBCDBC78BF8CA487BE980650175E4F3502559AA9718D8A79CCC3C8D74D41DFF15BC5ABCB624EF07C4B4834D601BDC6127B08F856444D0E43066D6DAA6349E6661CE6659AC881C93572D6AD3136CB4A721A3011E896F
X-Mras: Ok
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240627_011224_446334_B1F49426 
X-CRM114-Status: GOOD (  17.84  )
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

V Wed, Jun 26, 2024 at 03:20:08PM -0400, John Meneghini napsal(a):
> > >   	else if (ctrl->ops->flags & NVME_F_FABRICS)
> > >   		/* Reserved for fabric connect */
> > >   		set->reserved_tags = 1;
> > 
> > You mentioned an addtional tags is supposed to be reserved for fabrics.
> > Shouldn't this just be an "if", not an "else if", and then increment
> > reserved_tags?
> 
> Yes, good point. I was thinking we don't need more than 2 tags if it's a fabric.
> 
> So you want to reserve 3 tags when both cancel and fabrics are true?

You dropped the reserved tag for the connect command, this is from
the V2 patchset I am working on:

From: Maurizio Lombardi <mlombard@redhat.com>
Date: Tue, 25 Jun 2024 15:45:54 +0200
Subject: [PATCH 3/8] nvme-core: reserve tags for cancel commands

If the controller supports cancel commands, reserve two tags for them

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fea5400ddf92..1b20f1a10321 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4532,9 +4532,14 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
         */
        if (ctrl->quirks & NVME_QUIRK_SHARED_TAGS)
                set->reserved_tags = NVME_AQ_DEPTH;
-       else if (ctrl->ops->flags & NVME_F_FABRICS)
+       else if (ctrl->ops->flags & NVME_F_FABRICS) {
                /* Reserved for fabric connect */
                set->reserved_tags = 1;
+               if (nvme_io_command_supported(ctrl, nvme_cmd_cancel)) {
+                       /* Reserved for cancel commands */
+                       set->reserved_tags += 2;
+               }
+       }
        set->numa_node = ctrl->numa_node;
        set->flags = BLK_MQ_F_SHOULD_MERGE;
        if (ctrl->ops->flags & NVME_F_BLOCKING)
-- 
2.43.0

Maurizio


