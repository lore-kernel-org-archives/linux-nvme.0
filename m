Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB9CE77180
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2024 16:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fvPA/Xow3m3G42ETCw/C7YnNXiVSSwMvusNe5RP65TU=; b=qysqLQf/mn9c0uJvrvQSFGZLYT
	uzaiK8cI4z8Qsk/dpnCI9cXy67iZFl+EBVXCO64bu/vMjSQziQVKjLbg+sD4zfUdr7cioTDHCVjCL
	NBNm+ifMm8qIMF9lMSV18gp1nlJXUeptSA9LN0Cf8l403M4S33Jk+BuYNYtQLHHETEHIzi0+8vahR
	6572jKhaEIg3f32FQT4jmuNz9XUae6KHnJaKQKHKLZn99cDwA1mLxA0oaCekFaDr4pQPoADjC3Nc7
	60G8iPVWieiC6aT/2UAn4d8oypcHmriaghZEZTUiZ8mpPdQUY/DGOYQj+fjG7xVLKwsXEM4G0kU5R
	owSfp5JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNEIW-0000000Af6Q-1aQJ;
	Mon, 16 Dec 2024 16:50:20 +0000
Received: from hours.tkos.co.il ([84.110.109.230] helo=mail.tkos.co.il)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNEIO-0000000Af24-3dt3
	for linux-nvme@lists.infradead.org;
	Mon, 16 Dec 2024 16:50:14 +0000
Received: from localhost (unknown [10.0.8.3])
	by mail.tkos.co.il (Postfix) with ESMTP id 7B3D5440022;
	Mon, 16 Dec 2024 18:45:53 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1734367553;
	bh=fuQeC2e0rsD0c2PAdGiK/vNcTpRlD2eT0wbcH+7rOuI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dyPS5KXeVFNOAOgbpUJBmeZPtPHiaRB+ftUGcO0KQJdZWctFA2VY8i2x93GpTWvgO
	 RQt8Hbvz85jac1yLI22gRyQbAQ/UtKYI1bFzcWeLES3rsFuQQE8woqh68RWXMhETvn
	 MWoryPfIamgyaCfCEvxSyMrKzz2D+nzeKKCDs4P+Hcp46LdaZK7OTsuQva7ZfWWmuJ
	 hMtLT0HX4qPQGW5IMwLt7Wz84k64EAiBnNCO/E7OrPdbMG/iHDyK7aD01RbaIo1M6k
	 mbjzee3UBZDTsIDyJ/TpkGwXMvsjfoN0DHWAnL04xQVG86flwIxgRfO3DdE9VpTZ68
	 WToh21KpiQgZw==
From: Baruch Siach <baruch@tkos.co.il>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,  Jens Axboe <axboe@fb.com>,  Sagi
 Grimberg <sagi@grimberg.me>,  linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: use dev_err() to make message more useful
In-Reply-To: <20241212072918.GA7039@lst.de> (Christoph Hellwig's message of
	"Thu, 12 Dec 2024 08:29:18 +0100")
References: <551518fe326d5cff08aa2df1b7d69fcd689fdd96.1733988012.git.baruch@tkos.co.il>
	<20241212072918.GA7039@lst.de>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 16 Dec 2024 18:50:03 +0200
Message-ID: <87pllrvah0.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_085013_379221_A48CD706 
X-CRM114-Status: UNSURE (   9.99  )
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

Hi Christoph,

On Thu, Dec 12 2024, Christoph Hellwig wrote:
> On Thu, Dec 12, 2024 at 09:20:12AM +0200, Baruch Siach wrote:
>> +	req = nvme_find_rq(&anv->ctrl, apple_nvme_queue_tagset(anv, q), command_id);
>
> Please avoid the overly long lines.  Note that the nvme_ctrl has pointers
> to the admin and io tagset, so you can actuall simply the second paramter
> here by just passing a 'bool admin_queue' and remove the
> apple_nvme_queue_tagset, nvme_queue_tagset, nvme_rdma_tagset and
> nvme_loop_tagset helpers entirely.  The TCP one still has other users
> by might be worth looking into as a follow up.

Passing 'bool admin_queue' is not enough. You also need qid to select
blk_mq_tags in the tagset.tags[] array.

Is it worth it?

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

