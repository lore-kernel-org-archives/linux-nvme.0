Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D95D73EBB
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Feb 2026 07:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DcS5zPDkVsISsgcvshDZz7Orsbw30EHTM1vDZopuXKk=; b=V0mvnggmUvjrXUabBqSraEb3W5
	R+0tIcxhfIEdjX3LOXo6XmCvsDIT35WKFt0lifwnRpDJT4sq1aVkw9XniW8YqCpUBB6/76wylzwtn
	C6sXYg5B2oYCF7ZANF72/YyCr4yWY1RJbCuqFQ8V6gM0H40FkidNbMK9mM2OTyCCEoitq1qilgvgt
	TFPghjiWnYMEhsqOCgfqfNZZkjfq4PxQ3whTmVGnmjBZyBBp5acHGKynLf/uRMWPaOSPjPDbKecJ1
	tELmV04iMgkqfzleu53nypH7HsfZKL3QREw1qY7m8+ERbAn1THhLTb2ne0A/tYvPQjwe7Gi1zQaFI
	cqSJHJ7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmoBL-00000004aT5-1TiR;
	Mon, 02 Feb 2026 07:17:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmoBI-00000004aSj-1Adt
	for linux-nvme@lists.infradead.org;
	Mon, 02 Feb 2026 07:17:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 11D9068B05; Mon,  2 Feb 2026 08:17:04 +0100 (CET)
Date: Mon, 2 Feb 2026 08:17:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org,
	dwagner@suse.de, hare@suse.de, jmeneghi@redhat.com,
	emilne@redhat.com, mlombard@bsdbackstore.eu
Subject: Re: [PATCH 1/1] nvme: add support for dynamic quirk configuration
 via module parameter
Message-ID: <20260202071703.GA991@lst.de>
References: <20260128103318.76842-1-mlombard@redhat.com> <20260128103318.76842-2-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128103318.76842-2-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260201_231708_603940_71B9D5B2 
X-CRM114-Status: GOOD (  34.41  )
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

On Wed, Jan 28, 2026 at 11:33:18AM +0100, Maurizio Lombardi wrote:
> Introduce support for enabling or disabling specific NVMe quirks at
> module load time through the `quirks` module parameter.
> This mechanism allows users to apply known quirks dynamically
> based on the device's PCI vendor and device IDs,
> without requiring to add hardcoded entries in the driver
> and recompiling the kernel.

Nit: this commit message reads a little odd because line lengths are so
inconsistent, please use up all 73/75 chracaters consistently.

> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt

I thought those file only used to document always built-in paramters
using __setup and not module parameters, but grabbing random ones that
look modular disproves that.

> +			list of quirk names separated by commas. A quirk name can
> +			be prefixed by '^', meaning that the specified quirk must

Overly long lines.

> +static int quirks_param_set(const char *value, const struct kernel_param *kp);

Can we get away without a forware declaration here?

> +static struct quirk_entry *quirk_list;
> +static unsigned int quirk_count;

Please use nvme_pci_ prefixes for global variables and functions.

> +static int quirks_param_set(const char *value, const struct kernel_param *kp)
> +{
> +	char *val, *outer_ptr, *inner_ptr, *field;
> +	char *q_name;
> +	u16 vid, did;
> +	u32 *flags;
> +	size_t i = 0, q_len, field_len;
> +	int err, b;
> +
> +	val = kstrdup(value, GFP_KERNEL);
> +	if (!val)
> +		return -ENOMEM;
> +
> +	err = param_set_copystring(val, kp);
> +	if (err)
> +		goto exit;

All other callers of param_set_copystring except for usbhid set
it to the passsed in value and not a copy.  Given that this
function has no documentation I'm not sure what is right, but
this smells a bit fishy.

> +	kfree(quirk_list);
> +	quirk_list = NULL;

How can quirk_list be non-NULL here given that we don't allow
runtime-changes to the paramter?

> +	if (!*val) {
> +		quirk_count = 0;
> +		goto exit;
> +	}

> +	for (quirk_count = 1, i = 0; val[i]; i++)
> +		if (val[i] == '-')
> +			quirk_count++;

initializing the quirk_count in the loop looks odd, compare to:

	quirk_count = 1;
	for (i = 0; val[i]; i++)
		if (val[i] == '-')
			quirk_count++;

> +
> +	quirk_list = kcalloc(quirk_count, sizeof(struct quirk_entry),
> +			     GFP_KERNEL);
> +	if (!quirk_list) {
> +		quirk_count = 0;
> +		err = -ENOMEM;
> +		goto exit;
> +	}

Instead of zeroing the global variable on error, please only set it
from a local one on success to make the code more robust.

> +	i = 0;
> +	outer_ptr = val;
> +	while ((field = strsep(&outer_ptr, "-"))) {
> +		inner_ptr = field;
> +
> +		/* Each entry consists of VID:DID:quirk_names */
> +		field = strsep(&inner_ptr, ":");

This juggling between field and innter_ptr looks odd.  I'd scan directly
into innter_ptr and keep field declarated locally in the loop.  Same
for any other variable not used globally.  Also splitting out the
loop bodies into well named helpers would help readability a lot here.

> +			field_len = strlen(field);
> +			for (b = 0; ; ++b) {
> +				q_name = nvme_quirk_name(BIT(b));

Urrg.  Please avoid use of BIT in general, but especially here where
you're actually doing arithmetics amd just declare constants.

Given that we're unlikely to add tons of quirk lines, simply reallocing
the array vs pre-sizing it might also be simpler.

> +static struct quirk_entry *detect_dynamic_quirks(struct pci_dev *pdev)
> +{
> +	int i;
> +
> +	for (i = 0; i < quirk_count; ++i) {

The nvme driver like most of the kernel uses post-increments in for
loops.  (We already had at least one more instance above).

> +		if (pdev->vendor == quirk_list[i].vendor_id &&
> +		    pdev->device == quirk_list[i].dev_id) {
> +			return &quirk_list[i];
> +		}
> +	}

No need for either braces, and at least the inner ones are counter to
the usual kernel style.

> +	qentry = detect_dynamic_quirks(pdev);
> +	if (qentry) {
> +		quirks |= qentry->enabled_quirks;
> +		quirks &= ~(qentry->disabled_quirks);

No need for the braces after the ~.


