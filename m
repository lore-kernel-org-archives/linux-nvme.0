Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F0FC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 16:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d8UQhwuwoAkbFZ57jztu2SSHAHpShjKkjidJXZ4cRn4=; b=013sS2KcIoBPNiUpk291GPDUYY
	9vz5DPXuwIO3XpioS3cx1TzSFLNvS1mIQIfv1PwneOsL0eo5OaS6vI5wTXLi3d0BvTtC03L0XIDkD
	ZJe22IdstnjS2LC1y1KhhNS8NNDGLwWBNwQZsMuVU5VZLbspnep0JYBu3x+2f9FOb6QuZwQFBpHB0
	rf9RDFRXu8qUJVEhgruE2otuWgFA+cBkCqG9gUpyMj7mWFrv6aD1p7h2Rq68gFYdSfRUQTbEsB9eU
	GaM0/V8MPipKzkdXSejtKoPvlJ4WESNzuQ936QpUnMdLnEyCV62dIXvYXnvHtuCxo8W572GZwevas
	WVl2Ec2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMYNA-00AlNK-S0; Tue, 22 Feb 2022 16:50:45 +0000
Received: from relay5.hostedemail.com ([64.99.140.39])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMYIc-00AjfJ-FU
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 16:46:04 +0000
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
 by unirelay10.hostedemail.com (Postfix) with ESMTP id 784C8A5A;
 Tue, 22 Feb 2022 16:45:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf18.hostedemail.com (Postfix) with ESMTPA id 396B643; 
 Tue, 22 Feb 2022 16:45:34 +0000 (UTC)
Message-ID: <66a0c8210cf9e7dfcc3fa2d247de1eebd5a8acb7.camel@perches.com>
Subject: Re: [PATCHv3 04/10] linux/kernel: introduce lower_48_bits macro
From: Joe Perches <joe@perches.com>
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-crypto@vger.kernel.org, x86@kernel.org, 
 linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com, colyli@suse.de,
 Bart Van Assche <bvanassche@acm.org>
Date: Tue, 22 Feb 2022 08:45:53 -0800
In-Reply-To: <20220222163144.1782447-5-kbusch@kernel.org>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-5-kbusch@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 396B643
X-Stat-Signature: yzf67mxeguumtukwkfw7sqsufuzga6du
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+NisYWVxViQyJRvI3jjilg5uVaEbHyZ28=
X-HE-Tag: 1645548334-553202
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_084602_642914_36582920 
X-CRM114-Status: UNSURE (   8.19  )
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

On Tue, 2022-02-22 at 08:31 -0800, Keith Busch wrote:
> Recent data integrity field enhancements allow 48-bit reference tags.
> Introduce a helper macro since this will be a repeated operation.
[]
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
[]
> @@ -63,6 +63,12 @@
>  }					\
>  )
>  
> +/**
> + * lower_48_bits - return bits 0-47 of a number
> + * @n: the number we're accessing
> + */
> +#define lower_48_bits(n) ((u64)((n) & 0xffffffffffffull))

why not make this a static inline function?
And visually, it's difficult to quickly count a repeated character to 12.

Perhaps:

static inline u64 lower_48_bits(u64 val)
{
	return val & GENMASK_ULL(47, 0);
}



