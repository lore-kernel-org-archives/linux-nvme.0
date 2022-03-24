Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F14C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 06:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+KE1BvFMvVsJ/wb607eX3jHakM89GYVqTkCnt3m2rzI=; b=UpkgAGNa6KPX1cbs6x7y2vbFVU
	0a+FiYw9l+eSW3ASZTaCrRBVJbkS8RJkYRIWZ5ulzNsJfkl5IoX6389d2V0qLCYKaHChPZeL6EpBR
	Id1FH43StFugJ8uoSK7J5h2ihASUerJCbyhNiljDGOwpC3lSNKBupx5XyDRv965W5OxHcojh+5Ud7
	kan6yniCrSqvb2naq0PK/+/YkA/FQ2IovZN/tsWIXS7uHMRsL8JP5P4szye+VdAnHI88ItX8VJjox
	8ItvKWFgnW2iVwpQpLu9onoj74ip0cFDUAEqKvsCCOF6kX8EhTSAPwvekOwDJCdPh/2NnvsKxwg0M
	ergDsCZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXGs0-00Foxd-Ua; Thu, 24 Mar 2022 06:22:52 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXGry-00Fowz-LO
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 06:22:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E116B68C4E; Thu, 24 Mar 2022 07:22:46 +0100 (CET)
Date: Thu, 24 Mar 2022 07:22:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
 asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 sbates@raithlin.com, logang@deltatee.com, pankydev8@gmail.com,
 javier@javigon.com, mcgrof@kernel.org, a.manzanares@samsung.com,
 joshiiitr@gmail.com, anuj20.g@samsung.com
Subject: Re: [PATCH 05/17] nvme: wire-up support for async-passthru on
 char-device.
Message-ID: <20220324062246.GB12519@lst.de>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152702epcas5p1eb1880e024ac8b9531c85a82f31a4e78@epcas5p1.samsung.com>
 <20220308152105.309618-6-joshi.k@samsung.com> <20220311070148.GA17881@lst.de>
 <20220314162356.GA13902@test-zns> <20220315085410.GA4132@lst.de>
 <20220316072727.GA2104@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316072727.GA2104@test-zns>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_232250_874477_963AA7D7 
X-CRM114-Status: GOOD (  20.77  )
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

On Wed, Mar 16, 2022 at 12:57:27PM +0530, Kanchan Joshi wrote:
> So what is the picture that you have in mind for struct io_uring_cmd?
> Moving meta fields out makes it look like this - 


> @@ -28,7 +28,10 @@ struct io_uring_cmd {
>        u32             cmd_op;
>        u16             cmd_len;
>        u16             unused;
> -       u8              pdu[28]; /* available inline for free use */
> +       void __user     *meta_buffer; /* nvme pt specific */
> +       u32             meta_len; /* nvme pt specific */
> +       u8              pdu[16]; /* available inline for free use */
> +
> };
> And corresponding nvme 16 byte pdu - struct nvme_uring_cmd_pdu {
> -       u32 meta_len;
>        union {
>                struct bio *bio;
>                struct request *req;
>        };
>        void *meta; /* kernel-resident buffer */
> -       void __user *meta_buffer;
> } __packed;

No, I'd also move the meta field (and call it meta_buffer) to
struct io_uring_cmd, and replace the pdu array with a simple
 
 	void *private;

> We would still need to use/export that even if we somehow manage to move
> task-work trigger from nvme-function to blk_mq_complete_request.
> io_uring's task-work infra is more baked than raw task-work infra.
> It would not be good to repeat all that code elsewhere.
> I tried raw one in the first attempt, and Jens suggested to move to baked
> one. Here is the link that gave birth to this interface -
> https://lore.kernel.org/linux-nvme/6d847f4a-65a5-bc62-1d36-52e222e3d142@kernel.dk/

Ok.  I can't say I'm a fan of where this is going.

