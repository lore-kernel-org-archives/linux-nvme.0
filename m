Return-Path: <SRS0=MUCY=OP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80827C433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Sep 2021 20:09:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01F0360560
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Sep 2021 20:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 01F0360560
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=svenpeter.dev
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:Cc:To:From:Date:References:
	In-Reply-To:Message-Id:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+wxa46zBoAxZZ9E25t/miBlhqmx/VAIzDHI0kCjgVQ0=; b=QMU2nEnM869bC6
	lL7RjXCaM/5Gc87XgO14/BlNSA9o+WitlaXSRjsjMFeKa0CBR4RvJP9kiZ7oTnszasgcYWsUgq5Q/
	DSjfLz+IQEH+VwMxndEEqtkbVV2Kchn1Wt8/L+lMMN8gveppBsYDg5UftRE/Kg+eZpB9eNhcOus7b
	3RsAJb+NYyZGfZw0bC2fNALKzF1VowWbF0VeApqmJG90+yM6i1c3Uqz5KZVH8IghkuiWiH4zF8CcQ
	7AFFtMA3MLH2UfBVQmB1GSTf07wKLPckMPSs/wpQoq1pX0/+fmZngM89hcHSH4AqrETke38LboqOI
	6wtrOBBCPptIVWQur/4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUDz7-00HAJL-Ak; Sat, 25 Sep 2021 20:09:21 +0000
Received: from new2-smtp.messagingengine.com ([66.111.4.224])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUDz4-00HAIZ-3V
 for linux-nvme@lists.infradead.org; Sat, 25 Sep 2021 20:09:20 +0000
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailnew.nyi.internal (Postfix) with ESMTP id 52F5F580D54;
 Sat, 25 Sep 2021 16:09:14 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute1.internal (MEProxy); Sat, 25 Sep 2021 16:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm2; bh=6PMSDO6BZ+xy27mgnWdzVTs8mhQn
 VA8J8jGxD4LcfOU=; b=H+g1bbOSnBkO6sxhXn55NQO0dvnC9stLi7CUq+nR9YU7
 kRHg2t+h+BzqAjNYrI6Eu2n4wNZHyXtOmDUma9peybZivLQUUgM9r8uj/csKWCQw
 mOO3ooQLnvWeUCgSKGYnNZE4NmVEuFNduW42uJ27etBBG71P+qmJsFJ/RVR8k4Gq
 6pJfOVRUSr5uoUcrzcUPow/XrkcDoJ4RFwIEDTPAwfUZNeliSe5YaEetGRMBXFJ5
 vT4PLMNv4xyW2c3thmKOhuJ47qeb1tbyEGiR7glFQCEax69GSqHD8KXbB3ck6WX+
 mYD4IujyJ28OmMXvlBRmBqh+kthnA0KqMnYpvco3NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=6PMSDO
 6BZ+xy27mgnWdzVTs8mhQnVA8J8jGxD4LcfOU=; b=aWdv+8Huy4/tVeW0qNa/j1
 WfmDevqrNPfUHPzwOI/RWGvhNIFlvMSfkXbEJ1R5SraIv7LmYg1V6H24ZMEfyoXm
 4A87v2Ep4GQmDmupu00IGXW5CYoAiWU8h5wvZQ9jZwbIUs2lISGMVGM4DdU9p8eP
 zWUKBE8iUQbXIOUewhmfZipvYyQrrt2bfjgaeT2ay0UwZYu+idsZKY4r8VCUKSQT
 ylHozUivzwRKKri1B+WGgCEDO6tdZo2ByEB0F8YCghJfvR+sAc4jzV5nllct+Vnx
 /GjDoYD4rRcfBEkSnmBPZuEDBlSORuWY+k4I284+2qeN/iTxab9VDrXf+Ey9Fdug
 ==
X-ME-Sender: <xms:6YFPYZ5d08SRG3wr83VlAi1ErzS504Y-2-UICm7-NM05OB4jNcZ2zg>
 <xme:6YFPYW7suE2YmsCoaS7rkPwtbneFJH01qGp7kIPQMuahQiZwARBh605djNlfKgVoo
 9h4VDa9obdN4xohFeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudejfedgudeggecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
 vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
 grthhtvghrnhepudeujefgkeevleefhfefvdekieefteejudeviedugeejffevvdekvdek
 ueeluedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpphhrohhtohhnmhgrihhlrd
 gtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
 shhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:6YFPYQfX74yHY59l1D46POM5twFxVuELLDQeNJRzZvm-kJ-11fg7zg>
 <xmx:6YFPYSJEpg4Ji-p9yf6MuJbir14EeKyuy07jlP3F5DWMI_AL8YkdJQ>
 <xmx:6YFPYdJSnSX1ETQv9oAVVlo9IragYiI-rXqG8EY-lNjX9eHRND0zqA>
 <xmx:6oFPYWWxPMGclGbG25ztirA6Kfs4W_2NV_yJfY3VIg-1cpMqjGIwqg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 7454151C0060; Sat, 25 Sep 2021 16:09:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1303-gb2406efd75-fm-20210922.002-gb2406efd
Mime-Version: 1.0
Message-Id: <4849f3d3-4abd-49b7-b053-d7965daa7138@www.fastmail.com>
In-Reply-To: <20210925195425.GB116968@dhcp-10-100-145-180.wdc.com>
References: <PNZPR01MB4415600ACD3C8D9944F15058B8A59@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <CAHk-=wgML11x9afCvmg9yhVm9wi5mvnjBvmX+i7OfMA0Vd4FWA@mail.gmail.com>
 <20210925195425.GB116968@dhcp-10-100-145-180.wdc.com>
Date: Sat, 25 Sep 2021 22:08:53 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "Keith Busch" <kbusch@kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "Aditya Garg" <gargaditya08@live.com>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>,
 "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "trivial@kernel.org" <trivial@kernel.org>
Subject: Re: [PATCH] Urgent bug fix causing Apple SSDs to not work.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210925_130918_316513_14607B01 
X-CRM114-Status: GOOD (  33.29  )
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

Hi,

I actually ran into a similar issue while adding support for the NVMe
controller found on the M1 and assumed it was only present there.

Some background why this happens: ANS2 is a co-processor that emulates
an NVMe MMIO interface and uses the tag as an index to an internal data
structure. On the M1 we can directly talk to ANS2 and while we can submit
commands with a higher index it'll just ignore the upper bits and only
return the lowest eight IIRC in the completion queue.
I guess whatever software is running on the T2 actually has an assert to
ensure that the tag is within the limits before forwarding the command
to ANS2.

I haven't tested the attached patch yet but my WIP tree has an almost identical
one that works fine.



Best,

Sven


On Sat, Sep 25, 2021, at 21:54, Keith Busch wrote:
> On Sat, Sep 25, 2021 at 11:47:08AM -0700, Linus Torvalds wrote:
>> On Fri, Sep 24, 2021 at 9:02 PM Aditya Garg <gargaditya08@live.com> wrote:
>> >
>> > From: Aditya Garg <gargaditya08@live.com>
>> > Date: Fri, 24 Sep 2021 15:36:45 +0530
>> > Subject: [PATCH] Revert nvme to 5.14.5 to fix incompatibility arised in Apple SSDs.
>> > Fixes: e7006de6c238 (nvme: code command_id with a genctr for use-after-free validation)
>> 
>> I think we need to hear more about the problem than just revert a
>> commit like this randomly. That commit has already been picked up for
>> -stable,
>> 
>> What are the exact symptoms, and which Apple SSD is this?
>> 
>> I do find this:
>> 
>>   https://lore.kernel.org/all/cjJiSFV77WM51ciS8EuBcdeBcv9T83PUB-Kw3yi8PuC_LwrrUUnQ3w5RC1PbKvSYE72KryXp3wOJhv4Ov_WWIe2gKWOOo5uwuUjbbFA8HDM=@protonmail.com/
>> 
>> which instead of a revert has an actual patch. Can you try that one?
>> 
>> Keith Busch replied to that one, saying that the Apple SSD might not
>> be spec compliant, but hey, what else is new? If we start demanding
>> that hardware comply with specs, we'd have to scrap the whole notion
>> of working in the real world. Plus it would be very hypocritical of
>> us, since we ignore all specs when we deem them too limiting (whether
>> they be language specs, POSIX OS specs, or whatever).
>
> Right, we have a lot of quirks for the apple controllers, what's one
> more? :)
>
> Could the following patch be tried? I'm basing this off the 'lspci' from
> Orlando, but I'm assuming the previous model has the same limitation,
> too.
>
> ---
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 7efb31b87f37..f0787233557f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -979,6 +979,7 @@ EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
>  blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
>  {
>  	struct nvme_command *cmd = nvme_req(req)->cmd;
> +	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
>  	blk_status_t ret = BLK_STS_OK;
> 
>  	if (!(req->rq_flags & RQF_DONTPREP)) {
> @@ -1027,7 +1028,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, 
> struct request *req)
>  		return BLK_STS_IOERR;
>  	}
> 
> -	nvme_req(req)->genctr++;
> +	if (!(ctrl->quirks & NVME_QUIRK_SKIP_CID_GEN))
> +		nvme_req(req)->genctr++;
>  	cmd->common.command_id = nvme_cid(req);
>  	trace_nvme_setup_cmd(req, cmd);
>  	return ret;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 9871c0c9374c..b49761d30df7 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -86,6 +86,12 @@ enum nvme_quirks {
>  	 */
>  	NVME_QUIRK_NO_DEEPEST_PS		= (1 << 5),
> 
> +	/*
> +	 * The controller requires the command_id value be be limited to the
> +	 * queue depth.
> +	 */
> +	NVME_QUIRK_SKIP_CID_GEN			= (1 << 6),
> +
>  	/*
>  	 * Set MEDIUM priority on SQ creation
>  	 */
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index b82492cd7503..d9f22ed68185 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3369,7 +3369,10 @@ static const struct pci_device_id nvme_id_table[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2005),
>  		.driver_data = NVME_QUIRK_SINGLE_VECTOR |
>  				NVME_QUIRK_128_BYTES_SQES |
> -				NVME_QUIRK_SHARED_TAGS },
> +				NVME_QUIRK_SHARED_TAGS ,
> +				NVME_QUIRK_SKIP_CID_GEN },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2006),
> +		.driver_data = NVME_QUIRK_SKIP_CID_GEN },
> 
>  	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
>  	{ 0, }
> --

-- 
Sven Peter

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
