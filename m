From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 13 Oct 2016 02:15:00 -0700
Subject: [PATCH 3/7 v2] nvme-fabrics: Add FC transport FC-NVME definitions
In-Reply-To: <e98579b7-2b6a-8987-0ced-a0146ea5919b@broadcom.com>
References: <57f82b10.h/qKXTOsgeHQsdmh%james.smart@broadcom.com>
 <20161012085834.GD12972@infradead.org>
 <e98579b7-2b6a-8987-0ced-a0146ea5919b@broadcom.com>
Message-ID: <20161013091500.GA16162@infradead.org>

On Wed, Oct 12, 2016@11:53:29AM -0700, James Smart wrote:
> Ok - help my style. I assumed deltas to original patch made sense to
> itemize. As they are specific to this one file I thought it made sense to be
> in the commit message for this patch. I have no problem moving it to the
> cover letter. Just not sure what the criteria is for one place vs another.

If you want to keep them in this patch that's not as usual but okay as
well.  But in that case move it under the '---' marker, so that git-am
won't pick it up.
