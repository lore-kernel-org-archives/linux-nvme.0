Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9259AE7DF11
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Feb 2026 17:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:
	Subject:Cc:To:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8Utz5/Tqu+ajciMbgQqB3gxHe5J+aaY8t9YWZp31Fxw=; b=fYMZS0myq3KZ/g3+U1YVqCxo98
	2//RKwJcqEQSl/r/WD4qG9OuD0BWF3EmHYrtIHvrVj78QfQrNfmCz+7DIfO4VYHKKfi4BMEVPBTD7
	qVENaKHRzLd9QTNCvPtE7JfmMDk2jgyUZ+ahY4FMK15REibd5rkBRbxpw1gWNHQ08L1thotiahopK
	lYrp4rL4yQfk78mneUpV4ycHAHEEZeUa88wrLfutt4GRmcminXaGBxDgE6QNgoRrSfXTQSbW6DMMh
	3FFSUwQWrMOwJUqRxdIOQw1GZmCC9MYvxWbf0gsHNKYzATGdWfAwTxNeDkIQRGGLCAbrQKdNuMBLx
	qLhIh1Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmxso-00000005MyQ-2J69;
	Mon, 02 Feb 2026 17:38:42 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmxsl-00000005Mxt-2WsN
	for linux-nvme@lists.infradead.org;
	Mon, 02 Feb 2026 17:38:41 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 91b7408f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Feb 2026 18:38:34 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Feb 2026 18:38:34 +0100
Message-Id: <DG4NQUF89U9S.13DRTI17KNITZ@bsdbackstore.eu>
To: "Christoph Hellwig" <hch@lst.de>, "Maurizio Lombardi"
 <mlombard@redhat.com>
Cc: <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>,
 <dwagner@suse.de>, <hare@suse.de>, <jmeneghi@redhat.com>,
 <emilne@redhat.com>, <mlombard@bsdbackstore.eu>
Subject: Re: [PATCH 1/1] nvme: add support for dynamic quirk configuration
 via module parameter
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
X-Mailer: aerc 0.21.0
References: <20260128103318.76842-1-mlombard@redhat.com>
 <20260128103318.76842-2-mlombard@redhat.com> <20260202071703.GA991@lst.de>
In-Reply-To: <20260202071703.GA991@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_093839_973904_42351094 
X-CRM114-Status: GOOD (  28.09  )
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

Hello Christoph,

On Mon Feb 2, 2026 at 8:17 AM CET, Christoph Hellwig wrote:
>
> Nit: this commit message reads a little odd because line lengths are so
> inconsistent, please use up all 73/75 chracaters consistently.
>
>
>> +			list of quirk names separated by commas. A quirk name can
>> +			be prefixed by '^', meaning that the specified quirk must
>
> Overly long lines.
>
>> +static int quirks_param_set(const char *value, const struct kernel_para=
m *kp);
>
> Can we get away without a forware declaration here?
>
>> +static struct quirk_entry *quirk_list;
>> +static unsigned int quirk_count;
>
> Please use nvme_pci_ prefixes for global variables and functions.

Ok

>
>> +static int quirks_param_set(const char *value, const struct kernel_para=
m *kp)
>> +{
>> +	char *val, *outer_ptr, *inner_ptr, *field;
>> +	char *q_name;
>> +	u16 vid, did;
>> +	u32 *flags;
>> +	size_t i =3D 0, q_len, field_len;
>> +	int err, b;
>> +
>> +	val =3D kstrdup(value, GFP_KERNEL);
>> +	if (!val)
>> +		return -ENOMEM;
>> +
>> +	err =3D param_set_copystring(val, kp);
>> +	if (err)
>> +		goto exit;
>
> All other callers of param_set_copystring except for usbhid set
> it to the passsed in value and not a copy.  Given that this
> function has no documentation I'm not sure what is right, but
> this smells a bit fishy.

Changed it to used the passed value

>
>> +	kfree(quirk_list);
>> +	quirk_list =3D NULL;
>
> How can quirk_list be non-NULL here given that we don't allow
> runtime-changes to the paramter?

That's right, I cleaned it up

>
>> +	if (!*val) {
>> +		quirk_count =3D 0;
>> +		goto exit;
>> +	}
>
>> +	for (quirk_count =3D 1, i =3D 0; val[i]; i++)
>> +		if (val[i] =3D=3D '-')
>> +			quirk_count++;
>
> initializing the quirk_count in the loop looks odd, compare to:
>
> 	quirk_count =3D 1;
> 	for (i =3D 0; val[i]; i++)
> 		if (val[i] =3D=3D '-')
> 			quirk_count++;
>
>> +
>> +	quirk_list =3D kcalloc(quirk_count, sizeof(struct quirk_entry),
>> +			     GFP_KERNEL);
>> +	if (!quirk_list) {
>> +		quirk_count =3D 0;
>> +		err =3D -ENOMEM;
>> +		goto exit;
>> +	}
>
> Instead of zeroing the global variable on error, please only set it
> from a local one on success to make the code more robust.

Ok

> Given that we're unlikely to add tons of quirk lines, simply reallocing
> the array vs pre-sizing it might also be simpler.

I tried but IMO doesn't make it much simpler.

>
>> +static struct quirk_entry *detect_dynamic_quirks(struct pci_dev *pdev)
>> +{
>> +	int i;
>> +
>> +	for (i =3D 0; i < quirk_count; ++i) {
>
> The nvme driver like most of the kernel uses post-increments in for
> loops.  (We already had at least one more instance above).
>
>> +		if (pdev->vendor =3D=3D quirk_list[i].vendor_id &&
>> +		    pdev->device =3D=3D quirk_list[i].dev_id) {
>> +			return &quirk_list[i];
>> +		}
>> +	}
>
> No need for either braces, and at least the inner ones are counter to
> the usual kernel style.
>
>> +	qentry =3D detect_dynamic_quirks(pdev);
>> +	if (qentry) {
>> +		quirks |=3D qentry->enabled_quirks;
>> +		quirks &=3D ~(qentry->disabled_quirks);
>
> No need for the braces after the ~.

Should all be fixed in V2, please take a look and let me know


Thanks,
Maurizio

